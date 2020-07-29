<template>
  <v-form ref="form" id="search-form" @submit.prevent="onSubmit">
    <v-row>
      <v-col class="left">
        <v-text-field label="School"
                      v-model.trim="school"
                      placeholder="Cambridge University">
        </v-text-field>

        <v-text-field label="Course"
                      v-model.trim="course"
                      placeholder="CS4410">
        </v-text-field>
      </v-col>

      <v-col class="right">
        <v-btn type="submit">Search</v-btn>
      </v-col>
    </v-row>
    <v-row id="error-container" v-if="error">
      <p>{{ error }}</p>
    </v-row>
  </v-form>
</template>

<script>
module.exports = {
  data: function() {
    return {
      school: this.$route.query.school,
      course: this.$route.query.course,
      error: null,
    }
  },
  computed: {
    formIsValid: function() {
      return this.school || this.course;
    },
  },
  methods: {
    onSubmit: function(event) {
      if(this.formIsValid) {
        this.onValidForm();
      } else {
        this.onInvalidForm();
      }
    },
    onValidForm: function () {
      this.error = null;
      this.$router.push({
        path: 'search',
        query: {
          school: this.school,
          course: this.course,
        }
      });
    },
    onInvalidForm: function () {
      this.error = "Please enter at least one search criterion.";
    },
    fetchAndEmitResults: async function() {
      let url = new URL("/search", window.location.href);
      this.school && url.searchParams.set('school', this.school);
      this.course && url.searchParams.set('course', this.course);
      url.searchParams.set('timespan', "this-week")

      return fetch(url)
        .then(response => response.json())
        .then(result => {
          this.$emit('searchresult', result);
        })
        .catch(error => {
          throw new Error(error);
        });
    },
  },
  watch: {
    // When $route changes, component is reused, so manually set new school and course and fetch results.
    $route: function(to, from) {
      this.school = to.query.school;
      this.course = to.query.course;
      this.fetchAndEmitResults();
    }
  },
  mounted: function() {
    if (this.formIsValid) this.fetchAndEmitResults();
  },
}
</script>

<style scoped>
.right {
  align-items: center;
  display: flex;
  flex-grow: 0;
}

#search-form {
  align-self: center;
  min-width: 375px;
  width: 30%;
}

#error-container {
  color: red;
  display: flex;
  justify-content: center;
}
</style>