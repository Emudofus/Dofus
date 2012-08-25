// Action script...

// [Initial MovieClip Action of sprite 20978]
#initclip 243
if (!ank.utils.Logger)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).prototype;
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).log = function (txt, sSource)
    {
        ank.utils.Logger.LC.send("loggerOut", "log", txt);
        if (txt.length < ank.utils.Logger.MAX_LOG_SIZE)
        {
            ank.utils.Logger._instance._logs.push(sSource == undefined ? (txt) : (sSource + " :\n" + txt));
        } // end if
        if (ank.utils.Logger._instance._logs.length > ank.utils.Logger.MAX_LOG_COUNT)
        {
            ank.utils.Logger._instance._logs.shift();
        } // end if
    };
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).err = function (txt)
    {
        txt = "ERROR : " + txt;
        ank.utils.Logger.LC.send("loggerOut", "err", txt);
        ank.utils.Logger._instance._errors.push(txt);
    };
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).__get__logs = function ()
    {
        return (ank.utils.Logger._instance._logs.join("\n"));
    };
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).__get__errors = function ()
    {
        return (ank.utils.Logger._instance._errors.join("\n"));
    };
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).addProperty("errors", (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).__get__errors, function ()
    {
    });
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).addProperty("logs", (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).__get__logs, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).LC = new LocalConnection();
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).MAX_LOG_COUNT = 50;
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    }).MAX_LOG_SIZE = 300;
    (_global.ank.utils.Logger = function ()
    {
        this._logs = new Array();
        this._errors = new Array();
        ank.utils.Logger.LC.connect("loggerIn");
        ank.utils.Logger.LC.getLogs = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "log", ank.utils.Logger.logs);
        };
        ank.utils.Logger.LC.getErrors = function ()
        {
            ank.utils.Logger.LC.send("loggerOut", "err", ank.utils.Logger.errors);
        };
    })._instance = new ank.utils.Logger();
} // end if
#endinitclip
