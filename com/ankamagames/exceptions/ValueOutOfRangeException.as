// Action script...

// [Initial MovieClip Action of sprite 20847]
#initclip 112
if (!com.ankamagames.exceptions.ValueOutOfRangeException)
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
    var _loc1 = (_global.com.ankamagames.exceptions.ValueOutOfRangeException = function (objectErrorSource, className, methodName, variableName, invalidValue, minValue, maxValue)
    {
        super(objectErrorSource, className, methodName, variableName + "[" + invalidValue + ") is out of of range. The value value should be between " + minValue + " and " + maxValue + ").");
    }).prototype;
    _loc1.getExceptionName = function (Void)
    {
        return ("com.ankamagames.exceptions.ValueOutOfRangeException");
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
