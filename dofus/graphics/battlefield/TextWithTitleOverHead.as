// Action script...

// [Initial MovieClip Action of sprite 20834]
#initclip 99
if (!dofus.graphics.battlefield.TextWithTitleOverHead)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.battlefield)
    {
        _global.dofus.graphics.battlefield = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.battlefield.TextWithTitleOverHead = function (sText, sFile, nColor, nFrame, sTitle, nColorTitle, nStarsValue)
    {
        super();
        this.initialize(nStarsValue);
        this.draw(sText, sFile, nColor, nFrame, sTitle, nColorTitle);
    }).prototype;
    _loc1.initialize = function (starValue)
    {
        super.initialize();
        if (starValue == undefined || _global.isNaN(starValue))
        {
            starValue = -1;
        } // end if
        this._nStarsValue = starValue;
        this.createTextField("_txtTitle", 40, 0, -3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + 4, 0, 0);
        this.createTextField("_txtText", 30, 0, -3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue > -1 ? (2) : (1)) + 20 + (this._nStarsValue > -1 ? (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH) : (0)), 0, 0);
        this._txtText.embedFonts = true;
        this._txtTitle.embedFonts = true;
        this._aStars = new Array();
    };
    _loc1.draw = function (sText, sFile, nColor, nFrame, sTitle, nColorTitle)
    {
        var _loc8 = sFile != undefined && nFrame != undefined;
        this._txtText.autoSize = "center";
        this._txtText.text = sText;
        this._txtText.selectable = false;
        this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        if (nColor != undefined)
        {
            this._txtText.textColor = nColor;
        } // end if
        this._txtTitle.autoSize = "center";
        this._txtTitle.text = sTitle;
        this._txtTitle.selectable = false;
        this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        if (nColorTitle != undefined)
        {
            this._txtTitle.textColor = nColorTitle;
        } // end if
        this._nFullWidth = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT - 1) * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN;
        var _loc9 = Math.ceil(this._txtText.textHeight + 20 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue > -1 ? (4) : (3)) + (this._nStarsValue > -1 ? (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH) : (0)));
        var _loc10 = Math.ceil(Math.max(Math.max(this._txtText.textWidth, this._txtTitle.textWidth), this._nStarsValue > -1 ? (this._nFullWidth) : (0)) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
        this.drawBackground(_loc10, _loc9, dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
        if (this._nStarsValue > -1)
        {
            var _loc11 = this.getStarsColor();
            var _loc12 = 0;
            
            while (++_loc12, _loc12 < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
            {
                var _loc13 = new Object();
                _loc13._x = _loc12 * (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN) - this._nFullWidth / 2 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER;
                _loc13._y = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 4 + this._txtTitle.textHeight;
                this._aStars[_loc12] = this.createEmptyMovieClip("star" + _loc12, 50 + _loc12);
                this._aStars[_loc12].attachMovie("StarBorder", "star", 1, _loc13);
                var _loc14 = this._aStars[_loc12].star.fill;
                if (_loc11[_loc12] > -1)
                {
                    var _loc15 = new Color(_loc14);
                    _loc15.setRGB(_loc11[_loc12]);
                    continue;
                } // end if
                _loc14._alpha = 0;
            } // end while
        } // end if
        if (_loc8)
        {
            this.drawGfx(sFile, nFrame);
        } // end if
    };
    _loc1.getStarsColor = function ()
    {
        var _loc2 = new Array();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
        {
            var _loc4 = Math.floor(this._nStarsValue / 100) + (this._nStarsValue - Math.floor(this._nStarsValue / 100) * 100 > _loc3 * (100 / dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT) ? (1) : (0));
            _loc2[_loc3] = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS[Math.min(_loc4, dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS.length - 1)];
        } // end while
        return (_loc2);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.battlefield.TextWithTitleOverHead = function (sText, sFile, nColor, nFrame, sTitle, nColorTitle, nStarsValue)
    {
        super();
        this.initialize(nStarsValue);
        this.draw(sText, sFile, nColor, nFrame, sTitle, nColorTitle);
    }).STARS_COUNT = 5;
    (_global.dofus.graphics.battlefield.TextWithTitleOverHead = function (sText, sFile, nColor, nFrame, sTitle, nColorTitle, nStarsValue)
    {
        super();
        this.initialize(nStarsValue);
        this.draw(sText, sFile, nColor, nFrame, sTitle, nColorTitle);
    }).STARS_WIDTH = 10;
    (_global.dofus.graphics.battlefield.TextWithTitleOverHead = function (sText, sFile, nColor, nFrame, sTitle, nColorTitle, nStarsValue)
    {
        super();
        this.initialize(nStarsValue);
        this.draw(sText, sFile, nColor, nFrame, sTitle, nColorTitle);
    }).STARS_MARGIN = 2;
    (_global.dofus.graphics.battlefield.TextWithTitleOverHead = function (sText, sFile, nColor, nFrame, sTitle, nColorTitle, nStarsValue)
    {
        super();
        this.initialize(nStarsValue);
        this.draw(sText, sFile, nColor, nFrame, sTitle, nColorTitle);
    }).STARS_COLORS = [-1, 16777011, 16750848, 39168, 39372, 6697728, 2236962, 16711680, 65280, 16777215, 16711935];
} // end if
#endinitclip
