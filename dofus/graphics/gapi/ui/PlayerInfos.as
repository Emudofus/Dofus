// Action script...

// [Initial MovieClip Action of sprite 1026]
#initclip 247
class dofus.graphics.gapi.ui.PlayerInfos extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__data, unloadThis, addToQueue, _btnClose, api, _winBackground, _lstEffects, __set__data;
    function PlayerInfos()
    {
        super();
    } // End of the function
    function set data(oData)
    {
        _oData = oData;
        //return (this.data());
        null;
    } // End of the function
    function get data()
    {
        return (_oData);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.PlayerInfos.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
    } // End of the function
    function initData()
    {
        if (_oData != undefined)
        {
            _winBackground.__set__title(api.lang.getText("EFFECTS") + " " + _oData.name + " (" + api.lang.getText("LEVEL_SMALL") + _oData.Level + ")");
            _lstEffects.__set__dataProvider(_oData.EffectsManager.getEffects());
        } // end if
    } // End of the function
    function quit()
    {
        this.unloadThis();
    } // End of the function
    function click(oEvent)
    {
        this.unloadThis();
    } // End of the function
    static var CLASS_NAME = "PlayerInfos";
} // End of Class
#endinitclip
