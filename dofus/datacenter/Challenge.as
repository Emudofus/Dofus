// Action script...

// [Initial MovieClip Action of sprite 939]
#initclip 151
class dofus.datacenter.Challenge extends Object
{
    var _nID, _nFightType, _teams, __get__count, __get__fightType, __get__id, __get__teams;
    function Challenge(nID, nFightType)
    {
        super();
        this.initialize(nID, nFightType);
    } // End of the function
    function initialize(nID, nFightType)
    {
        _nID = nID;
        _nFightType = nFightType;
        _teams = new Object();
    } // End of the function
    function addTeam(t)
    {
        _teams[t.id] = t;
        t.setChallenge(this);
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get fightType()
    {
        return (_nFightType);
    } // End of the function
    function get teams()
    {
        return (_teams);
    } // End of the function
    function get count()
    {
        var _loc2 = 0;
        for (var _loc3 in _teams)
        {
            _loc2 = _loc2 + _teams[_loc3].count;
        } // end of for...in
        return (_loc2);
    } // End of the function
} // End of Class
#endinitclip
