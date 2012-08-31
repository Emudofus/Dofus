// Action script...

// [Initial MovieClip Action of sprite 1003]
#initclip 220
class dofus.graphics.gapi.ui.HouseIndoor extends ank.gapi.core.UIAdvancedComponent
{
    var _oHouse, _mcForSale, _mcLock, __get__house, _aSkills, __get__skills, _mcHouse, _parent, __set__house, __set__skills;
    function HouseIndoor()
    {
        super();
    } // End of the function
    function set house(oHouse)
    {
        _oHouse = oHouse;
        oHouse.addEventListener("forsale", this);
        oHouse.addEventListener("locked", this);
        _mcForSale._visible = oHouse.isForSale;
        _mcLock._visible = oHouse.isLocked;
        //return (this.house());
        null;
    } // End of the function
    function set skills(aSkills)
    {
        _aSkills = aSkills;
        //return (this.skills());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.HouseIndoor.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _mcHouse.onRelease = click;
        if (_oHouse == undefined)
        {
            _mcForSale._visible = false;
            _mcLock._visible = false;
        } // end if
    } // End of the function
    function click()
    {
        var _loc7 = _parent.gapi.createPopupMenu();
        var _loc5 = _parent._oHouse;
        var _loc6 = _parent.api;
        _loc7.addStaticItem(_loc5.name);
        for (var _loc8 in _parent._aSkills)
        {
            var _loc3 = _parent._aSkills[_loc8];
            var _loc4 = _loc3.getState(true, _loc5.localOwner, _loc5.isForSale, _loc5.isLocked, true);
            if (_loc4 != "X")
            {
                _loc7.addItem(_loc3.description, _loc6.kernel.GameManager, _loc6.kernel.GameManager.useSkill, [_loc3.id], _loc4 == "V");
            } // end if
        } // end of for...in
        _loc7.show(_root._xmouse, _root._ymouse);
    } // End of the function
    function forsale(oEvent)
    {
        _mcForSale._visible = oEvent.value;
    } // End of the function
    function locked(oEvent)
    {
        _mcLock._visible = oEvent.value;
    } // End of the function
    static var CLASS_NAME = "HouseIndoor";
} // End of Class
#endinitclip
