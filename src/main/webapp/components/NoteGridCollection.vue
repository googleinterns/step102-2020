<template>
  <div class="note-grid-collection">
    <note-grid-card v-for="(note, index) in sortedNotes"
    <v-card-title>{{header}}</v-card-title>
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
    compareFunc: Function,
    header: String,
  },
  computed: {
    activeNotes: function() {
      // Filter the notes that get shown based on filter provided by parent.
      if (this.filters && this.filters.length) {
        return this.notes.filter(this.noteFilter);
      }
      return this.notes;
    },
    sortedNotes: function() {
      // Sort the currently active notes using sortFunc for comparisons.
      return this.activeNotes.sort(this.compareFunc);
    }
  },
  methods: {
    onClick: function(note) {
      this.$parent.$emit('open-preview', note)
    },
    noteFilter: function(note) {
      // True if some filter matches a miscLabel, title, or school, or course
      return this.filters.some(filter => {
        return note.miscLabels.includes(filter)
          || note.title.includes(filter)
          || note.school.includes(filter)
          || note.course.includes(filter)
      });
    }
  },
}
</script>
