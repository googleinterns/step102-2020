<template>
  <v-row justify="center">
    <v-dialog v-model="showPreview" max-width="860px">
      <v-card>
        <v-card-title class="headline">
          {{title}}
        </v-card-title>
        <v-card-subtitle>
          <em>{{author}}</em> - {{dateString}}
        </v-card-subtitle>

        <v-badge :content="favoriteCount"
                  class="ma-2">
          <v-icon>mdi-star</v-icon>
        </v-badge>
        <v-badge :content="downloadCount"
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
      date: Date,
      favoriteCount: Number,
      downloadCount: Number,
      school: Object,
      course: Object,
      labels: Array,
      isFavorited: Boolean,
      pdfSrc: String,
    },
    data: function() {
      return {
        showPreview: false,
      }
    },
    computed: {
      dateString: function() {
        return this.date?.toDateString();
      },
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
