<template>
  <div id="navbar-container">
    <v-app-bar height="80px"
               color="blue darken-4"
               fixed>

      <a href="/" class="bold" id="title">starfish</a>
      <img src="/assets/starfish.png" id="logo">

      <v-spacer></v-spacer>

      <v-btn color="primary"
             dark
             @click.stop="signIn"
             id="signin-link"
             v-if="!signedIn">
        Sign Up/Login
      </v-btn>

      <div v-if="signedIn">
        <upload-form id="post-note"></upload-form>
        <!-- User dropdown menu -->
        <v-menu v-model="showDropdown" :offset-y="true">
          <template v-slot:activator="{ on, attrs }">
            <button v-bind="attrs"
                   v-on="on">
              <v-avatar>
                <v-img :src="user.displayPicture">
              </v-avatar>
            </button>
          </template>

          <v-card>
            <v-list>
              <v-list-item>
                <v-list-item-avatar>
                  <v-img :src="user.displayPicture">
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
              <v-list-item @click="signOut">
                <v-list-item-title>Logout</v-list-item-title>
              </v-list-item>            
            </v-list>
          </v-card>
        </v-menu>
      </div> 
    </v-app-bar>
  </div>
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

#navbar-container {
  height: 80px;
}

#title {
  font-size: 3em;
  color: white;
  margin: 0 0 0 10px;
  text-decoration: none;
}

#logo {
  height: 85%;
  margin: 0 0 5px 10px;
}
</style>
