// Action script...

// [Initial MovieClip Action of sprite 875]
#initclip 87
class dofus.datacenter.MonsterGroup extends ank.battlefield.datacenter.Sprite
{
    var api, initialize, _aNamesList, __get__name, _aLevelsList, __get__Level, __set__Level, __get__alignment, __set__name;
    function MonsterGroup(sID, clipClass, sGfxFile, cellNum, dir)
    {
        super();
        api = _global.API;
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, null);
    } // End of the function
    function set name(value)
    {
        _aNamesList = new Array();
        var _loc4 = value.split(",");
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc2 = api.lang.getMonstersText(_loc4[_loc3]);
            _aNamesList.push(_loc2.n);
            if (_loc2.a != -1)
            {
                _nAlignmentIndex = _loc2.a;
            } // end if
        } // end of for
        //return (this.name());
        null;
    } // End of the function
    function get name()
    {
        var _loc3 = new String();
        for (var _loc2 = 0; _loc2 < _aNamesList.length; ++_loc2)
        {
            _loc3 = _loc3 + (_aNamesList[_loc2] + " (" + _aLevelsList[_loc2] + ")\n");
        } // end of for
        return (_loc3);
    } // End of the function
    function set Level(value)
    {
        _aLevelsList = value.split(",");
        //return (this.Level());
        null;
    } // End of the function
    function get alignment()
    {
        return (new dofus.datacenter.Alignment(_nAlignmentIndex, 0));
    } // End of the function
    var _sDefaultAnimation = "static";
    var _bAllDirections = false;
    var _bForceWalk = true;
    var _nAlignmentIndex = -1;
} // End of Class
#endinitclip
