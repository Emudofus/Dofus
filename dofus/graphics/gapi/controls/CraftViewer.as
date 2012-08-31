// Action script...

// [Initial MovieClip Action of sprite 985]
#initclip 202
class dofus.graphics.gapi.controls.CraftViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _oJob, addToQueue, __get__job, _lstCrafts, _btnSlot0, _btnSlot1, _btnSlot2, _btnSlot3, _btnSlot4, _btnSlot5, _btnSlot6, _btnSlot7, api, _lblCrafts, _lblFilter, _lblNoCraft, gapi, __set__job;
    function CraftViewer()
    {
        super();
    } // End of the function
    function set job(oJob)
    {
        _oJob = oJob;
        this.addToQueue({object: this, method: layoutContent});
        //return (this.job());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.CraftViewer.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _lstCrafts._visible = false;
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initTexts});
    } // End of the function
    function addListeners()
    {
        _btnSlot0.addEventListener("click", this);
        _btnSlot1.addEventListener("click", this);
        _btnSlot2.addEventListener("click", this);
        _btnSlot3.addEventListener("click", this);
        _btnSlot4.addEventListener("click", this);
        _btnSlot5.addEventListener("click", this);
        _btnSlot6.addEventListener("click", this);
        _btnSlot7.addEventListener("click", this);
        _btnSlot0.addEventListener("over", this);
        _btnSlot1.addEventListener("over", this);
        _btnSlot2.addEventListener("over", this);
        _btnSlot3.addEventListener("over", this);
        _btnSlot4.addEventListener("over", this);
        _btnSlot5.addEventListener("over", this);
        _btnSlot6.addEventListener("over", this);
        _btnSlot7.addEventListener("over", this);
        _btnSlot0.addEventListener("out", this);
        _btnSlot1.addEventListener("out", this);
        _btnSlot2.addEventListener("out", this);
        _btnSlot3.addEventListener("out", this);
        _btnSlot4.addEventListener("out", this);
        _btnSlot5.addEventListener("out", this);
        _btnSlot6.addEventListener("out", this);
        _btnSlot7.addEventListener("out", this);
    } // End of the function
    function initTexts()
    {
        _lblCrafts.__set__text(api.lang.getText("RECEIPTS"));
        _lblFilter.__set__text(api.lang.getText("FILTER"));
    } // End of the function
    function layoutContent()
    {
        var _loc4 = api.datacenter.Basics.craftViewer_filter;
        _btnSlot0.__set__selected(_loc4[0]);
        _btnSlot1.__set__selected(_loc4[1]);
        _btnSlot2.__set__selected(_loc4[2]);
        _btnSlot3.__set__selected(_loc4[3]);
        _btnSlot4.__set__selected(_loc4[4]);
        _btnSlot5.__set__selected(_loc4[5]);
        _btnSlot6.__set__selected(_loc4[6]);
        _btnSlot7.__set__selected(_loc4[7]);
        if (_oJob == undefined)
        {
            return;
        } // end if
        var _loc5 = _oJob.crafts;
        var _loc6 = new ank.utils.ExtendedArray();
        for (var _loc2 = 0; _loc2 < _loc5.length; ++_loc2)
        {
            var _loc3 = _loc5[_loc2];
            if (_loc4[_loc3.itemsCount - 1])
            {
                _loc6.push(_loc3);
            } // end if
        } // end of for
        if (_loc6.length != 0)
        {
            _lstCrafts._visible = true;
            _lstCrafts.__set__dataProvider(_loc6);
        }
        else
        {
            _lstCrafts._visible = false;
            _lblNoCraft.__set__text(api.lang.getText("NO_CRAFT_AVAILABLE"));
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        var _loc3 = api.datacenter.Basics.craftViewer_filter;
        var _loc2 = Number(oEvent.target._name.substr(8));
        _loc3[_loc2] = oEvent.target.selected;
        this.layoutContent();
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = Number(oEvent.target._name.substr(8)) + 1;
        gapi.showTooltip(api.lang.getText("CRAFT_SLOT_FILTER", [_loc2]), oEvent.target, -20);
    } // End of the function
    function out(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "CraftViewer";
} // End of Class
#endinitclip
