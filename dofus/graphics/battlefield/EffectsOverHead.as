// Action script...

// [Initial MovieClip Action of sprite 967]
#initclip 179
class dofus.graphics.battlefield.EffectsOverHead extends MovieClip
{
    var createEmptyMovieClip, _aEffects, _mcEffects, _x, __get__height;
    function EffectsOverHead(aEffects)
    {
        super();
        this.initialize(aEffects);
        this.draw();
    } // End of the function
    function get height()
    {
        return (20);
    } // End of the function
    function initialize(aEffects)
    {
        this.createEmptyMovieClip("_mcEffects", 10);
        _aEffects = aEffects;
    } // End of the function
    function draw()
    {
        var _loc2 = _aEffects.length - 1;
        var _loc5;
        var _loc3;
        while (_loc2 >= 0)
        {
            _loc5 = _aEffects[_loc2];
            var _loc4 = new MovieClipLoader();
            _loc4.addListener(this);
            _mcEffects.createEmptyMovieClip("_mcEffect" + _loc2, _loc2);
            _loc3 = _mcEffects["_mcEffect" + _loc2];
            _loc3._x = _loc2 * dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH;
            _loc3.effect = _loc5;
            _loc4.loadClip(dofus.Constants.EFFECTSICON_FILE, _loc3);
            --_loc2;
        } // end while
        _x = -_aEffects.length * dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH / 2;
    } // End of the function
    function onLoadInit(mc)
    {
        var _loc3 = mc.getDepth();
        var _loc2 = _aEffects[_loc3];
        mc.attachMovie("Icon_" + _loc2.characteristic, "icon_mc", 10, {operator: _loc2.operator});
    } // End of the function
    static var ICON_WIDTH = 20;
} // End of Class
#endinitclip
