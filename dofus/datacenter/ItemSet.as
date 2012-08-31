// Action script...

// [Initial MovieClip Action of sprite 826]
#initclip 38
class dofus.datacenter.ItemSet extends Object
{
    var _nID, api, _aItems, _aEffects, _sEffects, __get__description, __get__effects, __get__id, __get__itemCount, __get__items, __get__name;
    function ItemSet(nID, sEffects, aItemIDs)
    {
        super();
        this.initialize(nID, sEffects, aItemIDs);
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get name()
    {
        return (api.lang.getItemSetText(_nID).n);
    } // End of the function
    function get description()
    {
        return (api.lang.getItemSetText(_nID).d);
    } // End of the function
    function get itemCount()
    {
        return (_aItems.length);
    } // End of the function
    function get items()
    {
        return (_aItems);
    } // End of the function
    function get effects()
    {
        return (dofus.datacenter.Item.getItemDescriptionEffects(_aEffects));
    } // End of the function
    function initialize(nID, sEffects, aItemIDs)
    {
        if (sEffects == undefined)
        {
            sEffects = "";
        } // end if
        if (aItemIDs == undefined)
        {
            aItemIDs = [];
        } // end if
        api = _global.API;
        _nID = nID;
        this.setEffects(sEffects);
        this.setItems(aItemIDs);
    } // End of the function
    function setEffects(compressedData)
    {
        _sEffects = compressedData;
        _aEffects = new Array();
        var _loc4 = compressedData.split(",");
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            var _loc2 = _loc4[_loc3].split("#");
            _loc2[0] = parseInt(_loc2[0], 16);
            _loc2[1] = _loc2[1] == "0" ? (undefined) : (parseInt(_loc2[1], 16));
            _loc2[2] = _loc2[2] == "0" ? (undefined) : (parseInt(_loc2[2], 16));
            _loc2[3] = _loc2[3] == "0" ? (undefined) : (parseInt(_loc2[3], 16));
            _aEffects.push(_loc2);
        } // end of for
    } // End of the function
    function setItems(aItemIDs)
    {
        var _loc6 = api.lang.getItemSetText(_nID).i;
        _aItems = new Array();
        var _loc7 = new Object();
        for (var _loc11 in aItemIDs)
        {
            _loc7[aItemIDs[_loc11]] = true;
        } // end of for...in
        for (var _loc3 = 0; _loc3 < _loc6.length; ++_loc3)
        {
            var _loc2 = Number(_loc6[_loc3]);
            if (isNaN(_loc2))
            {
                continue;
            } // end if
            var _loc4 = new dofus.datacenter.Item(0, _loc2, 1);
            var _loc5 = _loc7[_loc2] == true;
            _aItems.push({isEquiped: _loc5, item: _loc4});
        } // end of for
    } // End of the function
} // End of Class
#endinitclip
