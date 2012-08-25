// Action script...

// [Initial MovieClip Action of sprite 20703]
#initclip 224
if (!dofus.graphics.gapi.controls.GuildMountParkViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.GuildMountParkViewer = function ()
    {
        super();
    }).prototype;
    _loc1.__set__mountParks = function (eaMountParks)
    {
        this.updateData(eaMountParks);
        //return (this.mountParks());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.GuildMountParkViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.initTexts = function ()
    {
        this._dgMountParks.columnsNames = [this.api.lang.getText("LOCALISATION"), this.api.lang.getText("MOUTPARK_ITEM"), this.api.lang.getText("MOUNTS")];
        this._lblDescription.text = this.api.lang.getText("GUILD_MOUNTPARKS_LIST");
    };
    _loc1.updateData = function (eaMountParks)
    {
        this._lblCount.text = this.api.lang.getText("GUILD_MOUNTPARKS_COUNT", [eaMountParks.length, this.api.datacenter.Player.guildInfos.maxMountParks]);
        eaMountParks.sortOn("size", Array.NUMERIC | Array.DESCENDING);
        this._dgMountParks.dataProvider = eaMountParks;
    };
    _loc1.addProperty("mountParks", function ()
    {
    }, _loc1.__set__mountParks);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.GuildMountParkViewer = function ()
    {
        super();
    }).CLASS_NAME = "GuildMountParkViewer";
} // end if
#endinitclip
