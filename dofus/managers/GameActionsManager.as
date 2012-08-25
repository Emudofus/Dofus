// Action script...

// [Initial MovieClip Action of sprite 20564]
#initclip 85
if (!dofus.managers.GameActionsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.GameActionsManager = function (d, oAPI)
    {
        super();
        this.initialize(d, oAPI);
    }).prototype;
    _loc1.initialize = function (d, oAPI)
    {
        super.initialize(oAPI);
        this._data = d;
        this.clear();
    };
    _loc1.clear = function (Void)
    {
        this._id = undefined;
        this._bNextAction = false;
        this._state = dofus.managers.GameActionsManager.STATE_READY;
        this._currentType = null;
    };
    _loc1.transmittingMove = function (type, params)
    {
        if (!this.isWaiting())
        {
            this.api.network.GameActions.sendActions(type, params);
            this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
            this._currentType = type;
        }
        else if (this.canCancel(type))
        {
            this.cancel(this._data.cellNum);
            this.transmittingMove(type, params);
        }
        else
        {
            ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
        } // end else if
    };
    _loc1.transmittingOther = function (type, params)
    {
        if (!this.isWaiting())
        {
            this.api.network.GameActions.sendActions(type, params);
            this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
            this._currentType = type;
        }
        else
        {
            ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci " + type + " " + params);
        } // end else if
    };
    _loc1.onServerResponse = function (id)
    {
        this._id = id;
        this._state = dofus.managers.GameActionsManager.STATE_IN_PROGRESS;
    };
    _loc1.cancel = function (params, bForceStatic)
    {
        this._currentType = null;
        if (this.canCancel())
        {
            this.api.network.GameActions.actionCancel(this._id, params);
            var _loc4 = this._data.sequencer;
            var _loc5 = this._data.mc;
            _loc4.clearAllNextActions();
            if (bForceStatic == true)
            {
                _loc4.addAction(false, _loc5, _loc5.setAnim, ["Static"]);
            } // end if
            this.clear();
        } // end if
    };
    _loc1.end = function (bIAmSender)
    {
        if (this._bNextAction == false || !bIAmSender)
        {
            this.clear();
        }
        else
        {
            this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
            this._id = undefined;
        } // end else if
    };
    _loc1.ack = function (idAction)
    {
        this.api.network.GameActions.actionAck(idAction);
        this.end(true);
    };
    _loc1.isWaiting = function (Void)
    {
        switch (this._state)
        {
            case dofus.managers.GameActionsManager.STATE_READY:
            {
                return (false);
            } 
            case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
            case dofus.managers.GameActionsManager.STATE_IN_PROGRESS:
            {
                return (true);
            } 
        } // End of switch
        return (false);
    };
    _loc1.canCancel = function (type)
    {
        if (type != this._currentType)
        {
            return (false);
        } // end if
        if (this._id == undefined)
        {
            return (false);
        } // end if
        switch (this._state)
        {
            case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
            {
                return (false);
            } 
            case dofus.managers.GameActionsManager.STATE_READY:
            case dofus.managers.GameActionsManager.STATE_IN_PROGRESS:
            {
                return (true);
            } 
        } // End of switch
        return (false);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.GameActionsManager = function (d, oAPI)
    {
        super();
        this.initialize(d, oAPI);
    }).STATE_TRANSMITTING = 2;
    (_global.dofus.managers.GameActionsManager = function (d, oAPI)
    {
        super();
        this.initialize(d, oAPI);
    }).STATE_IN_PROGRESS = 1;
    (_global.dofus.managers.GameActionsManager = function (d, oAPI)
    {
        super();
        this.initialize(d, oAPI);
    }).STATE_READY = 0;
} // end if
#endinitclip
