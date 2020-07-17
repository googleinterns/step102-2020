<template>
  <div id="note-grid">
    <!-- A single preview component that shows the noteToPreview-->
    <note-preview v-bind="noteToPreview"
                  :is-favorited="isFavorited">
    </note-preview>

    <!-- Slot for all the <note-grid-collection> components -->
    <slot></slot>
  </div>
</template>

<script>
module.exports = {
  components: {
    'note-preview': httpVueLoader('/components/NotePreview.vue'),
  },
  data: function() {
    return {
      isFavorited: true,
      noteToPreview: {},
    }
  },
  mounted: function() {
    this.$on('open-preview', note => {
      this.noteToPreview = note;
      console.log(this.noteToPreview);
    });
  }
}
</script>
