// Action script...

// [Initial MovieClip Action of sprite 1019]
#initclip 240
class dofus.graphics.gapi.ui.CreateCharacter extends ank.gapi.core.UIAdvancedComponent
{
    var _bNeedToChooseServer, __get__needToChooseServer, _nServerID, __get__serverID, addToQueue, _btnPrevious, _btnValidate, _btnBack, _btnNext, _btnMan, _btnWoman, api, _lblTitle, _lblChooseClass, _lblSex, createEmptyMovieClip, _mcSymbols, _mcPlacerSymbols, _mcPlacerPanels, getNextHighestDepth, attachMovie, _sSelectedName, _nSelectedClassID, _ldrClassSymbol, _lblClassName, _arArtworks, _nSelectedSex, gapi, unloadThis, __set__needToChooseServer, __set__serverID;
    function CreateCharacter()
    {
        super();
    } // End of the function
    function set needToChooseServer(bNeedToChooseServer)
    {
        _bNeedToChooseServer = bNeedToChooseServer;
        //return (this.needToChooseServer());
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
        super.init(false, dofus.graphics.gapi.ui.CreateCharacter.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: layoutContent});
        _btnPrevious._visible = false;
        _btnValidate._visible = false;
    } // End of the function
    function addListeners()
    {
        _btnBack.addEventListener("click", this);
        _btnNext.addEventListener("click", this);
        _btnPrevious.addEventListener("click", this);
        _btnValidate.addEventListener("click", this);
        _btnMan.addEventListener("click", this);
        _btnWoman.addEventListener("click", this);
    } // End of the function
    function initTexts()
    {
        _lblTitle.__set__text(api.lang.getText("CREATE_TITLE"));
        _lblChooseClass.__set__text(api.lang.getText("CHOOSE_YOUR_CLASS"));
        _lblSex.__set__text(api.lang.getText("CREATE_SEX"));
        _btnBack.__set__label(api.lang.getText("BACK"));
        _btnNext.__set__label(api.lang.getText("CUSTOMIZE"));
        _btnPrevious.__set__label(api.lang.getText("PRESENTATION"));
        _btnValidate.__set__label(api.lang.getText("VALIDATE"));
    } // End of the function
    function layoutContent()
    {
        this.createEmptyMovieClip("_mcSymbols", 10);
        _mcSymbols._x = _mcPlacerSymbols._x;
        _mcSymbols._y = _mcPlacerSymbols._y;
        var _loc16 = dofus.Constants.GUILD_ORDER.length;
        for (var _loc2 = 0; _loc2 < _loc16; ++_loc2)
        {
            var _loc5 = dofus.Constants.GUILD_ORDER[_loc2];
            var _loc3 = _mcSymbols.attachMovie("Container", "_ctrSymbol" + _loc5, _loc2, {_x: _loc2 * dofus.graphics.gapi.ui.CreateCharacter.SYMBOL_SPACE, _y: dofus.graphics.gapi.ui.CreateCharacter.SYMBOL_Y_OFFSET * (_loc2 % 2), dragAndDrop: true, highlightFront: false, highlightRenderer: "CreateCharacterSymbolHighlight", styleName: "none", enabled: true, _width: dofus.graphics.gapi.ui.CreateCharacter.SYMBOL_WIDTH, _height: dofus.graphics.gapi.ui.CreateCharacter.SYMBOL_WIDTH, margin: 4});
            var _loc4 = new Object();
            _loc4.name = api.lang.getClassText(_loc5).sn;
            _loc4.iconFile = dofus.Constants.GUILDS_SYMBOL_PATH + _loc5 + ".swf";
            _loc4.id = _loc5;
            _loc3.contentData = _loc4;
            _loc3.addEventListener("click", this);
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
        } // end of for
        this.addToQueue({object: this, method: setSex, params: [random(2), true]});
        this.setCurrentPanel(_nCurrentPanelIndex);
        this.addToQueue({object: this, method: selectClass, params: [random(dofus.Constants.GUILD_ORDER.length - 1) + 1]});
    } // End of the function
    function setCurrentPanel(nPanelIndex)
    {
        var _loc4 = dofus.graphics.gapi.ui.CreateCharacter.PANELS[_nCurrentPanelIndex];
        var _loc5 = this[_loc4.n];
        for (var _loc2 = 0; _loc2 < _loc4.e.length; ++_loc2)
        {
            _loc5.removeEventListener(_loc4.e[_loc2], this);
        } // end of for
        if (_loc5 != undefined)
        {
            _loc5.removeMovieClip();
        } // end if
        var _loc3 = dofus.graphics.gapi.ui.CreateCharacter.PANELS[nPanelIndex];
        var _loc6 = this.attachMovie(_loc3.l, _loc3.n, this.getNextHighestDepth(), {_x: _mcPlacerPanels._x, _y: _mcPlacerPanels._y});
        for (var _loc2 = 0; _loc2 < _loc3.e.length; ++_loc2)
        {
            _loc6.addEventListener(_loc3.e[_loc2], this);
        } // end of for
        _nCurrentPanelIndex = nPanelIndex;
        this.applyClassToCurrentPanel();
        this.applySexToCurrentPanel();
        _btnPrevious._visible = _loc3.b[0];
        _btnNext._visible = _loc3.b[1];
        _btnValidate._visible = _loc3.b[2];
        if (nPanelIndex == 0)
        {
            return;
        } // end if
        _loc6.colors = [_nSelectedColor1, _nSelectedColor2, _nSelectedColor3];
        if (_sSelectedName != undefined)
        {
            _loc6.name = _sSelectedName;
        } // end if
    } // End of the function
    function selectClass(nClassID)
    {
        _mcSymbols["_ctrSymbol" + _nSelectedClassID].selected = false;
        _mcSymbols["_ctrSymbol" + nClassID].selected = true;
        _nSelectedClassID = nClassID;
        _ldrClassSymbol.__set__contentPath(dofus.Constants.GUILDS_SYMBOL_PATH + nClassID + ".swf");
        _lblClassName.__set__text(api.lang.getClassText(nClassID).ln);
        _arArtworks.__set__classID(nClassID);
        this.applyClassToCurrentPanel();
    } // End of the function
    function setSex(nSex, bInitialization)
    {
        var _loc2 = this["_btn" + (_nSelectedSex == 0 ? ("Man") : ("Woman"))];
        var _loc4 = this["_btn" + (nSex == 0 ? ("Man") : ("Woman"))];
        _loc2.__set__selected(false);
        _loc2.__set__enabled(true);
        _loc4.__set__selected(true);
        _loc4.__set__enabled(false);
        _nSelectedSex = nSex;
        if (bInitialization == true)
        {
            _arArtworks.setPosition(nSex);
        }
        else
        {
            _arArtworks.rotate(nSex);
        } // end else if
        this.applySexToCurrentPanel();
    } // End of the function
    function applyClassToCurrentPanel()
    {
        if (_nSelectedClassID != undefined)
        {
            this[dofus.graphics.gapi.ui.CreateCharacter.PANELS[_nCurrentPanelIndex].n].classID = _nSelectedClassID;
        } // end if
    } // End of the function
    function applySexToCurrentPanel()
    {
        if (_nCurrentPanelIndex == 0)
        {
            return;
        } // end if
        if (_nSelectedClassID != undefined)
        {
            this[dofus.graphics.gapi.ui.CreateCharacter.PANELS[_nCurrentPanelIndex].n].sex = _nSelectedSex;
        } // end if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnBack":
            {
                if (_bNeedToChooseServer)
                {
                    gapi.loadUIComponent("ChooseServer", "ChooseServer", {servers: api.datacenter.Basics.aks_servers, serverID: _nServerID});
                    this.unloadThis();
                }
                else
                {
                    api.network.Account.getCharacters();
                } // end else if
                break;
            } 
            case "_btnNext":
            {
                this.setCurrentPanel(1);
                break;
            } 
            case "_btnPrevious":
            {
                this.setCurrentPanel(0);
                break;
            } 
            case "_btnValidate":
            {
                if (_sSelectedName.length == 0 || _sSelectedName == undefined)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("NEED_CHARACTER_NAME"), "ERROR_BOX", {name: "CREATENONAME"});
                    return;
                } // end if
                if (_sSelectedName.length > 20)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("LONG_CHARACTER_NAME", [_sSelectedName, 20]));
                    return;
                } // end if
                api.network.Account.addCharacter(_sSelectedName, _nSelectedClassID, _nSelectedColor1, _nSelectedColor2, _nSelectedColor3, _nSelectedSex, _nServerID);
                break;
            } 
            case "_btnMan":
            {
                this.setSex(0);
                break;
            } 
            case "_btnWoman":
            {
                this.setSex(1);
                break;
            } 
            default:
            {
                this.selectClass(oEvent.target.contentData.id);
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = oEvent.target;
        gapi.showTooltip(_loc2.contentData.name, _loc2, -20);
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function nameChange(oEvent)
    {
        _sSelectedName = oEvent.value;
    } // End of the function
    function colorsChange(oEvent)
    {
        _nSelectedColor1 = oEvent.value.color1;
        _nSelectedColor2 = oEvent.value.color2;
        _nSelectedColor3 = oEvent.value.color3;
    } // End of the function
    static var CLASS_NAME = "CreateCharacter";
    static var SYMBOL_WIDTH = 38;
    static var SYMBOL_Y_OFFSET = 10;
    static var SYMBOL_SPACE = 40;
    static var PANELS = [{l: "ClassInfosViewer", n: "_civClass", b: [false, true, false]}, {l: "ClassCustomize", n: "_ccClass", e: ["nameChange", "colorsChange"], b: [true, false, true]}];
    var _nSelectedColor1 = -1;
    var _nSelectedColor2 = -1;
    var _nSelectedColor3 = -1;
    var _nCurrentPanelIndex = 0;
} // End of Class
#endinitclip
