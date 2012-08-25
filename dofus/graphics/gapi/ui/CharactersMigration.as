// Action script...

// [Initial MovieClip Action of sprite 20802]
#initclip 67
if (!dofus.graphics.gapi.ui.CharactersMigration)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.CharactersMigration = function ()
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
    _loc1.__set__characterCount = function (nCharacterCount)
    {
        this._nCharacterCount = nCharacterCount;
        //return (this.characterCount());
    };
    _loc1.__set__setNewName = function (sName)
    {
        this._mcPlayer._itCharacterName.text = sName;
        //return (this.setNewName());
    };
    _loc1.hideGenerateRandomName = function ()
    {
        this._mcPlayer._mcRandomName._visible = false;
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.CharactersMigration.CLASS_NAME);
        if (this.api.datacenter.Basics.aks_is_free_community)
        {
            this._btnSubscribe._visible = false;
        } // end if
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateCharactersList});
        this.addToQueue({object: this, method: this.initTexts});
        this._btnPlay._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._btnSkip.addEventListener("click", this);
        this._btnSubscribe.addEventListener("click", this);
        this._btnBack.addEventListener("click", this);
        this._lstCharacters.addEventListener("itemSelected", this);
        var ref = this;
        this._mcPlayer._mcDelete.onRelease = function ()
        {
            ref.api.kernel.showMessage(undefined, ref.api.lang.getText("DO_U_DELETE_A", [ref._lstCharacters.selectedItem.playerName]), "CAUTION_YESNO", {name: "ConfirmDelete", listener: ref});
        };
        this._mcPlayer._mcRandomName.onRelease = function ()
        {
            if (ref._nLastRegenerateTimer + ref.NAME_GENERATION_DELAY < getTimer())
            {
                ref.api.network.Account.getRandomCharacterName();
                ref._nLastRegenerateTimer = getTimer();
            } // end if
        };
        this._mcPlayer._mcRandomName.onRollOver = function ()
        {
            ref.gapi.showTooltip(ref.api.lang.getText("RANDOM_NICKNAME"), _root._xmouse, _root._ymouse - 20);
        };
        this._mcPlayer._mcRandomName.onRollOut = function ()
        {
            ref.gapi.hideTooltip();
        };
        this._mcPlayer._mcValid.onRelease = function ()
        {
            ref.validateCreation(ref._mcPlayer._itCharacterName.text, ref._lstCharacters.selectedItem.playerID);
        };
    };
    _loc1.updateCharactersList = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        for (var i in this._aSpriteList)
        {
            var _loc3 = new Object();
            _loc3.level = this._aSpriteList[i].Level;
            _loc3.playerName = this._aSpriteList[i].name;
            _loc3.newPlayerName = _loc3.playerName;
            _loc3.gfxID = this._aSpriteList[i].gfxID;
            _loc3.rowId = i;
            _loc3.list = this;
            _loc3.playerID = this._aSpriteList[i].id;
            _loc2.push(_loc3);
        } // end of for...in
        this._lstCharacters.dataProvider = _loc2;
        this._lstCharacters.selectedIndex = 0;
        var _loc4 = new Object();
        _loc4.row = new Object();
        _loc4.row.item = this._lstCharacters.selectedItem;
        this.itemSelected(_loc4);
    };
    _loc1.initData = function ()
    {
        this.api.datacenter.Basics.inGame = false;
        this._aConfirmedChatarcters = new Array();
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("CHOOSE_TITLE");
        this._btnSkip.label = this.api.lang.getText("SERVER_SELECT");
        this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
        this._btnBack.label = this.api.lang.getText("CHANGE_SERVER");
        this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
        this._lblAccount.text = this.api.lang.getText("ACCOUNT_INFO");
        this._lblLogin.text = this.api.lang.getText("PSEUDO_DOFUS", [this.api.datacenter.Basics.dofusPseudo]);
        this._lblServer.text = this.api.lang.getText("CURRENT_SERVER", [this.api.datacenter.Basics.aks_current_server.label]);
        this._taMigrationDesc.text = this.api.lang.getText("CHARACTER_MIGRATION_DESC");
        this._lblMigrationTitle.text = this.api.lang.getText("CHARACTER_MIGRATION_TITLE");
        this._lstCharacters.columnsNames = ["", this.api.lang.getText("NAME").substr(0, 1).toUpperCase() + this.api.lang.getText("NAME").substr(1), this.api.lang.getText("LEVEL"), this.api.lang.getText("STATE")];
    };
    _loc1.changeSpriteOrientation = function (mcSprite)
    {
        if (!mcSprite.attachMovie("staticF", "mcAnim", 10))
        {
            mcSprite.attachMovie("staticR", "mcAnim", 10);
        } // end if
    };
    _loc1.checkName = function (sName)
    {
        return (Math.random() * 2 > 1);
    };
    _loc1.destroy = function ()
    {
        this._mcPlayer._svCharacterViewer.destroy();
    };
    _loc1.validateCreation = function (sCharacterName, nCharacterId)
    {
        if (sCharacterName.length == 0 || sCharacterName == undefined)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("NEED_CHARACTER_NAME"), "ERROR_BOX", {name: "CREATENONAME"});
            return;
        } // end if
        if (sCharacterName.length > 20)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("LONG_CHARACTER_NAME", [sCharacterName, 20]), "ERROR_BOX");
            return;
        } // end if
        if (this.api.lang.getConfigText("CHAR_NAME_FILTER") && !this.api.datacenter.Player.isAuthorized)
        {
            var _loc4 = new dofus.utils.nameChecker.NameChecker(sCharacterName);
            var _loc5 = new dofus.utils.nameChecker.rules.NameCheckerCharacterNameRules();
            var _loc6 = _loc4.isValidAgainstWithDetails(_loc5);
            if (!_loc6.IS_SUCCESS)
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("INVALID_CHARACTER_NAME") + "\r\n" + _loc6.toString("\r\n"), "ERROR_BOX");
                return;
            } // end if
        } // end if
        if (!this.api.lang.getConfigText("CHARACTER_MIGRATION_ASK_SERVER_CONFIRM"))
        {
            if (this._aConfirmedChatarcters[nCharacterId] != undefined)
            {
                this.api.network.Account.validCharacterMigration(nCharacterId, sCharacterName);
            }
            else
            {
                var _loc7 = {name: "ConfirmMigration", params: {nCharacterId: nCharacterId, sCharacterName: sCharacterName}, listener: this};
                this.api.kernel.showMessage(undefined, this.api.lang.getText("CONFIRM_MIGRATION", [sCharacterName]), "CAUTION_YESNO", _loc7);
            } // end else if
        }
        else
        {
            this.api.network.Account.askCharacterMigration(nCharacterId, sCharacterName);
        } // end else if
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnSubscribe":
            {
                _root.getURL(this.api.lang.getConfigText("PAY_LINK"), "_blank");
                break;
            } 
            case "_btnSkip":
            {
                this.api.network.Account.getCharactersForced();
                this.api.datacenter.Basics.ignoreMigration = true;
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        this._mcPlayer._svCharacterViewer.zoom = 200;
        this._mcPlayer._svCharacterViewer.refreshDelay = 50;
        this._mcPlayer._svCharacterViewer.useSingleLoader = true;
        this._mcPlayer._svCharacterViewer.allowAnimations = false;
        this._mcPlayer._svCharacterViewer.spriteData = this._aSpriteList[oEvent.row.item.rowId];
        this._mcPlayer._lblOldName.text = this.api.lang.getText("OLD_NAME") + " : " + oEvent.row.item.playerName;
        this._mcPlayer._itCharacterName.text = oEvent.row.item.newPlayerName;
    };
    _loc1.initialization = function (oEvent)
    {
        this._mcSprite = oEvent.clip;
        this.gapi.api.colors.addSprite(this._mcSprite, this._oCurrentPlayerData);
        this._mcSprite._xscale = this._mcSprite._yscale = 180;
        this.addToQueue({object: this, method: this.changeSpriteOrientation, params: [this._mcSprite]});
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoConfirmDelete":
            {
                this.api.network.Account.deleteCharacterMigration(this._lstCharacters.selectedItem.playerID);
                break;
            } 
            case "AskYesNoConfirmMigration":
            {
                this._aConfirmedChatarcters[oEvent.params.nCharacterId] = true;
                this.api.network.Account.validCharacterMigration(oEvent.params.nCharacterId, oEvent.params.sCharacterName);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("setNewName", function ()
    {
    }, _loc1.__set__setNewName);
    _loc1.addProperty("characterCount", function ()
    {
    }, _loc1.__set__characterCount);
    _loc1.addProperty("spriteList", function ()
    {
    }, _loc1.__set__spriteList);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.CharactersMigration = function ()
    {
        super();
    }).CLASS_NAME = "CharactersMigration";
    _loc1.NAME_GENERATION_DELAY = 500;
    _loc1._nLastRegenerateTimer = 0;
} // end if
#endinitclip
