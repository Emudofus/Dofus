// Action script...

// [Initial MovieClip Action of sprite 867]
#initclip 79
class ank.battlefield.mc.Bubble extends MovieClip
{
    var _maxW, createTextField, _txtf, swapDepths, removeMovieClip, createEmptyMovieClip, _bg, _x, _y;
    function Bubble(text, x, y, maxW)
    {
        super();
        this.initialize(text, x, y, maxW);
    } // End of the function
    function initialize(text, x, y, maxW)
    {
        _maxW = maxW;
        this.createTextField("_txtf", 20, 0, 0, 150, 100);
        _txtf.autoSize = "left";
        _txtf.wordWrap = true;
        _txtf.embedFonts = true;
        _txtf.multiline = true;
        _txtf.selectable = false;
        _txtf.html = true;
        this.draw(text, x, y);
    } // End of the function
    function draw(text, x, y)
    {
        _txtf.htmlText = text;
        _txtf.setTextFormat(ank.battlefield.Constants.BUBBLE_TXTFORMAT);
        var _loc2 = _txtf.textHeight <= 10 ? (11) : (_txtf.textHeight);
        var _loc3 = _txtf.textWidth <= 10 ? (11) : (_txtf.textWidth + 4);
        this.drawBackground(_loc3, _loc2);
        this.adjust(_loc3 + ank.battlefield.Constants.BUBBLE_MARGIN * 2, _loc2 + ank.battlefield.Constants.BUBBLE_MARGIN * 2 + ank.battlefield.Constants.BUBBLE_PIC_HEIGHT, x, y);
        var _loc4 = ank.battlefield.Constants.BUBBLE_REMOVE_TIMER + text.length * ank.battlefield.Constants.BUBBLE_REMOVE_CHAR_TIMER;
        ank.utils.Timer.setTimer(this, "battlefield", this, remove, _loc4);
    } // End of the function
    function remove()
    {
        this.swapDepths(1);
        this.removeMovieClip();
    } // End of the function
    function drawBackground(w, h)
    {
        var _loc2 = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
        this.createEmptyMovieClip("_bg", 10);
        _bg.lineStyle(1, ank.battlefield.Constants.BUBBLE_BORDERCOLOR, 100);
        _bg.beginFill(ank.battlefield.Constants.BUBBLE_BGCOLOR, 100);
        _bg.moveTo(0, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        _bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH / 2, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        _bg.lineTo(0, 0);
        _bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        _bg.lineTo(w + _loc2, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        _bg.lineTo(w + _loc2, -h - _loc2 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        _bg.lineTo(0, -h - _loc2 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        _bg.endFill();
    } // End of the function
    function adjust(w, h, x, y)
    {
        var _loc2 = _maxW - w;
        var _loc3 = h + ank.battlefield.Constants.BUBBLE_Y_OFFSET;
        if (x > _loc2)
        {
            _txtf._x = -w + ank.battlefield.Constants.BUBBLE_MARGIN;
            _bg._xscale = -100;
        }
        else
        {
            _txtf._x = ank.battlefield.Constants.BUBBLE_MARGIN;
        } // end else if
        if (y < _loc3)
        {
            _txtf._y = ank.battlefield.Constants.BUBBLE_PIC_HEIGHT + ank.battlefield.Constants.BUBBLE_MARGIN - 3;
            _bg._yscale = -100;
        }
        else
        {
            _txtf._y = -h + ank.battlefield.Constants.BUBBLE_MARGIN - 3 - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
            _bg._y = -ank.battlefield.Constants.BUBBLE_Y_OFFSET;
        } // end else if
        _x = x;
        _y = y;
    } // End of the function
} // End of Class
#endinitclip
