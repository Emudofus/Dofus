// Action script...

// [Initial MovieClip Action of sprite 20515]
#initclip 36
if (!dofus.graphics.gapi.controls.TaxCollectorsViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.TaxCollectorsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__taxCollectors = function (eaTaxCollectors)
    {
        this.updateData(eaTaxCollectors);
        //return (this.taxCollectors());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.TaxCollectorsViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.initTexts = function ()
    {
        this._dgTaxCollectors.columnsNames = ["", this.api.lang.getText("NAME_BIG") + " / " + this.api.lang.getText("LOCALISATION"), this.api.lang.getText("ATTACKERS_SMALL"), this.api.lang.getText("DEFENDERS")];
        this._lblDescription.text = this.api.lang.getText("GUILD_TAXCOLLECTORS_LIST");
        this._lblHowDefend.text = this.api.lang.getText("HELP_HOW_DEFEND_TAX");
    };
    _loc1.updateData = function (eaTaxCollectors)
    {
        this._lblCount.text = String(eaTaxCollectors.length) + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("TAXCOLLECTORS"), "m", eaTaxCollectors.length < 2);
        eaTaxCollectors.sortOn("state", Array.NUMERIC | Array.DESCENDING);
        this._dgTaxCollectors.dataProvider = eaTaxCollectors;
    };
    _loc1.addProperty("taxCollectors", function ()
    {
    }, _loc1.__set__taxCollectors);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.TaxCollectorsViewer = function ()
    {
        super();
    }).CLASS_NAME = "TaxCollectorsViewer";
} // end if
#endinitclip
