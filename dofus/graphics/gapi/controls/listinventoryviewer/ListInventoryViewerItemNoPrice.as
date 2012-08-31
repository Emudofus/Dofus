// Action script...

// [Initial MovieClip Action of sprite 1061]
#initclip 31
class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItemNoPrice extends ank.gapi.core.UIBasicComponent
{
    var _lblName, _ldrIcon, addToQueue, __height, __width;
    function ListInventoryViewerItemNoPrice()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        _lblName.__set__text(bUsed ? ((oItem.Quantity > 1 ? ("x" + oItem.Quantity + " ") : ("")) + oItem.name) : (""));
        _ldrIcon.__set__contentPath(bUsed ? (oItem.iconFile) : (""));
        _lblName.__set__styleName(oItem.style == "" ? ("BrownLeftSmallLabel") : (oItem.style + "LeftSmallLabel"));
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
        _lblName.setSize(__width - 20, __height);
    } // End of the function
} // End of Class
#endinitclip
