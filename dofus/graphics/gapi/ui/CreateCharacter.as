// Action script...

// [Initial MovieClip Action of sprite 20786]
#initclip 51
if (!dofus.graphics.gapi.ui.CreateCharacter)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.CreateCharacter = function ()
    {
        super();
    }).prototype;
    _loc1.__set__remainingTime = function (nRemainingTime)
    {
        this._nRemainingTime = nRemainingTime;
        //return (this.remainingTime());
    };
    _loc1.__set__characterName = function (sNewName)
    {
        if (this._itCharacterName.text != undefined)
        {
            this._itCharacterName.text = sNewName;
        } // end if
        //return (this.characterName());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.CreateCharacter.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.setupRestriction});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initComponent});
        this.addToQueue({object: this, method: this.selectRandomBreed});
        this.api.kernel.StreamingDisplayManager.onCharacterCreation();
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("JavaScript:WriteLog(\'CreateCharacter\')");
        } // end if
    };
    _loc1.addListeners = function ()
    {
        var ref = this;
        this._mcMaleButton.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcMaleButton.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcMaleButton.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcFemaleButton.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcFemaleButton.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcFemaleButton.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcSpellButton.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcSpellButton.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcSpellButton.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcSpellButton2.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcSpellButton2.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcSpellButton2.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcHistoryButton.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcHistoryButton.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcHistoryButton.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcRandomName.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcRandomName.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcRandomName.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcRight.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcRight.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcRight.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcLeft.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcLeft.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcLeft.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._btnBack.addEventListener("click", this);
        this._btnValidate.addEventListener("click", this);
        this._itCharacterName.addEventListener("change", this);
        this._csColors.addEventListener("change", this);
        this._csColors.addEventListener("over", this);
        this._csColors.addEventListener("out", this);
        this._csBreedSelection.addEventListener("change", this);
    };
    _loc1.setupRestriction = function ()
    {
        var _loc2 = "";
        if (this.api.datacenter.Player.isAuthorized)
        {
            _loc2 = "a-zA-Z\\-\\[\\]";
        }
        else
        {
            _loc2 = "a-zA-Z\\-";
        } // end else if
        if (this.api.config.isStreaming)
        {
            _loc2 = _loc2 + "0-9";
        } // end if
        this._itCharacterName.restrict = _loc2;
    };
    _loc1.initTexts = function ()
    {
        this._lblTitle.text = this.api.lang.getText("CREATE_TITLE");
        this._lblCharacterColors.text = this.api.lang.getText("SPRITE_COLORS");
        this._lblCharacterName.text = this.api.lang.getText("CREATE_CHARACTER_NAME");
        this._btnBack.label = this.api.lang.getText("BACK");
        this._btnValidate.label = this.api.lang.getText("VALIDATE");
        this._lblHistoryButton.text = this.api.lang.getText("HISTORY_CLASS_WORD");
        this._lblSpellButton.text = this.api.lang.getText("SPELLS_SHORTCUT");
    };
    _loc1.initComponent = function ()
    {
        this._oColors = {color1: -1, color2: -1, color3: -1};
        this._nSex = Math.round(Math.random());
        var _loc2 = new Array();
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < dofus.Constants.GUILD_ORDER.length)
        {
            if (this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[_loc3] == 12)
            {
                continue;
            } // end if
            _loc2[_loc3] = dofus.Constants.BREEDS_SLIDER_PATH + dofus.Constants.GUILD_ORDER[_loc3] + this._nSex + ".swf";
        } // end while
        this._csBreedSelection.initialize(_loc2);
        this._csBreedSelection.animation = true;
        this._csBreedSelection.animationSpeed = 3;
        this._svCharacter.zoom = 250;
        this._svCharacter.spriteAnims = ["StaticF", "StaticR", "StaticL", "WalkF", "RunF", "Anim2R", "Anim2L"];
        this._svCharacter.refreshDelay = 50;
        this._svCharacter.useSingleLoader = true;
    };
    _loc1.selectRandomBreed = function ()
    {
        for (var _loc2 = -1; _loc2 == -1 || this.api.config.isStreaming && _loc2 == 12; _loc2 = Math.round(Math.random() * (dofus.Constants.GUILD_ORDER.length - 1)) + 1)
        {
        } // end of for
        this.setClass(_loc2, this._nSex);
        this._bLoaded = true;
    };
    _loc1.setClass = function (nClassID, nSex)
    {
        this._csColors.breed = nClassID;
        this._csColors.sex = nSex;
        if (this._nBreed == nClassID && this._nSex == nSex)
        {
            return;
        } // end if
        this._svCharacter.spriteData = new ank.battlefield.datacenter.Sprite("1", undefined, dofus.Constants.CLIPS_PERSOS_PATH + nClassID + nSex + ".swf", undefined, 5);
        this._ldrClassIcon.contentPath = dofus.Constants.BREEDS_SYMBOL_PATH + nClassID + ".swf";
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < dofus.Constants.GUILD_ORDER.length)
        {
            if (this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[_loc4] == 12)
            {
                continue;
            } // end if
            if (dofus.Constants.GUILD_ORDER[_loc4] == nClassID)
            {
                this._csBreedSelection.currentIndex = _loc4;
            } // end if
        } // end while
        if (this._nSex != nSex)
        {
            var _loc5 = new Array();
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < dofus.Constants.GUILD_ORDER.length)
            {
                if (this.api.config.isStreaming && dofus.Constants.GUILD_ORDER[_loc6] == 12)
                {
                    continue;
                } // end if
                _loc5[_loc6] = dofus.Constants.BREEDS_SLIDER_PATH + dofus.Constants.GUILD_ORDER[_loc6] + nSex + ".swf";
            } // end while
            this._csBreedSelection.clipsList = _loc5;
            this._csBreedSelection.updateColor(1, this._oColors.color1);
            this._csBreedSelection.updateColor(2, this._oColors.color2);
            this._csBreedSelection.updateColor(3, this._oColors.color3);
        } // end if
        var _loc7 = this.api.lang.getClassText(nClassID);
        this._lblClassName.text = _loc7.ln;
        this._txtClassDescription.text = "<font color=\'#514A3C\'>" + _loc7.d + "</font>";
        this._txtShortClassDescription.text = "<font color=\'#514A3C\' size=\'14\'><b>" + _loc7.sd + "</b></font>";
        this._svCharacter.setColors(this._oColors);
        if (dofus.Constants.EPISODIC_GUILD[nClassID - 1] > this.api.datacenter.Basics.aks_current_regional_version)
        {
            this._btnValidate.label = this.api.lang.getText("COMING_SOON_SHORT");
        }
        else
        {
            this._btnValidate.label = this.api.lang.getText("VALIDATE");
        } // end else if
        this._nBreed = nClassID;
        this._nSex = nSex;
    };
    _loc1.showColorPosition = function (nIndex)
    {
        var bWhite = true;
        this._nSavedColor = this._svCharacter.getColor(nIndex);
        this.onEnterFrame = function ()
        {
            this._svCharacter.setColor(nIndex, bWhite = !bWhite ? (16733525) : (16746632));
        };
    };
    _loc1.hideColorPosition = function (nIndex)
    {
        delete this.onEnterFrame;
        this._svCharacter.setColor(nIndex, this._nSavedColor);
    };
    _loc1.validateCreation = function ()
    {
        var _loc2 = this._itCharacterName.text;
        if (_loc2.length == 0 || _loc2 == undefined)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("NEED_CHARACTER_NAME"), "ERROR_BOX", {name: "CREATENONAME"});
            return;
        } // end if
        if (_loc2.length > 20)
        {
            this.api.kernel.showMessage(undefined, this.api.lang.getText("LONG_CHARACTER_NAME", [_loc2, 20]), "ERROR_BOX");
            return;
        } // end if
        if (this.api.lang.getConfigText("CHAR_NAME_FILTER") && !this.api.datacenter.Player.isAuthorized)
        {
            var _loc3 = new dofus.utils.nameChecker.NameChecker(_loc2);
            var _loc4 = new dofus.utils.nameChecker.rules.NameCheckerCharacterNameRules();
            var _loc5 = _loc3.isValidAgainstWithDetails(_loc4);
            if (!_loc5.IS_SUCCESS)
            {
                this.api.kernel.showMessage(undefined, this.api.lang.getText("INVALID_CHARACTER_NAME") + "\r\n" + _loc5.toString("\r\n"), "ERROR_BOX");
                return;
            } // end if
        } // end if
        if (dofus.Constants.EPISODIC_GUILD[this._nBreed - 1] > this.api.datacenter.Basics.aks_current_regional_version)
        {
            var _loc6 = this.api.lang.getClassText(this._nBreed).sn;
            this.api.kernel.showMessage(undefined, this.api.lang.getText("COMING_SOON_GUILD", [_loc6]), "ERROR_BOX");
            return;
        } // end if
        if (dofus.Constants.PAYING_GUILD[this._nBreed - 1] && this._nRemainingTime <= 0)
        {
            var _loc7 = this.api.lang.getClassText(this._nBreed).sn;
            this.api.kernel.showMessage(undefined, this.api.lang.getText("PAYING_GUILD", [_loc7]), "ERROR_BOX");
            return;
        } // end if
        this.api.datacenter.Basics.hasCreatedCharacter = true;
        if (dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
        {
            this.getURL("JavaScript:WriteLog(\'addCharacter;" + _loc2 + "\')");
        } // end if
        this.api.network.Account.addCharacter(_loc2, this._nBreed, this._oColors.color1, this._oColors.color2, this._oColors.color3, this._nSex);
    };
    _loc1.setColors = function (oColors)
    {
        this._oColors = oColors;
        this._svCharacter.setColors(this._oColors);
        this._csBreedSelection.updateColor(1, oColors.color1);
        this._csBreedSelection.updateColor(2, oColors.color2);
        this._csBreedSelection.updateColor(3, oColors.color3);
    };
    _loc1.hideGenerateRandomName = function ()
    {
        this._mcRandomName._visible = false;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._mcRight:
            {
                this._csBreedSelection.slide(1);
                break;
            } 
            case this._mcLeft:
            {
                this._csBreedSelection.slide(-1);
                break;
            } 
            case this._mcMaleButton:
            {
                this.setClass(this._nBreed, 0);
                break;
            } 
            case this._mcFemaleButton:
            {
                this.setClass(this._nBreed, 1);
                break;
            } 
            case this._mcSpellButton2:
            case this._mcSpellButton:
            {
                this.api.ui.loadUIComponent("SpellViewerOnCreate", "SpellViewerOnCreate", {breed: this._nBreed});
                break;
            } 
            case this._mcHistoryButton:
            {
                this.api.ui.loadUIComponent("HistoryViewerOnCreate", "HistoryViewerOnCreate", {breed: this._nBreed});
                break;
            } 
            case this._btnValidate:
            {
                this.validateCreation();
                break;
            } 
            case this._btnBack:
            {
                if (this.api.datacenter.Basics.createCharacter)
                {
                    this.api.kernel.changeServer(true);
                }
                else
                {
                    this.api.datacenter.Basics.ignoreCreateCharacter = true;
                    this.api.network.Account.getCharactersForced();
                } // end else if
                break;
            } 
            case this._mcRandomName:
            {
                if (this._nLastRegenerateTimer + dofus.graphics.gapi.ui.CreateCharacter.NAME_GENERATION_DELAY < getTimer())
                {
                    this.api.network.Account.getRandomCharacterName();
                    this._nLastRegenerateTimer = getTimer();
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._csColors:
            {
                this.showColorPosition(oEvent.index);
                break;
            } 
            case this._mcRandomName:
            {
                this.gapi.showTooltip(this.api.lang.getText("RANDOM_NICKNAME"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcMaleButton:
            {
                this.gapi.showTooltip(this.api.lang.getText("ANIMAL_MEN"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcFemaleButton:
            {
                this.gapi.showTooltip(this.api.lang.getText("ANIMAL_WOMEN"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcSpellButton:
            {
                this.gapi.showTooltip(this.api.lang.getText("CLASS_SPELLS"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcRight:
            {
                this.gapi.showTooltip(this.api.lang.getText("NEXT_WORD"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcLeft:
            {
                this.gapi.showTooltip(this.api.lang.getText("PREVIOUS_WORD"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._csColors:
            {
                this.hideColorPosition(oEvent.index);
                break;
            } 
            default:
            {
                this.gapi.hideTooltip();
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._csColors:
            {
                this.setColors(oEvent.value);
                break;
            } 
            case this._csBreedSelection:
            {
                if (this._bLoaded)
                {
                    this.setClass(dofus.Constants.GUILD_ORDER[oEvent.value], this._nSex);
                } // end if
                break;
            } 
            case this._itCharacterName:
            {
                var _loc3 = this._itCharacterName.text;
                if (!this.api.datacenter.Player.isAuthorized)
                {
                    _loc3 = _loc3.substr(0, 1).toUpperCase() + _loc3.substr(1);
                    var _loc4 = _loc3.substr(0, 1);
                    var _loc5 = 1;
                    
                    while (++_loc5, _loc5 < _loc3.length)
                    {
                        if (_loc3.substr(_loc5 - 1, 1) != "-")
                        {
                            _loc4 = _loc4 + _loc3.substr(_loc5, 1).toLowerCase();
                            continue;
                        } // end if
                        _loc4 = _loc4 + _loc3.substr(_loc5, 1);
                    } // end while
                    this._itCharacterName.removeEventListener("change", this);
                    this._itCharacterName.text = _loc4;
                    this._itCharacterName.addEventListener("change", this);
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("characterName", function ()
    {
    }, _loc1.__set__characterName);
    _loc1.addProperty("remainingTime", function ()
    {
    }, _loc1.__set__remainingTime);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.CreateCharacter = function ()
    {
        super();
    }).CLASS_NAME = "CreateCharacter";
    (_global.dofus.graphics.gapi.ui.CreateCharacter = function ()
    {
        super();
    }).NAME_GENERATION_DELAY = 500;
    _loc1._nLastRegenerateTimer = 0;
    _loc1._bLoaded = false;
} // end if
#endinitclip
