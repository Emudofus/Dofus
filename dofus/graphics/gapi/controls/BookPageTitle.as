// Action script...

// [Initial MovieClip Action of sprite 1038]
#initclip 5
class dofus.graphics.gapi.controls.BookPageTitle extends ank.gapi.core.UIAdvancedComponent
{
    var _oPage, __get__initialized, __get__page, addToQueue, _txtTitle, _lblSubTitle, _lblAuthor, __set__page;
    function BookPageTitle()
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
        super.init(false, dofus.graphics.gapi.controls.BookPageTitle.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: updateData});
    } // End of the function
    function updateData()
    {
        _txtTitle.__set__text(_oPage.title == undefined ? ("") : (_oPage.title));
        _lblSubTitle.__set__text(_oPage.subtitle == undefined ? ("") : (_oPage.subtitle));
        _lblAuthor.__set__text(_oPage.author == undefined ? ("") : (_oPage.author));
    } // End of the function
    static var CLASS_NAME = "BookPageTitle";
} // End of Class
#endinitclip
