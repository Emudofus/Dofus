// Action script...

// [Initial MovieClip Action of sprite 836]
#initclip 48
class dofus.managers.GameActionsManager extends dofus.utils.ApiElement
{
    var _data, _id, _bNextAction, _state, _currentType, api;
    function GameActionsManager(d, oAPI)
    {
        super();
        this.initialize(d, oAPI);
    } // End of the function
    function initialize(d, oAPI)
    {
        super.initialize(oAPI);
        _data = d;
        this.clear();
    } // End of the function
    function clear(Void)
    {
        _id = undefined;
        _bNextAction = false;
        _state = dofus.managers.GameActionsManager.STATE_READY;
        _currentType = null;
    } // End of the function
    function transmittingMove(type, params)
    {
        if (!this.isWaiting())
        {
            api.network.GameActions.sendActions(type, params);
            _state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
            _currentType = type;
        }
        else if (this.canCancel(type))
        {
            this.cancel(_data.cellNum);
            this.transmittingMove(type, params);
        }
        else
        {
            ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
        } // end else if
    } // End of the function
    function transmittingOther(type, params)
    {
        if (!this.isWaiting())
        {
            api.network.GameActions.sendActions(type, params);
            _state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
            _currentType = type;
        }
        else
        {
            ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci " + type + " " + params);
        } // end else if
    } // End of the function
    function onServerResponse(id)
    {
        _id = id;
        _state = dofus.managers.GameActionsManager.STATE_IN_PROGRESS;
    } // End of the function
    function cancel(params, bForceStatic)
    {
        _currentType = null;
        if (this.canCancel())
        {
            api.network.GameActions.actionCancel(_id, params);
            var _loc3 = _data.sequencer;
            var _loc2 = _data.mc;
            _loc3.clearAllNextActions();
            if (bForceStatic == true)
            {
                _loc3.addAction(false, _loc2, _loc2.setAnim, ["Static"]);
            } // end if
            this.clear();
        } // end if
    } // End of the function
    function end(bIAmSender)
    {
        if (_bNextAction == false || !bIAmSender)
        {
            this.clear();
        }
        else
        {
            _state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
            _id = undefined;
        } // end else if
    } // End of the function
    function ack(idAction)
    {
        api.network.GameActions.actionAck(idAction);
        this.end(true);
    } // End of the function
    function isWaiting(Void)
    {
        switch (_state)
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
    } // End of the function
    function canCancel(type)
    {
        if (type != _currentType)
        {
            return (false);
        } // end if
        if (_id == undefined)
        {
            return (false);
        } // end if
        switch (_state)
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
    } // End of the function
    static var STATE_TRANSMITTING = 2;
    static var STATE_IN_PROGRESS = 1;
    static var STATE_READY = 0;
} // End of Class
#endinitclip
