<template>
  <v-btn @click="loadMock">Load Mock Search Results</v-btn>
</template>

<script>
module.exports = {
  data: function() {
    return {
      result: [
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "AC set of notes",
          date: new Date(0),
          school: "ABC",
          course: "COP3502",
          miscLabels: ["A", "C"],
          numDownloads: 123,
          numFavorites: 456,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "BC set of notes",
          date: new Date(1000 * 60 * 60 * 24 * 3),
          school: "DEF",
          course: "MAC1147",
          miscLabels: ["B", "C"],
          numDownloads: 789,
          numFavorites: 012,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "ABC set of notes",
          date: new Date(1000 * 60 * 60 * 24 * 5),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
      ]
    }
  },
  methods: {
    loadMock: function() {
      this.$emit('searchresult', this.result)
    }
  }
}
</script>