// Action script...

// [Initial MovieClip Action of sprite 20772]
#initclip 37
if (!dofus.graphics.gapi.controls.Smileys)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.Smileys = function ()
    {
        super();
    }).prototype;
    _loc1.update = function ()
    {
        this.initData();
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.Smileys.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._cgSmileys.addEventListener("selectItem", this);
        this._cgEmotes.addEventListener("selectItem", this);
        this._cgEmotes.addEventListener("overItem", this);
        this._cgEmotes.addEventListener("outItem", this);
        this._ldrStreaming.addEventListener("initialization", this);
    };
    _loc1.initData = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        if (this.api.config.isStreaming)
        {
            this._ldrStreaming.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "all.swf";
        }
        else
        {
            var _loc3 = 1;
            
            while (++_loc3, _loc3 <= 15)
            {
                var _loc4 = new Object();
                _loc4.iconFile = dofus.Constants.SMILEYS_ICONS_PATH + _loc3 + ".swf";
                _loc4.index = _loc3;
                _loc2.push(_loc4);
            } // end while
            this._cgSmileys.dataProvider = _loc2;
        } // end else if
        var _loc5 = new ank.utils.ExtendedArray();
        var _loc6 = this.api.datacenter.Player.Emotes.getItems();
        for (var k in _loc6)
        {
            var _loc7 = new Object();
            var _loc8 = Number(k);
            _loc7.iconFile = dofus.Constants.EMOTES_ICONS_PATH + _loc8 + ".swf";
            _loc7.index = _loc8;
            _loc5.push(_loc7);
            _loc5.sortOn("index", Array.NUMERIC);
        } // end of for...in
        this._cgEmotes.dataProvider = _loc5;
    };
    _loc1.attachSmileys = function ()
    {
        var _loc2 = 0;
        var _loc3 = 0;
        var _loc4 = 16;
        var _loc5 = 4;
        var _loc7 = 1;
        
        while (++_loc7, _loc7 <= 15)
        {
            var _loc8 = this._ldrStreaming.content.attachMovie(String(_loc7), "smiley" + _loc7, _loc7);
            if (_loc8._width > _loc8._height)
            {
                var _loc6 = _loc8._height / _loc8._width;
                _loc8._height = _loc6 * _loc4;
                _loc8._width = _loc4;
            }
            else
            {
                _loc6 = _loc8._width / _loc8._height;
                _loc8._width = _loc6 * _loc4;
                _loc8._height = _loc4;
            } // end else if
            _loc8._x = _loc2 * (_loc4 + _loc5);
            _loc8._y = _loc3 * (_loc4 + _loc5);
            _loc8.contentData = {index: _loc7};
            var ref = this;
            _loc8.onRelease = function ()
            {
                ref.selectItem({target: this, owner: {_name: "_cgSmileys"}});
            };
            _loc8.onRollOver = function ()
            {
                this._parent.attachMovie("over", "over", -1);
                this._parent.over._x = this._x;
                this._parent.over._y = this._y;
            };
            _loc8.onReleaseOutside = _loc8.onRollOut = function ()
            {
                this._parent.createEmptyMovieClip("over", -1);
            };
            ++_loc2;
            if (_loc2 == 5)
            {
                _loc2 = 0;
                ++_loc3;
            } // end if
        } // end while
    };
    _loc1.initialization = function (oEvent)
    {
        this.attachSmileys();
    };
    _loc1.selectItem = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 == undefined)
        {
            return;
        } // end if
        switch (oEvent.owner._name)
        {
            case "_cgSmileys":
            {
                this.dispatchEvent({type: "selectSmiley", index: _loc3.index});
                break;
            } 
            case "_cgEmotes":
            {
                this.dispatchEvent({type: "selectEmote", index: _loc3.index});
                break;
            } 
        } // End of switch
    };
    _loc1.overItem = function (oEvent)
    {
        var _loc3 = oEvent.target.contentData;
        if (_loc3 != undefined)
        {
            var _loc4 = this.api.lang.getEmoteText(_loc3.index);
            var _loc5 = _loc4.n;
            var _loc6 = _loc4.s != undefined ? (" (/" + _loc4.s + ")") : ("");
            this.gapi.showTooltip(_loc5 + _loc6, oEvent.target, -20);
        } // end if
    };
    _loc1.outItem = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.Smileys = function ()
    {
        super();
    }).CLASS_NAME = "Smileys";
} // end if
#endinitclip
