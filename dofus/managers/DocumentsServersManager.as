// Action script...

// [Initial MovieClip Action of sprite 20728]
#initclip 249
if (!dofus.managers.DocumentsServersManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.DocumentsServersManager = function ()
    {
        super();
        dofus.managers.DocumentsServersManager._sSelf = this;
    }).prototype;
    (_global.dofus.managers.DocumentsServersManager = function ()
    {
        super();
        dofus.managers.DocumentsServersManager._sSelf = this;
    }).getInstance = function ()
    {
        return (dofus.managers.DocumentsServersManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI, "docs", "docs/");
    };
    _loc1.loadDocument = function (sID)
    {
        this.loadData(sID + ".swf");
    };
    _loc1.getDocumentObject = function (mc)
    {
        return (new dofus.datacenter.Document(mc));
    };
    _loc1.onComplete = function (mc)
    {
        var _loc3 = this.getDocumentObject(mc);
        this.addToQueue({object: this.api.ui, method: this.api.ui.loadUIComponent, params: [_loc3.uiType, "Document", {document: _loc3}]});
    };
    _loc1.onFailed = function ()
    {
        this.addToQueue({object: this.api.kernel, method: this.api.kernel.showMessage, params: [undefined, this.api.lang.getText("NO_DOCUMENTDATA_FILE"), "ERROR_BOX", {name: "NoMapData"}]});
        this.api.network.Documents.leave();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.DocumentsServersManager = function ()
    {
        super();
        dofus.managers.DocumentsServersManager._sSelf = this;
    })._sSelf = null;
} // end if
#endinitclip
