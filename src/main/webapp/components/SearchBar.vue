<template>
  <v-form ref="form" id="search-form" @submit.prevent="onSubmit">
    <v-row>
      <v-col class="left">
        <v-text-field label="School"
                      v-model.trim="school"
                      placeholder="Cambridge University"
                      :dark="isDark">
        </v-text-field>

        <v-text-field label="Course"
                      v-model.trim="course"
                      placeholder="CS4410"
                      :dark="isDark">
        </v-text-field>
      </v-col>

      <v-col class="right" v-if="showSearchButton">
        <v-btn type="submit">Search</v-btn>
      </v-col>
    </v-row>

    <v-row id="error-container" v-if="error">
      <p>{{ error }}</p>
    </v-row>

    <v-row align="center" justify="center" v-if="!showSearchButton">
      <v-btn color="blue lighten-2"
             dark
             id="find-btn"
             rounded
             type="submit"
             x-large>
        Find your perfect <br> notes now.
      </v-btn>
    </v-row>

  </v-form>
</template>

<script>
module.exports = {
  props: {
    isDark: {
      type: Boolean,
      default: function () {
        return false;
      }
    },
    showSearchButton: {
      type: Boolean,
      default: function () {
        return true;
      }
    }
  },
  data: function() {
    return {
      school: "",
      course: "",
      error: ""
    }
  },
  methods: {
    onSubmit: function(event) {
      if(!this.school && !this.course) {
        this.error = "Please enter at least one search criterion.";
      }
      else /* Form validated */ {
        this.error = "";
        this.queryDatabase(this.school, this.course);
      }
    },
    queryDatabase: function(school, course) {
      let url = new URL("/search", window.location.href);
      url.searchParams.set('school', school);
      url.searchParams.set('course', course);

      fetch(url)
        .then(response => response.json())
        .then(result => {
          this.$emit('searchresult', result);
        })
        .catch(error => {
          throw new Error(error);
        });
    }
  }
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