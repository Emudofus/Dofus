// Action script...

// [Initial MovieClip Action of sprite 133]
#initclip 195
class ank.gapi.controls.BackgroundHidder extends ank.gapi.core.UIBasicComponent
{
    var useHandCursor, __get__handCursor, createEmptyMovieClip, dispatchEvent, hidden_mc, __width, __height, getStyle, drawRoundRect, __set__handCursor;
    function BackgroundHidder()
    {
        super();
    } // End of the function
    function set handCursor(bHandCursor)
    {
        useHandCursor = bHandCursor;
        //return (this.handCursor());
        null;
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.BackgroundHidder.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("hidden_mc", 10);
        function onRelease()
        {
            this.dispatchEvent({type: "click"});
        } // End of the function
    } // End of the function
    function arrange()
    {
        hidden_mc._width = __width;
        hidden_mc._height = __height;
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        var _loc4 = _loc2.backgroundcolor == undefined ? (0) : (_loc2.backgroundcolor);
        var _loc3 = _loc2.backgroundalpha == undefined ? (10) : (_loc2.backgroundalpha);
        hidden_mc.clear();
        this.drawRoundRect(hidden_mc, 0, 0, 1, 1, 0, _loc4, _loc3);
    } // End of the function
    static var CLASS_NAME = "BackgroundHidder";
} // End of Class
#endinitclip
