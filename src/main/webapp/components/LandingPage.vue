<template>
  <div>
    <v-container fluid class="no-pad wave">
      <v-row>
        <v-col class="text-center" cols="12">
          <v-spacer class="lg-spacer"></v-spacer>
          <h1 class="font-weight-bold display-4 white-text"
              id="starfish-title">
            starfish
            <img src="/assets/starfish.png"
                 id="starfish-logo">
          </h1>
          <v-spacer></v-spacer>
          <h1 class="display-1 white-text"
              id="starfish-subtitle">
            Share and find the best course notes. Completely free.
          </h1>
          <v-spacer class="md-spacer"></v-spacer>
          <v-row align="center" justify="center">
            <search-bar :is-dark="true" :show-search-button="false"></search-bar>
          </v-row>
        </v-col>
      </v-row>
      <v-row align="center" justify="center">
        <v-img src="/assets/laptop-min.png"
               id="laptop-img">
        </v-img>
      </v-row>
    </v-container>
    <v-container fluid id="info-section">
      <v-row align="center" justify="space-around">
        <v-col sm="6">
          <p class="heading-2">
            Quickly identify course notes relevant to you.
          </p>
          <p class="subheading-2">
            Do you hate taking notes? Wish you could find high quality notes for all your
            classes? Look no further - start by searching for your school and/or course, 
            then filter your results to find exactly what you're looking for. At no cost.
          </p>
        </v-col>
        <v-col sm="4">
          <v-img src="/assets/search.svg"></v-img>
        </v-col>
      </v-row>
      <v-row align="center" justify="space-around">
        <v-col cols="4">
          <v-img src="/assets/share.svg"></v-img>
        </v-col>
        <v-col sm="6">
          <p class="heading-2">
            Earn points for the notes you share.
          </p>
          <p class="subheading-2">
            Do you ever feel like your notes are going to waste once classes are finished?
            Wish you could easily share your notes with your peers? Now you can - just log in 
            with your Google account and upload PDFs of your notes! Even better, earn
            points as you get more downloads and favorites on your uploaded notes. <br><br>
            <em>Coming soon: Redeem your points for awesome rewards!</em>
          </p>
        </v-col>
      </v-row>
      <v-row align="center" justify="space-around">
        <v-col sm="6">
          <p class="heading-2">
            Increase learning accessibility at universities everywhere!
          </p>
          <p class="subheading-2">
            Our goal is to make learning more <em>collaborative</em> by encouraging 
            students to share their course notes. That's why we also made a Chrome 
            extension that can quickly generate a 
            <a href="https://docs.google.com/document/d/1XlcAy-vrleXBxJl5Qy_SxGUyTqcwdUIhyJI2BygpNEc/edit" target="_blank">
              notes template
            </a>
            in Google Docs - perfect for taking notes with your friends.
          </p>
        </v-col>
        <v-col sm="4">
          <v-img src="/assets/collaborate.svg"></v-img>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
module.exports = {
  components: {
    'search-bar': httpVueLoader('/components/SearchBar.vue')
  }
}
</script>

<style>
.no-pad {
  padding: 0;
}

.no-wrap-fix {
  hyphens: auto;
  overflow-wrap: anywhere;
  text-align: center;
  word-wrap: break-word;
  word-break: normal;
}

.white-text {
  color: white;
}

.container {
  margin: 0 0 50px 0;
}

.spacer {
  margin: 10px;
}

#starfish-title {
  font-family: 'Caveat Brush'!important;
}

#starfish-subtitle {
  font-family: 'Coming Soon'!important;
}

#starfish-logo {
  height: 1em;
  margin-bottom: -0.1em;
}

#laptop-img {
  max-width: 600px;
}

.wave {
  background: rgb(3,0,57);
  background: linear-gradient(20deg, rgba(3,0,57,1) 0%, rgba(21,101,192,1) 53%, rgba(115,180,255,1) 100%);
  position: relative;
}

.wave:before {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 250px;
  background: url('/assets/wave.png');
  background-size: cover;
  background-repeat: no-repeat;
}

.heading-2 {
  font-size: 1.7rem;
  font-weight: 500;
}

.subheading-2 {
  font-size: 1.2rem;
}

.v-card {
  max-width: 425px;
}

#info-section {
  margin: 50px auto;
  max-width: 1200px;
}

@media only screen and (min-height: 850px) {
  .lg-spacer {
    margin: 100px!important;
  }

  .md-spacer {
    margin: 20px!important;
  }
}

@media only screen and (min-width: 1750px) {
  #laptop-img {
    max-width: 800px!important;
  }

  .wave:before {
    height: 425px!important;
  }

  .heading-1 {
    font-size: 2rem;
  }

  .subheading-1 {
    font-size: 1.5rem;
    line-height: 1.5rem;
  }

  .v-card {
    max-width: 500px!important;
  }
}
</style>