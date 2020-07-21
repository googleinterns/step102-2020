<template>
  <div>
    <!-- User can set their own filters. -->
    <v-combobox v-model="filters"
                label="Active Filters"
                hint="Add your own"
                multiple chips deletable-chips>
    </v-combobox>
    <!-- Or select from common filters -->
    <v-checkbox v-model="filters"
                v-for="filter in suggestedFilters" 
                :key="filter"
                :label="filter" 
                :value="filter">
    </v-checkbox>
  </div>
</template>

<script>
module.exports = {
  props: {
    value: Array,
    school: String, // TODO: Modify SearchBar.vue to emit school and course to NoteGrid, and pass to FilterList
    course: String,
  },
  data: function() {
    return {
      suggestedFilters: [
        "MAC",
        "ENC",
        "COP",
      ]
    }
  },
  computed: {
    filters: {
      get: function() {
        return this.value;
      },
      set: function(filters) {
        this.$emit('input', filters)
      }
    },
  },
  methods: {
    fetchSuggestedLabels: function() {
      let url = new URL("/common-labels", window.location.href); // TODO: Create the servlet and rename "/common-labels"
      url.searchParams.set('school', this.school);
      url.searchParams.set('course', this.course);

      fetch(url)
        .then(response => response.json())
        .then(result => {
          this.suggestedFilters = result;
        })
        .catch(error => {
          console.error(`FetchError: Server failed to provide a result for `
            + `school: ${this.school} and course: ${this.course}`);
        });
    }
  },
  mounted: function() {
    this.fetchSuggestedLabels(); // TODO: Run this whenever school or course changes.
  }
}
</script>
