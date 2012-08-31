// Action script...

// [Initial MovieClip Action of sprite 1057]
#initclip 24
class dofus.graphics.gapi.ui.Shortcuts extends ank.gapi.core.UIAdvancedComponent
{
    var unloadThis, addToQueue, api, _winBg, _btnClose2, _lblDescription, _lblKeys, _btnClose, _lstShortcuts;
    function Shortcuts()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Shortcuts.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function initTexts()
    {
        _winBg.__set__title(api.lang.getText("KEYBORD_SHORTCUT"));
        _btnClose2.__set__label(api.lang.getText("CLOSE"));
        _lblDescription.__set__text(api.lang.getText("SHORTCUTS_DESCRIPTION"));
        _lblKeys.__set__text(api.lang.getText("SHORTCUTS_KEYS"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnClose2.addEventListener("click", this);
    } // End of the function
    function initData()
    {
        var _loc2 = api.lang.getKeyboardShortcuts();
        var _loc3 = new ank.utils.ExtendedArray();
        for (var _loc4 in _loc2)
        {
            _loc3.push(_loc2[_loc4]);
        } // end of for...in
        _lstShortcuts.__set__dataProvider(_loc3);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "Shortcuts";
} // End of Class
#endinitclip
