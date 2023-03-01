(function (global) {
  let slot_frame = document.getElementById("slot-frame");
  let reel = document.getElementsByClassName("reel");
  let reels = document.getElementsByClassName("reels");
  let start_btn = document.getElementById("start-btn");
  let stop_btn = document.getElementsByClassName("stop-btn");
  let submit_form = document.getElementById("submit-form");

  let sec;          //スロットのリール回転速度(実行毎秒数)
  let stopReelFlag = [];  //スロットのリール停止フラグ
  let reelCounts = [];    //どの画像をどの位置にさせるか
  let slotFrameHeight;    //フレームの大きさ
  let slotReelsHeight;    //リール(画像)全体の大きさ
  let slotReelItemHeight; //リール(画像)1個の大きさ
  let slotReelStartHeight;//画像の初期値
  let slot_result_id = Array(4); 
  let slot_result_kanjis = Array(4); 
  let js_kanjis;

  let Slot = {
    // 初期化
    init: function() {
      sec = 125;
      slot_result_id = Array(4);
      slot_result_kanjis = Array(4);

      stopReelFlag[0] = stopReelFlag[1] = stopReelFlag[2] = stopReelFlag[3] = false;
      reelCounts[0] = reelCounts[1] = reelCounts[2] = reelCounts[3]= 0;
      $('.stop-btn').attr('disabled', true);
      json_kanjis = document.getElementById('json_kanjis').value;
      js_kanjis = JSON.parse(json_kanjis);
      source_length = js_kanjis.length;
      for(let index=0; index<reels.length; index++){
        reelCounts[index] = Math.floor( Math.random() * 100 )
        for(let i=0; i<5; i++){
          Slot.add_reel(index);
        }
      }
    },
    // クリックイベント
    start: function() {
      submit_form.style.display = "none"
      Slot.init();
      for(let index=0; index<stop_btn.length; index++ ){
        Slot.animatiton(index);
      }
    },
    // ストップボタンのクリックイベント
    stop: function(i) {
      stopReelFlag[i] = true;
      sec = sec/1.5;

      slot_result_id[i] = reels[i].children[1].getAttribute('data-id');
      slot_result_kanjis[i] = reels[i].children[1].getAttribute('data-kanjis')
      if(stopReelFlag[0] && stopReelFlag[1] && stopReelFlag[2] && stopReelFlag[3]){
        start_btn.removeAttribute("disabled");
        console.log("slot_result_id" + slot_result_id);
        console.log("slot_result_kanjis" + slot_result_kanjis);
        submit_form.style.display = "";
        $('#slot_yoji_first_kanji_id').val(slot_result_id[0]);
        $('#slot_yoji_second_kanji_id').val(slot_result_id[1]);
        $('#slot_yoji_third_kanji_id').val(slot_result_id[2]);
        $('#slot_yoji_fourth_kanji_id').val(slot_result_id[3]);
      }

    },
    // 最初の位置を設定
    resetLocationInfo: function() {
      slotFrameHeight = slot_frame.offsetHeight;
      slotReelsHeight = reels[0].offsetHeight;
      slotReelItemHeight = reel[0].offsetHeight;
      slotReelStartHeight = -slotReelsHeight; // reelの長さだけずらしたい
      slotReelStartHeight = slotReelStartHeight + slotFrameHeight + slotReelItemHeight * 1/2;
      for(let i=0; i<reels.length; i++){
        reels[i].style.top = String(slotReelStartHeight + 1 * slotReelItemHeight) + "px";
      }
    },
    // スロットを動かす
    animatiton: function(index) {
      $('.reels').eq(index).animate({
        'top' :slotReelStartHeight + 2 * slotReelItemHeight
      },{
        duration: sec,
        easing: 'linear',
        complete: function (){
          if(stopReelFlag[index]){
            return;
          }
          Slot.animatiton(index);

          // 最後のreel要素を削除
          let parent = document.getElementsByClassName('reels')[index];
          parent.removeChild(parent.lastChild);
          
          // reelを追加
          Slot.add_reel(index);

          // reelを追加した分、topをずらす
          $('.reels').eq(index).css({
            'top': slotReelStartHeight + 1 * slotReelItemHeight
          })
          
        }
      }
      );
    },
    add_reel: function(index){
      if (reelCounts[index] >= js_kanjis.length){
        reelCounts[index] = 0;
      }

      source_kanjis = js_kanjis[reelCounts[index]];

      const innerelement = document.createElement("li");
      innerelement.classList.add("reel");
      innerelement.setAttribute("data-id",source_kanjis.id);
      innerelement.setAttribute("data-kanjis",source_kanjis.letter);
      innerelement.innerHTML = "<a href=\"/kanjis/"+ source_kanjis.id + "\" target=\"_blank\" \
                                  class=\"h2 link-secondary text-decoration-none\" >" + source_kanjis.letter + "</a>";
      $('.reels').eq(index).prepend(innerelement);
      reelCounts[index]++;
    },
  };
        global.Slot = Slot;

})((this || 0).self || global);

$(document).ready(function() {
  Slot.init();
  Slot.resetLocationInfo();
  $('#start-btn').click(function(){
    $(this).attr('disabled', true);
    Slot.start();
    $('.stop-btn').attr('disabled', false);
  });
  $('.stop-btn').click(function () {
    // ストップボタンを押せないようにする
    $(this).attr('disabled', true);
    // レールの回転を停止
    Slot.stop($(this).attr('data-val'));
  });
});