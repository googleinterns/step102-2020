<template>
  <nav class="blue sticky nav-bar">
    <a href="index.html" class="bold" id="title">starfish</a>
    <img src="../assets/starfish.png" id="logo">
    <div id="action-items">
      <a href="#" id="post-action">PostANote</a>
      <div class="dropdown">
        <button class="dropdown-btn" @click.stop="toggleDropdown">
          <img id="user-profile" src="../assets/user.svg">
        </button>
        <div class="light-gray dropdown-content" v-if="showDropdown" v-click-outside="hideDropdown">
          <img src="../assets/user.svg" height="115px"/>
          <p class="bold" id="dropdown-name">{{ user.name }}</p>
          <p id="dropdown-points">{{ user.points }} points</p>
          <a class="dropdown-link" href="#">My Profile</a> 
          <a class="dropdown-link" href="#">Favorite Notes</a>
          <a class="dropdown-link" href="#">Logout</a>
        </div>
      </div>
    </div> 
  </nav>
</template>

<script>
Vue.directive('click-outside', {
  bind: function (el, binding, vnode) {
    this.event = function(event) {
      if(!(el == event.target || el.contains(event.target))) {
        vnode.context[binding.expression](event);
      }
    };
    document.body.addEventListener('click', this.event);
  },
  unbind: function(el) {
    document.body.removeEventListener('click', this.event);
  }
});

module.exports = {
  data: function() {
    return {
      showDropdown: false
    }
  },
  props: {
    user: Object
  },
  methods: {
    hideDropdown() {
      this.showDropdown = false;
    },
    toggleDropdown() {
      this.showDropdown = !this.showDropdown;
    }
  }
}
</script>

<style scoped>
.bold {
  font-weight: bold;
}

.blue {
  background-color: #004aad;
}

.light-gray {
  background-color: #f9f9f9;
}

.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}

.nav-bar {
  align-items: center;
  display: flex;
  font-family: 'Roboto';
  height: 80px;
}

.nav-bar a {
  float: left;
  font-size: 1.75em;
  color: white;
  text-decoration: none;
}

#title {
  font-size: 2.75em;
  margin: 0 10px 0 20px;
}

#logo {
  height: 60%;
  padding: 0 0 5px 0;
}

#action-items {
  height: 100%;
  margin-left: auto;
}

#post-action {
  height: 80px;
  line-height: 80px;
  padding: 0;
}

.dropdown {
  overflow: hidden;
  padding: 0 10px 0 20px;
}

.dropdown .dropdown-btn {
  background-color: inherit;
  border: none;
  color: white;
  font-size: 16px;
  font-family: inherit;
  height: 100%;
  margin: 0;
  outline: none;
}

.dropdown .dropdown-btn:hover {
  cursor: pointer;
}

.dropdown-btn img {
  height: 65%;
}

.dropdown-content {
  align-items: center;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  display: flex;
  flex-direction: column;
  height: 375px;
  justify-content: center;
  margin-right: 10px;
  position: absolute;
  right: 0;
  width: 350px;
  z-index: 1;
}

#dropdown-name {
  font-size: 1.75rem;
  margin: 25px 0 0 0;
}

#dropdown-points {
  font-size: 1.5rem;
  margin: 0;
}

.dropdown-content a {
  color: #575757;
  font-size: 1.25rem;
  margin: 20px 0 -15px 0;
  padding: 0;
}
</style>