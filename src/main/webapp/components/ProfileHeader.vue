<template>
  <div id="header">
    <div id="title">
      <p id="name">{{ name }}</p>
      <p id="points">{{ points }} points</p>
      <p id="school">{{ school }}</p>
    </div>
  </div>
</template>

<script>
module.exports = {
  props: {
    points: Number,
    name: String,
    displayPicture: String,
    school: String
  }
}
</script>

<style scoped>
#header {
  background-color: rgb(209, 228, 255);
  display: flex;
  padding: 50px;
}

#name {
  font: bold 3.5rem 'Roboto';
  margin: 0;
}

#points {
  color: steelblue;
  font: bold 2rem 'Roboto';
  margin-bottom: 1rem;
}

#school {
  font: italic 1.75rem 'Roboto';
}

#title {
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 80%;
  padding: 0 0 0 20px;
}
</style>
