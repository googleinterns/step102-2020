<template>
  <v-footer color="blue darken-3"
            dark>
    <v-col class="text-center" cols="12">
      <span>Made with &hearts; at 
      <a target="#" href="https://careers.google.com/jobs/"><img src="/assets/google.svg"></a>, by 
      <a target="#" href="https://github.com/Aradhya-B"><strong>Aradhya</strong></a>,
      <a target="#" href="https://github.com/andres-holguin"><strong>Andres</strong></a>,
      and <a target="#" href="https://github.com/keelywan"><strong>Keely</strong></a>.
      Contribute to the project <a href="https://github.com/googleinterns/step102-2020"><strong>here</strong></a>!
      Learn more <strong @click="goToAbout">here</strong>!
      Starfish &copy; {{ new Date().getFullYear() }}</span>
    </v-col>
  </v-footer>
</template>

<script>
module.exports = {
  methods: {
    goToAbout() {
      this.$router.push('about');
      window.scrollTo(0, 0);
    }
  }
}
</script>

<style scoped>

span {
  display: inline-block;
  padding: 3px;
}

img {
  display: inline-block;
  height: 20px;
  vertical-align: middle;
  width: auto;
}

a {
  color: inherit;
  cursor: pointer;
  text-decoration: none;
}

a:hover {
  color: blue;
}

strong:hover {
  cursor: pointer;
}
</style>
