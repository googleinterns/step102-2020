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

Vue.component("navigation", {
  data() {
    return {
      dropdownIsOpen: false
    }
  },
  template: `
    <nav class="blue nav-bar">
      <a href="index.html" class="bold" id="title">starfish</a>
      <div id="action-items">
        <a href="#" id="post-action">PostANote</a>
        <div class="dropdown">
          <button class="dropbtn" @click.stop="toggleDropdown">
            <img id="user-profile" src="assets/user.svg">
          </button>
          <div class="dropdown-content" v-if=dropdownIsOpen v-click-outside="hideDropdown">
            <img src="assets/user.svg" height="115px"/>
            <p class="bold" id="dropdown-name">Bob the Builder</p>
            <p id="dropdown-points">597 points</p>
            <a class="dropdown-link" href="#">My Profile</a> 
            <a class="dropdown-link" href="#">Favorite Notes</a>
            <a class="dropdown-link" href="#">Logout</a>
          </div>
        </div>
      </div> 
    </nav>`, 
  methods: {
    hideDropdown() {
      this.dropdownIsOpen = false;
    },
    toggleDropdown() {
      this.dropdownIsOpen = !this.dropdownIsOpen;
    }
  }
})

new Vue({ el: "#navbar" });