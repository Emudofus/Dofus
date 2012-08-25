// Action script...

// [Initial MovieClip Action of sprite 20574]
#initclip 95
if (!dofus.graphics.gapi.controls.bookpageindex.BookPageIndexChapterItem)
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
    if (!dofus.graphics.gapi.controls.bookpageindex)
    {
        _global.dofus.graphics.gapi.controls.bookpageindex = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.bookpageindex.BookPageIndexChapterItem = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lblPageNum.text = bUsed ? (oItem[4]) : ("");
            var _loc5 = this._lblPageNum.textWidth;
            this._lblChapter.text = bUsed ? (oItem[0]) : ("");
            this._lblChapter.setSize(this.__width - _loc5 - 30, this.__height);
        }
        else if (this._lblPageNum.text != undefined)
        {
            this._lblPageNum.text = "";
            this._lblChapter.text = "";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.arrange();
    };
    _loc1.size = function ()
    {
        super.size();
        this.addToQueue({object: this, method: this.arrange});
    };
    _loc1.arrange = function ()
    {
        this._lblChapter.setSize(this.__width - 50, this.__height);
        this._lblPageNum.setSize(this.__width - 20, this.__height);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
