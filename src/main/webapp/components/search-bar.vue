<template>
  <div class="flex" id="search-container">
    <div class="flex" id="search-area">
      <div class="flex search-item">
        <label for="school">School:</label>
        <input type="text" id="school" v-model.trim="schoolName" placeholder="Cambridge University">
      </div>
      <div class="flex search-item">
        <label for="course">Course:</label>
        <input type="text" id="course" v-model.trim="courseCode" placeholder="CS4410">
      </div>
    </div>
    <div class="flex" id="submit">
      <button v-on:click="search">Search</button>
    </div>
  </div>
</template>

<script>
module.exports = {
  data: function() {
    return {
      schoolName: "",
      courseCode: ""
    }
  },
  methods: {
    search() {
      // TODO: Implement search
    }
  }
}
</script>

<style scoped>
button,
input {
  font-size: inherit;
}

.flex {
  display: flex;
}

#search-container {
  font-size: 1.5rem;
  justify-content: center;
  width: 100%;
}

#search-area {
  flex-direction: column;
  margin: 5px;
  min-width: 20%;
}

.search-item {
  align-items: center;
  margin: 5px 0;
}

.search-item input {
  flex-grow: 1;
  margin-left: 3px;
  padding: 5px 10px;
}

#submit button{
  margin: 10px;
}
</style>