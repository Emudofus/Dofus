// Action script...

// [Initial MovieClip Action of sprite 20635]
#initclip 156
if (!dofus.graphics.battlefield.TextOverHead)
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
    var _loc1 = (_global.dofus.graphics.battlefield.TextOverHead = function (sText, sFile, nColor, nFrame, nPvpGain, title)
    {
        super();
        this.initialize(title != undefined);
        this.draw(sText, sFile, nColor, nFrame, nPvpGain, title);
    }).prototype;
    _loc1.initialize = function (displayTitle)
    {
        super.initialize();
        this.createTextField("_txtText", 30, 0, -3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
        if (displayTitle)
        {
            this.createTextField("_txtTitle", 31, 0, -3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
            this._txtTitle.embedFonts = true;
        } // end if
        this._txtText.embedFonts = true;
    };
    _loc1.draw = function (sText, sFile, nColor, nFrame, nPvpGain, title)
    {
        var _loc8 = sFile != undefined && nFrame != undefined;
        if (nPvpGain == undefined)
        {
            nPvpGain = 0;
        } // end if
        this._txtText.autoSize = "center";
        this._txtText.text = sText;
        this._txtText.selectable = false;
        this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        if (nColor != undefined)
        {
            this._txtText.textColor = nColor;
        } // end if
        if (title)
        {
            this._txtTitle.autoSize = "center";
            this._txtTitle.text = title.text;
            this._txtTitle.selectable = false;
            this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT2);
            if (title.color != undefined)
            {
                this._txtTitle.textColor = title.color;
            } // end if
            this._txtTitle._y = this._txtText._y + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtText.textHeight;
            var _loc9 = Math.ceil(this._txtText.textHeight + this._txtTitle.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3);
            var _loc10 = Math.ceil(Math.max(this._txtText.textWidth, this._txtTitle.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
        }
        else
        {
            _loc9 = Math.ceil(this._txtText.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
            _loc10 = Math.ceil(this._txtText.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
        } // end else if
        this.drawBackground(_loc10, _loc9, dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
        if (_loc8)
        {
            this.drawGfx(sFile, nFrame);
            this.addPvpGfxEffect(nPvpGain, nFrame);
        } // end if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
