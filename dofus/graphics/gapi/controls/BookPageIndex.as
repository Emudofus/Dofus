// Action script...

// [Initial MovieClip Action of sprite 20895]
#initclip 160
if (!dofus.graphics.gapi.controls.BookPageIndex)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.BookPageIndex = function ()
    {
        super();
    }).prototype;
    _loc1.__set__page = function (oPage)
    {
        this._oPage = oPage;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.page());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.BookPageIndex.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.updateData});
    };
    _loc1.addListeners = function ()
    {
        this._lstChapters.addEventListener("itemSelected", this);
    };
    _loc1.initTexts = function ()
    {
        this._lblIndex.text = this.api.lang.getText("TABLE_OF_CONTENTS");
    };
    _loc1.updateData = function ()
    {
        this._lstChapters.dataProvider = this._oPage.chapters;
    };
    _loc1.itemSelected = function (oEvent)
    {
        var _loc3 = oEvent.row.item[4];
        this.dispatchEvent({type: "chapterChange", pageNum: _loc3});
    };
    _loc1.addProperty("page", function ()
    {
    }, _loc1.__set__page);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.BookPageIndex = function ()
    {
        super();
    }).CLASS_NAME = "BookPageIndex";
} // end if
#endinitclip
