// Action script...

// [Initial MovieClip Action of sprite 20867]
#initclip 132
if (!dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerFeatsItem)
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
    if (!dofus.graphics.gapi.controls.alignmentviewer)
    {
        _global.dofus.graphics.gapi.controls.alignmentviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerFeatsItem = function ()
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
            this._ldrIcon.contentPath = oItem.iconFile;
            this._lblName.text = oItem.name + (oItem.level == undefined ? ("") : (" (" + this._mcList.gapi.api.lang.getText("LEVEL_SMALL") + " " + oItem.level + ")"));
            this._lblEffect.text = oItem.effect.description == undefined ? ("") : (oItem.effect.description);
        }
        else if (this._lblName.text != undefined)
        {
            this._ldrIcon.contentPath = "";
            this._lblName.text = "";
            this._lblEffect.text = "";
        } // end else if
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
