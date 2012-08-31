// Action script...

// [Initial MovieClip Action of sprite 1025]
#initclip 246
class dofus.graphics.gapi.ui.ChooseServer extends ank.gapi.core.UIAdvancedComponent
{
    var _eaServers, __get__servers, _nServerID, __get__serverID, addToQueue, _btnBack, _btnContinue, _cbServers, _ctrServerState, api, _lblTitle, _lblSelectedServer, _lblWhy, _txtWhy, _lblServerName, _lblServerCompletion, _lblCopyright, _txtServerDescription, _pbServerCompletion, _ldrLanguage, gapi, unloadThis, __set__serverID, __set__servers;
    function ChooseServer()
    {
        super();
    } // End of the function
    function set servers(eaServers)
    {
        _eaServers = eaServers;
        //return (this.servers());
        null;
    } // End of the function
    function set serverID(nServerID)
    {
        _nServerID = nServerID;
        //return (this.serverID());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.ChooseServer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
    } // End of the function
    function addListeners()
    {
        _btnBack.addEventListener("click", this);
        _btnContinue.addEventListener("click", this);
        _cbServers.addEventListener("itemSelected", this);
        _ctrServerState.addEventListener("over", this);
        _ctrServerState.addEventListener("out", this);
    } // End of the function
    function initTexts()
    {
        _lblTitle.__set__text(api.lang.getText("CHOOSE_SERVER"));
        _lblSelectedServer.__set__text(api.lang.getText("SECTECTED_SERVER"));
        _lblWhy.__set__text(api.lang.getText("CHOOSE_SERVER_WHY"));
        _txtWhy.__set__text(api.lang.getText("CHOOSE_SERVER_WHY_BLABLA"));
        _lblServerName.__set__text(api.lang.getText("SERVER_NAME"));
        _lblServerCompletion.__set__text(api.lang.getText("SERVER_COMPLETION"));
        _btnContinue.__set__label(api.lang.getText("SERVER_SELECT"));
        _btnBack.__set__label(api.lang.getText("BACK"));
        _lblCopyright.__set__text(api.lang.getText("COPYRIGHT"));
    } // End of the function
    function initData()
    {
        var _loc6 = _nServerID == undefined;
        _cbServers.__set__dataProvider(_eaServers);
        var _loc5 = 0;
        for (var _loc2 = 0; _loc2 < _eaServers.length; ++_loc2)
        {
            if (_loc6)
            {
                var _loc4 = _eaServers[_loc2].language;
                if (_loc4 == api.config.language)
                {
                    _loc5 = _loc2;
                    break;
                } // end if
                continue;
            } // end if
            var _loc3 = _eaServers[_loc2].id;
            if (_loc3 == _nServerID)
            {
                _loc5 = _loc2;
                break;
            } // end if
        } // end of for
        _cbServers.__set__selectedIndex(_loc5);
        this.showServerDescription(_eaServers[_loc5]);
    } // End of the function
    function showServerDescription(oServer)
    {
        _txtServerDescription.__set__text(oServer.description);
        _pbServerCompletion.__set__value(oServer.completion);
        switch (oServer.language)
        {
            case "fr":
            {
                _ldrLanguage.__set__contentPath("FrenchFlag");
                break;
            } 
            case "en":
            {
                _ldrLanguage.__set__contentPath("EnglishFlag");
                break;
            } 
        } // End of switch
        _ctrServerState.__set__contentPath("ChooseCharacterServerState" + oServer.state);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBack":
            {
                api.network.Account.getCharacters();
                break;
            } 
            case "_btnContinue":
            {
                api.kernel.showMessage(undefined, api.lang.getText("DO_U_CHOOSE_SERVER", [_cbServers.selectedItem.label]), "CAUTION_YESNO", {name: "ChooseSever", listener: this});
                break;
            } 
        } // End of switch
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.selectedItem;
        _nServerID = _loc2.id;
        this.showServerDescription(_loc2);
    } // End of the function
    function over(oEvent)
    {
        gapi.showTooltip(_cbServers.selectedItem.stateStr, _root._xmouse, _root._ymouse - 20);
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function yes(oEvent)
    {
        _nServerID = _cbServers.selectedItem.id;
        gapi.loadUIComponent("CreateCharacter", "CreateCharacter", {needToChooseServer: true, serverID: _nServerID});
        this.unloadThis();
    } // End of the function
    static var CLASS_NAME = "ChooseServer";
} // End of Class
#endinitclip
