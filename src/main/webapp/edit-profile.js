function log(event) {
  var image = document.getElementById('profile-img');
	image.src = URL.createObjectURL(event.target.files[0]);
}

