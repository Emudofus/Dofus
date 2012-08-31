// Action script...

// [Initial MovieClip Action of sprite 1036]
#initclip 3
class dofus.graphics.gapi.controls.BookPageText extends ank.gapi.core.UIAdvancedComponent
{
    var _oPage, __get__initialized, __get__page, _txtPage, addToQueue, owner, __set__page;
    function BookPageText()
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
        super.init(false, dofus.graphics.gapi.controls.BookPageText.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _txtPage.wordWrap = true;
        _txtPage.multiline = true;
        _txtPage.embedFonts = true;
        this.addToQueue({object: this, method: updateData});
    } // End of the function
    function updateData()
    {
        this.setCssStyle(_oPage.cssFile);
    } // End of the function
    function setCssStyle(sCssFile)
    {
        var _loc2 = new TextField.StyleSheet();
        _loc2.owner = this;
        _loc2.onLoad = function ()
        {
            owner.layoutContent(this);
        };
        _loc2.load(sCssFile);
    } // End of the function
    function layoutContent(ssStyle)
    {
        _txtPage.styleSheet = ssStyle;
        _txtPage.htmlText = _oPage.text;
    } // End of the function
    static var CLASS_NAME = "BookPageText";
} // End of Class
#endinitclip
