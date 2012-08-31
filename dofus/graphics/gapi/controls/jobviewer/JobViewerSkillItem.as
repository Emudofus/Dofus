// Action script...

// [Initial MovieClip Action of sprite 1072]
#initclip 42
class dofus.graphics.gapi.controls.jobviewer.JobViewerSkillItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _mcArrow, _lblSkill, _lblSource, __height, _lblQuantity, _ctrIcon, _parent, addToQueue, __set__list;
    function JobViewerSkillItem()
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
            _mcArrow._visible = true;
            _lblSkill.__set__text(oItem.description);
            _lblSource.__set__text(oItem.interactiveObject == undefined ? ("") : (oItem.interactiveObject));
            _lblSkill.setSize(_lblSource.__get__width() - _lblSource.__get__textWidth() - 15, __height);
            if (oItem.item != undefined)
            {
                var _loc4;
                if (oItem.param1 == oItem.param2)
                {
                    _loc4 = "(#4s)  #1";
                }
                else
                {
                    _loc4 = "(#4s)  #1{~2 " + _mcList.gapi.api.lang.getText("TO") + " }#2";
                } // end else if
                _lblQuantity.__set__text(ank.utils.PatternDecoder.getDescription(_loc4, new Array(oItem.param1, oItem.param2, oItem.param3, Math.round(oItem.param4 / 100) / 10)));
                _ctrIcon.__set__contentData(oItem.item);
            }
            else
            {
                var _loc5 = _parent._parent._parent._parent;
                var _loc3 = ank.utils.PatternDecoder.combine(_mcList.gapi.api.lang.getText("SLOT"), "n", oItem.param1 < 2);
                _loc4 = "#1 " + _loc3 + " (#2%)";
                _lblQuantity.__set__text(ank.utils.PatternDecoder.getDescription(_loc4, new Array(oItem.param1, oItem.param4)));
                _ctrIcon.__set__contentData(undefined);
            } // end else if
        }
        else
        {
            _mcArrow._visible = false;
            _lblSource.__set__text("");
            _lblSkill.__set__text("");
            _lblQuantity.__set__text("");
            _ctrIcon.__set__contentData(undefined);
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
        this.addToQueue({object: this, method: addListeners});
    } // End of the function
    function addListeners()
    {
        _ctrIcon.addEventListener("over", this);
        _ctrIcon.addEventListener("out", this);
    } // End of the function
    function over(oEvent)
    {
        var _loc2 = oEvent.target.contentData;
        _mcList._parent._parent.gapi.showTooltip(_loc2.name, oEvent.target, -20);
    } // End of the function
    function out(oEvent)
    {
        _mcList._parent._parent.gapi.hideTooltip();
    } // End of the function
} // End of Class
#endinitclip
