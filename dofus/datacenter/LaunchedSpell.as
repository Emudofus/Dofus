// Action script...

// [Initial MovieClip Action of sprite 942]
#initclip 154
class dofus.datacenter.LaunchedSpell
{
    var _nRemainingTurn, __get__remainingTurn, _sSpriteOnID, _oSpell, __set__remainingTurn, __get__spell, __get__spriteOnID;
    function LaunchedSpell(nSpellID, sSpriteOnID)
    {
        this.initialize(nSpellID, sSpriteOnID);
    } // End of the function
    function set remainingTurn(nRemainingTurn)
    {
        _nRemainingTurn = Number(nRemainingTurn);
        //return (this.remainingTurn());
        null;
    } // End of the function
    function get remainingTurn()
    {
        return (_nRemainingTurn);
    } // End of the function
    function get spriteOnID()
    {
        return (_sSpriteOnID);
    } // End of the function
    function get spell()
    {
        return (_oSpell);
    } // End of the function
    function initialize(nSpellID, sSpriteOnID)
    {
        _oSpell = _global.API.datacenter.Player.Spells.findFirstItem("ID", nSpellID).item;
        _sSpriteOnID = sSpriteOnID;
        var _loc3 = _oSpell.delayBetweenLaunch;
        if (_loc3 == undefined)
        {
            _loc3 = 0;
        } // end if
        if (_loc3 >= 63)
        {
            _nRemainingTurn = Number.MAX_VALUE;
        }
        else
        {
            _nRemainingTurn = _loc3;
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
