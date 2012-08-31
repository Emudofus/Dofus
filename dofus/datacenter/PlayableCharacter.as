// Action script...

// [Initial MovieClip Action of sprite 835]
#initclip 47
class dofus.datacenter.PlayableCharacter extends ank.battlefield.datacenter.Sprite
{
    var __proto__, api, _gfxID, GameActionsManager, CharacteristicsManager, EffectsManager, _ap, _mp, id, mc, __set__LP, __get__AP, __set__AP, __get__APinit, __get__MP, __set__MP, __get__MPinit, __get__gfxID, _name, __get__name, _level, broadcastMessage, __get__Level, _xp, __get__XP, _lp, dispatchEvent, __get__LPmax, __get__LP, _lpmax, _apinit, _mpinit, _kama, __get__Kama, _team, __get__Team, _aAccessories, __set__APinit, __set__Kama, __set__LPmax, __set__Level, __set__MPinit, __set__Team, __get__ToolAnimation, __get__Weapon, __set__XP, __get__artworkFile, __set__gfxID, __set__name;
    function PlayableCharacter(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        if (__proto__ == dofus.datacenter.PlayableCharacter.prototype)
        {
            this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
        } // end if
    } // End of the function
    function initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super.initialize(sID, clipClass, sGfxFile, cellNum, dir);
        api = _global.API;
        _gfxID = gfxID;
        GameActionsManager = new dofus.managers.GameActionsManager(this, api);
        CharacteristicsManager = new dofus.managers.CharacteristicsManager(this, api);
        EffectsManager = new dofus.managers.EffectsManager(this, api);
        if (sID == api.datacenter.Player.ID)
        {
            _ap = api.datacenter.Player.AP;
            _mp = api.datacenter.Player.MP;
        } // end if
        AsBroadcaster.initialize(this);
        mx.events.EventDispatcher.initialize(this);
    } // End of the function
    function updateLP(dLP)
    {
        LP = LP + Number(dLP);
        api.gfx.addSpritePoints(id, String(dLP), 16711680);
        if (dLP < 0)
        {
            mc.setAnim("Hit");
        } // end if
    } // End of the function
    function initLP(Void)
    {
        this.__set__LP(LPmax);
    } // End of the function
    function updateAP(dAP, bUsed)
    {
        if (bUsed == undefined)
        {
            bUsed = false;
        } // end if
        if (api.datacenter.Game.currentPlayerID != id && bUsed)
        {
            return;
        } // end if
        AP = AP + Number(dAP);
        this.__set__AP(Math.max(0, this.__get__AP()));
        api.gfx.addSpritePoints(id, String(dAP), 255);
    } // End of the function
    function initAP(bWithModerator)
    {
        if (bWithModerator == undefined)
        {
            bWithModerator = true;
        } // end if
        if (bWithModerator)
        {
            var _loc3 = CharacteristicsManager.getModeratorValue("1");
            this.__set__AP(Number(this.__get__APinit()) + Number(_loc3));
        }
        else
        {
            this.__set__AP(Number(this.__get__APinit()));
        } // end else if
    } // End of the function
    function updateMP(dMP, bUsed)
    {
        if (bUsed == undefined)
        {
            bUsed = false;
        } // end if
        if (api.datacenter.Game.currentPlayerID != id && bUsed)
        {
            return;
        } // end if
        MP = MP + Number(dMP);
        this.__set__MP(Math.max(0, this.__get__MP()));
        api.gfx.addSpritePoints(id, String(dMP), 26112);
    } // End of the function
    function initMP(bWithModerator)
    {
        if (bWithModerator == undefined)
        {
            bWithModerator = true;
        } // end if
        if (bWithModerator)
        {
            var _loc3 = CharacteristicsManager.getModeratorValue("23");
            this.__set__MP(Number(this.__get__MPinit()) + Number(_loc3));
        }
        else
        {
            this.__set__MP(Number(this.__get__MPinit()));
        } // end else if
    } // End of the function
    function get gfxID()
    {
        return (_gfxID);
    } // End of the function
    function set gfxID(value)
    {
        _gfxID = value;
        //return (this.gfxID());
        null;
    } // End of the function
    function get name()
    {
        return (_name);
    } // End of the function
    function set name(value)
    {
        _name = value;
        //return (this.name());
        null;
    } // End of the function
    function get Level()
    {
        return (_level);
    } // End of the function
    function set Level(value)
    {
        _level = Number(value);
        this.broadcastMessage("onSetLevel", value);
        //return (this.Level());
        null;
    } // End of the function
    function get XP()
    {
        return (_xp);
    } // End of the function
    function set XP(value)
    {
        _xp = Number(value);
        this.broadcastMessage("onSetXP", value);
        //return (this.XP());
        null;
    } // End of the function
    function get LP()
    {
        return (_lp);
    } // End of the function
    function set LP(value)
    {
        _lp = Number(value) > 0 ? (Number(value)) : (0);
        this.dispatchEvent({type: "lpChanged", value: value});
        this.broadcastMessage("onSetLP", value, this.__get__LPmax());
        //return (this.LP());
        null;
    } // End of the function
    function get LPmax()
    {
        return (_lpmax);
    } // End of the function
    function set LPmax(value)
    {
        _lpmax = Number(value);
        this.broadcastMessage("onSetLP", this.__get__LP(), value);
        //return (this.LPmax());
        null;
    } // End of the function
    function get AP()
    {
        return (_ap);
    } // End of the function
    function set AP(value)
    {
        _ap = Number(value);
        this.dispatchEvent({type: "apChanged", value: value});
        this.broadcastMessage("onSetAP", value);
        //return (this.AP());
        null;
    } // End of the function
    function get APinit()
    {
        return (_apinit);
    } // End of the function
    function set APinit(value)
    {
        _apinit = Number(value);
        //return (this.APinit());
        null;
    } // End of the function
    function get MP()
    {
        return (_mp);
    } // End of the function
    function set MP(value)
    {
        _mp = Number(value);
        this.dispatchEvent({type: "mpChanged", value: value});
        this.broadcastMessage("onSetMP", value);
        //return (this.MP());
        null;
    } // End of the function
    function get MPinit()
    {
        return (_mpinit);
    } // End of the function
    function set MPinit(value)
    {
        _mpinit = Number(value);
        //return (this.MPinit());
        null;
    } // End of the function
    function get Kama()
    {
        return (_kama);
    } // End of the function
    function set Kama(value)
    {
        _kama = Number(value);
        this.broadcastMessage("onSetKama", value);
        //return (this.Kama());
        null;
    } // End of the function
    function get Team()
    {
        return (_team);
    } // End of the function
    function set Team(value)
    {
        _team = Number(value);
        //return (this.Team());
        null;
    } // End of the function
    function get Weapon()
    {
        return (_aAccessories[0]);
    } // End of the function
    function get ToolAnimation()
    {
        var _loc3 = Weapon.unicID;
        var _loc2 = api.lang.getItemUnicText(_loc3);
        if (_loc2.an == undefined)
        {
            if (api.datacenter.Game.isFight)
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
            return ("anim" + _loc2.an);
        } // end else if
    } // End of the function
    function get artworkFile()
    {
        return (dofus.Constants.ARTWORKS_BIG_PATH + _gfxID + ".swf");
    } // End of the function
} // End of Class
#endinitclip
