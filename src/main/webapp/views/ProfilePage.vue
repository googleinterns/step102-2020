<template>
  <v-app>
    <div v-if="!user">
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
    'note-grid': httpVueLoader('/components/NoteGrid.vue'),
    'note-grid-collection': httpVueLoader('/components/NoteGridCollection.vue'),
    'profile-header': httpVueLoader('/components/ProfileHeader.vue')
  },
  data: function() {
    return {
      user: null,
      descFavorites: function(noteA, noteB) {
        return noteB.numFavorites - noteA.numFavorites;
      },
      descDate: function(noteA, noteB) {
        return Date.parse(noteB.dateCreated) - Date.parse(noteA.dateCreated);
      }
    }
  },
  mounted: function () {
    fetch('/user-registration')
      .then(response => {
        if(response.status === 200) {
          response.json()
            .then(userObj => this.user = userObj);
        } else {
          this.user = null;
        }
      })
  }
}
</script>
