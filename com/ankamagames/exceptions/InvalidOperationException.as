// Action script...

// [Initial MovieClip Action of sprite 20756]
#initclip 21
if (!com.ankamagames.exceptions.InvalidOperationException)
{
    if (!com)
    {
        _global.com = new Object();
    } // end if
    if (!com.ankamagames)
    {
        _global.com.ankamagames = new Object();
    } // end if
    if (!com.ankamagames.exceptions)
    {
        _global.com.ankamagames.exceptions = new Object();
    } // end if
    var _loc1 = (_global.com.ankamagames.exceptions.InvalidOperationException = function (objectErrorSource, className, methodName, msg)
    {
        super(objectErrorSource, className, methodName, msg);
    }).prototype;
    _loc1.getExceptionName = function (Void)
    {
        return ("com.ankamagames.exceptions.InvalidOperationException");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
