// Action script...

// [Initial MovieClip Action of sprite 20718]
#initclip 239
if (!dofus.graphics.gapi.controls.jobviewer.JobViewerSkillItem)
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
    if (!dofus.graphics.gapi.controls.jobviewer)
    {
        _global.dofus.graphics.gapi.controls.jobviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.jobviewer.JobViewerSkillItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._mcArrow._visible = true;
            this._lblSkill.text = oItem.description;
            this._lblSource.text = oItem.interactiveObject == undefined ? ("") : (oItem.interactiveObject);
            this._lblSkill.setSize(this._lblSource.width - this._lblSource.textWidth - 15, this.__height);
            if (oItem.item != undefined)
            {
                if (oItem.param1 == oItem.param2)
                {
                    var _loc5 = "(#4s)  #1";
                }
                else
                {
                    _loc5 = "(#4s)  #1{~2 " + this._mcList.gapi.api.lang.getText("TO_RANGE") + " }#2";
                } // end else if
                this._lblQuantity.text = ank.utils.PatternDecoder.getDescription(_loc5, new Array(oItem.param1, oItem.param2, oItem.param3, Math.round(oItem.param4 / 100) / 10));
                this._ctrIcon.contentData = oItem.item;
            }
            else
            {
                var _loc6 = this._parent._parent._parent._parent;
                var _loc7 = ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("SLOT"), "n", oItem.param1 < 2);
                var _loc8 = "#1 " + _loc7 + " (#2%)";
                this._lblQuantity.text = ank.utils.PatternDecoder.getDescription(_loc8, new Array(oItem.param1, oItem.param4));
                this._ctrIcon.contentData = undefined;
            } // end else if
        }
        else if (this._lblSource.text != undefined)
        {
            this._mcArrow._visible = false;
            this._lblSource.text = "";
            this._lblSkill.text = "";
            this._lblQuantity.text = "";
            this._ctrIcon.contentData = undefined;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcArrow._visible = false;
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._ctrIcon.addEventListener("over", this);
        this._ctrIcon.addEventListener("out", this);
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        this._mcList._parent._parent.gapi.showTooltip(_loc3.name, oEvent.target, -20);
    };
    _loc1.out = function (oEvent)
    {
        this._mcList._parent._parent.gapi.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
