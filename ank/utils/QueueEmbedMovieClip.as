// Action script...

// [Initial MovieClip Action of sprite 6]
#initclip 1
class ank.utils.QueueEmbedMovieClip extends MovieClip
{
    var onEnterFrame;
    function QueueEmbedMovieClip()
    {
        super();
    } // End of the function
    function addToQueue(oCall)
    {
        ank.utils.QueueEmbedMovieClip._aQueue.push(oCall);
        if (onEnterFrame == undefined)
        {
            onEnterFrame = runQueue;
        } // end if
    } // End of the function
    function runQueue()
    {
        var _loc2 = ank.utils.QueueEmbedMovieClip._aQueue.shift();
        _loc2.method.apply(_loc2.object, _loc2.params);
        if (ank.utils.QueueEmbedMovieClip._aQueue.length == 0)
        {
            delete this.onEnterFrame;
        } // end if
    } // End of the function
    static var _aQueue = new Array();
} // End of Class
#endinitclip
