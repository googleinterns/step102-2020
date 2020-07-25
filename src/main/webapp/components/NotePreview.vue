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

        <a href="#" @click="toggleFavorite">
          <v-badge class="ma-2">
            <template v-slot:badge>{{numFavorites}}</template>
            <v-icon :color="iconColor" class="action-icon">mdi-star</v-icon>
          </v-badge>
        </a>
        <a :href="pdfSource" :download="title" @click="increment">
          <v-badge class="ma-2">
            <template v-slot:badge>{{numDownloads}}</template>
            <v-icon class="action-icon">mdi-download</v-icon>
          </v-badge>
        </a>

        <label-list :school="school"
                    :course="course"
                    :labels="miscLabels">
        </label-list>

        <iframe :src="pdfSource"></iframe>
        <a href="src" download @click="increment">
          <v-icon>mdi-download</v-icon>
          Download
        </a>
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
          return 'Invalid Note'
        }
      },
      author: String,
      dateCreated: String,
      numFavorites: Number,
      numDownloads: Number,
      school: String,
      course: String,
      miscLabels: Array,
      pdfSource: String,
      sourceUrl: String
    },
    data: function() {
      return {
        showPreview: false,
        favorited: false,
        iconColor: 'undefined',
      }
    },
    computed: {
      src: function() {
        // TODO: Need to handle logic for if it is a pdf or Google Doc
        return `/serve-notes?key=${this.pdfSource}`;
      }
    },
    mounted: function() {
      this.$parent.$on('open-preview', note => {
        if(this.id) {
          this.setFavorite();
        }
        this.showPreview = true;
      });
    },
    methods: {
      increment: function() {
        fetch('/download-note?note_id=' + this.id, {
          method: 'POST'
        })
      },
      toggleFavorite: function() {
        this.getFavorited()
          .then(isFavorited => {
            this.favorited = isFavorited;
            const method = this.favorited ? 'DELETE' : 'POST';
            fetch('/favorite-note?note_id=' + this.id, {
              method: method
            }).then(response => {
              if(response.status === 403) alert('Please sign in to favorite this note.');
              else this.favorited = !this.favorited;
            })
          })
      },
      getFavorited: function() {
        return fetch('/favorite-note?note_id=' + this.id)
          .then(response => response.json());
      },
      setFavorite: function() {
        this.getFavorited()
          .then(isFavorited => {
            this.favorited = isFavorited;
          });
      }
    },
    watch: {
      id: function(noteId) {
        if(noteId) {
          this.setFavorite();
        }
      },
      favorited: function(favoriteStatus) {
        this.iconColor = this.favorited ? 'yellow' : 'undefined';
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

  .action-icon:hover {
    color: black;
  }
</style>
