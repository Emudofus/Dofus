// Action script...

// [Initial MovieClip Action of sprite 818]
#initclip 27
class ank.utils.extensions.MovieClipExtensions extends MovieClip
{
    var createEmptyMovieClip, localToGlobal, globalToLocal, _x, _y;
    function MovieClipExtensions()
    {
        super();
    } // End of the function
    function attachClassMovie(className, instanceName, depth, argv)
    {
        var _loc2 = this.createEmptyMovieClip(instanceName, depth);
        _loc2.__proto__ = className.prototype;
        className.apply(_loc2, argv);
        return (_loc2);
    } // End of the function
    function alignOnPixel()
    {
        var _loc2 = new Object({x: 0, y: 0});
        this.localToGlobal(_loc2);
        _loc2.x = Math.floor(_loc2.x);
        _loc2.y = Math.floor(_loc2.y);
        this.globalToLocal(_loc2);
        _x = _x - _loc2.x;
        _y = _y - _loc2.y;
    } // End of the function
    function playFirstChildren()
    {
        for (var _loc2 in this)
        {
            if (this[_loc2].__proto__ == MovieClip.prototype)
            {
                this[_loc2].gotoAndPlay(1);
            } // end if
        } // end of for...in
    } // End of the function
    function end(seq)
    {
        var _loc3 = this.getFirstParentProperty("_ACTION");
        if (seq == undefined)
        {
            seq = _loc3.sequencer;
        } // end if
        seq.onActionEnd();
    } // End of the function
    function getFirstParentProperty(prop)
    {
        var _loc3 = 20;
        var _loc2 = this;
        while (_loc3 >= 0)
        {
            if (_loc2[prop] != undefined)
            {
                return (_loc2[prop]);
            } // end if
            _loc2 = _loc2._parent;
            --_loc3;
        } // end while
    } // End of the function
    function getActionClip(Void)
    {
        return (this.getFirstParentProperty("_ACTION"));
    } // End of the function
} // End of Class
#endinitclip
