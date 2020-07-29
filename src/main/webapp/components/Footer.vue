<template>
  <v-footer color="blue darken-3"
            absolute
            dark>
    <v-col class="text-center" cols="12">
      <span>Made with &hearts; at 
      <a target="#" href="https://careers.google.com/jobs/"><img src="/assets/google.svg"></a>, by 
      <a target="#" href="https://github.com/Aradhya-B"><strong>Aradhya</strong></a>,
      <a target="#" href="https://github.com/andres-holguin"><strong>Andres</strong></a>,
      and <a target="#" href="https://github.com/keelywan"><strong>Keely</strong></a>.
      Contribute to the project <a href="https://github.com/googleinterns/step102-2020"><strong>here</strong></a>! 
      Starfish &copy; {{ new Date().getFullYear() }}</span>
    </v-col>
  </v-footer>
</template>

<style scoped>

span {
  padding: 3px;
  display: inline-block;
}

img {
  height: 20px;
  width: auto;
  display: inline-block;
  vertical-align: middle;
}

a {
  color: inherit;
  text-decoration: none;
  cursor: pointer;
}

a:hover {
  color: blue;
}

</style>
