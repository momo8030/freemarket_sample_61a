$(function(){
  $('.owl-item img').mouseover(function(){
   var $thisImg = $(this).attr('src');
   $('.owl-lazy img').attr({src:$thisImg});
   $('.owl-lazy img').hide();
   $('.owl-lazy img').fadeIn(50);
   return false;
 });
});