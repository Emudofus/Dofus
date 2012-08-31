// Action script...

// [Initial MovieClip Action of sprite 834]
#initclip 46
class ank.utils.Sequencer extends Object
{
    var _nTimeout, _unicID, _nActionIndex, _aActions, _bPlaying, onSequenceEnd;
    function Sequencer(timeout)
    {
        super();
        this.initialize(timeout);
    } // End of the function
    function initialize(nTimeout)
    {
        _nTimeout = nTimeout == undefined ? (10000) : (nTimeout);
        _unicID = String(getTimer()) + random(10000);
        _nActionIndex = 0;
        this.clear();
    } // End of the function
    function clear(Void)
    {
        _aActions = new Array();
        _bPlaying = false;
        ank.utils.Timer.removeTimer(this, "sequencer");
    } // End of the function
    function addAction(bWaitEnd, mRefObject, fFunction, aParams, nDuration)
    {
        var _loc2 = new Object();
        _loc2.id = this.getActionIndex();
        _loc2.waitEnd = bWaitEnd;
        _loc2.object = mRefObject;
        _loc2.fn = fFunction;
        _loc2.parameters = aParams;
        _loc2.duration = nDuration;
        _aActions.push(_loc2);
    } // End of the function
    function execute(bForced)
    {
        if (_bPlaying && bForced == undefined)
        {
            return;
        } // end if
        _bPlaying = true;
        var _loc3 = true;
        while (_loc3)
        {
            if (_aActions.length > 0)
            {
                var _loc2 = _aActions[0];
                if (_loc2.waitEnd)
                {
                    _loc2.object[_unicID] = _loc2.id;
                } // end if
                _loc2.fn.apply(_loc2.object, _loc2.parameters);
                if (!_loc2.waitEnd)
                {
                    this.onActionEnd(true);
                }
                else
                {
                    _loc3 = false;
                    ank.utils.Timer.setTimer(_loc2.object, "sequencer", this, onActionTimeOut, _loc2.duration != undefined ? (_loc2.duration) : (_nTimeout), [_loc2.id]);
                } // end else if
                continue;
            } // end if
            _loc3 = false;
            this.stop();
        } // end while
    } // End of the function
    function stop()
    {
        _bPlaying = false;
    } // End of the function
    function isPlaying()
    {
        return (_bPlaying);
    } // End of the function
    function clearAllNextActions(Void)
    {
        _aActions.splice(1);
        ank.utils.Timer.removeTimer(this, "sequencer");
    } // End of the function
    function onActionTimeOut(nActionID)
    {
        if (nActionID != undefined && _aActions[0].id != nActionID)
        {
            return;
        } // end if
        this.onActionEnd(false);
    } // End of the function
    function onActionEnd(bDontCallExecute)
    {
        if (_aActions.length == 0)
        {
            return;
        } // end if
        if (_aActions[0].waitEnd)
        {
            ank.utils.Timer.removeTimer(_aActions[0].object, "sequencer");
        } // end if
        _aActions.shift();
        if (_aActions.length == 0)
        {
            this.clear();
            this.onSequenceEnd();
        }
        else if (bDontCallExecute != true)
        {
            if (_bPlaying)
            {
                this.execute(true);
            } // end if
        } // end else if
    } // End of the function
    function getActionIndex(Void)
    {
        ++_nActionIndex;
        if (_nActionIndex > 10000)
        {
            _nActionIndex = 0;
        } // end if
        return (_nActionIndex);
    } // End of the function
} // End of Class
#endinitclip
