// Action script...

// [Initial MovieClip Action of sprite 838]
#initclip 50
class dofus.managers.EffectsManager extends dofus.utils.ApiElement
{
    var _oSprite, _aEffects;
    function EffectsManager(oSprite, oAPI)
    {
        super();
        this.initialize(oSprite, oAPI);
    } // End of the function
    function initialize(oSprite, oAPI)
    {
        super.initialize(oAPI);
        _oSprite = oSprite;
        _aEffects = new Array();
    } // End of the function
    function getEffects()
    {
        return (_aEffects);
    } // End of the function
    function addEffect(oEffect)
    {
        _aEffects.push(oEffect);
    } // End of the function
    function terminateAllEffects()
    {
        var _loc2 = _aEffects.length;
        var _loc3;
        while (--_loc2 >= 0)
        {
            _loc3 = _aEffects[_loc2];
            _aEffects.splice(_loc2, _loc2 + 1);
        } // end while
    } // End of the function
    function nextTurn()
    {
        var _loc2 = _aEffects.length;
        var _loc3;
        while (--_loc2 >= 0)
        {
            _loc3 = _aEffects[_loc2];
            --_loc3.remainingTurn;
            if (_loc3.remainingTurn <= 0)
            {
                _aEffects.splice(_loc2, 1);
            } // end if
        } // end while
    } // End of the function
} // End of Class
#endinitclip
