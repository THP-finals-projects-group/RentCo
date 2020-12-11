// PAGE SIGN UP AND SIGN IN

function myFunction() {
  var x = document.getElementById("myInput");
  if (x.type === "password" ) {
    x.type = "text";
  } else {
    x.type = "password";
  }
} 

$('#boxid').click(function() {
  if ($(this).is(':checked')) {
    $(this).siblings('label').html(' Cacher');
  } else {
    $(this).siblings('label').html(' Voir');
  }
});


// GOOGLE MAP

function initMap(lat, lng) {
    var myCoords = new google.maps.LatLng(lat, lng);
    var mapOptions = {
    center: myCoords,
    zoom: 14
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    var marker = new google.maps.Marker({
        position: myCoords,
        map: map
    });
}