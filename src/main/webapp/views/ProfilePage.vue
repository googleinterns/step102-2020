<template>
  <v-app>
    <navbar @setuser="onSetUser" @signedin="onSignIn"></navbar>
    <div v-if="!signedIn">
      <h1>Please sign in</h1>
    </div> 
    <div v-else> 
        <profile-header :points="user.points"
                        :name="user.displayName">
        </profile-header>
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
      this.user = user;
    },
    onSignIn: function(signedIn) {
      this.signedIn = signedIn;
    },
  }
}
</script>
