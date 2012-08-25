// Action script...

// [Initial MovieClip Action of sprite 20985]
#initclip 250
if (!dofus.aks.Tutorial)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.aks)
    {
        _global.dofus.aks = new Object();
    } // end if
    var _loc1 = (_global.dofus.aks.Tutorial = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).prototype;
    _loc1.end = function (nActionListID, nCellNum, nDir)
    {
        if (nActionListID == undefined)
        {
            nActionListID = 0;
        } // end if
        if (nCellNum == undefined || nDir == undefined)
        {
            this.aks.send("TV" + String(nActionListID), false);
        }
        else
        {
            this.aks.send("TV" + String(nActionListID) + "|" + String(nCellNum) + "|" + String(nDir), false);
        } // end else if
    };
    _loc1.onShowTip = function (sExtraData)
    {
        var _loc3 = Number(sExtraData);
        this.api.kernel.TipsManager.showNewTip(_loc3);
    };
    _loc1.onCreate = function (sExtraData)
    {
        var _loc3 = sExtraData.split("|");
        var _loc4 = _loc3[0];
        var _loc5 = _loc3[1];
        var _loc6 = this.api.config.language;
        this.api.kernel.TutorialServersManager.loadTutorial(_loc4 + "_" + _loc5);
    };
    _loc1.onGameBegin = function ()
    {
        var _loc2 = new ank.utils.Sequencer((this.api.config.isStreaming ? (dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN_LIGHT) : (dofus.aks.Tutorial.INTRO_CINEMATIC_MAX_LEN)) * 1000);
        dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT = dofus.Constants.CINEMATICS_PATH + "9_" + this.api.config.language + ".swf";
        _loc2.addAction(false, this.api.sounds, this.api.sounds.stopAllSounds);
        if (!this.api.config.isStreaming)
        {
            _loc2.addAction(true, this.api.ui, this.api.ui.loadUIComponent, ["Cinematic", "Cinematic", {file: this.api.config.isStreaming ? (dofus.aks.Tutorial.INTRO_CINEMATIC_PATH_LIGHT) : (dofus.aks.Tutorial.INTRO_CINEMATIC_PATH), sequencer: _loc2}, {bUltimateOnTop: true}]);
        } // end if
        _loc2.addAction(false, this.api.ui, this.api.ui.loadUIComponent, ["AskGameBegin", "AskGameBegin", undefined, {bAlwaysOnTop: true}]);
        _loc2.addAction(false, this.api.sounds, this.api.sounds.playMusic, [dofus.aks.Tutorial.NOOB_AREA_MUSIC_ID, true]);
        this.addToQueue({object: _loc2, method: _loc2.execute, params: [true]});
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.aks.Tutorial = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).INTRO_CINEMATIC_PATH = dofus.Constants.CINEMATICS_PATH + "8.swf";
    (_global.dofus.aks.Tutorial = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).INTRO_CINEMATIC_MAX_LEN = 120;
    (_global.dofus.aks.Tutorial = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).INTRO_CINEMATIC_PATH_LIGHT = "";
    (_global.dofus.aks.Tutorial = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).INTRO_CINEMATIC_MAX_LEN_LIGHT = 120;
    (_global.dofus.aks.Tutorial = function (oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    }).NOOB_AREA_MUSIC_ID = 129;
} // end if
#endinitclip
