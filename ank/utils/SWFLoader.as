// Action script...

// [Initial MovieClip Action of sprite 969]
#initclip 181
class ank.utils.SWFLoader extends MovieClip
{
    var _frameStart, _aArgs, createEmptyMovieClip, swf_mc, broadcastMessage;
    function SWFLoader()
    {
        super();
        AsBroadcaster.initialize(this);
        this.initialize(0);
    } // End of the function
    function initialize(frame, args)
    {
        this.clear();
        _frameStart = frame;
        _aArgs = args;
    } // End of the function
    function clear()
    {
        this.createEmptyMovieClip("swf_mc", 10);
    } // End of the function
    function remove()
    {
        swf_mc.__proto__ = MovieClip.prototype;
        swf_mc.removeMovieClip();
    } // End of the function
    function loadSWF(file, frame, args)
    {
        this.initialize(frame, args);
        var _loc2 = new MovieClipLoader();
        _loc2.addListener(this);
        _loc2.loadClip(file, swf_mc);
    } // End of the function
    function onLoadComplete(mc)
    {
        this.broadcastMessage("onLoadComplete", mc, _aArgs);
    } // End of the function
    function onLoadInit(mc)
    {
        if (_frameStart != undefined)
        {
            mc.gotoAndStop(_frameStart);
        } // end if
        this.broadcastMessage("onLoadInit", mc, _aArgs);
    } // End of the function
} // End of Class
#endinitclip
