<template>
  <nav class="navy-blue sticky nav-bar">
    <a href="index.html" class="bold" id="title">starfish</a>
    <img src="/assets/starfish.png" id="logo">
    <div class="action-items" v-if="!signedIn">
      <v-btn color="primary"
            dark
            @click.stop="signIn"
            id="signin-link">
        Sign Up/Login
      </v-btn>
    </div>
    <div class="action-items" v-if="signedIn">
      <upload-form id="post-note"></upload-form>
      <!-- User dropdown menu -->
      <v-menu v-model="showDropdown" :offset-y="true">
        <template v-slot:activator="{ on, attrs }">
          <v-btn v-bind="attrs"
                 v-on="on">
            <v-avatar>
              <v-icon>mdi-account-circle</v-icon>
            </v-avatar>
          </v-btn>
        </template>
        <v-card>
          <v-list>
            <v-list-item>
              <v-list-item-avatar>
                <v-icon>mdi-account-circle</v-icon>
              </v-list-item-avatar>

              <v-list-item-content>
                <v-list-item-title>{{ user.name }}</v-list-item-title>
                <v-list-item-subtitle>{{ user.points }} points</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-list>

          <v-divider></v-divider>

          <v-list>
            <v-list-item @click="">
              <v-list-item-title>My Profile</v-list-item-title>
            </v-list-item>

            <v-list-item @click="">
              <v-list-item-title>Favorite Notes</v-list-item-title>
            </v-list-item>

            <v-list-item @click="signOut">
              <v-list-item-title>Logout</v-list-item-title>
            </v-list-item>            
          </v-list>
        </v-card>
      </v-menu>
    </div> 
  </nav>
</template>

<script>
module.exports = {
  components: {
    'upload-form': httpVueLoader('/components/UploadForm.vue'),
  },
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
      fetch('/user-signin?idToken=' + token + '&exp=' + expirationTime, {
        method: "POST"
      }).then(response => {
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

button {
  margin: 0 10px;
}

button:focus {
  outline: none;
}

#logo {
  height: 60%;
  padding: 0 0 5px 0;
}

.action-items {
  align-items: center;
  display: flex;
  height: 100%;
  margin-left: auto;
  width: auto;
}

.vert-center {
  height: 80px;
  line-height: 80px;
}

#signin-link {
  margin-right: 30px;
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
