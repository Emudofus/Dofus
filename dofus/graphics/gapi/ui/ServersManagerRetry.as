// Action script...

// [Initial MovieClip Action of sprite 20524]
#initclip 45
if (!dofus.graphics.gapi.ui.ServersManagerRetry)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.ServersManagerRetry = function ()
    {
        super();
    }).prototype;
    _loc1.__set__timer = function (nTimer)
    {
        this.addToQueue({object: this, method: function (n)
        {
            this._nTimer = Number(n);
            if (this.initialized)
            {
                this.updateLabel();
            } // end if
        }, params: [nTimer]});
        //return (this.timer());
    };
    _loc1.updateLabel = function ()
    {
        var _loc2 = this.api.lang.getText("SERVERS_MANAGER_RETRY", [this._nTimer]);
        this._lblCounter.text = _loc2;
        this._lblCounterShadow.text = _loc2;
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.ServersManagerRetry.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.updateLabel});
    };
    _loc1.addProperty("timer", function ()
    {
    }, _loc1.__set__timer);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.ServersManagerRetry = function ()
    {
        super();
    }).CLASS_NAME = "ServersManagerRetry";
    _loc1._nTimer = 0;
} // end if
#endinitclip
