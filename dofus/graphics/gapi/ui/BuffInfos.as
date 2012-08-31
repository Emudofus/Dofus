// Action script...

// [Initial MovieClip Action of sprite 1049]
#initclip 16
class dofus.graphics.gapi.ui.BuffInfos extends ank.gapi.core.UIAdvancedComponent
{
    var _oData, __get__initialized, __get__data, unloadThis, addToQueue, api, _btnClose2, _btnClose, _bvBuffViewer, __set__data;
    function BuffInfos()
    {
        super();
    } // End of the function
    function set data(oData)
    {
        _oData = oData;
        if (this.__get__initialized())
        {
            this.updateData();
        } // end if
        //return (this.data());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.BuffInfos.CLASS_NAME);
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: updateData});
    } // End of the function
    function initTexts()
    {
        _btnClose2.__set__label(api.lang.getText("CLOSE"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnClose2.addEventListener("click", this);
    } // End of the function
    function updateData()
    {
        _bvBuffViewer.__set__itemData(_oData);
    } // End of the function
    function click(oEvent)
    {
        this.callClose();
    } // End of the function
    static var CLASS_NAME = "BuffInfos";
} // End of Class
#endinitclip
