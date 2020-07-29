<template>
  <v-col>
    <v-card @click="onClick"
            width="208px"
            :color="cardColor">
      <v-img :src="thumbnailSrc"
             height="180px"
             position="top">
        <v-icon>{{ isGNote ? "mdi-google-drive" : "mdi-pdf-box" }}</v-icon>             
      </v-img>

      <v-divider></v-divider>

      <v-card-title>
        <v-list-item-title class="d-block text-truncate">{{title}}</v-list-item-title>
      </v-card-title>

      <v-card-subtitle>
        <v-list-item-subtitle>{{ course }} • {{ school }}</v-list-item-subtitle>
      </v-card-subtitle>

      <v-card-text>
        <v-row no-gutters>
          <v-col>
            {{dateCreated}}
          </v-col>
          <v-col col="1">
            <v-badge overlap class="ma-1">
              <template v-slot:badge>{{numFavorites}}</template>
              <v-icon :color="favColor">mdi-star</v-icon>
            </v-badge>
            <v-badge overlap class="ma-1">
              <template v-slot:badge>{{numDownloads}}</template>
              <v-icon>mdi-download</v-icon>
            </v-badge>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>
  </v-col>
</template>

<script>
  module.exports = {
    props: {
      thumbnailSrc: String,
      id: Number,
      title: String,
      dateCreated: String,
      school: String,
      course: String,
      labels: Array,
      numDownloads: Number,
      numFavorites: Number,
      isFavorited: Boolean,
      isActive: Boolean,
    },
    data: function() {
      return {
        favorited: this.isFavorited,
      }
    },
    computed: {
      thumbnail: function() {
        // TODO: Generate a thumbnail of the pdf
        let source = 'assets/notes.png';
        return {backgroundImage:`url(${source})`};
      },
      isGNote: function() {
        return true; // TODO: Check note data to determine if note is a GNote
      },
      cardColor: function() {
        if (this.isActive) return "blue lighten-4"
      },
      favColor: function() {
        if (this.favorited) return "yellow"
      }
    },
    methods: {
      onClick: function() {
        this.isActive ? this.$emit('open-preview') : this.$emit('activate');
      },
    }
  }
</script>
