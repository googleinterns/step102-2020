<template>
  <div class="note-grid-collection">
    <note-grid-card v-for="(note, index) in activeNotes"
                    :key="index"
                    v-bind="note"
                    @click="onClick(note)">
    </note-grid-card>
  </div>
</template>

<script>
module.exports = {
  components: {
    'note-grid-card': httpVueLoader('/components/NoteGridCard.vue'),
  },
  props: {
    notes: {
      type: Array,
      required: true,
    },
    filters: Array,
  },
  computed: {
    activeNotes: function() {
      // Filter the notes that get shown based on filter provided by parent.
      if (this.filters && this.filters.length) {
        return this.notes.filter(note => {
          return this.filters.some(filter => {
            return note.miscLabels.includes(filter)
          });
        });
      }
      else return this.notes;
    },
  },
  methods: {
    onClick: function(note) {
      this.$parent.$emit('open-preview', note)
    },
  },
}
</script>
