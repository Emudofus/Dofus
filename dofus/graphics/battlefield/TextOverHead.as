// Action script...

// [Initial MovieClip Action of sprite 972]
#initclip 184
class dofus.graphics.battlefield.TextOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
    var createTextField, _txtText, drawBackground, drawGfx;
    function TextOverHead(sText, sFile, nColor, nFrame)
    {
        super();
        this.initialize();
        this.draw(sText, sFile, nColor, nFrame);
    } // End of the function
    function initialize()
    {
        super.initialize();
        this.createTextField("_txtText", 30, 0, -3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER, 0, 0);
        _txtText.embedFonts = true;
    } // End of the function
    function draw(sText, sFile, nColor, nFrame)
    {
        var _loc2 = sFile != undefined && nFrame != undefined;
        _txtText.autoSize = "center";
        _txtText.text = sText;
        _txtText.selectable = false;
        _txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
        if (nColor != undefined)
        {
            _txtText.textColor = nColor;
        } // end if
        var _loc3 = Math.ceil(_txtText.textHeight + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 2);
        var _loc4 = Math.ceil(_txtText.textWidth + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
        this.drawBackground(_loc4, _loc3, dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
        if (_loc2)
        {
            this.drawGfx(sFile, nFrame);
        } // end if
    } // End of the function
} // End of Class
#endinitclip
