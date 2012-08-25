// Action script...

// [Initial MovieClip Action of sprite 20679]
#initclip 200
if (!com.ankamagames.exceptions.AbstractException)
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
    var _loc1 = (_global.com.ankamagames.exceptions.AbstractException = function (objectErrorSource, className, methodName, msg)
    {
        super(msg);
        this._className = className;
        this._methodName = methodName;
        this._objectErrorSource = objectErrorSource;
    }).prototype;
    _loc1.getSource = function (Void)
    {
        return (this._objectErrorSource);
    };
    _loc1.getMessage = function (Void)
    {
        return (!super.message ? (null) : (super.toString()));
    };
    _loc1.getExceptionName = function (Void)
    {
        return ("com.ankamagames.exceptions.AbstractException");
    };
    _loc1.getClassName = function (Void)
    {
        return (this._className);
    };
    _loc1.getMethodName = function (Void)
    {
        return (!this._methodName ? (null) : (this._methodName));
    };
    _loc1.toString = function (Void)
    {
        var _loc3 = this.getExceptionName() + " in " + this.getClassName() + (this.getMethodName() != null ? ("." + this.getMethodName()) : (""));
        var _loc4 = this.getMessage();
        if (!_loc4)
        {
            return (_loc3);
        } // end if
        return ("[EXCEPTION] " + _loc3 + " :\r\n\t" + _loc4);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
