// Action script...

// [Initial MovieClip Action of sprite 1029]
#initclip 250
class dofus.graphics.gapi.ui.DocumentBook extends ank.gapi.core.UIAdvancedComponent
{
    var _oDoc, __get__document, gapi, api, addToQueue, _btnPrevious, _btnNext, _btnAskPageLeft, _btnAskPageRight, _btnClose, _nCurrentLeftPageNum, _mcRightPlacer, _mcLeftPlacer, getNextHighestDepth, attachMovie, _lblLeftPageNum, _lblRightPageNum, __set__document;
    function DocumentBook()
    {
        super();
    } // End of the function
    function set document(oDoc)
    {
        _oDoc = oDoc;
        //return (this.document());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.DocumentBook.CLASS_NAME);
    } // End of the function
    function destroy()
    {
        gapi.hideTooltip();
    } // End of the function
    function callClose()
    {
        api.network.Documents.leave();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: setLeftPageNumber, params: [0]});
        _btnPrevious._visible = false;
        _btnNext._visible = false;
        _btnAskPageLeft.__set__enabled(false);
        _btnAskPageRight.__set__enabled(false);
    } // End of the function
    function addListeners()
    {
        _btnPrevious.addEventListener("click", this);
        _btnPrevious.addEventListener("over", this);
        _btnPrevious.addEventListener("out", this);
        _btnNext.addEventListener("click", this);
        _btnNext.addEventListener("over", this);
        _btnNext.addEventListener("out", this);
        _btnClose.addEventListener("click", this);
        _btnAskPageLeft.addEventListener("click", this);
        _btnAskPageRight.addEventListener("click", this);
        _btnAskPageLeft.addEventListener("over", this);
        _btnAskPageRight.addEventListener("over", this);
        _btnAskPageLeft.addEventListener("out", this);
        _btnAskPageRight.addEventListener("out", this);
    } // End of the function
    function setLeftPageNumber(nPageNum)
    {
        if (_oDoc == undefined)
        {
            return;
        } // end if
        _nCurrentLeftPageNum = nPageNum;
        var _loc3 = _oDoc.getPage(nPageNum);
        var _loc4 = _oDoc.getPage(nPageNum + 1);
        this.layoutContent(_loc3, true);
        this.layoutContent(_loc4, false);
        _btnPrevious._visible = nPageNum > 0;
        _btnNext._visible = nPageNum + 2 < _oDoc.pageCount;
    } // End of the function
    function layoutContent(oPage, bLeft)
    {
        var _loc4 = bLeft ? ("_mcLeftRenderer") : ("_mcRightRenderer");
        var _loc3 = bLeft ? (_mcLeftPlacer) : (_mcRightPlacer);
        this[_loc4].removeMovieClip();
        switch (oPage.type)
        {
            case "title":
            {
                this.attachMovie("BookPageTitle", _loc4, this.getNextHighestDepth(), {_x: _loc3._x, _y: _loc3._y, page: oPage});
                break;
            } 
            case "index":
            {
                this.attachMovie("BookPageIndex", _loc4, this.getNextHighestDepth(), {_x: _loc3._x, _y: _loc3._y, page: oPage});
                this[_loc4].addEventListener("chapterChange", this);
                break;
            } 
            case "text":
            {
                this.attachMovie("BookPageText", _loc4, this.getNextHighestDepth(), {_x: _loc3._x, _y: _loc3._y, page: oPage});
                break;
            } 
            case "blank":
            default:
            {
                break;
            } 
        } // End of switch
        if (bLeft)
        {
            _lblLeftPageNum.__set__text(oPage.num == undefined ? ("") : (oPage.num));
            _btnAskPageLeft.__set__enabled(oPage.num != undefined);
        }
        else
        {
            _lblRightPageNum.__set__text(oPage.num == undefined ? ("") : (oPage.num));
            _btnAskPageRight.__set__enabled(oPage.num != undefined);
        } // end else if
    } // End of the function
    function askPage(nPageNum)
    {
        var _loc2 = gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: nPageNum});
        _loc2.addEventListener("validate", this);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnPrevious":
            {
                this.setLeftPageNumber(_nCurrentLeftPageNum - 2);
                break;
            } 
            case "_btnNext":
            {
                this.setLeftPageNumber(_nCurrentLeftPageNum + 2);
                break;
            } 
            case "_btnClose":
            {
                this.callClose();
                break;
            } 
            case "_btnAskPageLeft":
            {
                this.askPage(1);
                break;
            } 
            case "_btnAskPageRight":
            {
                this.askPage(_oDoc.pageCount - 1);
                break;
            } 
        } // End of switch
    } // End of the function
    function chapterChange(oEvent)
    {
        var _loc3 = oEvent.pageNum % 2 == 0 ? (oEvent.pageNum) : (oEvent.pageNum - 1);
        this.setLeftPageNumber(_loc3);
    } // End of the function
    function validate(oEvent)
    {
        var _loc2 = Number(oEvent.value);
        if (isNaN(_loc2))
        {
            _loc2 = 1;
        } // end if
        if (_loc2 < 1)
        {
            _loc2 = 1;
        } // end if
        if (_loc2 >= _oDoc.pageCount)
        {
            _loc2 = _oDoc.pageCount - 1;
        } // end if
        var _loc3 = _loc2 % 2 == 0 ? (_loc2) : (_loc2 - 1);
        this.setLeftPageNumber(_loc3);
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnPrevious":
            {
                gapi.showTooltip(api.lang.getText("PREVIOUS_PAGE"), oEvent.target, -20);
                break;
            } 
            case "_btnNext":
            {
                gapi.showTooltip(api.lang.getText("NEXT_PAGE"), oEvent.target, -20);
                break;
            } 
            default:
            {
                gapi.showTooltip(api.lang.getText("CHOOSE_PAGE_NUMBER"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "DocumentBook";
} // End of Class
#endinitclip
