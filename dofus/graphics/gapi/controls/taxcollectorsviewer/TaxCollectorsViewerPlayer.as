// Action script...

// [Initial MovieClip Action of sprite 20882]
#initclip 147
if (!dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerPlayer)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls.taxcollectorsviewer)
    {
        _global.dofus.graphics.gapi.controls.taxcollectorsviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerPlayer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__data = function (oData)
    {
        if (oData != this._oData)
        {
            this._oData = oData;
            this.addToQueue({object: this, method: this.setSprite});
        } // end if
        //return (this.data());
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._ldrSprite.addEventListener("initialization", this);
    };
    _loc1.setSprite = function ()
    {
        this._ldrSprite.contentPath = this._oData.gfxFile == undefined ? ("") : (this._oData.gfxFile);
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.clip;
        _global.GAC.addSprite(_loc3, this._oData);
        _loc3.attachMovie("staticR", "mcAnim", 10);
        _loc3._xscale = -80;
        _loc3._yscale = 80;
    };
    _loc1.addProperty("data", function ()
    {
    }, _loc1.__set__data);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
