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
}
</script>
