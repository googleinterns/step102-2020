<template>
  <v-app>
    <navbar></navbar>
    <search-bar @searchresult="updateSearchResult"></search-bar>
    <mock-search @searchresult="updateSearchResult"></mock-search>
    <note-grid v-slot="{ filters }">
      <note-grid-collection :note-data="searchResult"
                            header="Most Favorited"
                            :filters="filters"
                            :compare-func="descFavorites">
      </note-grid-collection>
      <note-grid-collection :note-data="searchResult"
                            header="Recently Posted"
                            :filters="filters"
                            :compare-func="descDate">
      </note-grid-collection>
      <!-- 
        The following note-grid-collection sample is a rudimentary way of displaying notes 
        that have gained the most score recently (1 week). In practice, the backend will need 
        a way of counting the # of favorites and downloads a share has had in the past X days.
      -->
      <!--
      <note-grid-collection :note-data="searchResult"
                            header="Trending Notes"
                            :filters="filters"
                            :compare-func="descFavorites"
                            :max-age="7 * 24 * 60 * 60 * 1000">
      </note-grid-collection>
      -->
    </note-grid>
  </v-app>
</template>

<script>
module.exports = {
  // Example for how to load component <sample-component>
  components: {
    'navbar': httpVueLoader('/components/Navbar.vue'),
    'search-bar': httpVueLoader('/components/SearchBar.vue'),
    'note-grid': httpVueLoader('/components/NoteGrid.vue'),
    'note-grid-collection': httpVueLoader('/components/NoteGridCollection.vue'),
    'mock-search': httpVueLoader('/components/MockSearchButton.vue'),
  },
  data: function() {
    return {
      searchResult: [],
      descFavorites: function(noteA, noteB) {
        return noteB.numFavorites - noteA.numFavorites;
      },
      descDate: function(noteA, noteB) {
        return Date.parse(noteB.dateCreated) - Date.parse(noteA.dateCreated);
      }
    }
  },
  methods: {
    updateSearchResult: function(result) {
      this.searchResult = result;
    },
  }
}
</script>
