// Action script...

// [Initial MovieClip Action of sprite 20481]
#initclip 2
if (!ank.utils.QueueEmbedMovieClip)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.QueueEmbedMovieClip = function ()
    {
        super();
    }).prototype;
    _loc1.addToQueue = function (oCall)
    {
        ank.utils.QueueEmbedMovieClip._aQueue.push(oCall);
        if (ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame == undefined)
        {
            ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame = this.runQueue;
        } // end if
    };
    _loc1.runQueue = function ()
    {
        for (var k in ank.utils.QueueEmbedMovieClip._aQueue)
        {
            var _loc2 = ank.utils.QueueEmbedMovieClip._aQueue.shift();
            _loc2.method.apply(_loc2.object, _loc2.params);
            if (ank.utils.QueueEmbedMovieClip._aQueue.length == 0)
            {
                delete ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame;
            } // end if
        } // end of for...in
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.QueueEmbedMovieClip = function ()
    {
        super();
    })._aQueue = new Array(, _global.ank.utils.QueueEmbedMovieClip = function ()
    {
        super();
    })._mcEnterFrame = _level0.createEmptyMovieClip("_mcQueueEnterFrame", _level0.getNextHighestDepth());
} // end if
#endinitclip
