// Action script...

// [Initial MovieClip Action of sprite 1076]
#initclip 46
class dofus.graphics.gapi.controls.spellfullinfosvieweritem.SpellFullInfosViewerItem extends ank.gapi.core.UIBasicComponent
{
    var _lbl, _ctrElement, addToQueue, __height, __width;
    function SpellFullInfosViewerItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            if (oItem.description == undefined)
            {
                _lbl.__set__text(sSuggested);
            }
            else
            {
                _lbl.__set__text(oItem.description);
                switch (oItem.element)
                {
                    case "N":
                    {
                        _ctrElement.__set__contentPath("IconNeutral");
                        break;
                    } 
                    case "F":
                    {
                        _ctrElement.__set__contentPath("IconFire");
                        break;
                    } 
                    case "A":
                    {
                        _ctrElement.__set__contentPath("IconAir");
                        break;
                    } 
                    case "W":
                    {
                        _ctrElement.__set__contentPath("IconWater");
                        break;
                    } 
                    case "E":
                    {
                        _ctrElement.__set__contentPath("IconEarth");
                        break;
                    } 
                    default:
                    {
                        _ctrElement.__set__contentPath("");
                        break;
                    } 
                } // End of switch
            } // end else if
        }
        else
        {
            _lbl.__set__text("");
            _ctrElement.__set__contentPath("");
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.arrange();
    } // End of the function
    function size()
    {
        super.size();
        this.addToQueue({object: this, method: arrange});
    } // End of the function
    function arrange()
    {
        _lbl.setSize(__width - 20, __height);
    } // End of the function
} // End of Class
#endinitclip
