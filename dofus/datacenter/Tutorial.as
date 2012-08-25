// Action script...

// [Initial MovieClip Action of sprite 20831]
#initclip 96
if (!dofus.datacenter.Tutorial)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Tutorial = function (mcData)
    {
        super();
        this._oBlocs = new Object();
        this.setData(mcData.actions);
        this._sRootBlocID = mcData.rootBlocID;
        this._sRootExitBlocID = mcData.rootExitBlocID;
        this._bCanCancel = mcData.canCancel == undefined ? (true) : (mcData.canCancel);
    }).prototype;
    _loc1.__get__canCancel = function ()
    {
        return (this._bCanCancel);
    };
    _loc1.addBloc = function (oBloc)
    {
        this._oBlocs[oBloc.id] = oBloc;
    };
    _loc1.setData = function (aBlocs)
    {
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < aBlocs.length)
        {
            var _loc4 = aBlocs[_loc3];
            var _loc5 = Number(_loc4[0]);
            switch (_loc5)
            {
                case dofus.datacenter.TutorialBloc.TYPE_ACTION:
                {
                    var _loc6 = _loc4[1];
                    var _loc7 = _loc4[2];
                    var _loc8 = _loc4[3];
                    var _loc9 = _loc4[4];
                    var _loc10 = _loc4[5];
                    var _loc11 = new dofus.datacenter.TutorialAction(_loc6, _loc7, _loc8, _loc9, _loc10);
                    this.addBloc(_loc11);
                    break;
                } 
                case dofus.datacenter.TutorialBloc.TYPE_WAITING:
                {
                    var _loc12 = _loc4[1];
                    var _loc13 = Number(_loc4[2]);
                    var _loc14 = _loc4[3];
                    var _loc15 = new dofus.datacenter.TutorialWaiting(_loc12, _loc13, _loc14);
                    this.addBloc(_loc15);
                    break;
                } 
                case dofus.datacenter.TutorialBloc.TYPE_IF:
                {
                    var _loc16 = _loc4[1];
                    var _loc17 = _loc4[2];
                    var _loc18 = _loc4[3];
                    var _loc19 = _loc4[4];
                    var _loc20 = _loc4[5];
                    var _loc21 = _loc4[6];
                    var _loc22 = new dofus.datacenter.TutorialIf(_loc16, _loc17, _loc18, _loc19, _loc20, _loc21);
                    this.addBloc(_loc22);
                    break;
                } 
            } // End of switch
        } // end while
    };
    _loc1.getRootBloc = function ()
    {
        return (this._oBlocs[this._sRootBlocID]);
    };
    _loc1.getRootExitBloc = function ()
    {
        return (this._oBlocs[this._sRootExitBlocID]);
    };
    _loc1.getBloc = function (sBlocID)
    {
        return (this._oBlocs[sBlocID]);
    };
    _loc1.addProperty("canCancel", _loc1.__get__canCancel, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.Tutorial = function (mcData)
    {
        super();
        this._oBlocs = new Object();
        this.setData(mcData.actions);
        this._sRootBlocID = mcData.rootBlocID;
        this._sRootExitBlocID = mcData.rootExitBlocID;
        this._bCanCancel = mcData.canCancel == undefined ? (true) : (mcData.canCancel);
    }).NORMAL_BLOC = 0;
    (_global.dofus.datacenter.Tutorial = function (mcData)
    {
        super();
        this._oBlocs = new Object();
        this.setData(mcData.actions);
        this._sRootBlocID = mcData.rootBlocID;
        this._sRootExitBlocID = mcData.rootExitBlocID;
        this._bCanCancel = mcData.canCancel == undefined ? (true) : (mcData.canCancel);
    }).EXIT_BLOC = 1;
} // end if
#endinitclip
