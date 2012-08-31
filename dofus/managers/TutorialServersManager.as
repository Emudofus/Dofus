// Action script...

// [Initial MovieClip Action of sprite 890]
#initclip 102
class dofus.managers.TutorialServersManager extends dofus.managers.ServersManager
{
    var api, _aServersList, _nIndexMax, loadData, addToQueue;
    function TutorialServersManager()
    {
        super();
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        if (api.lang == undefined)
        {
            ank.utils.Logger.err("[TutorialServersManager] pas de fich de langue");
            return;
        } // end if
        _aServersList = api.lang.getConfigText("TUTORIALS_DATA_PATH");
        _nIndexMax = _aServersList.length - 1;
    } // End of the function
    function loadTutorial(sID)
    {
        this.loadData(sID + ".swf");
    } // End of the function
    function onComplete(mc)
    {
        api.ui.unloadUIComponent("CenterText");
        var _loc2 = new dofus.datacenter.Tutorial(mc);
        this.addToQueue({object: api.kernel.TutorialManager, method: api.kernel.TutorialManager.start, params: [_loc2]});
    } // End of the function
    function onError()
    {
        api.ui.unloadUIComponent("CenterText");
        this.addToQueue({object: api.kernel, method: api.kernel.showMessage, params: [undefined, api.lang.getText("NO_TUTORIALDATA_FILE"), "ERROR_CHAT"]});
        api.kernel.TutorialManager.terminate(0);
    } // End of the function
} // End of Class
#endinitclip
