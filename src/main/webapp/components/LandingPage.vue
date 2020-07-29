<template>
  <div>
    <v-container fluid class="no-pad wave">
      <v-row id="info">
        <v-col class="text-center" cols="12">
          <v-spacer class="lg-spacer"></v-spacer>
          <h1 class="font-weight-bold display-4 white-text">
            starfish
            <img src="/assets/starfish.png"
                 id="starfish-logo">
          </h1>
          <v-spacer></v-spacer>
          <h4 class="display-1 white-text">
            Share and find the best course notes. Completely free.
          </h4>
          <v-spacer class="md-spacer"></v-spacer>
          <v-btn color="blue lighten-2"
                 id="find-btn"
                 rounded
                 x-large
                 dark>
            Find your perfect <br> notes now.
          </v-btn>
          <v-spacer></v-spacer>
        </v-col>
      </v-row>
      <v-row align="center" justify="center">
        <v-img src="/assets/laptop-min.png"
               id="laptop-img">
        </v-img>
      </v-row>
    </v-container>
    <v-container fluid class="no-pad">
      <v-row align="center" justify="center">
        <v-card class="mx-auto">
          <v-card-title class="no-wrap-fix heading-1">
            Quickly identify course notes relevant to you.
          </v-card-title>
          <v-card-text class="no-wrap-fix subheading-1">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
          </v-card-text>
        </v-card>
        <v-card class="mx-auto"
                max-width="400">
          <v-card-title class="no-wrap-fix heading-1">
            Get recognized by your peers and earn points for the notes you share.
          </v-card-title>
          <v-card-text class="no-wrap-fix subheading-1">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
          </v-card-text>
        </v-card>
        <v-card class="mx-auto"
                max-width="400">
          <v-card-title class="no-wrap-fix heading-1">
            Increase learning accessibility at universities everywhere!
          </v-card-title>
          <v-card-text class="no-wrap-fix subheading-1">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
          </v-card-text>
        </v-card>
      </v-row>
    </v-container>
  </div>
</template>

<style scoped>
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

#starfish-logo {
  height: 1em;
  margin-bottom: -0.1em;
}

#find-btn {
  font-size: 1.25rem;
  height: auto;
  padding: 8px 23px;
}

#laptop-img {
  max-width: 600px;
}

.wave {
  background-color: #1565C0;
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

.heading-1 {
  font-size: 1.7rem;
  font-weight: 500;
}

.subheading-1 {
  font-size: 1.2rem;
}

.v-card {
  max-width: 400px;
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