// Action script...

// [Initial MovieClip Action of sprite 930]
#initclip 142
class dofus.graphics.battlefield.SmileyOverHead extends MovieClip
{
    var attachMovie, __get__height, __get__width;
    function SmileyOverHead(nSmileyID)
    {
        super();
        this.draw(nSmileyID);
    } // End of the function
    function get height()
    {
        return (20);
    } // End of the function
    function get width()
    {
        return (20);
    } // End of the function
    function draw(nSmileyID)
    {
        this.attachMovie("Loader", "_ldrSmiley", 10, {_x: -10, _width: 20, _height: 20, scaleContent: true, contentPath: dofus.Constants.SMILEYS_ICONS_PATH + nSmileyID + ".swf"});
    } // End of the function
} // End of Class
#endinitclip
