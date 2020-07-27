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
        <a :href="pdfSource" :download="title" @click="increment">
          <v-badge :content="numDownloads"
                    class="ma-2">
            <v-icon>mdi-download</v-icon>
          </v-badge>
        </a>

        <label-list :school="school"
                    :course="course"
                    :labels="miscLabels"
                    :can-modify="isFavorited">
        </label-list>

        <iframe :src="sourceUrl"></iframe>
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
      id: Number,
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
      miscLabels: Array,
      isFavorited: Boolean,
      pdfSource: String,
      sourceUrl: String
    },
    data: function() {
      return {
        showPreview: false,
      }
    },
    mounted: function() {
      this.$parent.$on('open-preview', note => {
        this.showPreview = true;
      });
    },
    methods: {
      increment: function() {
        fetch('/download-note?note_id=' + this.id, {
          method: 'POST'
        })
      }
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
