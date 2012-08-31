// Action script...

// [Initial MovieClip Action of sprite 1063]
#initclip 33
class dofus.graphics.gapi.controls.listinventoryviewer.ListInventoryViewerItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _lblPrice, _lblName, __height, __width, _ldrIcon, addToQueue, __set__list;
    function ListInventoryViewerItem()
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
        _lblPrice.__set__text(bUsed ? (String(oItem.price).addMiddleChar(_mcList.gapi.api.lang.getConfigText("THOUSAND_SEPARATOR"), 3)) : (""));
        var _loc3 = _lblPrice.__get__textWidth();
        _lblName.__set__text(bUsed ? ((oItem.Quantity > 1 ? ("x" + oItem.Quantity + " ") : ("")) + oItem.name) : (""));
        _lblName.setSize(__width - _loc3 - 30, __height);
        _lblName.__set__styleName(oItem.style == "" ? ("BrownLeftSmallLabel") : (oItem.style + "LeftSmallLabel"));
        _ldrIcon.__set__contentPath(bUsed ? (oItem.iconFile) : (""));
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
        _lblName.setSize(__width - 50, __height);
        _lblPrice.setSize(__width - 20, __height);
    } // End of the function
} // End of Class
#endinitclip
