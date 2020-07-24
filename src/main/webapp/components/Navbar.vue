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
                <v-list-item-title>{{ user.displayName }}</v-list-item-title>
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
    'upload-form': httpVueLoader('/components/UploadForm.vue')
  },
  data: function() {
    return {
      showDropdown: false,
      signedIn: false,
      clientId: "506538592562-rueidmib5vvra4cn2ihb48b3fhneb1ka.apps.googleusercontent.com",
      googleAuth: null,
      user: null
    }
  },
  methods: {
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
      fetch('/user-registration?idToken=' + token + '&exp=' + expirationTime, {
        method: 'POST'
      }).then(response => {
          this.getUserInfo();
        })
        .catch(err => {
          console.log(err);
        })
    },
    getUserInfo() {
      fetch('/user-registration')
        .then(response => response.json())
        .then(userInfo => {
          this.user = userInfo;
          this.signedIn = true;
        })
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
          this.user = null;
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
      this.$emit('setuser', userVal);
    }
  }
}
</script>

<style scoped>
button {
  margin: 0 10px;
}

button:focus {
  outline: none;
}

.bold {
  font-weight: bold;
}

.navy-blue {
  background-color: #004aad;
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
  align-items: center;
  display: flex;
  height: 100%;
  margin-left: auto;
  width: auto;
}

#signin-link {
  margin-right: 30px;
}
</style>
