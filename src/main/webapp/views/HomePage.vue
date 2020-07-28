<template>
  <main class="navy-blue">
    <h1 class="home-title">starfish</h1>
    <h3 class="subtitle">Share and find the best course notes. Completely free.</h3>
    <!-- TODO: Connect these searchresult events to the search page -->
    <search-bar @searchresult="() => {}"></search-bar>
    <mock-search @searchresult="() => {}"></mock-search>    
    <router-link to="/search">
      <img id="laptop" src="assets/laptop-min.png">
    </router-link>
  </main>  
</template>

<script>
module.exports = {
  components: {
    'search-bar': httpVueLoader('/components/SearchBar.vue'),
    'mock-search': httpVueLoader('/components/MockSearchButton.vue'),
  },
}
</script>

<style>
body {
  margin: auto 0;
}

.zone {
  font-size: 2em;
}

/* COLORS */
.navy-blue {
  background-color: #004aad;
}

/* NAV */
.main-nav {
  display: flex;
  align-items: center;
  justify-content: center;
  list-style: none;
  font-size: 0.7em;
  font-family: Helvetica;
  margin: 0;
}


.push {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: auto;
}

#user-profile {
  width: 40px;
  height: auto;
}

li {
  padding: 10px;
}

.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}

/* MAIN */

.home-title {
  color: white;
  margin: 0px;
}

.subtitle {
  color: white;
}

label {
  color: white;
}

main {
  height: 70vh;
  padding-top: 85px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

form {
  display: flex;
  flex-direction: column;
}

.inline {
  display: flex;
  flex-direction: row;
}

.inline-form-el {
  flex: 1 1 auto;
}

#laptop {
  width: 750px;
  height: auto;
}

/* MEDIA QUERIES */
@media only screen and (max-width: 600px) {
  .main-nav {
    font-size: 0.5em;
    padding: 0;
  }
  #laptop {
    width: 400px;
    height: auto;
  }
}
</style>