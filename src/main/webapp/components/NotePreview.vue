<template>
  <v-row justify="center">
    <v-dialog v-model="showPreview" max-width="860px">
      <v-card>
        <v-card-title class="headline">
          {{title}}
        </v-card-title>
        <v-card-subtitle>
          <v-tooltip right>
            <template v-slot:activator="{ on, attrs }">
              <span v-bind="attrs" v-on="on">
                <em>{{authorInfo.displayName}}</em>
              </span>
            </template>
            <span>{{authorInfo.points}} points</span>
          </v-tooltip> 
          - {{dateCreated}}
        </v-card-subtitle>

        <a href="#" @click="toggleFavorite">
          <v-badge class="ma-2">
            <template v-slot:badge>{{currNumFavorites}}</template>
            <v-icon :color="iconColor" class="action-icon">mdi-star</v-icon>
          </v-badge>
        </a>
        <a :href="pdfSource" :download="title" @click="increment">
          <v-badge class="ma-2">
            <template v-slot:badge>{{currNumDownloads}}</template>
            <v-icon class="action-icon">mdi-download</v-icon>
          </v-badge>
        </a>

        <label-list :school="school"
                    :course="course"
                    :labels="miscLabels">
        </label-list>

        <iframe :src="modifiedSourceUrl"></iframe>
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
      authorId: String,
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
        authorInfo: {
          displayName: '',
          points: ''
        },
        currNumFavorites: 0,
        currNumDownloads: 0
      }
    },
    mounted: function() {
      this.$parent.$on('open-preview', note => {
        if(note.id) {
          this.setFavorite(note.id);
          this.setDownload(note.id);
        }
        this.showPreview = true;
      });
    },
    methods: {
      increment: function() {
        fetch('/download-note?note_id=' + this.id, {
          method: 'POST'
        }).then(() => {
          this.currNumDownloads++;
          this.setAuthorInfo(this.authorId);
        })
      },
      toggleFavorite: function() {
        this.getFavorited(this.id)
          .then(favoriteInfo => {
            this.favorited = favoriteInfo.isFavorited == 1;
            const method = this.favorited ? 'DELETE' : 'POST';
            fetch('/favorite-note?note_id=' + this.id, {
              method: method
            }).then(response => {
              if(response.status === 403) alert('Please sign in to favorite this note.');
              else {
                this.favorited = !this.favorited;
                this.currNumFavorites += method === 'POST' ? 1 : -1;
                this.setAuthorInfo(this.authorId);
              }
            })
          })
      },
      getFavorited: function(noteId) {
        return fetch('/favorite-note?note_id=' + noteId)
          .then(response => {console.log(response); return response.json()});
      },
      setFavorite: function(noteId) {
        this.getFavorited(noteId)
          .then(favoriteInfo => {
            this.favorited = favoriteInfo.isFavorited == 1;
            this.currNumFavorites = favoriteInfo.numFavorites;
          });
      },
      setDownload: function(noteId) {
        fetch('/download-note?note_id=' + noteId)
          .then(response => response.json())
          .then(downloadInfo => this.currNumDownloads = downloadInfo);
      },
      setAuthorInfo: function(authorId) {
        fetch('/get-author-info?userId=' + authorId)
          .then(response => response.json())
          .then(userInfo => this.authorInfo = userInfo);
      }
    },
    watch: {
      id: function(noteId) {
        if(noteId) {
          this.setFavorite(noteId);
          this.setDownload(noteId);
          this.setAuthorInfo(this.authorId);
        }
      },
      favorited: function(favoriteStatus) {
        this.iconColor = this.favorited ? 'yellow' : 'undefined';
      }
    },
    computed: {
      modifiedSourceUrl: function() {
        if(this.sourceUrl && this.sourceUrl.includes('google')) {
          return this.sourceUrl + '/preview';
        }
        return this.sourceUrl;
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
