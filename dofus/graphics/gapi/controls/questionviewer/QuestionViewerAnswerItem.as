// Action script...

// [Initial MovieClip Action of sprite 20704]
#initclip 225
if (!dofus.graphics.gapi.controls.questionviewer.QuestionViewerAnswerItem)
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
    if (!dofus.graphics.gapi.controls.questionviewer)
    {
        _global.dofus.graphics.gapi.controls.questionviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.questionviewer.QuestionViewerAnswerItem = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._mcRound._visible = true;
            this._txtResponse.text = oItem.label;
        }
        else if (this._txtResponse.text != undefined)
        {
            this._mcRound._visible = false;
            this._txtResponse.text = "";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcRound._visible = false;
    };
    _loc1.size = function ()
    {
        super.size();
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
