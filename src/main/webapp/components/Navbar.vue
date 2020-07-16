<template>
  <nav class="navy-blue sticky nav-bar">
    <a href="index.html" class="bold" id="title">starfish</a>
    <img src="../assets/starfish.png" id="logo">
    <div class="action-items" v-if="!signedIn">
      <a href="#" class="vert-center" @click.stop="signIn" id="signin-link">Sign Up/Login</a>
    </div>
    <div class="action-items" v-if="signedIn">
      <a href="#" class="vert-center">PostANote</a>
      <div class="dropdown">
        <button class="dropdown-btn" @click.stop="toggleDropdown">
          <img id="user-profile" src="../assets/user.svg">
        </button>
        <div class="light-gray dropdown-content" v-if="showDropdown" v-click-outside="hideDropdown">
          <img src="../assets/user.svg" height="115px"/>
          <p class="bold" id="dropdown-name">{{ user.name }}</p>
          <p id="dropdown-points">{{ user.points }} points</p>
          <!-- TODO: Update links when new pages are created -->
          <a class="dropdown-link" href="#">My Profile</a> 
          <a class="dropdown-link" href="#">Favorite Notes</a>
          <a class="dropdown-link" href="#" @click="signOut">Logout</a>
        </div>
      </div>
    </div> 
  </nav>
</template>

<script>
Vue.directive('click-outside', {
  bind: function (el, binding, vnode) {
    this.event = function(event) {
      if(!(el == event.target || el.contains(event.target))) {
        vnode.context[binding.expression](event);
      }
    };
    document.body.addEventListener('click', this.event);
  },
  unbind: function(el) {
    document.body.removeEventListener('click', this.event);
  }
});

module.exports = {
  data: function() {
    return {
      showDropdown: false,
      signedIn: false,
      clientId: "506538592562-rueidmib5vvra4cn2ihb48b3fhneb1ka.apps.googleusercontent.com",
      googleAuth: null,
      // TODO: Set user to null once testing is finished
      user: {
        name: 'Default Name',
        points: 0
      }
    }
  },
  methods: {
    hideDropdown() {
      this.showDropdown = false;
    },
    toggleDropdown() {
      this.showDropdown = !this.showDropdown;
    },
    onGAPILoad() {
      gapi.load('auth2', this.initGoogleAuth);
    },
    initGoogleAuth() {
      gapi.auth2.init({
        client_id: this.clientId
      }).then(() => {
        this.googleAuth = gapi.auth2.getAuthInstance();
        if(this.googleAuth.isSignedIn.get()) this.registerUser();
      })
    },
    registerUser() {
      const authRes = this.googleAuth.currentUser.get().getAuthResponse();
      const token = authRes.id_token;
      const expirationTime = authRes.expires_at;
      fetch('/user-signin?idToken=' + token + 'exp=' + expirationTime)
        .then(response => {
          this.signedIn = true;
          // TODO: Send GET request to retrieve user data then set it
        })
        .catch(err => {
          console.log(err);
        })
    },
    setUserInfo(userData) {
      this.user = userData;
    },
    signIn() {
      this.googleAuth.signIn().then(() => {
        this.registerUser();
      }).catch(err => {
        console.log(err);
      });
    },
    signOut() {
      this.googleAuth.disconnect();
      this.googleAuth.signOut().then(() => {
        fetch('/user-logout', {
          method: 'POST'
        }).then(response => {
          this.signedIn = false;
          this.showDropdown = false;
          // TODO: Set user to null once servlets are completed
        });
      })
    }
  },
  mounted() {
    let gapiScript = document.createElement('script');
    gapiScript.onload = this.onGAPILoad;
    gapiScript.src = "https://apis.google.com/js/client.js";
    document.head.appendChild(gapiScript);
  },
  watch: {
    user: function(userVal) {
      this.$emit('set-user', userVal);
    }
  }
}
</script>

<style scoped>
.bold {
  font-weight: bold;
}

.navy-blue {
  background-color: #004aad;
}

.light-gray {
  background-color: #f9f9f9;
}

.sticky {
  position: sticky;
  top: 0;
  left: 0;
  width: 100%;
}

.nav-bar {
  align-items: center;
  display: flex;
  font-family: 'Roboto';
  height: 80px;
}

.nav-bar a {
  float: left;
  font-size: 1.75em;
  color: white;
  text-decoration: none;
}

#title {
  font-size: 2.75em;
  margin: 0 10px 0 20px;
}

#logo {
  height: 60%;
  padding: 0 0 5px 0;
}

.action-items {
  height: 100%;
  margin-left: auto;
}

.vert-center {
  height: 80px;
  line-height: 80px;
}

#signin-link {
  padding-right: 30px;
}

.dropdown {
  height: 100%;
  overflow: hidden;
  padding: 0 10px 0 20px;
}

.dropdown .dropdown-btn {
  background-color: inherit;
  border: none;
  color: white;
  font-size: 16px;
  font-family: inherit;
  height: 100%;
  margin: 0;
  outline: none;
  width: 75px;
}

.dropdown .dropdown-btn:hover {
  cursor: pointer;
}

.dropdown-btn img {
  height: 65%;
}

.dropdown-content {
  align-items: center;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  display: flex;
  flex-direction: column;
  height: 375px;
  justify-content: center;
  margin-right: 10px;
  position: absolute;
  right: 0;
  width: 350px;
  z-index: 1;
}

#dropdown-name {
  font-size: 1.75rem;
  margin: 25px 0 0 0;
}

#dropdown-points {
  font-size: 1.5rem;
  margin: 0;
}

.dropdown-content a {
  color: #575757;
  font-size: 1.25rem;
  margin: 20px 0 -15px 0;
  padding: 0;
}
</style>