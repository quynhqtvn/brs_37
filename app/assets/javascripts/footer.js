$('#nav').affix({
  offset: {
    top: $('header').height() - $('#nav').height()
  }
});	

$('body').scrollspy({ target: '#nav' })

$('.scroll-top').click(function(){
  $('body,html').animate({scrollTop:0}, 1000);
})

$('#nav .navbar-nav li>a').click(function(){
  var link = $(this).attr('href');
  var posi = $(link).offset().top + 20;
  $('body,html').animate({scrollTop: posi}, 700);
})
