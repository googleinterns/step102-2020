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
        .map(this.parseData)
        .filter(this.dateFilter)
        .filter(this.noteFilter)
        .sort(this.compareFunc);
    }
  },
  methods: {
    onClick: function(note) {
      this.$parent.$emit('open-preview', note)
    },
    parseData: function(note) {
      note[0].date = new Date(note[0].dateCreated);
      // Move trendingScore from tuple to note object.
      let trendingIndex = 1;
      note[0].trendingScore = note[trendingIndex];
      return note[0];
    },
    dateFilter: function(note) {
      // If no age restriction, immediately pass filter.
      if (!this.maxAge) return true;

      // Pass if younger than maxAge.
      return Date.now() - note.date < this.maxAge;
    },
    noteFilter: function(note) {
      // If no filter or empty filter, immediately pass filter.
      if (!this.filters || !this.filters.length) return true;

      // Pass if some filter matches a miscLabel, title, school, or course
      return this.filters.some(filter => {
        filter = filter.toLowerCase();
        return note.miscLabels.some(label => label.toLowerCase() == filter)
          || note.title.toLowerCase().includes(filter)
          || note.school.toLowerCase().includes(filter)
          || note.course.toLowerCase().includes(filter)
        ;
      });
    },
  },
}
</script>
