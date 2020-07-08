<template>
  <form class="flex" id="search-container" action="/" @submit="checkForm">
    <div class="flex" id="search-area">
      <div class="flex search-item">
        <label for="school">School:</label>
        <input
            type="text"
            id="school"
            name="school"
            v-model.trim="school"
            placeholder="Cambridge University">
      </div>
      <div class="flex search-item">
        <label for="course">Course:</label>
        <input
            type="text"
            id="course"
            name="course"
            v-model.trim="course"
            placeholder="CS4410">
      </div>
    </div>
    <input type="submit" value="Search" id="search-btn">
  </form>
</template>

<script>
module.exports = {
  data: function() {
    return {
      school: null,
      course: null
    }
  },
  methods: {
    checkForm: function(e) {
      if(!this.school && !this.course) {
        e.preventDefault();
        // TODO: Add error message on form
      }
    }
  }
}
</script>

<style scoped>
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

#search-btn {
  margin: 10px;
}
</style>