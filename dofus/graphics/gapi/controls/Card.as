// Action script...

// [Initial MovieClip Action of sprite 1054]
#initclip 21
class dofus.graphics.gapi.controls.Card extends ank.gapi.core.UIAdvancedComponent
{
    var _sName, __get__name, _nBackground, __get__background, _sGfxFile, __get__gfxFile, addToQueue, _lblName, _ldrBack, _ldrGfx, __set__background, __set__gfxFile, __set__name;
    function Card()
    {
        super();
    } // End of the function
    function set name(sName)
    {
        _sName = sName;
        //return (this.name());
        null;
    } // End of the function
    function set background(nBackground)
    {
        _nBackground = nBackground;
        //return (this.background());
        null;
    } // End of the function
    function set gfxFile(sGfxFile)
    {
        _sGfxFile = sGfxFile;
        //return (this.gfxFile());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.Card.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function initData()
    {
        _lblName.__set__text(_sName);
        _ldrBack.__set__contentPath(dofus.Constants.CARDS_PATH + _nBackground + ".swf");
        _ldrGfx.__set__contentPath(_sGfxFile);
    } // End of the function
    static var CLASS_NAME = "Card";
} // End of Class
#endinitclip
