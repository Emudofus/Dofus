// Action script...

// [Initial MovieClip Action of sprite 20869]
#initclip 134
if (!ank.utils.Sequencer)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.Sequencer = function (timeout)
    {
        super();
        this.initialize(timeout);
    }).prototype;
    _loc1.initialize = function (nTimeout)
    {
        this._nTimeout = nTimeout == undefined ? (10000) : (nTimeout);
        this._unicID = String(getTimer()) + random(10000);
        this._nActionIndex = 0;
        this.clear();
    };
    _loc1.clear = function (Void)
    {
        this._aActions = new Array();
        this._bPlaying = false;
        this._nTimeModerator = 1;
        ank.utils.Timer.removeTimer(this, "sequencer");
    };
    _loc1.setTimeModerator = function (nTimeModerator)
    {
        this._nTimeModerator = nTimeModerator;
    };
    _loc1.addAction = function (bWaitEnd, mRefObject, fFunction, aParams, nDuration)
    {
        var _loc7 = new Object();
        _loc7.id = this.getActionIndex();
        _loc7.waitEnd = bWaitEnd;
        _loc7.object = mRefObject;
        _loc7.fn = fFunction;
        _loc7.parameters = aParams;
        _loc7.duration = nDuration;
        this._aActions.push(_loc7);
    };
    _loc1.execute = function (bForced)
    {
        if (this._bPlaying && bForced == undefined)
        {
            return;
        } // end if
        this._bPlaying = true;
        var _loc3 = true;
        while (_loc3)
        {
            if (this._aActions.length > 0)
            {
                var _loc4 = this._aActions[0];
                if (_loc4.waitEnd)
                {
                    _loc4.object[this._unicID] = _loc4.id;
                } // end if
                _loc4.fn.apply(_loc4.object, _loc4.parameters);
                if (!_loc4.waitEnd)
                {
                    this.onActionEnd(true);
                }
                else
                {
                    _loc3 = false;
                    ank.utils.Timer.setTimer(_loc4.object, "sequencer", this, this.onActionTimeOut, _loc4.duration != undefined ? (_loc4.duration * this._nTimeModerator) : (this._nTimeout), [_loc4.id]);
                } // end else if
                continue;
            } // end if
            _loc3 = false;
            this.stop();
        } // end while
    };
    _loc1.stop = function ()
    {
        this._bPlaying = false;
    };
    _loc1.isPlaying = function ()
    {
        return (this._bPlaying);
    };
    _loc1.clearAllNextActions = function (Void)
    {
        this._aActions.splice(1);
        ank.utils.Timer.removeTimer(this, "sequencer");
    };
    _loc1.onActionTimeOut = function (nActionID)
    {
        if (nActionID != undefined && this._aActions[0].id != nActionID)
        {
            return;
        } // end if
        this.onActionEnd(false);
    };
    _loc1.onActionEnd = function (bDontCallExecute)
    {
        if (this._aActions.length == 0)
        {
            return;
        } // end if
        if (this._aActions[0].waitEnd)
        {
            ank.utils.Timer.removeTimer(this._aActions[0].object, "sequencer");
        } // end if
        this._aActions.shift();
        if (this._aActions.length == 0)
        {
            this.clear();
            this.onSequenceEnd();
        }
        else if (bDontCallExecute != true)
        {
            if (this._bPlaying)
            {
                this.execute(true);
            } // end if
        } // end else if
    };
    _loc1.toString = function ()
    {
        return ("Sequencer unicID:" + this._unicID + " playing:" + this._bPlaying + " actionsCount:" + this._aActions.length + " currentActionID:" + this._aActions[0].id + " currentActionObject:" + this._aActions[0].object);
    };
    _loc1.getActionIndex = function (Void)
    {
        ++this._nActionIndex;
        if (this._nActionIndex > 10000)
        {
            this._nActionIndex = 0;
        } // end if
        return (this._nActionIndex);
    };
    ASSetPropFlags(_loc1, null, 1);
    _loc1._nTimeModerator = 1;
} // end if
#endinitclip
