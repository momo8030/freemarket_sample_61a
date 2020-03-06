$(function(){
  var dropzone = $('.dropzone-area'); //クリックすると画像を選択出来るエリア・・・上段
  var dropzone2 = $('.dropzone-area2'); //クリックすると画像を選択出来るエリア・・・下段
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  //input_areaをクリックしたらイベント発火
  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0];
    var reader = new FileReader(); //リアルタイムでブラウザに表示
    inputs.push($(this));//選択したimgのプレビュー作成
    var img = $(`<div class= "img_view"><img></div>`); //divタグ作成
    reader.onload = function(e) {  //ファイルを読み込んだあと以下実行
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>'); 
      img.append(btn_wrapper); //編集・削除ボタン作成
      img.find('img').attr({
        src: e.target.result
      })
    }
    reader.readAsDataURL(file);
    images.push(img);

    //画像プレビューのコード
    if(images.length >= 5) {  //data-image(画像の数)が５個以上なら画像プレビュー ２段目表示
      dropzone2.css({
        'display': 'block'
      })
      
      dropzone.css({   
        'display': 'none'
      })
      $.each(images, function(index, image) {  //data-imageに +1追加 画像の数をカウント
        image.attr('data-image', index); 
        preview2.append(image);
        dropzone2.css({
          'width': `calc(100% - (125px * ${images.length - 5}))`  //画像が増える度にクリックエリアが減っていく・・下段
        })
      })
      if(images.length == 9) {  //data-image(画像の数)が９個になれば pタグをカメラアイコンに変更
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {  //data-imageに +1追加 画像の数をカウント
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (125px * ${images.length}))`  //画像が増える度にクリックエリアが減っていく・・上段
        })
      }
      if(images.length == 2) {
        dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>') //data-image(画像の数)が2個になれば pタグをカメラアイコンに変更
      }
    if(images.length == 10) {  //data-image(画像の数)が10個になれば下段のクリックエリアを非表示
      dropzone2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.prepend(new_image); //上記クリックエリア追加
  });

  //削除ボタンを押したらイベント発火
  $(document).on('click', '.delete', function() {
    var target_image = $(this).parent().parent();  //parent()・・一つ上の階層の親要素を取得、ここではparent２つでclass: img_viewの情報を変数に代入
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){ //data-imageが同じなら remove(削除) する
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');  //ボタンが押されたdata-image の値を numに代入
        images.splice(num, 1);  //num番目の要素を1つ削除
        inputs.splice(num, 1);
        //以下画像削除に伴いブラウザ表示崩れない様にするコード
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (125px * ${images.length - 5}))`
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 8) {
        dropzone2.find('i').replaceWith('<p>ここをクリックしてくださいな</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (125px * ${images.length}))`
      })
    }
    if(images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if(images.length == 2) {
      dropzone.find('i').replaceWith('<p>ここをクリックしてくださいよ</p>')
    }
  })
});