// Action script...

// [Initial MovieClip Action of sprite 876]
#initclip 88
class dofus.datacenter.NonPlayableCharacter extends ank.battlefield.datacenter.Sprite
{
    var api, __proto__, _oNpcText, __get__unicID, _gfxID, __get__gfxID, id, __get__actions, __set__gfxID, __get__name, __set__unicID;
    function NonPlayableCharacter(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        api = _global.API;
        if (__proto__ == dofus.datacenter.NonPlayableCharacter.prototype)
        {
            this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
        } // end if
    } // End of the function
    function set unicID(value)
    {
        _oNpcText = api.lang.getNonPlayableCharactersText(value);
        //return (this.unicID());
        null;
    } // End of the function
    function get name()
    {
        return (_oNpcText.n);
    } // End of the function
    function get actions()
    {
        var _loc6 = new Array();
        var _loc3 = _oNpcText.a;
        var _loc2 = _loc3.length;
        while (_loc2-- > 0)
        {
            _loc6.push({name: api.lang.getNonPlayableCharactersActionText(_loc3[_loc2]), action: this.getActionFunction(_loc3[_loc2])});
        } // end while
        return (_loc6);
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
    function initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super.initialize(sID, clipClass, sGfxFile, cellNum, dir);
        _gfxID = gfxID;
    } // End of the function
    function getActionFunction(nActionID)
    {
        switch (nActionID)
        {
            case 1:
            {
                return ({object: api.kernel.GameManager, method: api.kernel.GameManager.startExchange, params: [0, id]});
                break;
            } 
            case 2:
            {
                return ({object: api.kernel.GameManager, method: api.kernel.GameManager.startExchange, params: [2, id]});
                break;
            } 
            case 3:
            {
                return ({object: api.kernel.GameManager, method: api.kernel.GameManager.startDialog, params: [id]});
                break;
            } 
            case 4:
            {
                return ({object: api.kernel.GameManager, method: api.kernel.GameManager.startExchange, params: [9, id]});
                break;
            } 
            default:
            {
                return (new Object());
            } 
        } // End of switch
    } // End of the function
} // End of Class
#endinitclip
