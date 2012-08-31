// Action script...

// [Initial MovieClip Action of sprite 1077]
#initclip 47
class dofus.graphics.gapi.controls.itemviewer.ItemViewerItem extends ank.gapi.core.UIBasicComponent
{
    var _lbl, addToQueue, __height, __width;
    function ItemViewerItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            if (oItem instanceof dofus.datacenter.Effect)
            {
                _lbl.__set__text(oItem.description);
                switch (oItem.operator)
                {
                    case "+":
                    {
                        _lbl.__set__styleName("GreenLeftSmallLabel");
                        break;
                    } 
                    case "-":
                    {
                        _lbl.__set__styleName("RedLeftSmallLabel");
                        break;
                    } 
                    default:
                    {
                        _lbl.__set__styleName("BrownLeftSmallLabel");
                        break;
                    } 
                } // End of switch
            }
            else
            {
                _lbl.__set__text(sSuggested);
                _lbl.__set__styleName("BrownLeftSmallLabel");
            } // end else if
        }
        else
        {
            _lbl.__set__text("");
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
        _lbl.setSize(__width, __height);
    } // End of the function
} // End of Class
#endinitclip
