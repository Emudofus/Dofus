// Action script...

// [Initial MovieClip Action of sprite 989]
#initclip 206
class dofus.graphics.gapi.ui.CenterText extends ank.gapi.core.UIAdvancedComponent
{
    var __get__text, __get__background, __get__timer, addToQueue, _mcBackground, unloadThis, _lblBlackBR, _lblBlackBL, _lblBlackTR, _lblBlackTL, _lblWhite, __set__background, __set__text, __set__timer;
    function CenterText()
    {
        super();
    } // End of the function
    function set text(sText)
    {
        _sText = sText;
        //return (this.text());
        null;
    } // End of the function
    function set background(bBackground)
    {
        _bBackground = bBackground;
        //return (this.background());
        null;
    } // End of the function
    function set timer(nTimer)
    {
        _nTimer = nTimer;
        //return (this.timer());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.CenterText.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        if (_sText.length == 0)
        {
            return;
        } // end if
        this.addToQueue({object: this, method: initText});
        _mcBackground._visible = _bBackground;
        if (_nTimer != 0)
        {
            ank.utils.Timer.setTimer(this, "centertext", this, unloadThis, _nTimer);
        } // end if
    } // End of the function
    function initText()
    {
        _lblWhite.__set__text(_lblBlackTL.__set__text(_lblBlackTR.__set__text(_lblBlackBL.__set__text(_lblBlackBR.__set__text(_sText)))));
    } // End of the function
    static var CLASS_NAME = "CenterText";
    var _sText = "";
    var _bBackground = false;
    var _nTimer = 0;
} // End of Class
#endinitclip
