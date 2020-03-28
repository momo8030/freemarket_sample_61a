$(function(){
  var dropzone = $('.dropzone-area'); //クリックすると画像を選択出来るエリア・・・上段
  var dropzone2 = $('.dropzone-area2'); //クリックすると画像を選択出来るエリア・・・下段
  var input_area = $('.input_area'); //new_imageの保管場所
  var count_data = $('.img_view').length; //img_viewの個数を数える
  var preview = $('#preview');
  var preview2 = $('#preview2');

  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0];
    var reader = new FileReader(); 
    var img = $(`<div class= "img_view"><img></div>`);
    
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn delete">削除</div></div>'); 
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }
    reader.readAsDataURL(file);
    
    var minus_area = count_data += 1 //クリックエリアの伸縮用にimg_viewの個数を数える
    // previewへの条件分岐
    if (minus_area >= 5){
      preview2.append(img);
    }
    else {
      preview.append(img);
    }

    // クリックエリア伸縮
    if (minus_area >= 5){
      dropzone.css({
        'display': 'none'
      })
      dropzone2.css({   
        'display': 'block'
      })
      dropzone2.css({
        'width': `calc(100% - (20% * ${minus_area - 5}))`
      })
    }
    else {
      dropzone.css({
        'display': 'block'
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${minus_area}))`
      })
      dropzone2.css({   
        'display': 'none'
      })
    }
    if (minus_area >= 1) {
      dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
    }
    if (minus_area == 9) {
      dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
    }
    if (minus_area == 10) {
      dropzone2.css({
        'display': 'none'
      })
    }

    var image_id = $(this).data('image');
    image_id += 1
    $('.dropzone-box').attr('for',`item_images_attributes_${image_id}_url`);
    var new_image = $(`<input name="item[images_attributes][${image_id}][url]", class="upload-image" data-image="${image_id}", type="file", id="item_images_attributes_${image_id}_url">`);
    input_area.append(new_image);
    var count_id = $(this).data('image');
    $('img:last').attr('data-image', `${count_id}`)
  });

  $(document).on('click', '.delete', function() {
    $(this).parent().parent().remove();
    var del_id = $(this).parent().prev().data('image');
    var del_image = $(`<input name="item[images_attributes][${del_id}][_destroy]", class="delete-image", type="hidden", value=1>`);
    preview2.append(del_image);
  
    var plus_area = count_data -= 1 //クリックエリアの伸縮用にimg_viewの個数を数える
    // if 灰色のやつ 増えるver
    if (plus_area <= 9) { 
      dropzone.css({
        'display': 'none'
      })
      dropzone2.css({   
        'display': 'block'
      })
      dropzone2.css({
        'width': `calc(100% - (20% * ${plus_area - 5}))`
      })
    }
    if (plus_area <= 4) {
      dropzone.css({
        'display': 'block'
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${plus_area}))`
      })
      dropzone2.css({   
        'display': 'none'
      })
    }
    if (plus_area <= 8) {
      dropzone2.find('i').replaceWith('<p>ここをクリックしてくださいよ</p>')
    }
    else {
      dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
    }
    if (plus_area <= 2) {
      dropzone.find('i').replaceWith('<p>ここをクリックしてくださいよ</p>')
    }
    else {
      dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
    }
  });
  
  if (count_data >= 5) {
    dropzone.css({
    'display': 'none'
    })
  }
  if (count_data <= 5) {
    dropzone.css({
    'width': `calc(100% - (20% * ${count_data}))`
    })
  }
  if (count_data >= 5) {
    dropzone2.css({
    'width': `calc(100% - (20% * ${count_data - 5}))`,
    'display': 'block'
    })
  }
  if (count_data == 9) {
    dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
  }

  if (document.URL.match(/edit/)) {
    var preview_img = document.getElementById('preview').children;
    var move_image = document.getElementById('preview2');
    if (count_data == 10){
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
    }
    if (count_data == 9){
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
    }
    if (count_data == 8) {
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
    }
    if (count_data == 7) {
      move_image.appendChild(preview_img[5]);
      move_image.appendChild(preview_img[5]);
    }
    if (count_data == 6) {
      move_image.appendChild(preview_img[5]);
   }
  }
})