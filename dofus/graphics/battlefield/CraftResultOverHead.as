// Action script...

// [Initial MovieClip Action of sprite 946]
#initclip 158
class dofus.graphics.battlefield.CraftResultOverHead extends ank.gapi.core.UIBasicComponent
{
    var attachMovie, _ldrItem, _mcCross, _mcMiss, __get__height, __get__width;
    function CraftResultOverHead(bAdd, oItem)
    {
        super();
        this.initialize();
        this.draw(bAdd, oItem);
    } // End of the function
    function get height()
    {
        return (33);
    } // End of the function
    function get width()
    {
        return (62);
    } // End of the function
    function initialize()
    {
        this.attachMovie("CraftResultOverHeadBubble", "_mcBack", 10);
    } // End of the function
    function draw(bAdd, oItem)
    {
        if (oItem == undefined)
        {
            this.attachMovie("CraftResultOverHeadCross", "_mcCross", 40);
            _ldrItem.removeMovieClip();
        }
        else
        {
            this.attachMovie("Loader", "_ldrItem", 20, {_x: 6, _y: 4, _width: 20, _height: 20, scaleContent: true, contentPath: oItem.iconFile});
            _mcCross.removeMovieClip();
        } // end else if
        if (!bAdd)
        {
            this.attachMovie("CraftResultOverHeadMiss", "_mcMiss", 30);
        }
        else
        {
            _mcMiss.removeMovieClip();
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
