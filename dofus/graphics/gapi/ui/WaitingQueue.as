// Action script...

// [Initial MovieClip Action of sprite 20692]
#initclip 213
if (!dofus.graphics.gapi.ui.WaitingQueue)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.WaitingQueue = function ()
    {
        super();
        this._btnLeaveQueue._visible = false;
    }).prototype;
    _loc1.__set__queueInfos = function (oQueueInfos)
    {
        this._oQueueInfos = oQueueInfos;
        //return (this.queueInfos());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.WaitingQueue.CLASS_NAME);
        if (this.api.datacenter.Basics.aks_is_free_community)
        {
            this._btnSubscribe._visible = false;
        } // end if
    };
    _loc1.createChildren = function ()
    {
        if (this._oQueueInfos == undefined)
        {
            return;
        } // end if
        this._btnSubscribe._visible = false;
        this._btnLeaveQueue._visible = false;
        this.addToQueue({object: this, method: this.initButton});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initButton = function ()
    {
        this._btnSubscribe.addEventListener("click", this);
        this._btnLeaveQueue.addEventListener("click", this);
        this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
        this._btnLeaveQueue.label = this.api.lang.getText("WAIT_QUEUE_LEAVE");
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.lang.getServerInfos(this._oQueueInfos.queueId).n;
        if (_loc2 != undefined)
        {
            this._lblWhite3.text = this._lblBlackTL3.text = this._lblBlackTR3.text = this._lblBlackBL3.text = this._lblBlackBR3.text = this.api.lang.getText("WAITING_FOR_CONNECTION_ON", [_loc2]);
        }
        else
        {
            this._lblWhite3.text = this._lblBlackTL3.text = this._lblBlackTR3.text = this._lblBlackBL3.text = this._lblBlackBR3.text = this.api.lang.getText("WAITING_FOR_CONNECTION");
        } // end else if
        if (this._oQueueInfos.subscriber == true || this.api.datacenter.Basics.aks_is_free_community)
        {
            this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this.api.lang.getText("WAIT_QUEUE_ABO_MSG1", [this._oQueueInfos.position, this._oQueueInfos.totalAbo]);
            this._lblWhite2.text = this._lblBlackTL2.text = this._lblBlackTR2.text = this._lblBlackBL2.text = this._lblBlackBR2.text = this.api.lang.getText("WAIT_QUEUE_ABO_MSG2", [this._oQueueInfos.totalNonAbo]);
        }
        else if (this._oQueueInfos.subscriber == false)
        {
            this._btnSubscribe._visible = true;
            this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this.api.lang.getText("WAIT_QUEUE_NON_ABO_MSG1", [this._oQueueInfos.position - this._oQueueInfos.totalAbo, this._oQueueInfos.totalNonAbo]);
            this._lblWhite2.text = this._lblBlackTL2.text = this._lblBlackTR2.text = this._lblBlackBL2.text = this._lblBlackBR2.text = this.api.lang.getText("WAIT_QUEUE_NON_ABO_MSG2", [this._oQueueInfos.totalAbo]);
        }
        else
        {
            this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this.api.lang.getText("WAIT_QUEUE_POSITION", [this._oQueueInfos.position]);
        } // end else if
        if (this._oQueueInfos.queueId > -1 && this.api.lang.getConfigText("ENABLE_LEAVE_QUEUE"))
        {
            this._btnLeaveQueue._visible = true;
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnSubscribe":
            {
                _root.getURL(this.api.lang.getConfigText("PAY_LINK"), "_blank");
                break;
            } 
            case "_btnLeaveQueue":
            {
                this.api.kernel.changeServer();
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("queueInfos", function ()
    {
    }, _loc1.__set__queueInfos);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.WaitingQueue = function ()
    {
        super();
        this._btnLeaveQueue._visible = false;
    }).CLASS_NAME = "WaitingQueue";
} // end if
#endinitclip
