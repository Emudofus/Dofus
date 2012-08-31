// Action script...

// [Initial MovieClip Action of sprite 970]
#initclip 182
class dofus.graphics.battlefield.GuildOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
    var createTextField, _txtGuildName, _txtSpriteName, drawBackground, attachMovie, drawGfx;
    function GuildOverHead(sText, sSpriteName, oEmblem, sFile, nFrame)
    {
        super();
        this.initialize();
        this.draw(sText, sSpriteName, oEmblem, sFile, nFrame);
    } // End of the function
    function initialize()
    {
        super.initialize();
        this.createTextField("_txtGuildName", 30, 0, -2 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
        this.createTextField("_txtSpriteName", 40, 0, 13 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
    } // End of the function
    function draw(sGuildName, sSpriteName, oEmblem, sFile, nFrame)
    {
        var _loc3 = sFile != undefined && nFrame != undefined;
        _txtGuildName.embedFonts = true;
        _txtGuildName.autoSize = "left";
        _txtGuildName.text = sGuildName;
        _txtGuildName.selectable = false;
        _txtGuildName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_SMALL_FORMAT);
        _txtSpriteName.embedFonts = true;
        _txtSpriteName.autoSize = "left";
        _txtSpriteName.text = sSpriteName;
        _txtSpriteName.selectable = false;
        _txtSpriteName.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        var _loc4 = Math.ceil(30 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
        var _loc2 = Math.ceil(Math.max(_txtGuildName.textWidth, _txtSpriteName.textWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 4) + 30;
        _txtGuildName._x = _txtSpriteName._x = -_loc2 / 2 + 30 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2;
        this.drawBackground(_loc2, _loc4, dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
        this.attachMovie("Emblem", "_eEmblem", 100, {_x: Math.ceil(-_loc2 / 2) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER, _y: dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, _height: 30, _width: 30, data: oEmblem, shadow: true});
        if (_loc3)
        {
            this.drawGfx(sFile, nFrame);
        } // end if
    } // End of the function
} // End of Class
#endinitclip
