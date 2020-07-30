<template>
  <v-card class="mx-auto"
          height="30vh"
          min-height="250px"
          outline>
    <v-img height="30vh"
           min-height="250px"
           src="/assets/profile_bg.jpg">
      <v-row align="end" class="fill-height">
        <v-col class="py-0">
          <v-list-item color="rgba(0, 0, 0, .4)" dark>
            <v-list-item-content>
              <v-list-item-title id="name">{{ name }}</v-list-item-title>
              <v-list-item-subtitle id="points">{{ points }} points</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
    </v-img>
  </v-card>
</template>

<script>
module.exports = {
  props: {
    points: Number,
    name: String,
  }
}
</script>

<style scoped>
#name {
  font: bold 3.5rem 'Roboto';
  margin: 0;
}

#points {
  font: bold 2rem 'Roboto';
  margin-bottom: 1rem;
}
</style>
