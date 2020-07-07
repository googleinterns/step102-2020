<template>
  <div class="flex-row" id="search-container">
    <div class="flex-col" id="search-box">
      <span class="search-item">
        <label>School: </label>
        <input type="text" v-model="school" placeholder="Cambridge University">
      </span>
      <span class="search-item">
        <label>Course: </label>
        <input type="text" v-model="course" placeholder="CS4410">
      </span>
    </div>
    <div id="submit">
      <button v-on:click="search">Search</button>
    </div>
  </div>
</template>

<script>
module.exports = {
  data: function() {
    return {
      school: "",
      course: ""
    }
  },
  methods: {
    search() {
      // Implement search
      console.log(this.school);
      console.log(this.course);
    }
  }
}
</script>

<style>
#search-container {
  font-size: 1.5rem;
}

.flex-row {
  display: flex;
  flex-direction: row;
}

.flex-col {
  display: flex;
  flex-direction: column;
}

button,
input {
  font-size: inherit;
}

#search-box {
  min-width: 20%;
}

.search-item {
  align-items: center;
  display: flex;
  margin: 5px 0;
}

.search-item input {
  flex-grow: 1;
  margin-left: 3px;
  padding: 5px 10px;
}

#search-container {
  justify-content: center;
  width: 100%;
}

#search-container div {
  margin: 5px;
}

#submit {
  display: flex;
}

#submit button{
  margin: 5px 0;
}
</style>