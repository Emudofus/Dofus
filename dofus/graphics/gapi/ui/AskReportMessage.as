// Action script...

// [Initial MovieClip Action of sprite 20530]
#initclip 51
if (!dofus.graphics.gapi.ui.AskReportMessage)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.AskReportMessage = function ()
    {
        super();
    }).prototype;
    _loc1.__get__message = function ()
    {
        return (this._sMessage);
    };
    _loc1.__set__message = function (msg)
    {
        this._sMessage = msg;
        //return (this.message());
    };
    _loc1.__get__messageId = function ()
    {
        return (this._sMessageId);
    };
    _loc1.__set__messageId = function (id)
    {
        this._sMessageId = id;
        //return (this.messageId());
    };
    _loc1.__get__channelId = function ()
    {
        return (this._sChannelId);
    };
    _loc1.__set__channelId = function (id)
    {
        this._sChannelId = id;
        //return (this.channelId());
    };
    _loc1.__get__authorId = function ()
    {
        return (this._sCharacterId);
    };
    _loc1.__set__authorId = function (id)
    {
        this._sCharacterId = id;
        //return (this.authorId());
    };
    _loc1.__get__authorName = function ()
    {
        return (this._sCharacterName);
    };
    _loc1.__set__authorName = function (name)
    {
        this._sCharacterName = name;
        //return (this.authorName());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.AskReportMessage.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._btnCancel.addEventListener("click", this);
        this._btnOk.addEventListener("click", this);
    };
    _loc1.initTexts = function ()
    {
        this._winBackground.title = this.api.lang.getText("REPORT_A_SENTANCE");
        this._lblGonnaReport.text = this.api.lang.getText("GONNA_REPORT_THIS_MESSAGE");
        this._lblReason.text = this.api.lang.getText("REASON_WORD") + ":";
        this._lblIgnoreToo.text = this.api.lang.getText("BLACKLIST_MESSAGE_AUTHOR");
        this._btnOk.label = this.api.lang.getText("VALIDATE");
        this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
    };
    _loc1.initData = function ()
    {
        this._taMessage.text = this._sMessage.split("<br/>").join("");
        this._btnIgnoreToo.selected = true;
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = this.api.lang.getAbuseReasons();
        _loc2.push({id: -1, label: "(" + this.api.lang.getText("PLEASE_SELECT") + ")"});
        for (var i in _loc3)
        {
            _loc2.push({id: _loc3[i].i, label: _loc3[i].t});
        } // end of for...in
        this._cbReason.dataProvider = _loc2;
        this._cbReason.selectedIndex = 0;
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnOk:
            {
                if (this._cbReason.selectedItem.id > 0)
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("REPORT_MESSAGE_CONFIRMATION"), "CAUTION_YESNO", {name: "ReportMessage", listener: this});
                }
                else
                {
                    this.api.kernel.showMessage(this.api.lang.getText("ERROR_WORD"), this.api.lang.getText("ERROR_MUST_SELECT_A_REASON"), "ERROR_BOX");
                } // end else if
                break;
            } 
            case this._btnCancel:
            {
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.yes = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoReportMessage":
            {
                var _loc3 = this._sMessage.substring(this._sMessage.indexOf(": ") + 7, this._sMessage.indexOf("</font>"));
                this.api.network.Chat.reportMessage(this._sCharacterName, this._sMessageId, _loc3, this._cbReason.selectedItem.id);
                if (this._btnIgnoreToo.selected)
                {
                    this.api.kernel.ChatManager.addToBlacklist(this._sCharacterName);
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("TEMPORARY_BLACKLISTED_AND_REPORTED", [this._sCharacterName]), "INFO_CHAT");
                }
                else
                {
                    this.api.kernel.showMessage(undefined, this.api.lang.getText("REPORTED", [this._sCharacterName]), "INFO_CHAT");
                } // end else if
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.no = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "AskYesNoReportMessage":
            {
                this.unloadThis();
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("channelId", _loc1.__get__channelId, _loc1.__set__channelId);
    _loc1.addProperty("messageId", _loc1.__get__messageId, _loc1.__set__messageId);
    _loc1.addProperty("authorName", _loc1.__get__authorName, _loc1.__set__authorName);
    _loc1.addProperty("message", _loc1.__get__message, _loc1.__set__message);
    _loc1.addProperty("authorId", _loc1.__get__authorId, _loc1.__set__authorId);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.AskReportMessage = function ()
    {
        super();
    }).CLASS_NAME = "AskReportMessage";
} // end if
#endinitclip
