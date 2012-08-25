// Action script...

// [Initial MovieClip Action of sprite 20828]
#initclip 93
if (!dofus.graphics.battlefield.GuildOverHead)
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
    var _loc1 = (_global.dofus.graphics.battlefield.GuildOverHead = function (sText, sSpriteName, oEmblem, sFile, nFrame, nPvpGain, title)
    {
        super();
        this.initialize(title != undefined);
        this.draw(sText, sSpriteName, oEmblem, sFile, nFrame, nPvpGain, title);
    }).prototype;
    _loc1.initialize = function (displayTitle)
    {
        super.initialize();
        this.createTextField("_txtGuildName", 30, 0, -2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
        this.createTextField("_txtSpriteName", 40, 0, 13 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
        if (displayTitle)
        {
            this.createTextField("_txtTitle", 31, 0, -2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
            this._txtTitle.embedFonts = true;
        } // end if
    };
    _loc1.draw = function (sGuildName, sSpriteName, oEmblem, sFile, nFrame, nPvpGain, title)
    {
        var _loc9 = sFile != undefined && nFrame != undefined;
        if (nPvpGain == undefined)
        {
            nPvpGain = 0;
        } // end if
        this._txtGuildName.embedFonts = true;
        this._txtGuildName.autoSize = "left";
        this._txtGuildName.text = sGuildName;
        this._txtGuildName.selectable = false;
        this._txtGuildName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_SMALL_FORMAT);
        this._txtSpriteName.embedFonts = true;
        this._txtSpriteName.autoSize = "left";
        this._txtSpriteName.text = sSpriteName;
        this._txtSpriteName.selectable = false;
        this._txtSpriteName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        var _loc12 = 0;
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
            var _loc10 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 3 + this._txtTitle.textHeight);
            var _loc13 = Math.ceil(Math.max(this._txtGuildName.textWidth, this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
            var _loc11 = Math.ceil(Math.max(_loc13, this._txtTitle.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2));
            _loc12 = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + this._txtTitle.textHeight;
            this._txtGuildName._x = this._txtSpriteName._x = -_loc11 / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
            this._txtTitle._y = 27 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2;
        }
        else
        {
            _loc10 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
            _loc11 = Math.ceil(Math.max(this._txtGuildName.textWidth, this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
            this._txtGuildName._x = this._txtSpriteName._x = -_loc11 / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
        } // end else if
        this.drawBackground(_loc11, _loc10, dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
        this.attachMovie("Emblem", "_eEmblem", 100, {_x: Math.ceil(-_loc11 / 2) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER, _y: dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, _height: 30, _width: 30, data: oEmblem, shadow: true});
        if (_loc9)
        {
            this.drawGfx(sFile, nFrame);
            this.addPvpGfxEffect(nPvpGain, nFrame);
        } // end if
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
