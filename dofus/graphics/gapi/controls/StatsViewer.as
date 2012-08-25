// Action script...

// [Initial MovieClip Action of sprite 20593]
#initclip 114
if (!dofus.graphics.gapi.controls.StatsViewer)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.StatsViewer = function ()
    {
        super();
    }).prototype;
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.StatsViewer.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.initTexts = function ()
    {
        this._winBg.title = this.api.lang.getText("ADVANCED_STATS");
        this._dgStats.columnsNames = [this.api.lang.getText("STAT_WORD"), this.api.lang.getText("BASE_WORD"), this.api.lang.getText("STUFF_WORD"), this.api.lang.getText("FEATS"), this.api.lang.getText("BOOST"), this.api.lang.getText("TOTAL_WORD")];
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Player.addEventListener("fullStatsChanged", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = this.api.datacenter.Player.FullStats;
        var _loc3 = new ank.utils.ExtendedArray();
        for (var k in _loc2)
        {
            _loc3.push({isCat: true, name: this.api.lang.getText("FULL_STATS_CAT" + k)});
            var _loc4 = new ank.utils.ExtendedArray();
            var _loc5 = 0;
            
            while (++_loc5, _loc5 < _loc2[k].length)
            {
                _loc4.push({name: this.api.lang.getText("FULL_STATS_ID" + _loc2[k][_loc5].id), s: _loc2[k][_loc5].s, i: _loc2[k][_loc5].i, d: _loc2[k][_loc5].d, b: _loc2[k][_loc5].b, o: Number(_loc2[k][_loc5].o), c: k, p: _loc2[k][_loc5].p});
            } // end while
            _loc4.sortOn("o", Array.NUMERIC);
            var _loc6 = _loc3.concat(_loc4);
            _loc3 = new ank.utils.ExtendedArray();
            _loc3.createFromArray(_loc6);
        } // end of for...in
        this._dgStats.dataProvider = _loc3;
    };
    _loc1.fullStatsChanged = function (oEvent)
    {
        this.initData();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.StatsViewer = function ()
    {
        super();
    }).CLASS_NAME = "StatsViewer";
} // end if
#endinitclip
