<template>
  <v-app> <!-- TODO: find a different, more semantically correct root element -->
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
      <!-- TODO: change trending timespan with a drop-down -->
      <note-grid-collection :note-data="searchResult"
                            header="Trending Notes"
                            :filters="filters"
                            :compare-func="descTrending">
      </note-grid-collection>
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
        return noteB.date - noteA.date;
      },
      descTrending: function(noteA, noteB) {
        let trendingIndex = 1;
        return noteB.trendingScore - noteA.trendingScore;
      },
    }
  },
  methods: {
    updateSearchResult: function(result) {
      this.searchResult = result;
    },
  }
}
</script>
