  function selectFile(){
  // 新規投稿・編集ページのフォームを取得
  const postForm = document.getElementById('form_post');
  // プレビューを表示するためのスペースを取得
  const previewList = document.getElementById('previews');
  // 新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。
  if (!postForm) return null;

  // input要素を取得。name情報は検証ツールから確認すること！！
  const fileField = document.querySelector('input[type="file"][name="post[image]"]');
  // input要素で値の変化が起きた際に呼び出される関数
  fileField.addEventListener('change', function(e){
  // 古いプレビューが存在する場合は削除(最後に記述する)
  const alreadyPreview = document.querySelector('.preview');
  if (alreadyPreview) {
    alreadyPreview.remove();
  };
  // 取得した画像ファイルの情報は、変数fileに格納する
  const file = e.target.files[0];
  // 取得した画像情報のURLを生成(生成されたURLはblobという変数に代入)
  const blob = window.URL.createObjectURL(file);
  // 画像を表示するためのdiv要素を生成
  const previewWrapper = document.createElement('div');
  previewWrapper.setAttribute('class', 'preview mt-3 d-flex justify-content-center');
  // 表示する画像を生成
  const previewImage = document.createElement('img');
  previewImage.setAttribute('class', 'preview-image w-50 ');
  // setAttributeメソッドを用いて生成したimg要素のsrc属性へ変数blobを設定する
  previewImage.setAttribute('src', blob);
  // 生成したHTMLの要素をブラウザに表示させる
  
  // var element = document.getElementById("previews mt-3 fs-4");
  // element.textContent = "変更後";
  //文字列の表示
  
  previewWrapper.appendChild(previewImage);
  previewList.appendChild(previewWrapper);
  });
  }
  window.selectFile=selectFile
  $(document).ready(selectFile);
  document.addEventListener('turbolinks:load', selectFile);
