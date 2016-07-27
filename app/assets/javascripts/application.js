// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function update_location(user_id, position) {
  var lat = position.coords.latitude;
  var lon = position.coords.longitude;
  var user_id = user_id;

  $.ajax({
    type: 'PUT',
    url: "/users/" + user_id,
    data: { user: {latitude: lat, longitude: lon} },
    dataType: 'json',
    success: function(data){ },
    error: function(data) {
      console.log(data);
    }  
  });
}

function get_location1(position) {
  var lat = position.coords.latitude;
  var lon = position.coords.longitude;

  console.log(lat + ', ' + lon);

  $.get({
    url: "/nearby_guests",
    data: { user: {guest: 'true', latitude: lat, longitude: lon} }
  });
}

function toggle_add_new_image() {
  $('#add_image_button').click(function(e) {
    event.preventDefault();
    var show_toggle = +$(this).find('.toggle_add_image_button').attr('data-show');

    switch(show_toggle) {
      case 0:
        $('.toggle_add_image_button').attr('data-show', '1').text("Hide image");
        return $('.new_category_images').css('display', 'block');          
      case 1:
        $('.toggle_add_image_button').attr('data-show', '0').text("Add new picture");
        return $('.new_category_images').css('display', 'none');
      }
  });
}
