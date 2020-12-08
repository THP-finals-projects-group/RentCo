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
    $(this).siblings('span').html(' Cacher');
  } else {
    $(this).siblings('span').html(' Voir');
  }
});