// Action script...

// [Initial MovieClip Action of sprite 1041]
#initclip 8
class dofus.graphics.gapi.ui.CreateGuild extends ank.gapi.core.UIAdvancedComponent
{
    var _bEnabled, api, _eaBacks, _eaUps, _nBackID, _nUpID, addToQueue, _winBg, _lblName, _lblEmblem, _lblColors, _btnCancel, _btnCreate, _btnTabBack, _btnTabUp, _btnClose, _cpColors, _cgGrid, _itName, _eEmblem, __set__enabled;
    function CreateGuild()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.CreateGuild.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        if (_bEnabled)
        {
            api.network.Guild.leave();
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function createChildren()
    {
        _eaBacks = new ank.utils.ExtendedArray();
        for (var _loc3 = 1; _loc3 <= dofus.Constants.EMBLEM_BACKS_COUNT; ++_loc3)
        {
            _eaBacks.push({iconFile: dofus.Constants.EMBLEMS_BACK_PATH + _loc3 + ".swf"});
        } // end of for
        _eaUps = new ank.utils.ExtendedArray();
        for (var _loc2 = 1; _loc2 <= dofus.Constants.EMBLEM_UPS_COUNT; ++_loc2)
        {
            _eaUps.push({iconFile: dofus.Constants.EMBLEMS_UP_PATH + _loc2 + ".swf"});
        } // end of for
        _nBackID = 1;
        _nUpID = 1;
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: setTextFocus});
        this.addToQueue({object: this, method: updateCurrentTabInformations});
        this.addToQueue({object: this, method: updateBack});
        this.addToQueue({object: this, method: updateUp});
    } // End of the function
    function initTexts()
    {
        _winBg.__set__title(api.lang.getText("GUILD_CREATION"));
        _lblName.__set__text(api.lang.getText("GUILD_NAME"));
        _lblEmblem.__set__text(api.lang.getText("EMBLEM"));
        _lblColors.__set__text(api.lang.getText("CREATE_COLOR"));
        _btnCancel.__set__label(api.lang.getText("CANCEL_SMALL"));
        _btnCreate.__set__label(api.lang.getText("CREATE"));
        _btnTabBack.__set__label(api.lang.getText("EMBLEM_BACK"));
        _btnTabUp.__set__label(api.lang.getText("EMBLEM_UP"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnCancel.addEventListener("click", this);
        _btnCreate.addEventListener("click", this);
        _btnTabBack.addEventListener("click", this);
        _btnTabUp.addEventListener("click", this);
        _cpColors.addEventListener("change", this);
        _cgGrid.addEventListener("selectItem", this);
    } // End of the function
    function setTextFocus()
    {
        _itName.setFocus();
    } // End of the function
    function updateCurrentTabInformations()
    {
        switch (_sCurrentTab)
        {
            case "Back":
            {
                _cpColors.setColor(_nBackColor);
                _cgGrid.__set__dataProvider(_eaBacks);
                _cgGrid.__set__selectedIndex(_nBackID - 1);
                break;
            } 
            case "Up":
            {
                _cpColors.setColor(_nUpColor);
                _cgGrid.__set__dataProvider(_eaUps);
                _cgGrid.__set__selectedIndex(_nUpID - 1);
                break;
            } 
        } // End of switch
    } // End of the function
    function setCurrentTab(sNewTab)
    {
        var _loc2 = this["_btnTab" + _sCurrentTab];
        var _loc3 = this["_btnTab" + sNewTab];
        _loc2.__set__selected(true);
        _loc2.__set__enabled(true);
        _loc3.__set__selected(false);
        _loc3.__set__enabled(false);
        _sCurrentTab = sNewTab;
        this.updateCurrentTabInformations();
    } // End of the function
    function updateBack()
    {
        _eEmblem.__set__backID(_nBackID);
        _eEmblem.__set__backColor(_nBackColor);
    } // End of the function
    function updateUp()
    {
        _eEmblem.__set__upID(_nUpID);
        _eEmblem.__set__upColor(_nUpColor);
    } // End of the function
    function setEnabled(bEnabled)
    {
        _btnCancel.__set__enabled(_bEnabled);
        _btnClose.__set__enabled(_bEnabled);
        _btnCreate.__set__enabled(_bEnabled);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            case "_btnCancel":
            {
                api.network.Guild.leave();
                break;
            } 
            case "_btnCreate":
            {
                var _loc2 = _itName.__get__text();
                if (_loc2 == undefined || _loc2.length < 3)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("BAD_GUILD_NAME"), "ERROR_BOX");
                    return;
                } // end if
                if (_nBackID == undefined || _nUpID == undefined)
                {
                    return;
                } // end if
                this.__set__enabled(false);
                api.network.Guild.create(_nBackID, _nBackColor, _nUpID, _nUpColor, _loc2);
                break;
            } 
            case "_btnTabBack":
            {
                this.setCurrentTab("Back");
                break;
            } 
            case "_btnTabUp":
            {
                this.setCurrentTab("Up");
                break;
            } 
        } // End of switch
    } // End of the function
    function change(oEvent)
    {
        switch (_sCurrentTab)
        {
            case "Back":
            {
                _nBackColor = oEvent.value;
                this.updateBack();
                break;
            } 
            case "Up":
            {
                _nUpColor = oEvent.value;
                this.updateUp();
                break;
            } 
        } // End of switch
    } // End of the function
    function selectItem(oEvent)
    {
        switch (_sCurrentTab)
        {
            case "Back":
            {
                _nBackID = oEvent.owner.selectedIndex + 1;
                this.updateBack();
                break;
            } 
            case "Up":
            {
                _nUpID = oEvent.owner.selectedIndex + 1;
                this.updateUp();
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "CreateGuild";
    var _nBackColor = 14933949;
    var _nUpColor = 0;
    var _sCurrentTab = "Back";
} // End of Class
#endinitclip
