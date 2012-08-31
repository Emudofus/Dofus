// Action script...

// [Initial MovieClip Action of sprite 977]
#initclip 191
class dofus.graphics.gapi.controls.timeline.TimelinePointer extends ank.gapi.core.UIBasicComponent
{
    var _x, _destX;
    function TimelinePointer()
    {
        super();
    } // End of the function
    function moveTween(destX)
    {
        var nDir = destX > _x ? (1) : (-1);
        var i = 0;
        _destX = destX;
        function onEnterFrame()
        {
            ++i;
            _x = _x + i * i * nDir;
            if (_x * nDir > _destX * nDir)
            {
                _x = _destX;
                delete this.onEnterFrame;
            } // end if
        } // End of the function
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.timeline.TimelinePointer.CLASS_NAME);
    } // End of the function
    static var CLASS_NAME = "Timeline";
} // End of Class
#endinitclip
