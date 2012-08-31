// Action script...

// [Initial MovieClip Action of sprite 940]
#initclip 152
class dofus.datacenter.Team extends ank.battlefield.datacenter.Sprite
{
    var __set__color1, _nType, _oAlignment, _aPlayers, _oChallenge, id, __get__alignment, __get__challenge, __get__count, __get__enemyTeam, __get__name, __get__type;
    function Team(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super();
        this.initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment);
    } // End of the function
    function initialize(sID, fClipClass, sGfxFile, nCellNum, nColor1, nType, nAlignment)
    {
        super.initialize(sID, fClipClass, sGfxFile, nCellNum);
        this.__set__color1(nColor1);
        _nType = Number(nType);
        _oAlignment = new dofus.datacenter.Alignment(Number(nAlignment));
        _aPlayers = new Object();
    } // End of the function
    function setChallenge(oChallenge)
    {
        _oChallenge = oChallenge;
    } // End of the function
    function addPlayer(oPlayer)
    {
        _aPlayers[oPlayer.id] = oPlayer;
    } // End of the function
    function removePlayer(nID)
    {
        delete _aPlayers[nID];
    } // End of the function
    function get type()
    {
        return (_nType);
    } // End of the function
    function get alignment()
    {
        return (_oAlignment);
    } // End of the function
    function get name()
    {
        var _loc2 = new String();
        for (var _loc3 in _aPlayers)
        {
            _loc2 = _loc2 + ("\n" + _aPlayers[_loc3].name + "(" + _aPlayers[_loc3].level + ")");
        } // end of for...in
        return (_loc2.substr(1));
    } // End of the function
    function get count()
    {
        var _loc2 = 0;
        for (var _loc3 in _aPlayers)
        {
            ++_loc2;
        } // end of for...in
        return (_loc2);
    } // End of the function
    function get challenge()
    {
        return (_oChallenge);
    } // End of the function
    function get enemyTeam()
    {
        var _loc2 = _oChallenge.__get__teams();
        var _loc3;
        for (var _loc4 in _loc2)
        {
            if (_loc4 != id)
            {
                _loc3 = _loc4;
                break;
            } // end if
        } // end of for...in
        return (_loc2[_loc3]);
    } // End of the function
} // End of Class
#endinitclip
