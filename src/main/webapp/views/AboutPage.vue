<template>
  <div class="about">
    <v-container fluid class="narrow info-section">
      <h1 class="display-4 heading-1">A Note to the Beach Team</h1>
      <v-row no-gutters>
        When we first heard that our Google internships were going to go remote, we honestly had no 
        idea what to expect. Excitement for the summer had quickly turned to anxiety and we 
        couldn’t help but wonder if this would negatively impact our experience. Maybe if we’d had 
        the chance to meet the team we’d get to work with before our internships started and see 
        how amazing they were, we would’ve been a lot less anxious; nonetheless, within just a 
        couple short weeks, we knew we’d found a virtual place we could call home. Right from the 
        get go, we were invited and encouraged to attend weekly Fikas (A Swedish word meaning to 
        “go out for coffee”), UI+UX, and Eng planning meetings. We learned something unique from 
        every single person and were simply blown away by everybody’s openness to welcome a group 
        of 3 random interns they’ve never met before in person, working on a random open-source 
        project, onto their incredible team. This summer has exceeded our expectations 10 fold and 
        while there’ll be a lot of things we’ll want to forget after the pandemic, our Google 
        internship with the Beach team is one thing we’ll cherish forever &hearts;. 
        See below for a short poem that summarizes our feelings: <br>
        <v-row justify="center">
          <div class="poem">
            <ul>
              <li>Even though we’re really bad at rhymes,</li>
              <li>We want to acknowledge that in these trying times</li>
              <li>You all created a welcoming space</li>
              <li>And made us feel like we had a place -</li>
              <li>In meetings and Fikas and escape room</li>
              <li>Which we had to do over Zoom :((</li>
            </ul> 
            <p></p>
            <ul>
              <li>This summer was unforgettable,</li>
              <li>Extraordinary and incredible. </li>
              <li>So we just wanted to say,</li>
              <li>Thank you very much,</li>
              <li>We wish we could stay,</li>
              <li>But please let’s keep in touch!</li>
            </ul>
          </div>
        </v-row>
      </v-row>
      <h1 class="display-4 heading-1">Meet the Team</h1>
      <v-row justify="space-between">
        <v-col md="4">
          <v-card height="540">
            <v-img src="/assets/aradhya.png"
                   max-height="150"
                   contain>
            </v-img>
            <h2 class="display-1 heading-1">Aradhya</h2>
            I’m passionate about entrepreneurship, technology, mythology, physical cosmology, 
            philosophy, and love to play basketball. I also love reading comic books and have 
            always dreamed of being like Iron Man. I’m a definite optimist at heart and believe 
            that the world tomorrow will be a better place than it is today, and that it’s my 
            responsibility to make it so.
          </v-card>
        </v-col>
        <v-col md="4">
          <v-card height="540">
            <v-img src="/assets/andres.png"
                   max-height="150"
                   contain>
            </v-img>
            <h2 class="display-1 heading-1">Andres</h2>
            I like video games and trying new foods. Catch me playing Skyrim at midnight with a 
            bowl of ramen. I hope to use the experience I gained from this internship to start 
            leading projects that will improve the lives of my local community.
          </v-card>
        </v-col>
        <v-col md="4">
          <v-card height="540">
            <v-img src="/assets/keely.png"
                   max-height="150"
                   contain>
            </v-img>
            <h2 class="display-1 heading-1">Keely</h2>
            I'm a huge bookworm and avid hiker- you'll either find me lost between the pages of my 
            current read (<em>Bridge to Terabithia</em>) or wandering among the mountains and woods 
            and wildlife. I love to explore new places, and I've always dreamed of traveling the 
            world. There's just so much to see and so little time so I better be on my way now!
          </v-card>
        </v-col>
      </v-row>
      <h1 class="display-4 heading-1">Shoutouts</h1>
      <v-row>
      <v-col md="4">
          <v-card height="390">
            <v-img src="/assets/nicholas.png"
                   max-height="150"
                   contain>
            </v-img>
            <h2 class="display-1 heading-1">Nicholas</h2>            
            Thank you for challenging us with interesting problem-solving riddles and creating a 
            friendly environment where we felt comfortable getting to know each other.
          </v-card>
        </v-col>
        <v-col md="4">
          <v-card height="390">
            <v-img src="/assets/beach_team.png"
                   max-height="150"
                   contain>
            </v-img>
            <h2 class="display-1 heading-1">Stofe Beach Team</h2>
            Thanks again to the Beach Team for an amazing summer experience! We felt supported by 
            you 100% of the way.
          </v-card>
        </v-col>
        <v-col md="4">
          <v-card height="390">
            <v-img src="/assets/colette.png"
                   max-height="150"
                   contain>
            </v-img>
            <h2 class="display-1 heading-1">Colette</h2>
            Thank you for encouraging us to reach out to fellow Googlers and helping us meet other 
            interns. 
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<style scoped>
.about {
  font-size: 20px;
}

.narrow {
  max-width: 1250px;
  padding: 25px;
}

.heading-1 {
  font-family: 'Caveat Brush'!important;
  margin: 25px 0;
}

.v-card {
  padding: 25px 10px;
}

.v-card h2 {
  text-align: center;
  margin: 0;
}

.poem ul
{
  list-style-type: none;
}

.poem li
{
  font-style:italic;
  padding-bottom: 0.1em;
}

.poem li:first-child::first-letter
{
  font-size:26px;
  font-style:italic;
  padding-right:3px;
}

.poem li:not(:first-child)
{
  margin-left: 26px;
}
</style>