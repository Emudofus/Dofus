// Action script...

// [Initial MovieClip Action of sprite 203]
#initclip 26
class ank.gapi.controls.StylizedRectangle extends ank.gapi.core.UIBasicComponent
{
    var createEmptyMovieClip, _bInitialized, getStyle, _mcBackground, __height, __width, drawRoundRect;
    function StylizedRectangle()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.StylizedRectangle.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcBackground", 10);
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        if (_bInitialized)
        {
            this.draw();
        } // end if
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        var _loc3 = _loc2.cornerradius;
        var _loc5 = _loc2.bgcolor;
        var _loc4 = _loc2.alpha;
        _mcBackground.clear();
        this.drawRoundRect(_mcBackground, 0, 0, __width, __height, _loc3, _loc5, _loc4);
    } // End of the function
    static var CLASS_NAME = "StylizedRectangle";
} // End of Class
#endinitclip
