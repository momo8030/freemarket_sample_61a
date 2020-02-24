$(function(){
  const priceInput = '#price_calc';  //販売価格
  const feeFeild = '#sell_fee';     //手数料(10%)
  const profitFeild = '#sell_profit';   //販売利益

  $(priceInput).on('input', function(){   //リアルタイムで表示したいのでinputを使う｡入力の度にイベントが発火｡
    let input = $(this).val();
    if (input >= 300 && input <= 9999999){
      let fee = Math.floor(input * 0.1);
      let profit = "¥" + (input - fee).toLocaleString();
      $(feeFeild).html("¥" + fee.toLocaleString());
      $(profitFeild).html(profit);
    } else {
      let fee = '-';
      let profit = '-';
      $(feeFeild).html(fee);
      $(profitFeild).html(profit);
    };
  });
});