// Action script...

// [Initial MovieClip Action of sprite 1023]
#initclip 244
class dofus.graphics.gapi.ui.ChooseCharacter extends ank.gapi.core.UIAdvancedComponent
{
    var _aSpriteList, __get__initialized, __get__spriteList, _nRemainingTime, __get__remainingTime, _bShowComboBox, __get__showComboBox, addToQueue, _btnPlay, _cciSprite0, _cciSprite1, _cciSprite2, _cciSprite3, _cciSprite4, _btnCreate, _btnSubscribe, _txtRemainingTime, api, _lblTitle, _lblCopyright, _lblAccount, _nSelectedIndex, _nSelectedServerID, gapi, __set__remainingTime, __set__showComboBox, __set__spriteList;
    function ChooseCharacter()
    {
        super();
    } // End of the function
    function set spriteList(aSpriteList)
    {
        _aSpriteList = aSpriteList;
        if (this.__get__initialized())
        {
            this.initData();
        } // end if
        //return (this.spriteList());
        null;
    } // End of the function
    function set remainingTime(nRemainingTime)
    {
        _nRemainingTime = nRemainingTime;
        //return (this.remainingTime());
        null;
    } // End of the function
    function set showComboBox(bShowComboBox)
    {
        _bShowComboBox = bShowComboBox;
        //return (this.showComboBox());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.ChooseCharacter.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
        this.addToQueue({object: this, method: initTexts});
        _btnPlay._visible = false;
    } // End of the function
    function addListeners()
    {
        _cciSprite0.addEventListener("select", this);
        _cciSprite1.addEventListener("select", this);
        _cciSprite2.addEventListener("select", this);
        _cciSprite3.addEventListener("select", this);
        _cciSprite4.addEventListener("select", this);
        _cciSprite0.addEventListener("unselect", this);
        _cciSprite1.addEventListener("unselect", this);
        _cciSprite2.addEventListener("unselect", this);
        _cciSprite3.addEventListener("unselect", this);
        _cciSprite4.addEventListener("unselect", this);
        _cciSprite0.addEventListener("remove", this);
        _cciSprite1.addEventListener("remove", this);
        _cciSprite2.addEventListener("remove", this);
        _cciSprite3.addEventListener("remove", this);
        _cciSprite4.addEventListener("remove", this);
        _btnPlay.addEventListener("click", this);
        _btnCreate.addEventListener("click", this);
        _btnSubscribe.addEventListener("click", this);
    } // End of the function
    function initData()
    {
        for (var _loc2 = 0; _loc2 < 5; ++_loc2)
        {
            var _loc3 = this["_cciSprite" + _loc2];
            _loc3.showComboBox = _bShowComboBox;
            _loc3.params = {index: _loc2};
            _loc3.data = _aSpriteList[_loc2];
            _loc3.enabled = _aSpriteList[_loc2] != undefined;
        } // end of for
        _txtRemainingTime.__set__text(this.getRemainingString(_nRemainingTime));
        _txtRemainingTime.__set__styleName(_nRemainingTime == 0 ? ("RedLeftSmallTextArea") : ("BrownLeftSmallTextArea"));
        _btnSubscribe.__set__enabled(_nRemainingTime != -1);
        if (_aSpriteList.length == 0)
        {
            _btnPlay._visible = false;
        }
        else
        {
            _btnPlay._visible = true;
        } // end else if
        if (_aSpriteList.length >= 5)
        {
            _btnCreate.__set__enabled(false);
        }
        else
        {
            _btnCreate.__set__enabled(true);
        } // end else if
    } // End of the function
    function initTexts()
    {
        _lblTitle.__set__text(api.lang.getText("CHOOSE_TITLE"));
        _btnPlay.__set__label(api.lang.getText("PLAY"));
        _btnCreate.__set__label(api.lang.getText("CREATE_CHARACTER"));
        _btnSubscribe.__set__label(api.lang.getText("SUBSCRIPTION"));
        _lblCopyright.__set__text(api.lang.getText("COPYRIGHT"));
        _lblAccount.__set__text(api.lang.getText("ACCOUNT_INFO"));
    } // End of the function
    function getRemainingString(nRemainingTime)
    {
        if (nRemainingTime == -1)
        {
            return (api.lang.getText("OPEN_BETA_ACCOUNT"));
        }
        else if (nRemainingTime == 0)
        {
            return (api.lang.getText("SUBSCRIPTION_OUT"));
        }
        else
        {
            var _loc8 = new Date();
            _loc8.setTime(nRemainingTime);
            var _loc7 = _loc8.getUTCFullYear() - 1970;
            var _loc5 = _loc8.getUTCMonth();
            var _loc2 = _loc8.getUTCDate() - 1;
            var _loc4 = _loc8.getUTCHours();
            var _loc6 = _loc8.getUTCMinutes();
            var _loc9 = " " + api.lang.getText("AND") + " ";
            var _loc3 = api.lang.getText("REMAINING_TIME") + " ";
            if (_loc7 != 0 && _loc5 == 0)
            {
                var _loc14 = ank.utils.PatternDecoder.combine(api.lang.getText("YEARS"), "m", _loc7 == 1);
                _loc3 = _loc3 + (_loc7 + " " + _loc14);
            }
            else if (_loc7 != 0 && _loc5 != 0)
            {
                _loc14 = ank.utils.PatternDecoder.combine(api.lang.getText("YEARS"), "m", _loc7 == 1);
                var _loc10 = ank.utils.PatternDecoder.combine(api.lang.getText("MONTHS"), "m", _loc5 == 1);
                _loc3 = _loc3 + (_loc7 + " " + _loc14 + _loc9 + _loc5 + " " + _loc10);
            }
            else if (_loc5 != 0 && _loc2 == 0)
            {
                _loc10 = ank.utils.PatternDecoder.combine(api.lang.getText("MONTHS"), "m", _loc5 == 1);
                _loc3 = _loc3 + (_loc5 + " " + _loc10);
            }
            else if (_loc5 != 0 && _loc2 != 0)
            {
                _loc10 = ank.utils.PatternDecoder.combine(api.lang.getText("MONTHS"), "m", _loc5 == 1);
                var _loc11 = ank.utils.PatternDecoder.combine(api.lang.getText("DAYS"), "m", _loc2 == 1);
                _loc3 = _loc3 + (_loc5 + " " + _loc10 + _loc9 + _loc2 + " " + _loc11);
            }
            else if (_loc2 != 0 && _loc4 == 0)
            {
                _loc11 = ank.utils.PatternDecoder.combine(api.lang.getText("DAYS"), "m", _loc2 == 1);
                _loc3 = _loc3 + (_loc2 + " " + _loc11);
            }
            else if (_loc2 != 0 && _loc4 != 0)
            {
                _loc11 = ank.utils.PatternDecoder.combine(api.lang.getText("DAYS"), "m", _loc2 == 1);
                var _loc13 = ank.utils.PatternDecoder.combine(api.lang.getText("HOURS"), "m", _loc4 == 1);
                _loc3 = _loc3 + (_loc2 + " " + _loc11 + _loc9 + _loc4 + " " + _loc13);
            }
            else if (_loc4 != 0 && _loc6 == 0)
            {
                _loc13 = ank.utils.PatternDecoder.combine(api.lang.getText("HOURS"), "m", _loc4 == 1);
                _loc3 = _loc3 + (_loc4 + " " + _loc13);
            }
            else if (_loc4 != 0 && _loc6 != 0)
            {
                _loc13 = ank.utils.PatternDecoder.combine(api.lang.getText("HOURS"), "m", _loc4 == 1);
                var _loc15 = ank.utils.PatternDecoder.combine(api.lang.getText("MINUTES"), "m", _loc6 == 1);
                _loc3 = _loc3 + (_loc4 + " " + _loc13 + _loc9 + _loc6 + " " + _loc15);
            }
            else if (_loc6 != 0)
            {
                _loc15 = ank.utils.PatternDecoder.combine(api.lang.getText("MINUTES"), "m", _loc6 == 1);
                _loc3 = _loc3 + (_loc6 + " " + _loc15);
            } // end else if
            return (_loc3 + " " + api.lang.getText("ON_FULL_VERSION") + ".");
        } // end else if
        return (null);
    } // End of the function
    function select(oEvent)
    {
        var _loc2 = oEvent.target.params.index;
        if (_nSelectedIndex == _loc2)
        {
            _nSelectedServerID = oEvent.serverID;
            this.click({target: _btnPlay});
            return;
        } // end if
        this["_cciSprite" + _nSelectedIndex].selected = false;
        if (_loc2 != undefined)
        {
            _nSelectedIndex = _loc2;
            _nSelectedServerID = oEvent.serverID;
        }
        else
        {
            delete this._nSelectedIndex;
            delete this._nSelectedServerID;
        } // end else if
    } // End of the function
    function unselect(oEvent)
    {
        var _loc2 = oEvent.target.params.index;
        if (_nSelectedIndex == _loc2)
        {
            delete this._nSelectedIndex;
        } // end if
    } // End of the function
    function remove(oEvent)
    {
        var _loc2 = oEvent.target.params.index;
        api.kernel.showMessage(api.lang.getText("DELETE"), api.lang.getText("DO_U_DELETE_A", [_aSpriteList[_loc2].name]), "CAUTION_YESNO", {name: "Delete", listener: this, params: {index: _loc2}});
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnPlay":
            {
                if (_nSelectedIndex == undefined)
                {
                    api.kernel.showMessage(undefined, api.lang.getText("SELECT_CHARACTER"), "ERROR_BOX", {name: "NoSelect"});
                }
                else
                {
                    api.datacenter.Basics.aks_current_server = new dofus.datacenter.Server(_nSelectedServerID, 1, 0);
                } // end else if
                api.network.Account.setCharacter(_aSpriteList[_nSelectedIndex].id, _nSelectedServerID);
                break;
            } 
            case "_btnCreate":
            {
                if (api.datacenter.Basics.aks_servers.length > 1)
                {
                    gapi.loadUIComponent("ChooseServer", "ChooseServer", {servers: api.datacenter.Basics.aks_servers});
                }
                else
                {
                    gapi.loadUIComponent("CreateCharacter", "CreateCharacter", {needToChooseServer: false, serverID: api.datacenter.Basics.aks_servers[0].id});
                } // end else if
                gapi.unloadUIComponent("ChooseCharacter");
                break;
            } 
            case "_btnSubscribe":
            {
                _root.getURL(api.lang.getConfigText("PAY_LINK"), "_blank");
                break;
            } 
        } // End of switch
    } // End of the function
    function yes(oEvent)
    {
        api.network.Account.deleteCharacter(_aSpriteList[oEvent.params.index].id);
    } // End of the function
    static var CLASS_NAME = "ChooseCharacter";
} // End of Class
#endinitclip
