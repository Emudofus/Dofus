// Action script...

// [Initial MovieClip Action of sprite 20905]
#initclip 170
if (!dofus.graphics.gapi.controls.ClassCustomize)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.ClassCustomize = function ()
    {
        super();
    }).prototype;
    _loc1.__set__classID = function (nClassID)
    {
        this._nClassID = nClassID;
        this.addToQueue({object: this, method: this.layoutContent});
        //return (this.classID());
    };
    _loc1.__set__sex = function (nSex)
    {
        this._nSex = nSex;
        this.addToQueue({object: this, method: this.layoutContent});
        //return (this.sex());
    };
    _loc1.__set__colors = function (aColors)
    {
        this.addToQueue({object: this, method: this.applyColor, params: [aColors[0], 1]});
        this.addToQueue({object: this, method: this.applyColor, params: [aColors[1], 2]});
        this.addToQueue({object: this, method: this.applyColor, params: [aColors[2], 3]});
        this.addToQueue({object: this, method: this.updateSprite});
        //return (this.colors());
    };
    _loc1.__set__name = function (sName)
    {
        this.addToQueue({object: this, method: function ()
        {
            if (this._itCharacterName.text != undefined)
            {
                this._itCharacterName.text = sName;
                this._itCharacterName.setFocus();
                Selection.setSelection(sName.length, sName.length);
            } // end if
        }});
        //return (this.name());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ClassCustomize.CLASS_NAME);
        this._mcRegenerateNickName._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this._visible = false;
        this._oColors = {color1: -1, color2: -1, color3: -1};
        this._oBakColors = {color1: -1, color2: -1, color3: -1};
        this.addToQueue({object: this, method: function ()
        {
            this.setupRestriction();
        }});
        this.addToQueue({object: this, method: this.checkFeaturesAvailability});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.api.colors.addSprite(this._ldrSprite, this._oColors);
        this.addToQueue({object: this, method: this.setColorIndex, params: [1]});
        this.addToQueue({object: this, method: function ()
        {
            this._itCharacterName.setFocus();
        }});
        this.addToQueue({object: this, method: function ()
        {
            this._visible = true;
        }});
    };
    _loc1.setupRestriction = function ()
    {
        if (this.api.datacenter.Player.isAuthorized)
        {
            this._itCharacterName.restrict = "a-zA-Z\\-\\[\\]";
        }
        else
        {
            this._itCharacterName.restrict = "a-zA-Z\\-";
        } // end else if
    };
    _loc1.checkFeaturesAvailability = function ()
    {
        if (this.api.lang.getConfigText("GENERATE_RANDOM_NAME") && this.api.datacenter.Basics.aks_can_generate_names !== false)
        {
            this._mcRegenerateNickName._visible = true;
        } // end if
    };
    _loc1.addListeners = function ()
    {
        this._cpColorPicker.addEventListener("change", this);
        this._ldrSprite.addEventListener("initialization", this);
        this._btnNextAnim.addEventListener("click", this);
        this._btnPreviousAnim.addEventListener("click", this);
        this._btnReset1.addEventListener("click", this);
        this._btnReset2.addEventListener("click", this);
        this._btnReset3.addEventListener("click", this);
        this._btnColor1.addEventListener("click", this);
        this._btnColor2.addEventListener("click", this);
        this._btnColor3.addEventListener("click", this);
        this._btnColor1.addEventListener("over", this);
        this._btnColor2.addEventListener("over", this);
        this._btnColor3.addEventListener("over", this);
        this._btnColor1.addEventListener("out", this);
        this._btnColor2.addEventListener("out", this);
        this._btnColor3.addEventListener("out", this);
        this._itCharacterName.addEventListener("change", this);
        var ref = this;
        this._mcRegenerateNickName.onRelease = function ()
        {
            ref.click({target: this});
        };
        this._mcRegenerateNickName.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcRegenerateNickName.onRollOut = function ()
        {
            ref.out({target: this});
        };
    };
    _loc1.initTexts = function ()
    {
        this._lblCharacterColors.text = this.api.lang.getText("SPRITE_COLORS");
        this._lblCharacterName.text = this.api.lang.getText("CREATE_CHARACTER_NAME");
    };
    _loc1.layoutContent = function ()
    {
        if (this._nClassID == undefined || this._nSex == undefined)
        {
            return;
        } // end if
        this._ldrSprite.contentPath = dofus.Constants.CLIPS_PERSOS_PATH + this._nClassID + this._nSex + ".swf";
    };
    _loc1.applyColor = function (nColor, nIndex)
    {
        if (nIndex == undefined)
        {
            nIndex = this._nSelectedColorIndex;
        } // end if
        var _loc4 = {ColoredButton: {bgcolor: nColor == -1 ? (16711680) : (nColor), highlightcolor: nColor == -1 ? (16777215) : (nColor), bgdowncolor: nColor == -1 ? (16711680) : (nColor), highlightdowncolor: nColor == -1 ? (16777215) : (nColor)}};
        ank.gapi.styles.StylesManager.loadStylePackage(_loc4);
        this["_btnColor" + nIndex].styleName = "ColoredButton";
        this._oColors["color" + nIndex] = nColor;
        this._oBakColors["color" + nIndex] = nColor;
        this.updateSprite();
    };
    _loc1.setColorIndex = function (nIndex)
    {
        var _loc3 = this["_btnColor" + this._nSelectedColorIndex];
        var _loc4 = this["_btnColor" + nIndex];
        _loc3.selected = false;
        _loc4.selected = true;
        this._nSelectedColorIndex = nIndex;
    };
    _loc1.showColorPosition = function (nIndex)
    {
        var bWhite = true;
        this.onEnterFrame = function ()
        {
            this._oColors["color" + nIndex] = bWhite ? (16733525) : (16746632);
            this.updateSprite();
            bWhite = !bWhite;
        };
    };
    _loc1.hideColorPosition = function (nIndex)
    {
        delete this.onEnterFrame;
        this._oColors.color1 = this._oBakColors.color1;
        this._oColors.color2 = this._oBakColors.color2;
        this._oColors.color3 = this._oBakColors.color3;
        this.updateSprite();
    };
    _loc1.updateSprite = function ()
    {
        var _loc2 = this._ldrSprite.content;
        _loc2.mcAnim.removeMovieClip();
        _loc2.attachMovie(dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS[this._nSpriteAnimIndex], "mcAnim", 10);
        _loc2._xscale = _loc2._yscale = 200;
    };
    _loc1.hideGenerateRandomName = function ()
    {
        this._mcRegenerateNickName._visible = false;
    };
    _loc1.change = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_itCharacterName":
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
                this.dispatchEvent({type: "nameChange", value: this._itCharacterName.text});
                break;
            } 
            case "_cpColorPicker":
            {
                this.applyColor(oEvent.value);
                this.dispatchEvent({type: "colorsChange", value: this._oColors});
                break;
            } 
        } // End of switch
    };
    _loc1.initialization = function (oEvent)
    {
        this.updateSprite();
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnNextAnim":
            {
                ++this._nSpriteAnimIndex;
                if (this._nSpriteAnimIndex >= dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length)
                {
                    this._nSpriteAnimIndex = 0;
                } // end if
                this.updateSprite();
                break;
            } 
            case "_btnPreviousAnim":
            {
                --this._nSpriteAnimIndex;
                if (this._nSpriteAnimIndex < 0)
                {
                    this._nSpriteAnimIndex = dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length - 1;
                } // end if
                this.updateSprite();
                break;
            } 
            case "_btnColor1":
            case "_btnColor2":
            case "_btnColor3":
            {
                var _loc3 = Number(oEvent.target._name.substr(9));
                var _loc4 = this._oBakColors["color" + _loc3];
                if (_loc4 != -1)
                {
                    this._cpColorPicker.setColor(_loc4);
                } // end if
                this.setColorIndex(_loc3);
                break;
            } 
            case "_btnReset1":
            case "_btnReset2":
            case "_btnReset3":
            {
                var _loc5 = Number(oEvent.target._name.substr(9));
                this.applyColor(-1, _loc5);
                this.dispatchEvent({type: "colorsChange", value: this._oColors});
                break;
            } 
            case "_mcRegenerateNickName":
            {
                if (this._nLastRegenerateTimer + dofus.graphics.gapi.controls.ClassCustomize.NAME_GENERATION_DELAY < getTimer())
                {
                    this.api.network.Account.getRandomCharacterName();
                    this._nLastRegenerateTimer = dofus.graphics.gapi.controls.ClassCustomize.NAME_GENERATION_DELAY;
                    
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnColor1":
            case "_btnColor2":
            case "_btnColor3":
            {
                var _loc3 = Number(oEvent.target._name.substr(9));
                this.showColorPosition(_loc3);
                break;
            } 
            case "_mcRegenerateNickName":
            {
                var _loc4 = {x: this._mcRegenerateNickName._x, y: this._mcRegenerateNickName._y};
                this._mcRegenerateNickName.localToGlobal(_loc4);
                this.gapi.showTooltip(this.api.lang.getText("RANDOM_NICKNAME"), _loc4.x + this._x, _loc4.y + this._y - 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnColor1":
            case "_btnColor2":
            case "_btnColor3":
            {
                this.hideColorPosition();
                break;
            } 
            default:
            {
                this.gapi.hideTooltip();
            } 
        } // End of switch
    };
    _loc1.addProperty("colors", function ()
    {
    }, _loc1.__set__colors);
    _loc1.addProperty("name", function ()
    {
    }, _loc1.__set__name);
    _loc1.addProperty("sex", function ()
    {
    }, _loc1.__set__sex);
    _loc1.addProperty("classID", function ()
    {
    }, _loc1.__set__classID);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ClassCustomize = function ()
    {
        super();
    }).CLASS_NAME = "ClassCustomize";
    (_global.dofus.graphics.gapi.controls.ClassCustomize = function ()
    {
        super();
    }).SPRITE_ANIMS = ["StaticF", "StaticR", "StaticL", "WalkF", "RunF", "Anim2R", "Anim2L"];
    (_global.dofus.graphics.gapi.controls.ClassCustomize = function ()
    {
        super();
    }).NAME_GENERATION_DELAY = 500;
    _loc1._nSpriteAnimIndex = 0;
    _loc1._nLastRegenerateTimer = 0;
} // end if
#endinitclip
