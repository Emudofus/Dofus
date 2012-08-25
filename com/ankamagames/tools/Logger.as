// Action script...

// [Initial MovieClip Action of sprite 20592]
#initclip 113
if (!com.ankamagames.tools.Logger)
{
    if (!com)
    {
        _global.com = new Object();
    } // end if
    if (!com.ankamagames)
    {
        _global.com.ankamagames = new Object();
    } // end if
    if (!com.ankamagames.tools)
    {
        _global.com.ankamagames.tools = new Object();
    } // end if
    var _loc1 = (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).prototype;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).initialize = function ()
    {
        com.ankamagames.tools.Logger.instance = new com.ankamagames.tools.Logger();
    };
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).out = function ()
    {
        var _loc2 = arguments[0];
        var _loc3 = arguments[arguments.length - 3];
        var _loc4 = arguments[arguments.length - 2];
        var _loc5 = arguments[arguments.length - 1];
        var _loc6 = arguments.length > 4 ? (arguments[1]) : (undefined);
        if (_loc6 == 666)
        {
            _loc6 = com.ankamagames.tools.Logger.LEVEL_FUNCTION_CALL;
        } // end if
        var _loc7 = new String(_loc2);
        if (_loc7.toUpperCase().indexOf("[EXCEPTION]") == 0)
        {
            _loc7 = _loc7.substr(12);
            _loc6 = com.ankamagames.tools.Logger.LEVEL_EXCEPTION;
        }
        else if (_loc7.toUpperCase().indexOf("[WTF]") == 0)
        {
            _loc7 = _loc7.substr(5);
            _loc6 = com.ankamagames.tools.Logger.LEVEL_WIP;
        }
        else if (_loc7.indexOf("[?!!]") == 0)
        {
            _loc7 = _loc7.substr(5);
            _loc6 = com.ankamagames.tools.Logger.LEVEL_WHAT_TEH_FKCU;
        } // end else if
        com.ankamagames.tools.Logger.instance.trace(_loc7, _loc6);
    };
    _loc1.connect = function ()
    {
        this._socket = new XMLSocket();
        this._connected = false;
        this._socket.onConnect = function (success)
        {
            var _loc3 = arguments.callee.tracer;
            _loc3.onConnected(success);
        };
        this._socket.onClose = function ()
        {
            var _loc2 = arguments.callee.tracer;
            _loc2.onSocketClose();
        };
        this._socket.onConnect.tracer = this;
        this._socket.connect(com.ankamagames.tools.Logger.SERVER_HOST, com.ankamagames.tools.Logger.SERVER_PORT);
    };
    _loc1.trace = function (message, color)
    {
        if (this._connected)
        {
            this._socket.send("!SOS<showMessage key=\"KeyColor" + color + "\"><![CDATA[" + message + "]]></showMessage>");
        }
        else
        {
            var _loc4 = new Array();
            _loc4[0] = color;
            _loc4[1] = message;
            this._buffer.push(_loc4);
        } // end else if
    };
    _loc1.onSocketClose = function ()
    {
        if (this._nCurrentReconnection < com.ankamagames.tools.Logger.MAX_RECONNECTION_COUNT)
        {
            this.connect();
            ++this._nCurrentReconnection;
        } // end if
    };
    _loc1.onConnected = function (success)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < com.ankamagames.tools.Logger.LEVELS_LIST.length)
        {
            this._socket.send("!SOS<setKey><name>KeyColor" + com.ankamagames.tools.Logger.LEVELS_LIST[_loc3] + "</name><color>" + com.ankamagames.tools.Logger.LEVELS_LIST[_loc3] + "</color></setKey>");
        } // end while
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._buffer.length)
        {
            this._socket.send("!SOS<showMessage key=\"KeyColor" + this._buffer[_loc4][0] + "\"><![CDATA[" + this._buffer[_loc4][1] + "]]></showMessage>");
        } // end while
        this._connected = true;
        this._nCurrentReconnection = 0;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).SERVER_HOST = "localhost";
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).SERVER_PORT = 4444;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_STANDARD = 16777215;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_NETWORK = 13421772;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_GOOD = 39219;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_MEDIUM = 16750848;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_EXCEPTION = 16711680;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_WIP = 6723993;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_WHAT_TEH_FKCU = 16711935;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVEL_FUNCTION_CALL = 11190271;
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).LEVELS_LIST = [com.ankamagames.tools.Logger.LEVEL_STANDARD, com.ankamagames.tools.Logger.LEVEL_NETWORK, com.ankamagames.tools.Logger.LEVEL_GOOD, com.ankamagames.tools.Logger.LEVEL_MEDIUM, com.ankamagames.tools.Logger.LEVEL_EXCEPTION, com.ankamagames.tools.Logger.LEVEL_WIP, com.ankamagames.tools.Logger.LEVEL_WHAT_TEH_FKCU, com.ankamagames.tools.Logger.LEVEL_FUNCTION_CALL];
    (_global.com.ankamagames.tools.Logger = function ()
    {
        this._buffer = new Array();
        this.connect();
    }).MAX_RECONNECTION_COUNT = 10;
    _loc1._nCurrentReconnection = 0;
} // end if
#endinitclip
