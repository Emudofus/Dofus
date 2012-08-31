// Action script...

// [Initial MovieClip Action of sprite 964]
#initclip 176
class dofus.datacenter.FightInfos extends Object
{
    var _nID, duration, api, _eaTeam1Players, _eaTeam2Players, _nTeam1AlignmentIndex, _nTeam1Type, _nTeam1Count, _nTeam2AlignmentIndex, _nTeam2Type, _nTeam2Count, __get__durationString, __get__hasTeamPlayers, __get__id, __get__team1Count, __get__team1IconFile, __get__team1Level, __get__team1Players, __get__team2Count, __get__team2IconFile, __get__team2Level, __get__team2Players;
    function FightInfos(nID, nDuration)
    {
        super();
        this.initialize(nID, nDuration);
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get durationString()
    {
        if (duration <= 0)
        {
            return ("-");
        }
        else
        {
            var _loc2 = new Date();
            _loc2.setTime(duration);
            var _loc3 = _loc2.getUTCHours();
            var _loc4 = _loc2.getUTCMinutes();
            return ((_loc3 != 0 ? (_loc3 + " " + api.lang.getText("HOURS_SMALL") + " ") : ("")) + _loc4 + " " + api.lang.getText("MINUTES_SMALL"));
        } // end else if
    } // End of the function
    function get hasTeamPlayers()
    {
        return (_eaTeam1Players != undefined && _eaTeam2Players != undefined);
    } // End of the function
    function get team1IconFile()
    {
        return (dofus.Constants.getTeamFileFromType(_nTeam1Type, _nTeam1AlignmentIndex));
    } // End of the function
    function get team1Count()
    {
        return (_nTeam1Count);
    } // End of the function
    function get team1Players()
    {
        return (_eaTeam1Players);
    } // End of the function
    function get team1Level()
    {
        var _loc2 = 0;
        for (var _loc3 in _eaTeam1Players)
        {
            _loc2 = _loc2 + _eaTeam1Players[_loc3].level;
        } // end of for...in
        return (_loc2);
    } // End of the function
    function get team2IconFile()
    {
        return (dofus.Constants.getTeamFileFromType(_nTeam2Type, _nTeam2AlignmentIndex));
    } // End of the function
    function get team2Count()
    {
        return (_nTeam2Count);
    } // End of the function
    function get team2Players()
    {
        return (_eaTeam2Players);
    } // End of the function
    function get team2Level()
    {
        var _loc2 = 0;
        for (var _loc3 in _eaTeam2Players)
        {
            _loc2 = _loc2 + _eaTeam2Players[_loc3].level;
        } // end of for...in
        return (_loc2);
    } // End of the function
    function initialize(nID, nDuration)
    {
        api = _global.API;
        _nID = nID;
        duration = nDuration;
    } // End of the function
    function addTeam(nIndex, nType, nAlignmentIndex, nCount)
    {
        switch (nIndex)
        {
            case 1:
            {
                _nTeam1Type = nType;
                _nTeam1AlignmentIndex = nAlignmentIndex;
                _nTeam1Count = nCount;
                break;
            } 
            case 2:
            {
                _nTeam2Type = nType;
                _nTeam2AlignmentIndex = nAlignmentIndex;
                _nTeam2Count = nCount;
                break;
            } 
        } // End of switch
    } // End of the function
    function addPlayers(nIndex, eaPlayers)
    {
        switch (nIndex)
        {
            case 1:
            {
                _eaTeam1Players = eaPlayers;
                break;
            } 
            case 2:
            {
                _eaTeam2Players = eaPlayers;
                break;
            } 
        } // End of switch
    } // End of the function
} // End of Class
#endinitclip
