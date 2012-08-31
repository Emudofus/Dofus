// Action script...

// [Initial MovieClip Action of sprite 1024]
#initclip 245
class dofus.graphics.gapi.controls.ChooseCharacterSprite extends ank.gapi.core.UIAdvancedComponent
{
    var _bShowComboBox, __get__showComboBox, _oData, __get__data, getStyle, __get__selected, addToQueue, _btnDelete, _ldrSprite, _cbServers, _ctrServerState, api, _bEnabled, _mcInteraction, _parent, setMovieClipTransform, __set__selected, _lblName, _lblLevel, _ldrMerchant, _mcStateBack, _nServerID, _oServer, __set__enabled, _lblServer, _mcSelect, setMovieClipColor, _nIntervalID, gapi, dispatchEvent, __set__data, __set__showComboBox;
    function ChooseCharacterSprite()
    {
        super();
    } // End of the function
    function set showComboBox(bShowComboBox)
    {
        _bShowComboBox = bShowComboBox;
        //return (this.showComboBox());
        null;
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
    function set selected(bSelected)
    {
        _bSelected = bSelected;
        this.updateSelected(bSelected ? (this.getStyle().selectedcolor) : (this.getStyle().overcolor));
        //return (this.selected());
        null;
    } // End of the function
    function get selected()
    {
        return (_bSelected);
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.ChooseCharacterSprite.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        _btnDelete._visible = false;
    } // End of the function
    function addListeners()
    {
        _ldrSprite.addEventListener("initialization", this);
        _btnDelete.addEventListener("click", this);
        _btnDelete.addEventListener("over", this);
        _btnDelete.addEventListener("out", this);
        _cbServers.addEventListener("itemSelected", this);
        _ctrServerState.addEventListener("over", this);
        _ctrServerState.addEventListener("out", this);
        api.datacenter.Basics.aks_servers.addEventListener("modelChanged", this);
    } // End of the function
    function initData()
    {
        this.updateData();
    } // End of the function
    function setEnabled()
    {
        if (_bEnabled)
        {
            _mcInteraction.onRelease = function ()
            {
                _parent.innerRelease();
            };
            _mcInteraction.onRollOver = function ()
            {
                _parent.innerOver();
            };
            _mcInteraction.onRollOut = _mcInteraction.onReleaseOutside = function ()
            {
                _parent.innerOut();
            };
            this.setMovieClipTransform(this, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0});
        }
        else
        {
            delete _mcInteraction.onRelease;
            delete _mcInteraction.onRollOver;
            delete _mcInteraction.onRollOut;
            delete _mcInteraction.onReleaseOutside;
            this.setMovieClipTransform(this, this.getStyle().desabledtransform);
            this.__set__selected(false);
        } // end else if
    } // End of the function
    function updateData()
    {
        if (_oData != undefined)
        {
            _lblName.__set__text(_oData.name);
            _lblLevel.__set__text(api.lang.getText("LEVEL") + " " + _oData.Level);
            if (_oData.Merchant)
            {
                _ldrMerchant.__set__contentPath(dofus.Constants.OFFLINE_PATH + "0.swf");
            } // end if
            _ldrSprite.__set__contentPath(_oData.gfxFile);
            _btnDelete._visible = true;
            _cbServers._visible = true;
            this.updateServer(_oData.serverID);
            _mcStateBack._visible = true;
        }
        else
        {
            _lblName.__set__text("");
            _lblLevel.__set__text("");
            _ldrSprite.__set__contentPath("");
            _btnDelete._visible = false;
            _cbServers._visible = false;
            _ctrServerState.__set__contentPath("");
            _mcStateBack._visible = false;
        } // end else if
    } // End of the function
    function updateServer(nServerID)
    {
        if (nServerID != undefined)
        {
            _nServerID = nServerID;
        } // end if
        var _loc3 = api.datacenter.Basics.aks_servers;
        var _loc5 = 0;
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            var _loc4 = _loc3[_loc2].id;
            if (_loc4 == _nServerID)
            {
                _loc5 = _loc2;
                _oServer = _loc3[_loc2];
                break;
            } // end if
        } // end of for
        var _loc6 = _loc3[_loc5];
        if (_loc6 == undefined)
        {
            ank.utils.Logger.err("Serveur " + _nServerID + " inconnu");
        }
        else
        {
            this.__set__enabled(_loc6.state == dofus.datacenter.Server.SERVER_ONLINE);
            _ctrServerState.__set__contentPath("ChooseCharacterServerState" + _loc6.state);
        } // end else if
        if (_bShowComboBox)
        {
            _cbServers.__set__dataProvider(_loc3);
            _cbServers.__set__selectedIndex(_loc5);
            _cbServers.__set__buttonIcon("ComboBoxButtonNormalIcon");
            _lblServer.__set__text("");
            _cbServers.__set__enabled(true);
        }
        else
        {
            _cbServers.__set__buttonIcon("");
            _lblServer.__set__text(_loc6.label);
            _cbServers.__set__enabled(false);
        } // end else if
    } // End of the function
    function updateSelected(nColor)
    {
        if (_bSelected || _bOver && _bEnabled)
        {
            this.setMovieClipColor(_mcSelect, nColor);
            _mcSelect.gotoAndPlay(1);
            _mcSelect._visible = true;
        }
        else
        {
            _mcSelect.stop();
            _mcSelect._visible = false;
        } // end else if
    } // End of the function
    function changeSpriteOrientation(mcSprite)
    {
        clearInterval(_nIntervalID);
        mcSprite.attachMovie("staticF", "mcAnim", 10);
    } // End of the function
    function initialization(oEvent)
    {
        var _loc2 = oEvent.clip;
        gapi.api.colors.addSprite(_loc2, _oData);
        _loc2._xscale = _loc2._yscale = 120;
        if (System.capabilities.playerType == "PlugIn")
        {
            _nIntervalID = setInterval(changeSpriteOrientation, 100, _loc2);
        }
        else
        {
            this.addToQueue({object: this, method: changeSpriteOrientation, params: [_loc2]});
        } // end else if
    } // End of the function
    function innerRelease()
    {
        this.__set__selected(true);
        this.dispatchEvent({type: "select", serverID: _nServerID});
    } // End of the function
    function innerOver()
    {
        _bOver = true;
        this.updateSelected(_bSelected ? (this.getStyle().selectedcolor) : (this.getStyle().overcolor));
    } // End of the function
    function innerOut()
    {
        _bOver = false;
        this.updateSelected(this.getStyle().selectedcolor);
    } // End of the function
    function click(oEvent)
    {
        this.dispatchEvent({type: "remove"});
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target)
        {
            case _btnDelete:
            {
                gapi.showTooltip(api.lang.getText("DELETE_CHARACTER"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case _ctrServerState:
            {
                gapi.showTooltip(_oServer.stateStr, _root._xmouse, _root._ymouse - 20);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.selectedItem;
        _nServerID = _loc2.id;
        this.updateServer();
        if (!_bSelected && _bEnabled)
        {
            this.innerRelease();
        }
        else if (!_bEnabled)
        {
            this.dispatchEvent({type: "unselect"});
        } // end else if
    } // End of the function
    function modelChanged(oEvent)
    {
        if (_oData != undefined)
        {
            this.updateServer();
        } // end if
    } // End of the function
    static var CLASS_NAME = "ChooseCharacterSprite";
    var _bSelected = false;
    var _bOver = false;
} // End of Class
#endinitclip
