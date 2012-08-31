// Action script...

// [Initial MovieClip Action of sprite 991]
#initclip 208
class dofus.graphics.gapi.ui.AskYesNo extends ank.gapi.ui.FlyWindow
{
    var _sText, __get__text, __get__params, dispatchEvent, _winBackground, api, unloadThis, __set__text;
    function AskYesNo()
    {
        super();
    } // End of the function
    function set text(sText)
    {
        _sText = sText;
        //return (this.text());
        null;
    } // End of the function
    function get text()
    {
        return (_sText);
    } // End of the function
    function callClose()
    {
        this.dispatchEvent({type: "no", params: this.__get__params()});
        return (true);
    } // End of the function
    function initWindowContent()
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._txtText.text = _sText;
        _loc2._btnYes.label = api.lang.getText("YES");
        _loc2._btnNo.label = api.lang.getText("NO");
        _loc2._btnYes.addEventListener("click", this);
        _loc2._btnNo.addEventListener("click", this);
        _loc2._txtText.addEventListener("change", this);
        Key.addListener(this);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnYes":
            {
                this.dispatchEvent({type: "yes", params: this.__get__params()});
                break;
            } 
            case "_btnNo":
            {
                this.dispatchEvent({type: "no", params: this.__get__params()});
                break;
            } 
        } // End of switch
        this.unloadThis();
    } // End of the function
    function change(oEvent)
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._btnYes._y = _loc2._txtText._y + _loc2._txtText.height + 20;
        _loc2._btnNo._y = _loc2._txtText._y + _loc2._txtText.height + 20;
        _winBackground.setPreferedSize();
    } // End of the function
    function onKeyDown()
    {
        if (Key.isDown(13))
        {
            this.click({target: _winBackground.content._btnYes});
        } // end if
    } // End of the function
    static var CLASS_NAME = "AskYesNo";
} // End of Class
#endinitclip
