<template>
  <div class="labels-list">
    <!-- School Label -->
    <v-chip dark label
            class="ma-1"
            color="orange"
            :close="canModify"
            close-icon='mdi-find-replace'>
      <v-avatar left
                color="orange darken-3">
        {{school}}
      </v-avatar>
      {{school}}
    </v-chip>

    <!-- Course Label -->
    <v-chip dark label
            class="ma-1"
            color="blue"
            :close="canModify"
            close-icon='mdi-find-replace'>
      <v-icon left x-small>
        {{course}}
      </v-icon>
      {{course}}
    </v-chip>

    <!-- Remaining Labels -->
    <v-chip label
            class="ma-1"
            v-for="label in labels"
            :key="label"
            :close="canModify"
            close-icon='mdi-delete'>
      {{label}}
    </v-chip>

    <v-chip label
            v-if="canModify">
      <v-icon>
        mdi-plus
      </v-icon>
    </v-chip>
  </div>  
</template>

<script>
module.exports = {
  props: {
    canModify: {
      type: Boolean,
      default: function() {
        return false;
      }
    },
    school: {
      type: String,
      default: function() {
        return 'Unaffiliated';
      }
    },
    course: {
      type: String,
      default: function() {
        return 'Unaffiliated';
      }
    },
    labels: Array
  }
}
</script>
