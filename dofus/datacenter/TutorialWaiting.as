// Action script...

// [Initial MovieClip Action of sprite 894]
#initclip 106
class dofus.datacenter.TutorialWaiting extends dofus.datacenter.TutorialBloc
{
    var _nTimeout, _oCases, __get__cases, __get__timeout;
    function TutorialWaiting(sID, nTimeout, aCases)
    {
        super(sID, dofus.datacenter.TutorialBloc.TYPE_WAITING);
        _nTimeout = nTimeout;
        this.setCases(aCases);
    } // End of the function
    function get timeout()
    {
        return (_nTimeout == undefined ? (0) : (_nTimeout));
    } // End of the function
    function get cases()
    {
        return (_oCases);
    } // End of the function
    function setCases(aCases)
    {
        _oCases = new Object();
        for (var _loc2 = 0; _loc2 < aCases.length; ++_loc2)
        {
            var _loc3 = aCases[_loc2];
            var _loc4 = _loc3[0];
            var _loc6 = _loc3[1];
            var _loc5 = _loc3[2];
            var _loc7 = new dofus.datacenter.TutorialWaitingCase(_loc4, _loc6, _loc5);
            _oCases[_loc4] = _loc7;
        } // end of for
    } // End of the function
} // End of Class
#endinitclip
