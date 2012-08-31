// Action script...

// [Initial MovieClip Action of sprite 1042]
#initclip 9
class dofus.graphics.gapi.controls.TaxCollectorsViewer extends ank.gapi.core.UIAdvancedComponent
{
    var __get__taxCollectors, addToQueue, api, _dgTaxCollectors, _lblDescription, _lblHowDefend, _lblCount, __set__taxCollectors;
    function TaxCollectorsViewer()
    {
        super();
    } // End of the function
    function set taxCollectors(eaTaxCollectors)
    {
        this.updateData(eaTaxCollectors);
        //return (this.taxCollectors());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.TaxCollectorsViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
    } // End of the function
    function initTexts()
    {
        _dgTaxCollectors.__set__columnsNames(["", api.lang.getText("NAME_BIG") + " / " + api.lang.getText("LOCALISATION"), api.lang.getText("ATTACKERS_SMALL"), api.lang.getText("DEFENDERS")]);
        _lblDescription.__set__text(api.lang.getText("GUILD_TAXCOLLECTORS_LIST"));
        _lblHowDefend.__set__text(api.lang.getText("HELP_HOW_DEFEND_TAX"));
    } // End of the function
    function updateData(eaTaxCollectors)
    {
        _lblCount.__set__text(String(eaTaxCollectors.length) + " " + ank.utils.PatternDecoder.combine(api.lang.getText("TAXCOLLECTORS"), "m", eaTaxCollectors.length < 2));
        eaTaxCollectors.sortOn("state", Array.NUMERIC | Array.DESCENDING);
        _dgTaxCollectors.__set__dataProvider(eaTaxCollectors);
    } // End of the function
    static var CLASS_NAME = "TaxCollectorsViewer";
} // End of Class
#endinitclip
