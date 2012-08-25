// Action script...

// [Initial MovieClip Action of sprite 20545]
#initclip 66
if (!dofus.graphics.battlefield.OfflineOverHead)
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
    var _loc1 = (_global.dofus.graphics.battlefield.OfflineOverHead = function (oSprite)
    {
        super();
        this.initialize();
        this.draw(oSprite);
    }).prototype;
    _loc1.initialize = function ()
    {
        super.initialize();
        this.createTextField("_txtGuildName", 30, 0, -2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
        this.createTextField("_txtSpriteName", 40, 0, 13 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
    };
    _loc1.draw = function (oSprite)
    {
        var _loc3 = oSprite.guildName != undefined && oSprite.guildName.length != 0;
        this._txtSpriteName.embedFonts = true;
        this._txtSpriteName.autoSize = "left";
        this._txtSpriteName.text = oSprite.name;
        this._txtSpriteName.selectable = false;
        this._txtSpriteName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        this._txtSpriteName.textColor = 0;
        if (_loc3)
        {
            this._txtGuildName.embedFonts = true;
            this._txtGuildName.autoSize = "left";
            this._txtGuildName.text = oSprite.guildName;
            this._txtGuildName.selectable = false;
            this._txtGuildName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_SMALL_FORMAT);
            this._txtGuildName.textColor = 0;
        } // end if
        var _loc4 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
        var _loc5 = Math.ceil(Math.max(this._txtGuildName.textWidth, this._txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
        this._txtGuildName._x = this._txtSpriteName._x = -_loc5 / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
        if (!_loc3)
        {
            this._txtSpriteName._y = 9;
        } // end if
        this.drawBackground(_loc5, _loc4, 16777215);
        this.attachMovie("Loader", "_ldrIcon", 100, {_x: Math.ceil(-_loc5 / 2) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER, _y: dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, _height: 30, _width: 30, contentPath: dofus.Constants.EXTRA_PATH + oSprite.offlineType + ".swf", scaleContent: true});
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.battlefield.OfflineOverHead = function (oSprite)
    {
        super();
        this.initialize();
        this.draw(oSprite);
    }).BACKGROUND_COLOR = 13421772;
} // end if
#endinitclip
