<template>
  <div class="note-grid-collection">
    <v-card-title>{{header}}</v-card-title>

    <note-grid-card v-for="(note, index) in notes"
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
    noteData: {
      type: Array,
      required: true,
    },
    filters: Array,
    compareFunc: Function,
    header: String,
    maxAge: Number,
  },
  computed: {
    notes: function() {
      // Filter by date, matching terms, and sort with compareFunc
      return this.noteData
        .filter(this.dateFilter)
        .filter(this.noteFilter)
        .sort(this.compareFunc);
    }
  },
  methods: {
    onClick: function(note) {
      this.$parent.$emit('open-preview', note)
    },
    noteFilter: function(note) {
      // If no filter or empty filter, immediately pass filter.
      if (!this.filters || !this.filters.length) return true;

      // Pass if some filter matches a miscLabel, title, or school, or course
      return this.filters.some(filter => {
        return note.miscLabels.includes(filter)
          || note.title.includes(filter)
          || note.school.includes(filter)
          || note.course.includes(filter)
      });
    },
    dateFilter: function(note) {
      // If no age restriction, immediately pass filter.
      if (!this.maxAge) return true;

      // Pass if younger than maxAge.
      return Date.now() - note.date < this.maxAge;
    }
  },
}
</script>
