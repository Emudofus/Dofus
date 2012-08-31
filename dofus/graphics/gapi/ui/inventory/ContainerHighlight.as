// Action script...

// [Initial MovieClip Action of sprite 1064]
#initclip 34
class dofus.graphics.gapi.ui.inventory.ContainerHighlight extends ank.gapi.core.UIBasicComponent
{
    var createEmptyMovieClip, _mcBg, __width, __height, _mcL, _mcR, _mcT, _mcB;
    function ContainerHighlight()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.inventory.ContainerHighlight.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcHighlight", 10);
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
    static var CLASS_NAME = "ContainerHighlight";
} // End of Class
#endinitclip
