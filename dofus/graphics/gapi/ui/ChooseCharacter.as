// Action script...

// [Initial MovieClip Action of sprite 20830]
#initclip 95
if (!dofus.graphics.gapi.ui.ChooseCharacter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.ChooseCharacter = function ()
    {
        super();
    }).prototype;
    _loc1.__set__spriteList = function (aSpriteList)
    {
        this._aSpriteList = aSpriteList;
        if (this.initialized)
        {
            this.initData();
        } // end if
        //return (this.spriteList());
    };
    _loc1.__set__remainingTime = function (nRemainingTime)
    {
        this._nRemainingTime = nRemainingTime;
        //return (this.remainingTime());
    };
    _loc1.__set__showComboBox = function (bShowComboBox)
    {
        this._bShowComboBox = bShowComboBox;
        //return (this.showComboBox());
    };
    _loc1.__set__characterCount = function (nCharacterCount)
    {
        this._nCharacterCount = nCharacterCount;
        //return (this.characterCount());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ChooseCharacter.CLASS_NAME);
        if (this.api.datacenter.Basics.aks_is_free_community)
        {
            this._btnSubscribe._visible = false;
        } // end if
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this._btnPlay._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._cciSprite0.addEventListener("select", this);
        this._cciSprite1.addEventListener("select", this);
        this._cciSprite2.addEventListener("select", this);
        this._cciSprite3.addEventListener("select", this);
        this._cciSprite4.addEventListener("select", this);
        this._cciSprite0.addEventListener("remove", this);
        this._cciSprite1.addEventListener("remove", this);
        this._cciSprite2.addEventListener("remove", this);
        this._cciSprite3.addEventListener("remove", this);
        this._cciSprite4.addEventListener("remove", this);
        this._cciSprite0.addEventListener("reset", this);
        this._cciSprite1.addEventListener("reset", this);
        this._cciSprite2.addEventListener("reset", this);
        this._cciSprite3.addEventListener("reset", this);
        this._cciSprite4.addEventListener("reset", this);
        this._btnPlay.addEventListener("click", this);
        this._btnCreate.addEventListener("click", this);
        this._btnSubscribe.addEventListener("click", this);
        this._btnBack.addEventListener("click", this);
        this.api.kernel.StreamingDisplayManager.onCharacterChoice();
    };
    _loc1.updateCharactersList = function ()
    {
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < 5)
        {
            var _loc3 = this["_cciSprite" + _loc2];
            _loc3.showComboBox = this._bShowComboBox;
            _loc3.params = {index: _loc2 + this._nCharacterStartIndex};
            _loc3.data = this._aSpriteList[_loc2 + this._nCharacterStartIndex];
            _loc3.enabled = this._aSpriteList[_loc2 + this._nCharacterStartIndex] != undefined;
            _loc3.isDead = _loc3.data.isDead;
            _loc3.death = _loc3.data.deathCount;
            _loc3.deathState = _loc3.data.deathState;
        } // end while
    };
    _loc1.initData = function ()
    {
        this.api.datacenter.Basics.inGame = false;
        this._btnArrowLeft._visible = this._btnArrowRight._visible = this._aSpriteList.length > 5;
        this._nCharacterStartIndex = 0;
        this._btnArrowLeft.onRelease = function ()
        {
            this._parent._btnArrowLeft.gotoAndStop("on");
            this._parent._btnArrowRight.gotoAndStop("on");
            --this._parent._nCharacterStartIndex;
            if (this._parent._nCharacterStartIndex <= 0)
            {
                this._parent._nCharacterStartIndex = 0;
                this.gotoAndStop("off");
            } // end if
            this._parent.updateCharactersList();
        };
        this._btnArrowRight.onRelease = function ()
        {
            this._parent._btnArrowLeft.gotoAndStop("on");
            this._parent._btnArrowRight.gotoAndStop("on");
            ++this._parent._nCharacterStartIndex;
            if (this._parent._nCharacterStartIndex >= this._parent._aSpriteList.length - 5)
            {
                this._parent._nCharacterStartIndex = this._parent._aSpriteList.length - 5;
                this.gotoAndStop("off");
            } // end if
            this._parent.updateCharactersList();
        };
        this._lblRemainingTime.text = this.api.kernel.GameManager.getRemainingString(this._nRemainingTime);
        this._lblRemainingTime.styleName = this._nRemainingTime == 0 ? ("RedRightSmallBoldLabel") : ("WhiteRightSmallBoldLabel");
        this._btnSubscribe.enabled = this._nRemainingTime != -1;
        if (this._aSpriteList.length == 0)
        {
            this._btnPlay._visible = false;
        }
        else
        {
            this._btnPlay._visible = true;
        } // end else if
        if (!this.api.config.isStreaming)
        {
            this._lblLogin.onRollOver = function ()
            {
                this._parent.gapi.showTooltip(this._parent.api.lang.getText("PSEUDO_DOFUS_INFOS"), this, 20, undefined);
            };
            this._lblLogin.onRollOut = function ()
            {
                this._parent.gapi.hideTooltip();
            };
            this._lblLogin.onRelease = function ()
            {
                var _loc2 = this._parent.api.lang.getText("PSEUDO_DOFUS_LINK");
                if (_loc2 != undefined && _loc2 != "")
                {
                    this.getURL(_loc2, "_blank");
                } // end if
            };
        } // end if
        this._btnArrowLeft.onRelease();
        this._btnBack._visible = !this.api.config.isStreaming;
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("CHOOSE_TITLE");
        this._btnPlay.label = this.api.lang.getText("MENU_PLAY");
        this._btnCreate.label = this.api.lang.getText("CREATE_CHARACTER");
        this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
        this._btnBack.label = this.api.lang.getText("CHANGE_SERVER");
        this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
        this._lblAccount.text = this.api.lang.getText("ACCOUNT_INFO");
        if (!this.api.config.isStreaming)
        {
            this._lblLogin.text = this.api.lang.getText("PSEUDO_DOFUS", [this.api.datacenter.Basics.dofusPseudo]);
        }
        else
        {
            this._lblLogin.text = this.api.lang.getText("POPUP_GAME_BEGINNING_TITLE");
        } // end else if
        this._lblServer.text = this.api.lang.getText("CURRENT_SERVER", [this.api.datacenter.Basics.aks_current_server.label]);
    };
    _loc1.select = function (oEvent)
    {
        var _loc3 = oEvent.target.params.index;
        this["_cciSprite" + this._nSelectedIndex].selected = false;
        if (this._nSelectedIndex == _loc3)
        {
            delete this._nSelectedIndex;
        }
        else
        {
            this._nSelectedIndex = _loc3;
        } // end else if
        if (getTimer() - this._nSaveLastClick < ank.gapi.Gapi.DBLCLICK_DELAY)
        {
            this._nSelectedIndex = _loc3;
            this.click({target: this._btnPlay});
            return;
        } // end if
        this._nSaveLastClick = getTimer();
    };
    _loc1.remove = function (oEvent)
    {
        var _loc3 = oEvent.target.params.index;
        if (this.api.lang.getConfigText("SECRET_ANSWER_ON_DELETE") && (this._aSpriteList[_loc3].Level >= this.api.lang.getConfigText("SECRET_ANSWER_SINCE_LEVEL") && (this.api.datacenter.Basics.aks_secret_question != undefined && this.api.datacenter.Basics.aks_secret_question.length > 0)))
        {
            this.gapi.loadUIComponent("AskSecretAnswer", "AskSecretAnswer", {title: this.api.lang.getText("DELETE_WORD"), charToDelete: this._aSpriteList[_loc3]});
        }
        else
        {
            this.api.kernel.showMessage(this.api.lang.getText("DELETE_WORD"), this.api.lang.getText("DO_U_DELETE_A", [this._aSpriteList[_loc3].name]), "CAUTION_YESNO", {name: "Delete", listener: this, params: {index: _loc3}});
        } // end else if
    };
    _loc1.reset = function (oEvent)
    {
        var _loc3 = this._aSpriteList[oEvent.target.params.index].id;
        var _loc4 = this.gapi.loadUIComponent("AskYesNo", "AskYesReset", {title: this.api.lang.getText("RESET_SHORTCUT"), text: this.api.lang.getText("DO_U_RESET_CHARACTER"), params: {index: _loc3}});
        _loc4.addEventListener("yes", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnPlay":
            {
                if (this._nSelectedIndex == undefined)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("SELECT_CHARACTER"), "ERROR_BOX", {name: "NoSelect"});
                }
                else
                {
                    this.api.network.Account.setCharacter(this._aSpriteList[this._nSelectedIndex].id);
                } // end else if
                break;
            } 
            case "_btnCreate":
            {
                if (this._nCharacterCount >= 5 && !this.api.datacenter.Player.isAuthorized)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("TOO_MUCH_CHARACTER"), "ERROR_BOX");
                }
                else
                {
                    this.gapi.loadUIComponent("CreateCharacter", "CreateCharacter", {remainingTime: this._nRemainingTime});
                    this.gapi.unloadUIComponent("ChooseCharacter");
                } // end else if
                break;
            } 
            case "_btnSubscribe":
            {
                _root.getURL(this.api.lang.getConfigText("PAY_LINK"), "_blank");
                break;
            } 
            case "_btnBack":
            {
                this.api.kernel.changeServer(true);
                break;
            } 
            case "_btnChangeServer":
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesReset":
            {
                this.api.network.Account.resetCharacter(oEvent.params.index);
                break;
            } 
            case "AskYesNoDelete":
            {
                this.api.network.Account.deleteCharacter(this._aSpriteList[oEvent.params.index].id);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("characterCount", function ()
    {
    }, _loc1.__set__characterCount);
    _loc1.addProperty("showComboBox", function ()
    {
    }, _loc1.__set__showComboBox);
    _loc1.addProperty("remainingTime", function ()
    {
    }, _loc1.__set__remainingTime);
    _loc1.addProperty("spriteList", function ()
    {
    }, _loc1.__set__spriteList);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ChooseCharacter = function ()
    {
        super();
    }).CLASS_NAME = "ChooseCharacter";
} // end if
#endinitclip
