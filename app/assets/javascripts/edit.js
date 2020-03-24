$(function(){
  var dropzone = $('.dropzone-area'); //クリックすると画像を選択出来るエリア・・・上段
  var dropzone2 = $('.dropzone-area2'); //クリックすると画像を選択出来るエリア・・・下段
  var input_area = $('.input_area');
  
  var preview = $('#preview');
  var preview2 = $('#preview2');
  
  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var count_data = $('.img_view').length;
    
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

    if (count_data > 5){
      preview2.append(img);

      dropzone.css({
        'display': 'none'
      })
      dropzone2.css({   
        'display': 'block'
      })
    }
    else {
      preview.append(img);

      dropzone.css({
        'display': 'block'
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${count_data}))`
      })
      dropzone2.css({   
        'display': 'none'
      })
    }

    // if 灰色のやつ

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
    $('#preview2').append(del_image);
  });

  // if 灰色のやつ 増えるver
  
})






// $(function(){

//   //プレビューのhtmlを定義
//   function buildHTML(count) {
//     var html = `<div class="preview-box" id="preview-box__${count}">
//                   <div class="upper-box">
//                     <img src="" alt="preview">
//                   </div>
//                   <div class="lower-box">
//                     <div class="update-box">
//                       <label class="edit_btn">編集</label>
//                     </div>
//                     <div class="delete-box" id="delete_btn_${count}">
//                       <span>削除</span>
//                     </div>
//                   </div>
//                 </div>`
//     return html;
//   }

//   // 投稿編集時
//   //items/:i/editページへリンクした際のアクション=======================================
//   if (window.location.href.match(/\/items\/\d+\/edit/)){
//     //登録済み画像のプレビュー表示欄の要素を取得する
//     var prevContent = $('.label-content').prev();
//     labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
//     $('.label-content').css('width', labelWidth);
//     //プレビューにidを追加
//     $('.preview-box').each(function(index, box){
//       $(box).attr('id', `preview-box__${index}`);
//     })
//     //削除ボタンにidを追加
//     $('.delete-box').each(function(index, box){
//       $(box).attr('id', `delete_btn_${index}`);
//     })
//     var count = $('.preview-box').length;
//     //プレビューが5あるときは、投稿ボックスを消しておく
//     if (count == 5) {
//       $('.label-content').hide();
//     }
//   }
//   //=============================================================================

//   // ラベルのwidth操作
//   function setLabel() {
//     //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
//     var prevContent = $('.label-content').prev();
//     labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
//     $('.label-content').css('width', labelWidth);
//   }

//   // プレビューの追加
//   $(document).on('change', '.hidden-field', function() {
//     setLabel();
//     //hidden-fieldのidの数値のみ取得
//     var id = $(this).attr('id').replace(/[^0-9]/g, '');
//     //labelボックスのidとforを更新
//     $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
//     //選択したfileのオブジェクトを取得
//     var file = this.files[0];
//     var reader = new FileReader();
//     //readAsDataURLで指定したFileオブジェクトを読み込む
//     reader.readAsDataURL(file);
//     //読み込み時に発火するイベント
//     reader.onload = function() {
//       var image = this.result;
//       //プレビューが元々なかった場合はhtmlを追加
//       if ($(`#preview-box__${id}`).length == 0) {
//         var count = $('.preview-box').length;
//         var html = buildHTML(id);
//         //ラベルの直前のプレビュー群にプレビューを追加
//         var prevContent = $('.label-content').prev();
//         $(prevContent).append(html);
//       }
//       //イメージを追加
//       $(`#preview-box__${id} img`).attr('src', `${image}`);
//       var count = $('.preview-box').length;
//       //プレビューが5個あったらラベルを隠す 
//       if (count == 5) { 
//         $('.label-content').hide();
//       }

//       //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す=============
//       if ($(`#item_images_attributes_${id}__destroy`)){
//         $(`#item_images_attributes_${id}__destroy`).prop('checked',false);
//       } 
//       //=============================================================================

//       //ラベルのwidth操作
//       setLabel();
//       //ラベルのidとforの値を変更
//       if(count < 5){
//         $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
//       }
//     }
//   });

//   // 画像の削除
//   $(document).on('click', '.delete-box', function() {
//     var count = $('.preview-box').length;
//     setLabel(count);
//     var id = $(this).attr('id').replace(/[^0-9]/g, '');
//     $(`#preview-box__${id}`).remove();

//     //新規登録時と編集時の場合分け==========================================================

//     //新規投稿時
//     //削除用チェックボックスの有無で判定
//     if ($(`#item_images_attributes_${id}__destroy`).length == 0) {
//       //フォームの中身を削除 
//       $(`#item_images_attributes_${id}_image`).val("");
//       var count = $('.preview-box').length;
//       //5個めが消されたらラベルを表示
//       if (count == 4) {
//         $('.label-content').show();
//       }
//       setLabel(count);
//       if(id < 5){
//         $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});

//       }
//     } else {

//       //投稿編集時
//       $(`#item_images_attributes_${id}__destroy`).prop('checked',true);
//       //5個めが消されたらラベルを表示
//       if (count == 4) {
//         $('.label-content').show();
//       }

//       //ラベルのwidth操作
//       setLabel();
//       //ラベルのidとforの値を変更
//       //削除したプレビューのidによって、ラベルのidを変更する
//       if(id < 5){
//         $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
//       }
//     }
//     //=============================================================================
//   });
// });