//価格表示
$('#sell-price').on('keyup', function(){
  var price = $(this).val();
  var commission = Math.floor(price * 0.1)
  var seller_gain = price - commission

  if (price >= 300 && price <= 9999999) {
    $('#commission').text('¥' + commission.toLocaleString())
    $('#seller_gain').text('¥' + seller_gain.toLocaleString())
  } else {
    $('#commission').text('--')
    $('#seller_gain').text('--')
  }
})
