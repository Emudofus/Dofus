// Action script...

// [Initial MovieClip Action of sprite 11]
#initclip 4
class ank.gapi.styles.StylesManager extends Object
{
    function StylesManager()
    {
        super();
    } // End of the function
    static function setStyle(sStyleName, oStyle)
    {
        if (!(oStyle instanceof Object))
        {
            return;
        } // end if
        if (sStyleName == undefined)
        {
            return;
        } // end if
        if (oStyle == undefined)
        {
            return;
        } // end if
        ank.gapi.styles.StylesManager._styles[sStyleName] = oStyle;
    } // End of the function
    static function getStyle(sStyleName)
    {
        return (ank.gapi.styles.StylesManager._styles[sStyleName]);
    } // End of the function
    static function loadStylePackage(oPackage)
    {
        for (var _loc2 in oPackage)
        {
            ank.gapi.styles.StylesManager.setStyle(_loc2, oPackage[_loc2]);
        } // end of for...in
    } // End of the function
    static var _styles = new Object();
} // End of Class
#endinitclip
