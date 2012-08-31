// Action script...

// [Initial MovieClip Action of sprite 916]
#initclip 128
class dofus.datacenter.Job extends Object
{
    var _nID, _oJobText, _eaSkills, _eaCrafts, _nLevel, __get__level, _nXPmin, __get__xpMin, _nXP, __get__xp, _nXPmax, __get__xpMax, api, __get__crafts, __get__description, __get__iconFile, __get__id, __set__level, __get__name, __get__skills, __set__xp, __set__xpMax, __set__xpMin;
    function Job(nID, eaSkills)
    {
        super();
        this.initialize(nID, eaSkills);
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get name()
    {
        return (_oJobText.n);
    } // End of the function
    function get description()
    {
        return (_oJobText.d);
    } // End of the function
    function get iconFile()
    {
        return (dofus.Constants.JOBS_ICONS_PATH + _oJobText.g + ".swf");
    } // End of the function
    function get skills()
    {
        return (_eaSkills);
    } // End of the function
    function get crafts()
    {
        return (_eaCrafts);
    } // End of the function
    function set level(nLevel)
    {
        _nLevel = nLevel;
        //return (this.level());
        null;
    } // End of the function
    function get level()
    {
        return (_nLevel);
    } // End of the function
    function set xpMin(nXPmin)
    {
        _nXPmin = nXPmin;
        //return (this.xpMin());
        null;
    } // End of the function
    function get xpMin()
    {
        return (_nXPmin);
    } // End of the function
    function set xp(nXP)
    {
        _nXP = nXP;
        //return (this.xp());
        null;
    } // End of the function
    function get xp()
    {
        return (_nXP);
    } // End of the function
    function set xpMax(nXPmax)
    {
        _nXPmax = nXPmax;
        //return (this.xpMax());
        null;
    } // End of the function
    function get xpMax()
    {
        return (_nXPmax > 1.000000E+017 ? (_nXP) : (_nXPmax));
    } // End of the function
    function initialize(nID, eaSkills)
    {
        api = _global.API;
        _nID = nID;
        _eaSkills = eaSkills;
        if (!isNaN(eaSkills.length))
        {
            _eaCrafts = new ank.utils.ExtendedArray();
            for (var _loc8 = 0; _loc8 < eaSkills.length; ++_loc8)
            {
                var _loc5 = eaSkills[_loc8];
                var _loc6 = _loc5.craftsList;
                if (_loc6 != undefined)
                {
                    for (var _loc3 = 0; _loc3 < _loc6.length; ++_loc3)
                    {
                        var _loc7 = _loc6[_loc3];
                        var _loc4 = new dofus.datacenter.Craft(_loc7, _loc5);
                        if (_loc4.itemsCount <= _loc5.param1)
                        {
                            _eaCrafts.push(_loc4);
                        } // end if
                    } // end of for
                } // end if
                _eaCrafts.sortOn("name");
            } // end of for
        } // end if
        _oJobText = api.lang.getJobText(nID);
    } // End of the function
} // End of Class
#endinitclip
