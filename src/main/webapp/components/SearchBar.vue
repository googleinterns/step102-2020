<template>
  <form class="flex" id="search-container" action="/" @submit.prevent="onSubmit">
    <div class="flex" id="input-area">
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
    onSubmit: function(event) {
      if(!this.school && !this.course) {
        this.error = "Please enter at least one search criterion.";
      }
      else /* Form validated */ {
        this.error = "";
        this.queryDatabase(this.school, this.course)
          .then(result => this.$emit('searchresult', result))
          .catch(error => this.error = error);
      }
    },
    queryDatabase: async function(school, course) {
      let url = new URL("/notes", window.location.href);
      url.searchParams.set('school', school);
      url.searchParams.set('course', course);

      return fetch(url).then(response => response.json())
        .catch(error => {
          throw new Error(error);
        });
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

#input-area {
  min-width: 25%;
}

#search-area {
  flex-direction: column;
  flex-grow: 1;
  margin: 5px;
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