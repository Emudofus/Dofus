// Action script...

// [Initial MovieClip Action of sprite 825]
#initclip 37
class dofus.graphics.gapi.controls.ItemSetViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oItemSet, __get__initialized, __get__itemSet, addToQueue, _btnClose, api, _lblEffects, _lblItems, _winBg, _txtDescription, _lstEffects, _visible, dispatchEvent, gapi, __set__itemSet;
    function ItemSetViewer()
    {
        super();
    } // End of the function
    function set itemSet(oItemSet)
    {
        _oItemSet = oItemSet;
        if (this.__get__initialized())
        {
            this.updateData();
        } // end if
        //return (this.itemSet());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.ItemSetViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: updateData});
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        for (var _loc2 = 1; _loc2 <= 8; ++_loc2)
        {
            var _loc3 = this["_ctr" + _loc2];
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
        } // end of for
    } // End of the function
    function initTexts()
    {
        _lblEffects.__set__text(api.lang.getText("ITEMSET_EFFECTS"));
        _lblItems.__set__text(api.lang.getText("ITEMSET_EQUIPED_ITEMS"));
    } // End of the function
    function updateData()
    {
        if (_oItemSet != undefined)
        {
            var _loc6 = _oItemSet.items;
            _winBg.__set__title(_oItemSet.name);
            _txtDescription.__set__text(_oItemSet.description);
            var _loc5 = _oItemSet.itemCount == undefined ? (8) : (_oItemSet.itemCount);
            for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
            {
                var _loc3 = _loc6[_loc2];
                var _loc4 = this["_ctr" + (_loc2 + 1)];
                _loc4._visible = true;
                _loc4.__set__contentData(_loc3.item);
                _loc4.__set__borderRenderer(_loc3.isEquiped ? ("ItemSetViewerItemBorderNone") : ("ItemSetViewerItemBorder"));
            } // end of for
            _lstEffects.__set__dataProvider(_oItemSet.effects);
            for (var _loc2 = _loc5 + 1; _loc2 <= 8; ++_loc2)
            {
                _loc4 = this["_ctr" + _loc2];
                _loc4._visible = false;
            } // end of for
            _visible = true;
        }
        else
        {
            ank.utils.Logger.err("[ItemSetViewer] le set n\'est pas défini");
            _visible = false;
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnClose":
            {
                this.dispatchEvent({type: "close"});
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_ctr1":
            case "_ctr2":
            case "_ctr3":
            case "_ctr4":
            case "_ctr5":
            case "_ctr6":
            case "_ctr7":
            case "_ctr8":
            {
                var _loc2 = oEvent.target.contentData;
                gapi.showTooltip(_loc2.name, oEvent.target, -20, undefined, _loc2.style + "ToolTip");
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "ItemSetViewer";
    static var NO_TRANSFORM = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
    static var INACTIVE_TRANSFORM = {ra: 50, rb: 0, ga: 50, gb: 0, ba: 50, bb: 0};
} // End of Class
#endinitclip
