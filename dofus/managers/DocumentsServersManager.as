// Action script...

// [Initial MovieClip Action of sprite 888]
#initclip 100
class dofus.managers.DocumentsServersManager extends dofus.managers.ServersManager
{
    var api, _aServersList, _nIndexMax, loadData, addToQueue;
    function DocumentsServersManager()
    {
        super();
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        if (api.lang == undefined)
        {
            ank.utils.Logger.err("[DocumentsServersManager] pas de fich de langue");
            return;
        } // end if
        _aServersList = api.lang.getConfigText("DOCUMENTS_DATA_PATH");
        _nIndexMax = _aServersList.length - 1;
    } // End of the function
    function loadDocument(sID)
    {
        this.loadData(sID + ".swf");
    } // End of the function
    function onComplete(mc)
    {
        api.ui.unloadUIComponent("CenterText");
        var _loc2 = new dofus.datacenter.Document(mc);
        this.addToQueue({object: api.ui, method: api.ui.loadUIComponent, params: [_loc2.uiType, "Document", {document: _loc2}]});
    } // End of the function
    function onError()
    {
        api.ui.unloadUIComponent("CenterText");
        this.addToQueue({object: api.kernel, method: api.kernel.showMessage, params: [undefined, api.lang.getText("NO_DOCUMENTDATA_FILE"), "ERROR_BOX", {name: "NoMapData"}]});
        api.network.Documents.leave();
    } // End of the function
} // End of Class
#endinitclip
