// Action script...

// [Initial MovieClip Action of sprite 993]
#initclip 210
class dofus.graphics.gapi.ui.AskOk extends ank.gapi.ui.FlyWindow
{
    var _sText, __get__text, _winBackground, api, dispatchEvent, unloadThis, __set__text;
    function AskOk()
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
        _loc2._btnOk.addEventListener("click", this);
        _loc2._txtText.addEventListener("change", this);
        _loc2._txtText.text = _sText;
        _loc2._btnOk.label = api.lang.getText("OK");
        Key.addListener(this);
    } // End of the function
    function click(oEvent)
    {
        Key.removeListener(this);
        this.dispatchEvent({type: "ok"});
        this.unloadThis();
    } // End of the function
    function change(oEvent)
    {
        var _loc2 = _winBackground.__get__content();
        _loc2._btnOk._y = _loc2._txtText._y + _loc2._txtText.height + 20;
        _winBackground.setPreferedSize();
    } // End of the function
    function onKeyUp()
    {
        if (Key.getCode() == 13)
        {
            Selection.setFocus();
            this.click();
        } // end if
    } // End of the function
    static var CLASS_NAME = "AskOk";
} // End of Class
#endinitclip
