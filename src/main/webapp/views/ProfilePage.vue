<template>
  <v-app>
    <navbar @setuser="onSetUser" @signedin="onSignIn"></navbar>
    <v-container v-if="!signedIn"
                 class="fill-height"
                 fluid>
      <v-row align="center" justify="center">
        <h1 class="lg-heading">Please sign in</h1>
      </v-row>
    </v-container>
    <div v-else> 
      <profile-header :points="user.points"
                      :name="user.displayName">
      </profile-header>
      <div class="notes-container">
        <note-grid>
          <note-grid-collection :note-data="user.favoriteNotes"
                                header="Favorited Notes"
                                :compare-func="descFavorites">
          </note-grid-collection>
          <note-grid-collection :note-data="user.uploadedNotes"
                                header="Uploaded Notes"
                                :compare-func="descDate">
          </note-grid-collection>
        </note-grid>
      </div>
    </div>
  </v-app>
</template>

<script>
module.exports = {
  components: {
    'navbar': httpVueLoader('/components/Navbar.vue'),
    'note-grid': httpVueLoader('/components/NoteGrid.vue'),
    'note-grid-collection': httpVueLoader('/components/NoteGridCollection.vue'),
    'profile-header': httpVueLoader('/components/ProfileHeader.vue')
  },
  data: function() {
    return {
      user: {
        points: 0,
        displayName: "Default Username",
      },
      signedIn: false,
      descFavorites: function(noteA, noteB) {
        return noteB.numFavorites - noteA.numFavorites;
      },
      descDate: function(noteA, noteB) {
        return Date.parse(noteB.dateCreated) - Date.parse(noteA.dateCreated);
      }
    }
  },
  methods: {
    onSetUser: function(user) {
      console.log(user);
      this.user = user;
    },
    onSignIn: function(signedIn) {
      this.signedIn = signedIn;
    },
  }
}
</script>

<style>
.lg-heading {
  font: 6rem 'Caveat Brush';
}

.notes-container {
  margin: 25px;
}
</style>
