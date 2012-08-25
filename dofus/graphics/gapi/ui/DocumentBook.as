// Action script...

// [Initial MovieClip Action of sprite 20737]
#initclip 2
if (!dofus.graphics.gapi.ui.DocumentBook)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.DocumentBook = function ()
    {
        super();
    }).prototype;
    _loc1.__set__document = function (oDoc)
    {
        this._oDoc = oDoc;
        //return (this.document());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.DocumentBook.CLASS_NAME);
    };
    _loc1.destroy = function ()
    {
        this.gapi.hideTooltip();
    };
    _loc1.callClose = function ()
    {
        this.api.network.Documents.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.setLeftPageNumber, params: [0]});
        this._btnPrevious._visible = false;
        this._btnNext._visible = false;
        this._btnAskPageLeft.enabled = false;
        this._btnAskPageRight.enabled = false;
    };
    _loc1.addListeners = function ()
    {
        this._btnPrevious.addEventListener("click", this);
        this._btnPrevious.addEventListener("over", this);
        this._btnPrevious.addEventListener("out", this);
        this._btnNext.addEventListener("click", this);
        this._btnNext.addEventListener("over", this);
        this._btnNext.addEventListener("out", this);
        this._btnClose.addEventListener("click", this);
        this._btnAskPageLeft.addEventListener("click", this);
        this._btnAskPageRight.addEventListener("click", this);
        this._btnAskPageLeft.addEventListener("over", this);
        this._btnAskPageRight.addEventListener("over", this);
        this._btnAskPageLeft.addEventListener("out", this);
        this._btnAskPageRight.addEventListener("out", this);
    };
    _loc1.setLeftPageNumber = function (nPageNum)
    {
        if (this._oDoc == undefined)
        {
            return;
        } // end if
        this._nCurrentLeftPageNum = nPageNum;
        var _loc3 = this._oDoc.getPage(nPageNum);
        var _loc4 = this._oDoc.getPage(nPageNum + 1);
        this.layoutContent(_loc3, true);
        this.layoutContent(_loc4, false);
        this._btnPrevious._visible = nPageNum > 0;
        this._btnNext._visible = nPageNum + 2 < this._oDoc.pageCount;
    };
    _loc1.layoutContent = function (oPage, bLeft)
    {
        var _loc4 = bLeft ? ("_mcLeftRenderer") : ("_mcRightRenderer");
        var _loc5 = bLeft ? (this._mcLeftPlacer) : (this._mcRightPlacer);
        this[_loc4].removeMovieClip();
        switch (oPage.type)
        {
            case "title":
            {
                this.attachMovie("BookPageTitle", _loc4, this.getNextHighestDepth(), {_x: _loc5._x, _y: _loc5._y, page: oPage});
                break;
            } 
            case "index":
            {
                this.attachMovie("BookPageIndex", _loc4, this.getNextHighestDepth(), {_x: _loc5._x, _y: _loc5._y, page: oPage});
                this[_loc4].addEventListener("chapterChange", this);
                break;
            } 
            case "text":
            {
                this.attachMovie("BookPageText", _loc4, this.getNextHighestDepth(), {_x: _loc5._x, _y: _loc5._y, page: oPage});
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
            this._lblLeftPageNum.text = oPage.num == undefined ? ("") : (oPage.num);
            this._btnAskPageLeft.enabled = oPage.num != undefined;
        }
        else
        {
            this._lblRightPageNum.text = oPage.num == undefined ? ("") : (oPage.num);
            this._btnAskPageRight.enabled = oPage.num != undefined;
        } // end else if
    };
    _loc1.askPage = function (nPageNum)
    {
        var _loc3 = this.gapi.loadUIComponent("PopupQuantity", "PopupQuantity", {value: nPageNum, max: nPageNum});
        _loc3.addEventListener("validate", this);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnPrevious":
            {
                this.setLeftPageNumber(this._nCurrentLeftPageNum - 2);
                break;
            } 
            case "_btnNext":
            {
                this.setLeftPageNumber(this._nCurrentLeftPageNum + 2);
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
                this.askPage(this._oDoc.pageCount - 1);
                break;
            } 
        } // End of switch
    };
    _loc1.chapterChange = function (oEvent)
    {
        var _loc3 = oEvent.pageNum % 2 == 0 ? (oEvent.pageNum) : (oEvent.pageNum - 1);
        this.setLeftPageNumber(_loc3);
    };
    _loc1.validate = function (oEvent)
    {
        var _loc3 = Number(oEvent.value);
        if (_global.isNaN(_loc3))
        {
            _loc3 = 1;
        } // end if
        if (_loc3 < 1)
        {
            _loc3 = 1;
        } // end if
        if (_loc3 >= this._oDoc.pageCount)
        {
            _loc3 = this._oDoc.pageCount - 1;
        } // end if
        var _loc4 = _loc3 % 2 == 0 ? (_loc3) : (_loc3 - 1);
        this.setLeftPageNumber(_loc4);
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnPrevious":
            {
                this.gapi.showTooltip(this.api.lang.getText("PREVIOUS_PAGE"), oEvent.target, -20);
                break;
            } 
            case "_btnNext":
            {
                this.gapi.showTooltip(this.api.lang.getText("NEXT_PAGE"), oEvent.target, -20);
                break;
            } 
            default:
            {
                this.gapi.showTooltip(this.api.lang.getText("CHOOSE_PAGE_NUMBER"), oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("document", function ()
    {
    }, _loc1.__set__document);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.DocumentBook = function ()
    {
        super();
    }).CLASS_NAME = "DocumentBook";
} // end if
#endinitclip
