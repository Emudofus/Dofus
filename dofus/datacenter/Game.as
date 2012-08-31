// Action script...

// [Initial MovieClip Action of sprite 920]
#initclip 132
class dofus.datacenter.Game extends Object
{
    var _nPlayerCount, __get__playerCount, _sCurrentPlayerID, __get__currentPlayerID, _sLastPlayerID, __get__lastPlayerID, _nState, __get__state, _bSpectator, __get__isSpectator, _aTurnSequence, __get__turnSequence, _oResults, __get__results, _bInCreaturesMode, __get__isInCreaturesMode, __get__isRunning, _nInteractionType, __set__currentPlayerID, __get__interactionType, __get__isFight, __set__isInCreaturesMode, __set__isRunning, __set__isSpectator, __set__lastPlayerID, __set__playerCount, __set__results, __set__state, __set__turnSequence;
    function Game()
    {
        super();
        this.initialize();
    } // End of the function
    function set playerCount(nPlayerCount)
    {
        _nPlayerCount = Number(nPlayerCount);
        //return (this.playerCount());
        null;
    } // End of the function
    function get playerCount()
    {
        return (_nPlayerCount);
    } // End of the function
    function set currentPlayerID(sCurrentPlayerID)
    {
        _sCurrentPlayerID = sCurrentPlayerID;
        //return (this.currentPlayerID());
        null;
    } // End of the function
    function get currentPlayerID()
    {
        return (_sCurrentPlayerID);
    } // End of the function
    function set lastPlayerID(sLastPlayerID)
    {
        _sLastPlayerID = sLastPlayerID;
        //return (this.lastPlayerID());
        null;
    } // End of the function
    function get lastPlayerID()
    {
        return (_sLastPlayerID);
    } // End of the function
    function set state(nState)
    {
        _nState = Number(nState);
        //return (this.state());
        null;
    } // End of the function
    function get state()
    {
        return (_nState);
    } // End of the function
    function set isSpectator(bSpectator)
    {
        _bSpectator = bSpectator;
        //return (this.isSpectator());
        null;
    } // End of the function
    function get isSpectator()
    {
        return (_bSpectator);
    } // End of the function
    function set turnSequence(aTurnSequence)
    {
        _aTurnSequence = aTurnSequence;
        //return (this.turnSequence());
        null;
    } // End of the function
    function get turnSequence()
    {
        return (_aTurnSequence);
    } // End of the function
    function set results(oResults)
    {
        _oResults = oResults;
        //return (this.results());
        null;
    } // End of the function
    function get results()
    {
        return (_oResults);
    } // End of the function
    function set isInCreaturesMode(bInCreaturesMode)
    {
        _bInCreaturesMode = bInCreaturesMode;
        //return (this.isInCreaturesMode());
        null;
    } // End of the function
    function get isInCreaturesMode()
    {
        return (_bInCreaturesMode);
    } // End of the function
    function set isRunning(bRunning)
    {
        _bRunning = bRunning;
        //return (this.isRunning());
        null;
    } // End of the function
    function get isRunning()
    {
        return (_bRunning);
    } // End of the function
    function get isFight()
    {
        return (_nState > 1 && _nState != undefined);
    } // End of the function
    function get interactionType()
    {
        return (_nInteractionType);
    } // End of the function
    function initialize()
    {
        _bRunning = false;
        _nPlayerCount = 0;
        _sCurrentPlayerID = null;
        _sLastPlayerID = null;
        _nState = 0;
        _aTurnSequence = new Array();
        _oResults = new Object();
        _nInteractionType = 0;
        _bInCreaturesMode = false;
    } // End of the function
    function setInteractionType(sType)
    {
        switch (sType)
        {
            case "move":
            {
                _nInteractionType = 1;
                break;
            } 
            case "spell":
            {
                _nInteractionType = 2;
                break;
            } 
            case "cc":
            {
                _nInteractionType = 3;
                break;
            } 
            case "place":
            {
                _nInteractionType = 4;
                break;
            } 
            case "target":
            {
                _nInteractionType = 5;
                break;
            } 
        } // End of switch
    } // End of the function
    var _bRunning = false;
} // End of Class
#endinitclip
