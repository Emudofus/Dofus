// Action script...

// [Initial MovieClip Action of sprite 20814]
#initclip 79
if (!ank.battlefield.mc.Bubble)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.mc)
    {
        _global.ank.battlefield.mc = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.mc.Bubble = function (text, x, y, maxW)
    {
        super();
        this.initialize(text, x, y, maxW);
    }).prototype;
    _loc1.initialize = function (text, x, y, maxW)
    {
        this._maxW = maxW;
        this.createTextField("_txtf", 20, 0, 0, 150, 100);
        this._txtf.autoSize = "left";
        this._txtf.wordWrap = true;
        this._txtf.embedFonts = true;
        this._txtf.multiline = true;
        this._txtf.selectable = false;
        this._txtf.html = true;
        this.draw(text, x, y);
    };
    _loc1.draw = function (text, x, y)
    {
        this._txtf.htmlText = text;
        this._txtf.setTextFormat(ank.battlefield.Constants.BUBBLE_TXTFORMAT);
        var _loc5 = this._txtf.textHeight <= 10 ? (11) : (this._txtf.textHeight);
        var _loc6 = this._txtf.textWidth <= 10 ? (11) : (this._txtf.textWidth + 4);
        this.drawBackground(_loc6, _loc5);
        this.adjust(_loc6 + ank.battlefield.Constants.BUBBLE_MARGIN * 2, _loc5 + ank.battlefield.Constants.BUBBLE_MARGIN * 2 + ank.battlefield.Constants.BUBBLE_PIC_HEIGHT, x, y);
        var _loc7 = ank.battlefield.Constants.BUBBLE_REMOVE_TIMER + text.length * ank.battlefield.Constants.BUBBLE_REMOVE_CHAR_TIMER;
        ank.utils.Timer.setTimer(this, "battlefield", this, this.remove, _loc7);
    };
    _loc1.remove = function ()
    {
        this.swapDepths(1);
        this.removeMovieClip();
    };
    _loc1.drawBackground = function (w, h)
    {
        var _loc4 = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
        this.createEmptyMovieClip("_bg", 10);
        this._bg.lineStyle(1, ank.battlefield.Constants.BUBBLE_BORDERCOLOR, 100);
        this._bg.beginFill(ank.battlefield.Constants.BUBBLE_BGCOLOR, 100);
        this._bg.moveTo(0, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH / 2, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        this._bg.lineTo(0, 0);
        this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        this._bg.lineTo(w + _loc4, -ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        this._bg.lineTo(w + _loc4, -h - _loc4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        this._bg.lineTo(0, -h - _loc4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
        this._bg.endFill();
    };
    _loc1.adjust = function (w, h, x, y)
    {
        var _loc6 = this._maxW - w;
        var _loc7 = h + ank.battlefield.Constants.BUBBLE_Y_OFFSET;
        if (x > _loc6)
        {
            this._txtf._x = -w + ank.battlefield.Constants.BUBBLE_MARGIN;
            this._bg._xscale = -100;
        }
        else
        {
            this._txtf._x = ank.battlefield.Constants.BUBBLE_MARGIN;
        } // end else if
        if (y < _loc7)
        {
            this._txtf._y = ank.battlefield.Constants.BUBBLE_PIC_HEIGHT + ank.battlefield.Constants.BUBBLE_MARGIN - 3;
            this._bg._yscale = -100;
        }
        else
        {
            this._txtf._y = -h + ank.battlefield.Constants.BUBBLE_MARGIN - 3 - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
            this._bg._y = -ank.battlefield.Constants.BUBBLE_Y_OFFSET;
        } // end else if
        this._x = x;
        this._y = y;
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
