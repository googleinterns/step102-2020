<template>
  <v-row justify="center">
    <v-dialog v-model="showPreview" max-width="860px">
      <v-card>
        <v-card-title class="headline">
          {{title}}
        </v-card-title>
        <v-card-subtitle>
          <em>{{author}}</em> - {{dateCreated}}
        </v-card-subtitle>

        <v-badge :content="numFavorites"
                  class="ma-2">
          <v-icon>mdi-star</v-icon>
        </v-badge>
        <v-badge :content="numDownloads"
                  class="ma-2">
          <v-icon>mdi-download</v-icon>
        </v-badge>

        <label-list :school="school"
                    :course="course"
                    :labels="labels"
                    :can-modify="isFavorited">
        </label-list>

        <iframe :src="pdfSrc"></iframe>
        <button class="report">Report</button>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
  module.exports = {
    components: {
      'label-list': httpVueLoader('/components/LabelList.vue')
    },
    props: {
      title: {
        type: String,
        default: function() {
          return "Invalid Note"
        }
      },
      author: String,
      dateCreated: String,
      numFavorites: Number,
      numDownloads: Number,
      school: String,
      course: String,
      labels: Array,
      isFavorited: Boolean,
      /* pdfSrc: String, // TODO: Rename to Blobkey */
    },
    data: function() {
      return {
        showPreview: false,
        pdfSrc: '/serve-notes?key=mNCTQ9i8e3JoyD1TrynatQ'
      }
    },
    computed: {
      dateString: function() {
        return this.dateCreated?.toDateString();
      },
      src: function() {
        return `/serve-notes?key=${this.pdfSrc}`
      }
    },
    mounted: function() {
      this.$parent.$on('open-preview', note => {
        this.showPreview = true;
      });
    }
  }
</script>

<style>
  iframe {
    height: 100%;
    min-height: 700px;
    width: 100%;
  }

  .report {
    background-color: rgb(240, 140, 140);
    color: white;
    float: right;
  }
</style>
