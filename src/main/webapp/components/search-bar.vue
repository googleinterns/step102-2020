<template>
  <div class="flex" id="search-container">
    <div class="flex" id="search-box">
      <span class="flex search-item">
        <label>School: </label>
        <input type="text" v-model="school" placeholder="Cambridge University">
      </span>
      <span class="flex search-item">
        <label>Course: </label>
        <input type="text" v-model="course" placeholder="CS4410">
      </span>
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
      school: "",
      course: ""
    }
  },
  methods: {
    search() {
      // TODO: Implement search
    }
  }
}
</script>

<style>
.flex {
  display: flex;
}

#search-container {
  font-size: 1.5rem;
}

button,
input {
  font-size: inherit;
}

#search-box {
  flex-direction: column;
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

#search-container {
  justify-content: center;
  width: 100%;
}

#search-container div {
  margin: 5px;
}

#submit button{
  margin: 5px 0;
}
</style>