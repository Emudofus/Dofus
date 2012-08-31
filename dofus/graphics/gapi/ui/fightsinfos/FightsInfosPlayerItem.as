// Action script...

// [Initial MovieClip Action of sprite 1085]
#initclip 55
class dofus.graphics.gapi.ui.fightsinfos.FightsInfosPlayerItem extends ank.gapi.core.UIBasicComponent
{
    var _lblName, _lblLevel;
    function FightsInfosPlayerItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _lblName.__set__text(oItem.name);
            _lblLevel.__set__text(oItem.level);
        }
        else
        {
            _lblName.__set__text("");
            _lblLevel.__set__text("");
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
} // End of Class
#endinitclip
