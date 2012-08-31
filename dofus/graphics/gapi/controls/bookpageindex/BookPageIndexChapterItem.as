// Action script...

// [Initial MovieClip Action of sprite 1062]
#initclip 32
class dofus.graphics.gapi.controls.bookpageindex.BookPageIndexChapterItem extends ank.gapi.core.UIBasicComponent
{
    var _lblPageNum, _lblChapter, __height, __width, addToQueue;
    function BookPageIndexChapterItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        _lblPageNum.__set__text(bUsed ? (oItem[4]) : (""));
        var _loc2 = _lblPageNum.__get__textWidth();
        _lblChapter.__set__text(bUsed ? (oItem[0]) : (""));
        _lblChapter.setSize(__width - _loc2 - 30, __height);
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
        _lblChapter.setSize(__width - 50, __height);
        _lblPageNum.setSize(__width - 20, __height);
    } // End of the function
} // End of Class
#endinitclip
