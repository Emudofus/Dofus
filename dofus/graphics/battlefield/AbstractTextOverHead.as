// Action script...

// [Initial MovieClip Action of sprite 968]
#initclip 180
class dofus.graphics.battlefield.AbstractTextOverHead extends ank.gapi.core.UIBasicComponent
{
    var _height, _width, createEmptyMovieClip, _mcTxtBackground, drawRoundRect, _mcGfx, __get__height, __get__width;
    function AbstractTextOverHead()
    {
        super();
    } // End of the function
    function get height()
    {
        return (Math.ceil(_height));
    } // End of the function
    function get width()
    {
        return (Math.ceil(_width));
    } // End of the function
    function initialize()
    {
        this.createEmptyMovieClip("_mcGfx", 10);
        this.createEmptyMovieClip("_mcTxtBackground", 20);
    } // End of the function
    function drawBackground(nWidth, nHeight, nColor)
    {
        this.drawRoundRect(_mcTxtBackground, -nWidth / 2, 0, nWidth, nHeight, 3, nColor, dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_ALPHA);
    } // End of the function
    function drawGfx(sFile, nFrame)
    {
        _mcGfx.attachClassMovie(ank.utils.SWFLoader, "_mcSwfLoader", 10);
        _mcGfx._mcSwfLoader.loadSWF(sFile, nFrame);
    } // End of the function
    static var BACKGROUND_ALPHA = 70;
    static var BACKGROUND_COLOR = 0;
    static var TEXT_SMALL_FORMAT = new TextFormat("Font1", 10, 16777215, false, false, false, null, null, "left");
    static var TEXT_FORMAT = new TextFormat("Font2", 10, 16777215, false, false, false, null, null, "center");
    static var CORNER_RADIUS = 0;
    static var WIDTH_SPACER = 4;
    static var HEIGHT_SPACER = 4;
} // End of Class
#endinitclip
