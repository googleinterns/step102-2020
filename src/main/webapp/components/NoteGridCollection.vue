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
                        v-slot="{ toggle }">
        <div> <!-- This div supresses "multiple nodes" warning -->
          <note-grid-card v-bind="note"
                          @click="onClick(toggle, note)">
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
      // When the rendered notes change, move slide-group back to start.
      this.selected = 0;
      // Filter by date, matching terms, and sort with compareFunc
      return this.noteData
        .filter(this.dateFilter)
        .filter(this.noteFilter)
        .sort(this.compareFunc);
    },
  },
  methods: {
    onClick: function(toggleFunc, note) {
      toggleFunc();
      this.$parent.$emit('open-preview', note);
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
    dateFilter: function(note) {
      // If no age restriction, immediately pass filter.
      if (!this.maxAge) return true;

      // Pass if younger than maxAge.
      return Date.now() - note.date < this.maxAge;
    }
  },
}
</script>
