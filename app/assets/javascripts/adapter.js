//html font-size 自适应
var rem=100;
(function (doc, win) {
    var fontSize=100,
        designWith=375;
    var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
        recalc = function () {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
            var _size=fontSize * (clientWidth / designWith);
            rem=_size
            docEl.style.fontSize = _size+ 'px';
        };

    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);