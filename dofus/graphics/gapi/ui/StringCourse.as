// Action script...

// [Initial MovieClip Action of sprite 981]
#initclip 196
class dofus.graphics.gapi.ui.StringCourse extends ank.gapi.core.UIAdvancedComponent
{
    var _sName, __get__name, _sLevel, __get__level, _sGfx, __get__gfx, addToQueue, _ldrStringCourse, _lblName, _lblLevel, __set__gfx, __set__level, __set__name;
    function StringCourse()
    {
        super();
    } // End of the function
    function set name(sName)
    {
        _sName = sName;
        //return (this.name());
        null;
    } // End of the function
    function set level(sLevel)
    {
        _sLevel = sLevel;
        //return (this.level());
        null;
    } // End of the function
    function set gfx(sGfx)
    {
        _sGfx = sGfx;
        //return (this.gfx());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.StringCourse.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: loadContent});
    } // End of the function
    function loadContent()
    {
        _ldrStringCourse.__set__contentPath(_sGfx);
        _lblName.__set__text(_sName);
        _lblLevel.__set__text(_sLevel);
    } // End of the function
    function unloadContent()
    {
        _ldrStringCourse.__set__contentPath("");
        _lblName.__set__text("");
        _lblLevel.__set__text("");
    } // End of the function
    static var CLASS_NAME = "StringCourse";
} // End of Class
#endinitclip
