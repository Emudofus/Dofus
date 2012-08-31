// Action script...

// [Initial MovieClip Action of sprite 1048]
#initclip 15
class dofus.graphics.gapi.controls.BuffViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oItem, addToQueue, __get__itemData, _lblName, _txtDescription, _ldrIcon, _lstInfos, __set__itemData;
    function BuffViewer()
    {
        super();
    } // End of the function
    function set itemData(oItem)
    {
        _oItem = oItem;
        this.addToQueue({object: this, method: showItemData, params: [oItem]});
        //return (this.itemData());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.BuffViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
    } // End of the function
    function showItemData(oItem)
    {
        if (oItem != undefined)
        {
            _lblName.__set__text(oItem.name);
            _txtDescription.__set__text(oItem.description);
            _ldrIcon.__set__contentPath(oItem.iconFile);
            _lstInfos.__set__dataProvider(oItem.effects);
        }
        else
        {
            _lblName.__set__text("");
            _txtDescription.__set__text("");
            _ldrIcon.__set__contentPath("");
            _lstInfos.removeAll();
        } // end else if
    } // End of the function
    static var CLASS_NAME = "BuffViewer";
} // End of Class
#endinitclip
