// Action script...

// [Initial MovieClip Action of sprite 1037]
#initclip 4
class dofus.graphics.gapi.controls.BookPageIndex extends ank.gapi.core.UIAdvancedComponent
{
    var _oPage, __get__initialized, __get__page, addToQueue, _lstChapters, api, _lblIndex, dispatchEvent, __set__page;
    function BookPageIndex()
    {
        super();
    } // End of the function
    function set page(oPage)
    {
        _oPage = oPage;
        if (this.__get__initialized())
        {
            this.updateData();
        } // end if
        //return (this.page());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.BookPageIndex.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: updateData});
    } // End of the function
    function addListeners()
    {
        _lstChapters.addEventListener("itemSelected", this);
    } // End of the function
    function initTexts()
    {
        _lblIndex.__set__text(api.lang.getText("TABLE_OF_CONTENTS"));
    } // End of the function
    function updateData()
    {
        _lstChapters.__set__dataProvider(_oPage.chapters);
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.item[4];
        this.dispatchEvent({type: "chapterChange", pageNum: _loc2});
    } // End of the function
    static var CLASS_NAME = "BookPageIndex";
} // End of Class
#endinitclip
