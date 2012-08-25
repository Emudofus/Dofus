// Action script...

// [Initial MovieClip Action of sprite 20740]
#initclip 5
if (!dofus.datacenter.LaunchedSpell)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.LaunchedSpell = function (nSpellID, sSpriteOnID)
    {
        this.initialize(nSpellID, sSpriteOnID);
    }).prototype;
    _loc1.__set__remainingTurn = function (nRemainingTurn)
    {
        this._nRemainingTurn = Number(nRemainingTurn);
        //return (this.remainingTurn());
    };
    _loc1.__get__remainingTurn = function ()
    {
        return (this._nRemainingTurn);
    };
    _loc1.__get__spriteOnID = function ()
    {
        return (this._sSpriteOnID);
    };
    _loc1.__get__spell = function ()
    {
        return (this._oSpell);
    };
    _loc1.initialize = function (nSpellID, sSpriteOnID)
    {
        this._oSpell = _global.API.datacenter.Player.Spells.findFirstItem("ID", nSpellID).item;
        this._sSpriteOnID = sSpriteOnID;
        var _loc4 = this._oSpell.delayBetweenLaunch;
        if (_loc4 == undefined)
        {
            _loc4 = 0;
        } // end if
        if (_loc4 >= 63)
        {
            this._nRemainingTurn = Number.MAX_VALUE;
        }
        else
        {
            this._nRemainingTurn = _loc4;
        } // end else if
    };
    _loc1.addProperty("spriteOnID", _loc1.__get__spriteOnID, function ()
    {
    });
    _loc1.addProperty("remainingTurn", _loc1.__get__remainingTurn, _loc1.__set__remainingTurn);
    _loc1.addProperty("spell", _loc1.__get__spell, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
