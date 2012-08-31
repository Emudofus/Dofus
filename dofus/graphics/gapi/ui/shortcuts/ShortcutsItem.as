// Action script...

// [Initial MovieClip Action of sprite 1080]
#initclip 50
class dofus.graphics.gapi.ui.shortcuts.ShortcutsItem extends ank.gapi.core.UIBasicComponent
{
    var _lblDescription, _lblKeys;
    function ShortcutsItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _lblDescription.__set__text(oItem.d);
            _lblKeys.__set__text(oItem.k);
        }
        else
        {
            _lblDescription.__set__text("");
            _lblKeys.__set__text("");
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
} // End of Class
#endinitclip
