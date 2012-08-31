// Action script...

// [Initial MovieClip Action of sprite 891]
#initclip 103
class dofus.datacenter.Tutorial extends Object
{
    var _oBlocs, _sRootBlocID, _sRootExitBlocID, _bCanCancel, __get__canCancel;
    function Tutorial(mcData)
    {
        super();
        _oBlocs = new Object();
        this.setData(mcData.actions);
        _sRootBlocID = mcData.rootBlocID;
        _sRootExitBlocID = mcData.rootExitBlocID;
        _bCanCancel = mcData.canCancel == undefined ? (true) : (mcData.canCancel);
    } // End of the function
    function get canCancel()
    {
        return (_bCanCancel);
    } // End of the function
    function addBloc(oBloc)
    {
        _oBlocs[oBloc.id] = oBloc;
    } // End of the function
    function setData(aBlocs)
    {
        for (var _loc3 = 0; _loc3 < aBlocs.length; ++_loc3)
        {
            var _loc2 = aBlocs[_loc3];
            var _loc5 = Number(_loc2[0]);
            switch (_loc5)
            {
                case dofus.datacenter.TutorialBloc.TYPE_ACTION:
                {
                    var _loc12 = _loc2[1];
                    var _loc14 = _loc2[2];
                    var _loc8 = _loc2[3];
                    var _loc6 = _loc2[4];
                    var _loc15 = _loc2[5];
                    var _loc16 = new dofus.datacenter.TutorialAction(_loc12, _loc14, _loc8, _loc6, _loc15);
                    this.addBloc(_loc16);
                    break;
                } 
                case dofus.datacenter.TutorialBloc.TYPE_WAITING:
                {
                    _loc12 = _loc2[1];
                    var _loc11 = Number(_loc2[2]);
                    var _loc13 = _loc2[3];
                    _loc16 = new dofus.datacenter.TutorialWaiting(_loc12, _loc11, _loc13);
                    this.addBloc(_loc16);
                    break;
                } 
                case dofus.datacenter.TutorialBloc.TYPE_IF:
                {
                    _loc12 = _loc2[1];
                    var _loc4 = _loc2[2];
                    var _loc17 = _loc2[3];
                    var _loc9 = _loc2[4];
                    var _loc7 = _loc2[5];
                    var _loc10 = _loc2[6];
                    _loc16 = new dofus.datacenter.TutorialIf(_loc12, _loc4, _loc17, _loc9, _loc7, _loc10);
                    this.addBloc(_loc16);
                    break;
                } 
            } // End of switch
        } // end of for
    } // End of the function
    function getRootBloc()
    {
        return (_oBlocs[_sRootBlocID]);
    } // End of the function
    function getRootExitBloc()
    {
        return (_oBlocs[_sRootExitBlocID]);
    } // End of the function
    function getBloc(sBlocID)
    {
        return (_oBlocs[sBlocID]);
    } // End of the function
    static var NORMAL_BLOC = 0;
    static var EXIT_BLOC = 1;
} // End of Class
#endinitclip
