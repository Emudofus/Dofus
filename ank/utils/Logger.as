// Action script...

// [Initial MovieClip Action of sprite 415]
#initclip 19
class ank.utils.Logger
{
    var _logs, _errors;
    static var __get__logs, __get__errors;
    function Logger()
    {
        _logs = new Array();
        _errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.__get__logs());
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.__get__errors());
        };
    } // End of the function
    static function log(txt, sSource)
    {
        trace (txt);
        ank.utils.Logger.LC.send("loggerOut", "log", txt);
        if (txt.length < ank.utils.Logger.MAX_LOG_SIZE)
        {
            ank.utils.Logger._instance._logs.push(sSource == undefined ? (txt) : (sSource + " :\n" + txt));
        } // end if
        if (ank.utils.Logger._instance._logs.length > ank.utils.Logger.MAX_LOG_COUNT)
        {
            ank.utils.Logger._instance._logs.shift();
        } // end if
    } // End of the function
    static function err(txt)
    {
        txt = "ERROR : " + txt;
        trace (txt);
        ank.utils.Logger.LC.send("loggerOut", "err", txt);
        ank.utils.Logger._instance._errors.push(txt);
    } // End of the function
    static function get logs()
    {
        return (ank.utils.Logger._instance._logs.join("\n"));
    } // End of the function
    static function get errors()
    {
        return (ank.utils.Logger._instance._errors.join("\n"));
    } // End of the function
    static var LC = new LocalConnection();
    static var MAX_LOG_COUNT = 50;
    static var MAX_LOG_SIZE = 300;
    static var _instance = new ank.utils.Logger();
} // End of Class
#endinitclip
