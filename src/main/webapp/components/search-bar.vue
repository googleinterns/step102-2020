<template>
  <form class="flex" id="search-container" action="/" @submit="checkForm">
    <div class="flex">
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
    </div>
    <p class="red" v-if="error">{{ error }}</p>
  </form>
</template>

<script>
module.exports = {
  data: function() {
    return {
      school: null,
      course: null,
      error: null
    }
  },
  methods: {
    checkForm: function(e) {
      if(!this.school && !this.course) {
        e.preventDefault();
        this.error = "Please input either a school or course code.";
      }
      else {
        this.error = "";
      }
    }
  }
}
</script>

<style scoped>
input {
  font-size: inherit;
}

p {
  margin: 0;
}

.flex {
  display: flex;
}

.red {
  color: red;
}

#search-container {
  align-items: center;
  flex-direction: column;
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