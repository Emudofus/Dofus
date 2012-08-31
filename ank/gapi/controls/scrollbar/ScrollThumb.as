// Action script...

// [Initial MovieClip Action of sprite 32]
#initclip 16
class ank.gapi.controls.scrollbar.ScrollThumb extends MovieClip
{
    var top_mc, middle_mc, bottom_mc, __get__height, __set__height;
    function ScrollThumb()
    {
        super();
    } // End of the function
    function set height(nHeight)
    {
        top_mc._y = 0;
        middle_mc._y = top_mc._height;
        middle_mc._height = nHeight - top_mc._height - bottom_mc._height;
        bottom_mc._y = middle_mc._y + middle_mc._height;
        //return (this.height());
        null;
    } // End of the function
} // End of Class
#endinitclip
