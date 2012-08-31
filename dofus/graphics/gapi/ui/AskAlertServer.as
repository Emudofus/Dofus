// Action script...

// [Initial MovieClip Action of sprite 992]
#initclip 209
class dofus.graphics.gapi.ui.AskAlertServer extends ank.gapi.ui.FlyWindow
{
    var _sText, __get__text, __get__hideNext, _winBackground, api, dispatchEvent, unloadThis, __set__hideNext, __set__text;
    function AskAlertServer()
    {
        super();
    } // End of the function
    function set text(sText)
    {
        _sText = sText;
        //return (this.text());
        null;
    } // End of the function
    function set hideNext(bHideNext)
    {
        _bHideNext = bHideNext;
        //return (this.hideNext());
        null;
    } // End of the function
    function initWindowContent()
    {
        var c = _winBackground.__get__content();
        c._btnClose.addEventListener("click", this);
        c._btnHideNext.addEventListener("click", this);
        c._txtText.text = _sText;
        c._btnClose.label = api.lang.getText("CLOSE");
        c._lblHideNext.text = api.lang.getText("ALERT_HIDENEXT");
        SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).onStatus = function (oEvent)
        {
            if (oEvent.level == "status" && oEvent.code == "SharedObject.Flush.Success")
            {
                c._btnHideNext._visible = true;
                c._lblHideNext._visible = true;
                c._btnHideNext.enabled = true;
                c._btnHideNext.selected = false;
            } // end if
        };
        if (SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).flush() != true)
        {
            c._btnHideNext.enabled = false;
            c._btnHideNext.selected = false;
            c._btnHideNext._visible = false;
            c._lblHideNext._visible = false;
        }
        else
        {
            c._btnHideNext.selected = _bHideNext;
        } // end else if
        Key.addListener(this);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                Key.removeListener(this);
                this.dispatchEvent({type: "close", hideNext: _bHideNext});
                this.unloadThis();
                break;
            } 
            case "_btnHideNext":
            {
                _bHideNext = oEvent.target.selected;
                break;
            } 
        } // End of switch
    } // End of the function
    function change(oEvent)
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._btnOk._y = _loc2._txtText._y + _loc2._txtText.height + 20;
        _winBackground.setPreferedSize();
    } // End of the function
    function onKeyDown()
    {
        if (Key.isDown(13))
        {
            this.click(_winBackground.content._btnClose);
        } // end if
    } // End of the function
    static var CLASS_NAME = "AskAlertServer";
    var _bHideNext = false;
} // End of Class
#endinitclip
