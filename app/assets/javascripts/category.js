$(function(){
  
  // カテゴリーの選択欄追加
  function appendCategory(){
    let subHTML = `<div class= "condition-form">
                    <i class= 'fas arrow-down', 'chevron-down'></i>
                    <select class="select-form" name="item[category_id]">
                      <option value="">--</option>
                    </select>
                  </div>`;
    $(categoryWrapper).append(subHTML);
  }

  // カテゴリーの選択内容追加
  function appendOption(category, appendWrap){
    let subOptionHTML =`<option value="${category.id}", data-size-id="${category.size}", data-brand-id="${category.brand}">${category.name}</option>`;
    $(appendWrap).children('select').append(subOptionHTML);
  }

  //編集時に関係してくる
  // function attrCustomData(category, appendWrap, index){
  //   $(appendWrap).children('select').children(`option:nth-child(${index + 2})`).attr({
  //     'data-size-id': category.size,
  //     'data-brand-id': category.brand,
  //   });
  // }
  
  //メインカテゴリー
  const categoryWrapper = '#select__category-wrapper';
  const mainCategory = '#select__category-main';
  const subCategory = '#select__category-wrapper div:nth-child(2)';
  const subSubCategory = '#select__category-wrapper div:nth-child(3)';
  const sizeWrap = '#form__group-size';
  const brandWrap = '#form__group-brand';
  
  // メインカテゴリー選択時、サブカテゴリー追加
  $(mainCategory).on('change', function(){
    let sub = $(this).val();
    let sub_sub = "0";
    
    $.ajax({
      type: "GET",  
      url: '/items/new',  
      data: { sub: sub, sub_sub: sub_sub },
      dataType: 'json'
    })
    
    .done(function(categories){
      $(subSubCategory).remove();
      $(subCategory).remove();
      $(sizeWrap).remove();
      appendSizeNull();
      $(brandWrap).remove();
      if(sub != ''){
        appendCategory();
        categories.forEach(function(category){
          appendOption(category, subCategory);
        });
      }
    })
    .fail(function(){
      alert('カテゴリー検索に失敗しました');
    });
  });
  
  // サブカテゴリー選択時、サブサブカテゴリー追加
  $(document).on('change', subCategory, function(){
    let sub = $(mainCategory).val();
    let sub_sub = $(this).children('select').val();
    $.ajax({
      type: "GET",
      url: '/items/new',
      data: { sub: sub, sub_sub: sub_sub },
      dataType: 'json'
    })
    
    .done(function(categories){
      $(subSubCategory).remove();
      $(sizeWrap).remove();
      appendSizeNull();
      $(brandWrap).remove();
      if(sub_sub != '' && categories[0]){
        appendCategory();
        categories.forEach(function(category){
          appendOption(category, subSubCategory);
        });
      }
    })

    .fail(function(){
      alert('カテゴリー検索に失敗しました');
    });
  })
  
  // 編集時、カテゴリー追加
  // if(document.URL.match(/items/) && document.URL.match(/edit/)) {
  //   $(document).ready(function(){
  //     let sub = $(mainCategory).val();
  //     let sub_sub = $(subCategory).children('select').val();
      
  //     $.ajax({
  //       type: "GET",
  //       url: '/items/new',
  //       data: { sub: sub, sub_sub: sub_sub },
  //       dataType: 'json'
  //     })
      
  //     .done(function(categories){
  //       if(sub != ''){
  //         categories.forEach(function(category, index){
  //           attrCustomData(category, subSubCategory, index);
  //         });
  //       }
  //     })
  //     .fail(function(){
  //       alert('カテゴリー編集に失敗しました');
  //     });
  //   });
  // }
  
  // サイズ選択欄追加
  function appendSize(){
    const sizeHTML = `<div class="size-add" id="form__group-size">
                      <label for="product_size">サイズ
                        <span class = "span"> 必須</span>
                      </label>
                      <div class="sell-main__select-wrap">
                        <i class= 'fas arrow-down', 'chevron-down'></i>
                        <select class="select-form" name="item[size_id]" id="product_size_id">
                          <option value="">--</option>
                        </select>
                      </div>
                      <ul class="sell-main__has-error-text"></ul>
                    </div>`;
    $(categoryWrapper).parent().after(sizeHTML);
  }

  // サイズは必須項目のため、選択欄がないとき用に空のvalueを追加
  function appendSizeNull(){
    const sizeNullHTML = `<div id="form__group-size">
                            <input type="hidden" name="product[size_id]" value="99"></input>
                          </div>`;
    $(categoryWrapper).parent().after(sizeNullHTML);
  }

  // サイズ選択内容追加
  function appendSizeOption(size, appendWrap){
    let sizeOptionHTML =`<option value="${size.id}">${size.value}</option>`;
    $(appendWrap).find('select').append(sizeOptionHTML);
  }
  const formBoxDetail = '#form__box-detail';

  // ブランド入力欄追加
  function appendBrand(){
    const brandHTML = `<div class="group-form " id="form__group-brand">
                      <label for="product_brand">ブランド
                        <span class="any">任意</span>
                      </label>
                      <div>
                        <input class="select-form" placeholder="例）シャネル" type="text" name="product[brand]" id="product_brand">
                      </div>
                      <div></div>
                      <ul class="sell-main__has-error-text"></ul>
                    </div>`;
    $(formBoxDetail).children('div:last-child').before(brandHTML);
  }

  // 任意のカテゴリー選択でサイズとブランドの追加
  $(document).on('change', subSubCategory, function(){
    let selectedCategory = $(this).children('select');
    let selectedValue = selectedCategory.val();
    let selectedOption = selectedCategory.children(`[value="${selectedValue}"]`);
    let sizeId = selectedOption.data('size-id');
    let brandId = selectedOption.data('brand-id');

    $.ajax({
      type: "GET",
      url: '/api/items/new',
      data: { group: sizeId },
      dataType: 'json'
    })

    .done(function(sizes){
      $(sizeWrap).remove();
      if(sizeId != '' && sizes[0]){
        appendSize();
        sizes.forEach(function(size){
          appendSizeOption(size, sizeWrap);
        });
      } else {
        appendSizeNull();
      }
    })
    .fail(function(){
      alert('カテゴリー検索に失敗しました');
    });

    $(brandWrap).remove();
    if (brandId == '1'){
      appendBrand();
    }
  });

  const deliveryChargeWrap = '#form__group-delivery-charge';
  const deliveryCharge = '#delivery_charge_id';
  const deliverymethodWrap = '#form__group-delivery-method';

  // 配送方法選択欄の追加
  function appendDeliverymethod(){
    const deliverymethodHTML = `<div id="form__group-delivery-method">
                              <h3 for="product_delivery_method">配送の方法
                                <span class="span">必須</span>
                              </h3>
                              <div class="condition-form">
                                <i class='fas arrow-down', 'chevron-down'></i>
                                <select class="select-form" name="product[delivery_method_id]" id="product_delivery_method_id">
                                  <option value="">--</option>
                              </div>
                              <ul class="sell-main__has-error-text">
                              </ul>
                            </div>`;
    $(deliveryChargeWrap).after(deliverymethodHTML);
  }

  // 配送方法選択内容の追加
  function appendDeliverymethodOption(deliverymethod, appendWrap){
    let deliverymethodOptionHTML =`<option value="${deliverymethod.id}">${deliverymethod.value}</option>`;
    $(appendWrap).find('select').append(deliverymethodOptionHTML);
  }

  // 配送料選択時、配送方法表示
  $(document).on('change', deliveryCharge, function(){
    let deliveryChargeId = $(this).val();
    console.log(deliveryChargeId);
    $.ajax({
      type: "GET",
      url: '/api/items/new_delivery', //items_controller
      data: { charge: deliveryChargeId },
      dataType: 'json'
    })
    
    .done(function(deliverymethods){
      console.log(deliverymethods);
      $(deliverymethodWrap).remove();
      if(deliveryChargeId != '' && deliverymethods[0]){
        appendDeliverymethod();
        deliverymethods.forEach(function(deliverymethod){
          appendDeliverymethodOption(deliverymethod, deliverymethodWrap);
        });
      }
    })
    .fail(function(){
      alert('カテゴリー検索に失敗しました');
    });
  });
});