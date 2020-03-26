$(function(){
  /**
     * 屏幕尺寸
     */
    function screenScale() {
      var obj = {
          width: 0,
          height: 0,
          xScale: 0,
          yScale: 0
      };
  
      var realWidth = $(".statist-result").width();
      var realHeight = $(".statist-result").height();
      obj.width = window.innerWidth;
      obj.height = window.innerHeight;
      obj.xScale = obj.width / realWidth;
      obj.yScale = obj.height / realHeight;
      obj.minScale = Math.min(obj.xScale, obj.yScale);
      return obj;
  }

  // 设置适应
  function setSize() {
      
      var obj = screenScale();
      var jscss = [
          '.statist-result {',
          '   transform: translate(' + (-50 * (1 - obj.xScale)) + '%,' + (-50 * (1 - obj.yScale)) + '%) scale(' + obj.minScale + ',' + obj.minScale + ');',
          '   -webkit-transform: translate(' + (-50 * (1 - obj.xScale)) + '%,' + (-50 * (1 - obj.yScale)) + '%) scale(' + obj.minScale + ',' + obj.minScale + ');',
          '}'
      ].join('\n');

      var $style = $('#js-style');
      if ($style.length === 0) {
          $style = $('<style id="js-style" type="text/css"></style>');
          $style.appendTo('head');
      }
      $style.text(jscss);

      // // 文字
      // $('.tt').each(function () {
      //     console.log(obj.minScale);
      //     var fz = Math.ceil(parseInt($(this).css('font-size')) * (0.46+obj.minScale));
      //     fz = fz < 13 ? 13 : fz; 
      //     $(this).css('font-size', Math.ceil(fz)+ 'px');
      // });
      
  }
  setSize();
  window.addEventListener('resize', setSize, false);
})