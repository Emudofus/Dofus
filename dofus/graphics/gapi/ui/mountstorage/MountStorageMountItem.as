// Action script...

// [Initial MovieClip Action of sprite 20489]
#initclip 10
if (!dofus.graphics.gapi.ui.mountstorage.MountStorageMountItem)
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
    if (!dofus.graphics.gapi.ui.mountstorage)
    {
        _global.dofus.graphics.gapi.ui.mountstorage = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.mountstorage.MountStorageMountItem = function ()
    {
        super();
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._lbl.text = oItem.name;
            this._oItem = (dofus.datacenter.Mount)(oItem);
            if (this._oItem.newBorn)
            {
                this._ldrNewMount.contentPath = "OeufCasse";
            }
            else
            {
                this._ldrNewMount.contentPath = "";
            } // end else if
            this._ldrIcon.contentPath = dofus.Constants.GUILDS_MINI_PATH + oItem.gfxID + ".swf";
            this._mcSexMan._visible = !oItem.sex;
            this._mcSexWoman._visible = !this._mcSexMan._visible;
        }
        else if (this._lbl.text != undefined)
        {
            this._lbl.text = "";
            this._ldrIcon.contentPath = "";
            this._ldrNewMount.contentPath = "";
            this._mcSexMan._visible = false;
            this._mcSexWoman._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.arrange();
    };
    _loc1.addListeners = function ()
    {
        this._ldrIcon.addEventListener("complete", this);
    };
    _loc1.size = function ()
    {
        super.size();
        this.addToQueue({object: this, method: this.arrange});
    };
    _loc1.arrange = function ()
    {
        this._lbl.setSize(this.__width, this.__height);
    };
    _loc1.applyRideColor = function (mc, zone)
    {
        var _loc4 = this._oItem["color" + zone];
        if (_loc4 == -1 || _loc4 == undefined)
        {
            return;
        } // end if
        var _loc5 = (_loc4 & 16711680) >> 16;
        var _loc6 = (_loc4 & 65280) >> 8;
        var _loc7 = _loc4 & 255;
        var _loc8 = new Color(mc);
        var _loc9 = new Object();
        _loc9 = {ra: 0, ga: 0, ba: 0, rb: _loc5, gb: _loc6, bb: _loc7};
        _loc8.setTransform(_loc9);
    };
    _loc1.complete = function (oEvent)
    {
        var ref = this;
        this._ldrIcon.content.applyRideColor = function (mc, z)
        {
            ref.applyRideColor(mc, z);
        };
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
