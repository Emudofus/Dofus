// Action script...

// [Initial MovieClip Action of sprite 20510]
#initclip 31
if (!dofus.managers.TutorialServersManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.TutorialServersManager = function ()
    {
        super();
        dofus.managers.TutorialServersManager._sSelf = this;
    }).prototype;
    (_global.dofus.managers.TutorialServersManager = function ()
    {
        super();
        dofus.managers.TutorialServersManager._sSelf = this;
    }).getInstance = function ()
    {
        return (dofus.managers.TutorialServersManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI, "tutorials", "tutorials/");
    };
    _loc1.loadTutorial = function (sID)
    {
        this.loadData(sID + ".swf");
    };
    _loc1.onComplete = function (mc)
    {
        var _loc3 = new dofus.datacenter.Tutorial(mc);
        this.addToQueue({object: this.api.kernel.TutorialManager, method: this.api.kernel.TutorialManager.start, params: [_loc3]});
    };
    _loc1.onFailed = function ()
    {
        this.addToQueue({object: this.api.kernel, method: this.api.kernel.showMessage, params: [undefined, this.api.lang.getText("NO_TUTORIALDATA_FILE"), "ERROR_CHAT"]});
        this.api.kernel.TutorialManager.terminate(0);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.TutorialServersManager = function ()
    {
        super();
        dofus.managers.TutorialServersManager._sSelf = this;
    })._sSelf = null;
} // end if
#endinitclip
