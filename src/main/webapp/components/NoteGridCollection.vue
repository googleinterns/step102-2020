<template>
  <div class="note-grid-collection">
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
    notes: {
      type: Array,
      required: true,
    },
  },
  methods: {
    onClick: function(note) {
      this.$parent.$emit('open-preview', note)
    },
  },
}
</script>
