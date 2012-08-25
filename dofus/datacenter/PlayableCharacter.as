// Action script...

// [Initial MovieClip Action of sprite 20490]
#initclip 11
if (!dofus.datacenter.PlayableCharacter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.PlayableCharacter = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        if (this.__proto__ == dofus.datacenter.PlayableCharacter.prototype)
        {
            this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
        } // end if
    }).prototype;
    _loc1.initialize = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super.initialize(sID, clipClass, sGfxFile, cellNum, dir);
        this.api = _global.API;
        this._gfxID = gfxID;
        this.GameActionsManager = new dofus.managers.GameActionsManager(this, this.api);
        this.CharacteristicsManager = new dofus.managers.CharacteristicsManager(this, this.api);
        this.EffectsManager = new dofus.managers.EffectsManager(this, this.api);
        if (sID == this.api.datacenter.Player.ID)
        {
            this._ap = this.api.datacenter.Player.AP;
            this._mp = this.api.datacenter.Player.MP;
        } // end if
        AsBroadcaster.initialize(this);
        mx.events.EventDispatcher.initialize(this);
        this._states = new Object();
    };
    _loc1.updateLP = function (dLP)
    {
        this.LP = this.LP + Number(dLP);
        if (dLP < 0 && this.api.datacenter.Game.isFight)
        {
            this.LPmax = this.LPmax - Math.floor(-dLP * this.api.lang.getConfigText("PERMANENT_DAMAGE"));
            if (this.api.datacenter.Player.ID == this.id)
            {
                this.api.datacenter.Player.LPmax = this.LPmax;
                this.api.ui.getUIComponent("Banner").lpmaxChanged({value: this.LPmax});
                this.api.ui.getUIComponent("StatJob").lpMaxChanged({value: this.LPmax});
            } // end if
            this.api.ui.getUIComponent("Timeline").timelineControl.updateCharacters();
        } // end if
        this.api.gfx.addSpritePoints(this.id, String(dLP), 16711680);
        if (dLP < 0)
        {
            this.mc.setAnim("Hit");
        } // end if
    };
    _loc1.initLP = function (Void)
    {
        this.LP = this.LPmax;
    };
    _loc1.updateAP = function (dAP, bUsed)
    {
        if (bUsed == undefined)
        {
            bUsed = false;
        } // end if
        if (this.api.datacenter.Game.currentPlayerID != this.id && bUsed)
        {
            return;
        } // end if
        this.AP = this.AP + Number(dAP);
        this.AP = Math.max(0, this.AP);
        this.api.gfx.addSpritePoints(this.id, String(dAP), 255);
    };
    _loc1.initAP = function (bWithModerator)
    {
        if (bWithModerator == undefined)
        {
            bWithModerator = true;
        } // end if
        if (bWithModerator)
        {
            var _loc3 = this.CharacteristicsManager.getModeratorValue("1");
            this.AP = Number(this.APinit) + Number(_loc3);
        }
        else
        {
            this.AP = Number(this.APinit);
        } // end else if
    };
    _loc1.updateMP = function (dMP, bUsed)
    {
        if (bUsed == undefined)
        {
            bUsed = false;
        } // end if
        if (this.api.datacenter.Game.currentPlayerID != this.id && bUsed)
        {
            return;
        } // end if
        this.MP = this.MP + Number(dMP);
        this.MP = Math.max(0, this.MP);
        this.api.gfx.addSpritePoints(this.id, String(dMP), 26112);
    };
    _loc1.initMP = function (bWithModerator)
    {
        if (bWithModerator == undefined)
        {
            bWithModerator = true;
        } // end if
        if (bWithModerator)
        {
            var _loc3 = this.CharacteristicsManager.getModeratorValue("23");
            this.MP = Number(this.MPinit) + Number(_loc3);
        }
        else
        {
            this.MP = Number(this.MPinit);
        } // end else if
    };
    _loc1.isInState = function (stateID)
    {
        return (this._states[stateID] == true);
    };
    _loc1.setState = function (stateID, bActivate)
    {
        this._states[stateID] = bActivate;
    };
    _loc1.__get__gfxID = function ()
    {
        return (this._gfxID);
    };
    _loc1.__set__gfxID = function (value)
    {
        this._gfxID = value;
        //return (this.gfxID());
    };
    _loc1.__get__name = function ()
    {
        return (this._name);
    };
    _loc1.__set__name = function (value)
    {
        this._name = value;
        //return (this.name());
    };
    _loc1.__get__Level = function ()
    {
        return (this._level);
    };
    _loc1.__set__Level = function (value)
    {
        this._level = Number(value);
        this.broadcastMessage("onSetLevel", value);
        //return (this.Level());
    };
    _loc1.__get__XP = function ()
    {
        return (this._xp);
    };
    _loc1.__set__XP = function (value)
    {
        this._xp = Number(value);
        this.broadcastMessage("onSetXP", value);
        //return (this.XP());
    };
    _loc1.__get__LP = function ()
    {
        return (this._lp);
    };
    _loc1.__set__LP = function (value)
    {
        this._lp = Number(value) > 0 ? (Number(value)) : (0);
        this.dispatchEvent({type: "lpChanged", value: value});
        this.broadcastMessage("onSetLP", value, this.LPmax);
        //return (this.LP());
    };
    _loc1.__get__LPmax = function ()
    {
        return (this._lpmax);
    };
    _loc1.__set__LPmax = function (value)
    {
        this._lpmax = Number(value);
        this.broadcastMessage("onSetLP", this.LP, value);
        //return (this.LPmax());
    };
    _loc1.__get__AP = function ()
    {
        return (this._ap);
    };
    _loc1.__set__AP = function (value)
    {
        this._ap = Number(value);
        this.dispatchEvent({type: "apChanged", value: value});
        this.broadcastMessage("onSetAP", value);
        //return (this.AP());
    };
    _loc1.__get__APinit = function ()
    {
        return (this._apinit);
    };
    _loc1.__set__APinit = function (value)
    {
        this._apinit = Number(value);
        //return (this.APinit());
    };
    _loc1.__get__MP = function ()
    {
        return (this._mp);
    };
    _loc1.__set__MP = function (value)
    {
        this._mp = Number(value);
        this.dispatchEvent({type: "mpChanged", value: value});
        this.broadcastMessage("onSetMP", value);
        //return (this.MP());
    };
    _loc1.__get__MPinit = function ()
    {
        return (this._mpinit);
    };
    _loc1.__set__MPinit = function (value)
    {
        this._mpinit = Number(value);
        //return (this.MPinit());
    };
    _loc1.__get__Kama = function ()
    {
        return (this._kama);
    };
    _loc1.__set__Kama = function (value)
    {
        this._kama = Number(value);
        this.broadcastMessage("onSetKama", value);
        //return (this.Kama());
    };
    _loc1.__get__Team = function ()
    {
        return (this._team);
    };
    _loc1.__set__Team = function (value)
    {
        this._team = Number(value);
        //return (this.Team());
    };
    _loc1.__get__Weapon = function ()
    {
        return (this._aAccessories[0]);
    };
    _loc1.__get__ToolAnimation = function ()
    {
        var _loc2 = this.Weapon.unicID;
        var _loc3 = this.api.lang.getItemUnicText(_loc2);
        if (_loc3.an == undefined)
        {
            if (this.api.datacenter.Game.isFight)
            {
                return ("anim0");
            }
            else
            {
                return ("anim3");
            } // end else if
        }
        else
        {
            return ("anim" + _loc3.an);
        } // end else if
    };
    _loc1.__get__artworkFile = function ()
    {
        return (dofus.Constants.ARTWORKS_BIG_PATH + this._gfxID + ".swf");
    };
    _loc1.__get__states = function ()
    {
        return (this._states);
    };
    _loc1.__set__isSummoned = function (bIsSummoned)
    {
        this._summoned = bIsSummoned;
        //return (this.isSummoned());
    };
    _loc1.__get__isSummoned = function (bIsSummoned)
    {
        return (this._summoned);
    };
    _loc1.addProperty("MPinit", _loc1.__get__MPinit, _loc1.__set__MPinit);
    _loc1.addProperty("MP", _loc1.__get__MP, _loc1.__set__MP);
    _loc1.addProperty("Kama", _loc1.__get__Kama, _loc1.__set__Kama);
    _loc1.addProperty("LPmax", _loc1.__get__LPmax, _loc1.__set__LPmax);
    _loc1.addProperty("Weapon", _loc1.__get__Weapon, function ()
    {
    });
    _loc1.addProperty("Level", _loc1.__get__Level, _loc1.__set__Level);
    _loc1.addProperty("artworkFile", _loc1.__get__artworkFile, function ()
    {
    });
    _loc1.addProperty("Team", _loc1.__get__Team, _loc1.__set__Team);
    _loc1.addProperty("gfxID", _loc1.__get__gfxID, _loc1.__set__gfxID);
    _loc1.addProperty("isSummoned", _loc1.__get__isSummoned, _loc1.__set__isSummoned);
    _loc1.addProperty("states", _loc1.__get__states, function ()
    {
    });
    _loc1.addProperty("LP", _loc1.__get__LP, _loc1.__set__LP);
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("AP", _loc1.__get__AP, _loc1.__set__AP);
    _loc1.addProperty("APinit", _loc1.__get__APinit, _loc1.__set__APinit);
    _loc1.addProperty("ToolAnimation", _loc1.__get__ToolAnimation, function ()
    {
    });
    _loc1.addProperty("XP", _loc1.__get__XP, _loc1.__set__XP);
    ASSetPropFlags(_loc1, null, 1);
    _loc1._summoned = false;
} // end if
#endinitclip
