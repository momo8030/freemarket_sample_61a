// $(function(){
//   $("ul#list_active li").click(function(){
//     $("ul#list_active li.selected").removeClass("selected");
//     $(this).addClass("selected");
//   });
// });
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