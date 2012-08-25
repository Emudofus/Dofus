// Action script...

// [Initial MovieClip Action of sprite 20866]
#initclip 131
if (!com.ankamagames.exceptions.FileLoadException)
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
    var _loc1 = (_global.com.ankamagames.exceptions.FileLoadException = function (objectErrorSource, className, methodName, file)
    {
        super(objectErrorSource, className, methodName, file + " can\'t be loaded.");
    }).prototype;
    _loc1.getExceptionName = function (Void)
    {
        return ("com.ankamagames.exceptions.FileLoadException");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
