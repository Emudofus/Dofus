// Action script...

// [Initial MovieClip Action of sprite 20503]
#initclip 24
if (!dofus.graphics.gapi.controls.SpouseViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.SpouseViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__spouse = function (oSpouse)
    {
        this._oSpouse = oSpouse;
        if (this.initialized)
        {
            this.updateData();
        } // end if
        //return (this.spouse());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.SpouseViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.initTexts});
        this._mcInFight._visible = false;
    };
    _loc1.addListeners = function ()
    {
        this._btnJoin.addEventListener("click", this);
        this._btnCompass.addEventListener("click", this);
    };
    _loc1.initData = function ()
    {
        this.updateData();
    };
    _loc1.initTexts = function ()
    {
        this._btnJoin.label = this.api.lang.getText("JOIN_SMALL");
        if (this._oSpouse.isFollow)
        {
            this._btnCompass.label = this.api.lang.getText("STOP_FOLLOW");
        }
        else
        {
            this._btnCompass.label = this.api.lang.getText("FOLLOW");
        } // end else if
        this._lblPosition.text = this.api.lang.getText("LOCALISATION");
    };
    _loc1.updateData = function ()
    {
        if (this._oSpouse != undefined)
        {
            this._winBg.title = ank.utils.PatternDecoder.combine(this.api.lang.getText("SPOUSE"), this._oSpouse.sex, true);
            this._lblSpouse.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("SPOUSE"), this._oSpouse.sex, true);
            this._lblName.text = this._oSpouse.name;
            this.api.colors.addSprite(this._ldrArtwork, this._oSpouse);
            this._ldrArtwork.contentPath = dofus.Constants.GUILDS_FACES_PATH + this._oSpouse.gfx + ".swf";
            if (this._oSpouse.isConnected && this._lblCoordinates.text != undefined)
            {
                this._mcInFight._visible = this._oSpouse.isInFight;
                this._lblLevel.text = _global.isNaN(this._oSpouse.level) ? ("") : (this.api.lang.getText("LEVEL") + " " + this._oSpouse.level);
                this._lblArea.text = this.api.kernel.MapsServersManager.getMapName(this._oSpouse.mapID);
                this._lblCoordinates.text = "";
                this._btnJoin.enabled = !this.api.datacenter.Game.isFight;
                this._btnCompass.enabled = true;
            }
            else if (this._lblLevel.text != undefined)
            {
                this._mcInFight._visible = false;
                this._lblLevel.text = "";
                this._lblArea.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("SPOUSE_NOT_CONNECTED"), this._oSpouse.sex, true);
                this._lblCoordinates.text = "";
                this._btnJoin.enabled = false;
                this._btnCompass.enabled = false;
            } // end if
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnJoin:
            {
                if (!this.api.datacenter.Game.isFight)
                {
                    this.api.network.Friends.join("S");
                } // end if
                break;
            } 
            case this._btnCompass:
            {
                if (this._oSpouse.isConnected)
                {
                    if (this._oSpouse.isFollow)
                    {
                        this.api.network.Friends.compass(true);
                    }
                    else
                    {
                        this.api.network.Friends.compass(false);
                    } // end else if
                    this._oSpouse.isFollow = !this._oSpouse.isFollow;
                    this.initTexts();
                } // end if
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("spouse", function ()
    {
    }, _loc1.__set__spouse);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.SpouseViewer = function ()
    {
        super();
    }).CLASS_NAME = "SpouseViewer";
} // end if
#endinitclip
