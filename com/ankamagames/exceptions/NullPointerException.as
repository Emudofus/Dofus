// Action script...

// [Initial MovieClip Action of sprite 20680]
#initclip 201
if (!com.ankamagames.exceptions.NullPointerException)
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
    var _loc1 = (_global.com.ankamagames.exceptions.NullPointerException = function (objectErrorSource, className, methodName, variableName)
    {
        super(objectErrorSource, className, methodName, variableName + " is NULL!");
    }).prototype;
    _loc1.getExceptionName = function (Void)
    {
        return ("com.ankamagames.exceptions.NullPointerException");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
