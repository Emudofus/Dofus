// Action script...

// [Initial MovieClip Action of sprite 1059]
#initclip 28
class dofus.graphics.gapi.ui.inventory.ContainerBackground extends ank.gapi.core.UIBasicComponent
{
    var _mcBg, __width, __height, _mcL, _mcR, _mcT, _mcB;
    function ContainerBackground()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.inventory.ContainerBackground.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        _mcBg._width = __width;
        _mcBg._height = __height;
        _mcL._height = _mcR._height = __height;
        _mcT._width = _mcB._width = __width;
        _mcL._x = _mcT._x = _mcL._y = _mcT._y = _mcB._x = _mcR._y = 0;
        _mcB._y = __height - _mcL._width;
        _mcR._x = __width - _mcR._width;
    } // End of the function
    static var CLASS_NAME = "ContainerBackground";
} // End of Class
#endinitclip
