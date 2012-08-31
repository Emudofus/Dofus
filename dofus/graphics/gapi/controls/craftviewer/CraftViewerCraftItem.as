// Action script...

// [Initial MovieClip Action of sprite 1071]
#initclip 41
class dofus.graphics.gapi.controls.craftviewer.CraftViewerCraftItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _ldrItemIcon, _lblItemName, _lblSkill, addToQueue, __set__list;
    function CraftViewerCraftItem()
    {
        super();
    } // End of the function
    function set list(mcList)
    {
        _mcList = mcList;
        //return (this.list());
        null;
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _ldrItemIcon.__set__contentPath(oItem.craftItem.iconFile);
            _lblItemName.__set__text(oItem.craftItem.name + " (" + _mcList._parent.api.lang.getText("LEVEL_SMALL") + " " + oItem.craftItem.level + ")");
            _lblSkill.__set__text("(" + oItem.skill.description + " " + _mcList._parent.api.lang.getText("ON") + " " + oItem.skill.interactiveObject + ")");
            var _loc5 = oItem.items;
            var _loc4 = _loc5.length;
            for (var _loc2 = 0; _loc2 < _loc4; ++_loc2)
            {
                var _loc3 = _loc5[_loc2];
                this["_ctr" + _loc2]._visible = true;
                this["_ctr" + _loc2].contentData = _loc3;
                this["_lblPlus" + _loc2]._visible = true;
            } // end of for
            for (var _loc2 = _loc4; _loc2 < 8; ++_loc2)
            {
                this["_ctr" + _loc2]._visible = false;
                this["_lblPlus" + _loc2]._visible = false;
            } // end of for
        }
        else
        {
            _ldrItemIcon.__set__contentPath("");
            _lblItemName.__set__text("");
            _lblSkill.__set__text("");
            for (var _loc2 = 0; _loc2 < 8; ++_loc2)
            {
                this["_ctr" + _loc2]._visible = false;
                this["_lblPlus" + _loc2]._visible = false;
            } // end of for
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function size()
    {
        super.size();
    } // End of the function
    function addListeners()
    {
        for (var _loc2 = 0; _loc2 < 8; ++_loc2)
        {
            this["_ctr" + _loc2].addEventListener("over", this);
            this["_ctr" + _loc2].addEventListener("out", this);
        } // end of for
    } // End of the function
    function setContainerContentData(nIndex, oItem)
    {
        this["_ctr" + nIndex].contentData = oItem;
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = oEvent.target.contentData;
        _mcList._parent.gapi.showTooltip("x" + _loc2.Quantity + " - " + _loc2.name, oEvent.target, -20);
    } // End of the function
    function out(oEvent)
    {
        _mcList._parent.gapi.hideTooltip();
    } // End of the function
} // End of Class
#endinitclip
