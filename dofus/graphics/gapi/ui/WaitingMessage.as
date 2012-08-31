// Action script...

// [Initial MovieClip Action of sprite 1027]
#initclip 248
class dofus.graphics.gapi.ui.WaitingMessage extends ank.gapi.core.UIAdvancedComponent
{
    var __get__text, addToQueue, _lblBlackBR, _lblBlackBL, _lblBlackTR, _lblBlackTL, _lblWhite, __set__text;
    function WaitingMessage()
    {
        super();
    } // End of the function
    function set text(sText)
    {
        _sText = sText;
        //return (this.text());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.WaitingMessage.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        if (_sText.length == 0)
        {
            return;
        } // end if
        this.addToQueue({object: this, method: initText});
    } // End of the function
    function initText()
    {
        _lblWhite.__set__text(_lblBlackTL.__set__text(_lblBlackTR.__set__text(_lblBlackBL.__set__text(_lblBlackBR.__set__text(_sText)))));
    } // End of the function
    static var CLASS_NAME = "WaitingMessage";
    var _sText = "";
} // End of Class
#endinitclip
