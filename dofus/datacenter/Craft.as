// Action script...

// [Initial MovieClip Action of sprite 917]
#initclip 129
class dofus.datacenter.Craft extends Object
{
    var _oSkill, _oCraftItem, _aItems, api, name, __get__craftItem, __get__items, __get__itemsCount, __get__skill;
    function Craft(nID, oSkill)
    {
        super();
        this.initialize(nID, oSkill);
    } // End of the function
    function get skill()
    {
        return (_oSkill);
    } // End of the function
    function get craftItem()
    {
        return (_oCraftItem);
    } // End of the function
    function get items()
    {
        return (_aItems);
    } // End of the function
    function get itemsCount()
    {
        return (_aItems.length);
    } // End of the function
    function initialize(nID, oSkill)
    {
        api = _global.API;
        _oSkill = oSkill;
        _oCraftItem = new dofus.datacenter.Item(0, nID, 1);
        name = _oCraftItem.name;
        var _loc4 = api.lang.getCraftText(nID);
        _aItems = new Array();
        if (!isNaN(_loc4.length))
        {
            for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
            {
                var _loc5 = new dofus.datacenter.Item(0, _loc4[_loc3][0], _loc4[_loc3][1]);
                _aItems.push(_loc5);
            } // end of for
        } // end if
    } // End of the function
} // End of Class
#endinitclip
