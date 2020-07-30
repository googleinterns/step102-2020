<!--
  This component is used for testing.
-->
<template>
  <v-btn @click="loadMock">Load Mock Search Results</v-btn>
</template>

<script>
const MILLIS_PER_SEC = 1000;
const MILLIS_PER_MIN = 60 * MILLIS_PER_SEC;
const MILLIS_PER_HOUR = 60 * MILLIS_PER_MIN;
const MILLIS_PER_DAY = 24 * MILLIS_PER_HOUR;
const MILLIS_PER_WEEK = 7 * MILLIS_PER_DAY;

module.exports = {
  data: function() {
    return {
      result: [
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "AC set of notes",
          dateCreated: new Date(Date.now() - 3 * MILLIS_PER_DAY).toDateString(),
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
          dateCreated: new Date(Date.now() - 10 * MILLIS_PER_DAY).toDateString(),
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
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "ABC set of notes",
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "ABC set of notes",
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "ABC set of notes",
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "ABC set of notes",
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "ABC set of notes",
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "A really long title on the card that should test overfill handling",
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "GHI",
          course: "ENC1101",
          miscLabels: ["A", "B", "C"],
          numDownloads: 345,
          numFavorites: 678,
          isFavorited: false,
          pdfSource: "/assets/notes.pdf"
        },
        {
          thumbnailSrc: "/assets/notes.png",
          author: "Andres H.",
          title: "ABC set of notes",
          dateCreated: new Date(Date.now() - MILLIS_PER_DAY * 6).toDateString(),
          school: "A really long school name to test overfill handling",
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