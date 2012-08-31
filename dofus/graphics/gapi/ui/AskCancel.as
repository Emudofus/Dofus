// Action script...

// [Initial MovieClip Action of sprite 990]
#initclip 207
class dofus.graphics.gapi.ui.AskCancel extends ank.gapi.ui.FlyWindow
{
    var _sText, __get__text, _winBackground, api, __get__params, dispatchEvent, unloadThis, __set__text;
    function AskCancel()
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
    function initWindowContent()
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._txtText.text = _sText;
        _loc2._btnCancel.label = api.lang.getText("CANCEL_SMALL");
        _loc2._btnCancel.addEventListener("click", this);
        _loc2._txtText.addEventListener("change", this);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnCancel":
            {
                this.dispatchEvent({type: "cancel", params: this.__get__params()});
                break;
            } 
        } // End of switch
        this.unloadThis();
    } // End of the function
    function change(oEvent)
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._btnCancel._y = _loc2._txtText._y + _loc2._txtText.height + 20;
        _winBackground.setPreferedSize();
    } // End of the function
    static var CLASS_NAME = "AskCancel";
} // End of Class
#endinitclip
