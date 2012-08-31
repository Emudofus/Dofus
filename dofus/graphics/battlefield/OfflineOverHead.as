// Action script...

// [Initial MovieClip Action of sprite 971]
#initclip 183
class dofus.graphics.battlefield.OfflineOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
    var createTextField, _txtSpriteName, _txtGuildName, drawBackground, attachMovie;
    function OfflineOverHead(oSprite)
    {
        super();
        this.initialize();
        this.draw(oSprite);
    } // End of the function
    function initialize()
    {
        super.initialize();
        this.createTextField("_txtGuildName", 30, 0, -2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
        this.createTextField("_txtSpriteName", 40, 0, 13 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
    } // End of the function
    function draw(oSprite)
    {
        var _loc4 = oSprite.guildName != undefined && oSprite.guildName.length != 0;
        _txtSpriteName.embedFonts = true;
        _txtSpriteName.autoSize = "left";
        _txtSpriteName.text = oSprite.name;
        _txtSpriteName.selectable = false;
        _txtSpriteName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        _txtSpriteName.textColor = 0;
        if (_loc4)
        {
            _txtGuildName.embedFonts = true;
            _txtGuildName.autoSize = "left";
            _txtGuildName.text = oSprite.guildName;
            _txtGuildName.selectable = false;
            _txtGuildName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_SMALL_FORMAT);
            _txtGuildName.textColor = 0;
        } // end if
        var _loc5 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
        var _loc3 = Math.ceil(Math.max(_txtGuildName.textWidth, _txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
        _txtGuildName._x = _txtSpriteName._x = -_loc3 / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
        if (!_loc4)
        {
            _txtSpriteName._y = 9;
        } // end if
        this.drawBackground(_loc3, _loc5, 16777215);
        this.attachMovie("Loader", "_ldrIcon", 100, {_x: Math.ceil(-_loc3 / 2) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER, _y: dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, _height: 30, _width: 30, contentPath: dofus.Constants.OFFLINE_PATH + oSprite.offlineType + ".swf", scaleContent: true});
    } // End of the function
    static var BACKGROUND_COLOR = 13421772;
} // End of Class
#endinitclip
