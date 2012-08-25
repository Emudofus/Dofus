// Action script...

// [Initial MovieClip Action of sprite 20924]
#initclip 189
if (!dofus.graphics.gapi.ui.PayZoneDialog)
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
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).prototype;
    _loc1.__set__id = function (nNpcID)
    {
        this._nNpcID = nNpcID;
        //return (this.id());
    };
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__set__gfx = function (sGfx)
    {
        this._sGfx = sGfx;
        //return (this.gfx());
    };
    _loc1.__set__dialogID = function (nDialogID)
    {
        this._nDialogID = nDialogID;
        this.addToQueue({object: this, method: this.setDialog, params: [nDialogID]});
        //return (this.dialogID());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.PayZoneDialog.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Dialog.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.setNpcCharacteristics});
        this.gapi.unloadLastUIAutoHideComponent();
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
    };
    _loc1.setNpcCharacteristics = function ()
    {
        this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._sGfx + ".swf";
        this._winBackgroundUp.title = this._sName;
    };
    _loc1.setDialog = function (nIndex)
    {
        var _loc3 = new Object();
        _loc3.responses = new ank.utils.ExtendedArray();
        switch (nIndex)
        {
            case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_INFOS:
            {
                _loc3.label = this.api.lang.getText("PAYZONE_INFOS");
                _loc3.responses.push({label: this.api.lang.getText("YES"), id: dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES});
                _loc3.responses.push({label: this.api.lang.getText("NO"), id: dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO});
                break;
            } 
            case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS:
            {
                _loc3.label = this.api.lang.getText("PAYZONE_DETAILS");
                _loc3.responses.push({label: this.api.lang.getText("PAYZONE_BE_MEMBER"), id: dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER});
                break;
            } 
            default:
            {
                _loc3.label = this.api.lang.getText("PAYZONE_MSG_" + this._nDialogID) + "\n\n" + this.api.lang.getText("PAYZONE_BASE");
                _loc3.responses.push({label: this.api.lang.getText("PAYZONE_MORE_INFOS"), id: dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS});
                break;
            } 
        } // End of switch
        this.setQuestion(_loc3);
    };
    _loc1.setQuestion = function (oQuestion)
    {
        if (this._qvQuestionViewer == undefined)
        {
            this.attachMovie("QuestionViewer", "_qvQuestionViewer", 10, {_x: this._mcQuestionViewer._x, _y: this._mcQuestionViewer._y, question: oQuestion, isFirstQuestion: true});
            this._qvQuestionViewer.addEventListener("response", this);
            this._qvQuestionViewer.addEventListener("resize", this);
        }
        else
        {
            this._qvQuestionViewer.isFirstQuestion = true;
            this._qvQuestionViewer.question = oQuestion;
        } // end else if
    };
    _loc1.closeDialog = function ()
    {
        this.callClose();
    };
    _loc1.response = function (oEvent)
    {
        switch (oEvent.response.id)
        {
            case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES:
            {
                this.setDialog(dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS);
                break;
            } 
            case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO:
            {
                this.unloadThis();
                break;
            } 
            case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER:
            {
                this.getURL(this.api.lang.getConfigText("PAY_LINK"), "_blank");
                this.unloadThis();
                break;
            } 
            case dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS:
            {
                this.getURL(this.api.lang.getConfigText("MEMBERS_LINK"), "_blank");
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.resize = function (oEvent)
    {
        this._winBackground.setSize(undefined, oEvent.target.height + (oEvent.target._y - this._winBackground._y) + 12);
        this._winBackgroundUp.setSize(undefined, oEvent.target.height + (oEvent.target._y - this._winBackground._y) + 10);
    };
    _loc1.addProperty("dialogID", function ()
    {
    }, _loc1.__set__dialogID);
    _loc1.addProperty("gfx", function ()
    {
    }, _loc1.__set__gfx);
    _loc1.addProperty("id", function ()
    {
    }, _loc1.__set__id);
    _loc1.addProperty("name", function ()
    {
    }, _loc1.__set__name);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).CLASS_NAME = "PayZoneDialog";
    (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).PAYZONE_INFOS = 1;
    (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).PAYZONE_DETAILS = 2;
    (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).PAYZONE_YES = 0;
    (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).PAYZONE_NO = 1;
    (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).PAYZONE_BE_MEMBER = 2;
    (_global.dofus.graphics.gapi.ui.PayZoneDialog = function ()
    {
        super();
    }).PAYZONE_MORE_INFOS = 4;
} // end if
#endinitclip
