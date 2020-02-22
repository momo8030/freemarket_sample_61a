$(function(){
  $('#nav a .list__mypage-active').each(function(){
      var $href = $(this).attr('href');
      if(location.href.match($href)) {
      $(this).addClass('active');
      } else {
      $(this).removeClass('active');
      }
  });
});