<template>
  <div>
    <v-row v-if="noteData.length">
      <v-card-title>{{header}}</v-card-title>
    </v-row>

    <v-slide-group v-model="selected" 
                   show-arrows
                   center-active>
      <v-slide-item v-for="(note, index) in notes"
                        :key="index"
                        v-slot="{ active, toggle }">
        <div> <!-- This div supresses "multiple nodes" warning -->
          <note-grid-card v-bind="note"
                          :is-active="active"
                          @activate="toggle"
                          @open-preview="onOpenPreview(note)">
          </note-grid-card>
        </div>
      </v-slide-item>
    </v-slide-group>
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
  data: function() {
    return {
      selected: null,
    }
  },
  computed: {
    notes: function() {
      // When the rendered notes change, move slide-group back to start
      // By selecting first item, then unselecting it at the next tick.
      this.selected = 0;
      this.nextTick(() => this.selected = null)
      // Filter by date, matching terms, and sort with compareFunc
      return this.noteData
        .map(this.parseData)
        .filter(this.dateFilter)
        .filter(this.noteFilter)
        .sort(this.compareFunc);
    },
  },
  methods: {
    onOpenPreview: function(note) {
      this.$parent.$emit('open-preview', note);
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
    nextTick: function(f) {
      // Avoids race conditions with function f
      setTimeout(f, 0);
    }
  },
}
</script>
