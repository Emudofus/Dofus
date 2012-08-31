// Action script...

// [Initial MovieClip Action of sprite 1084]
#initclip 54
class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerFeatsItem extends ank.gapi.core.UIAdvancedComponent
{
    var _mcList, __get__list, _ldrIcon, _lblName, _lblEffect, __set__list;
    function AlignmentViewerFeatsItem()
    {
        super();
    } // End of the function
    function set list(mcList)
    {
        _mcList = mcList;
        //return (this.list());
        null;
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _ldrIcon.__set__contentPath(oItem.iconFile);
            _lblName.__set__text(oItem.name + (oItem.level == undefined ? ("") : (" (" + _mcList.gapi.api.lang.getText("LEVEL_SMALL") + " " + oItem.level + ")")));
            _lblEffect.__set__text(oItem.effect.description == undefined ? ("") : (oItem.effect.description));
        }
        else
        {
            _ldrIcon.__set__contentPath("");
            _lblName.__set__text("");
            _lblEffect.__set__text("");
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
