<template>
  <v-col>
    <v-card class="note-grid-card" @click="$emit('click')"
            width="208px">
      <v-img :src="thumbnailSrc"
             height="180px"
             position="top">
        <v-icon>{{ isGNote ? "mdi-google-drive" : "mdi-pdf-box" }}</v-icon>             
      </v-img>

      <div class="metadata">
        <div class="note-title">{{title}}</div>

        <div class="info-row">
          <p>{{school}} &bull; {{course}}</p>

          {{dateCreated}}
          <div class="rating-box">
            {{numFavorites}}
            <span class="star" @click.stop="toggleFavorite">&star;</span>          
          </div>
        </div>
      </div>
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
    },
    data: function() {
      return {
        favorited: this.isFavorited,
        isGNote: true,
      }
    },
    computed: {
      thumbnail: function() {
        // TODO: Generate a thumbnail of the pdf
        let source = 'assets/notes.png';
        return {backgroundImage:`url(${source})`};
      },
    },
    methods: {
      onClick: function() {
        this.$emit('click');
      },
      toggleFavorite: function() {
        let method = this.favorited ? 'DELETE' : 'POST';
        this.favorited = !this.favorited;
        fetch('/favorite-note?note_id=' + this.id, {
          method: method
        })
      }
    }
  }
</script>

<style>
/*
  .note-grid-card {
    border: 1px solid #dfe1e5;
    border-radius: 3px;
    width: 208px;
    margin-right: 20px;
    margin-bottom: 20px;
    display: inline-block;
  }

  .note-grid-card:hover {
    border: 2px solid #afdbdf;
  }

  .metadata {
    position: relative;
    border-top: 1px solid #dfe1e5;
  }

  .note-title {
    text-align: center;
    font-weight: bold;
    margin: 2px;
  }

  .info-row {
    text-align: center;
  }

  .info-row p {
    margin: 3px 0;
  }

  .info-row img {
    height: 18px;
    position: absolute;
    bottom: 0;
    left: 0;
    border-top: 2px solid #dfe1e5;
    border-right: 2px solid #dfe1e5;
  }

  .rating-box {
    display: inline-flex;
    position: absolute;
    bottom: 0;
    right: 0;
    height: 18px;
    border-radius: 4px;
    border-top: 2px solid #dfe1e5;
    border-left: 2px solid #dfe1e5;
  }

  .star {
    background-color: #aaa;
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px;
    font-size: 9pt;
  }
*/
</style>
