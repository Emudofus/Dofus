// Action script...

// [Initial MovieClip Action of sprite 20944]
#initclip 209
if (!dofus.graphics.gapi.controls.Timeline)
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
    var _loc1 = (_global.dofus.graphics.gapi.controls.Timeline = function ()
    {
        super();
    }).prototype;
    _loc1.__set__opened = function (bOpened)
    {
        this._bOpened = bOpened;
        this.layout_mc._visible = bOpened;
        //return (this.opened());
    };
    _loc1.__get__opened = function ()
    {
        return (this._bOpened);
    };
    _loc1.update = function ()
    {
        this.generate();
    };
    _loc1.nextTurn = function (id, bWithoutTween)
    {
        bWithoutTween = undefined;
        if (undefined)
        {
            bWithoutTween = false;
        } // end if
        var _loc4 = this.layout_mc.items_mc["item" + id];
        if (_loc4 == undefined)
        {
            return;
        } // end if
        this.layout_mc.pointer_mc._visible = true;
        this.stopChrono();
        this._vcChrono = _loc4.chrono;
        if (bWithoutTween)
        {
            this.layout_mc.pointer_mc.move(_loc4._x, 0);
            this.layout_mc.pointer_mc._xscale = _loc4._xscale;
            this.layout_mc.pointer_mc._yscale = _loc4._yscale;
        }
        else
        {
            this.layout_mc.pointer_mc.moveTween(_loc4._x, _loc4._xscale);
        } // end else if
        this.layout_mc.pointer_mc._y = _loc4._oData.isSummoned ? (dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA) : (0);
        this._currentDisplayIndex = id;
    };
    _loc1.hideItem = function (id)
    {
        var _loc3 = this.layout_mc.items_mc["item" + id];
        var _loc4 = new Color(_loc3.sprite);
        _loc4.setRGB(dofus.graphics.gapi.controls.Timeline.HIDE_COLOR);
    };
    _loc1.showItem = function (id)
    {
        var _loc3 = this.layout_mc.items_mc["item" + id];
        var _loc4 = new Color(_loc3.sprite);
        _loc4.setTransform({ra: 100, ga: 100, ba: 100, rb: 0, gb: 0, bb: 0});
    };
    _loc1.startChrono = function (nDuration)
    {
        this._vcChrono.startTimer(nDuration);
    };
    _loc1.stopChrono = function ()
    {
        this._vcChrono.stopTimer();
    };
    _loc1.updateCharacters = function ()
    {
        var _loc2 = this.api.datacenter;
        var _loc3 = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aTs.length)
        {
            _loc3.push(_loc2.Sprites.getItemAt(this._aTs[_loc4]));
        } // end while
        var _loc5 = _loc3.length;
        _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc5)
        {
            var _loc7 = _loc3[_loc4];
            var _loc6 = _loc7.id;
            this.layout_mc.items_mc["item" + _loc6].data = _loc7;
        } // end while
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.Timeline.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("layout_mc", 10);
        this.layout_mc.createEmptyMovieClip("SummonedLayout", 9);
        var _loc2 = this.layout_mc.attachMovie("TimelinePointer", "pointer_mc", 10);
        _loc2._visible = false;
        this.generate();
    };
    _loc1.generate = function (cs)
    {
        var _loc3 = this.api.datacenter;
        if (cs == undefined)
        {
            cs = _loc3.Game.turnSequence;
        } // end if
        this._aTs = cs;
        var _loc4 = new Array();
        var _loc5 = 0;
        
        while (++_loc5, _loc5 < cs.length)
        {
            _loc4.push(_loc3.Sprites.getItemAt(cs[_loc5]));
        } // end while
        var _loc6 = _loc4.length;
        if (this.layout_mc.items_mc == undefined)
        {
            this.layout_mc.createEmptyMovieClip("items_mc", 20);
        } // end if
        var _loc7 = 20;
        _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc6)
        {
            var _loc8 = _loc4[_loc5];
            _loc7 = _loc7 + (_loc8.isSummoned ? (dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH) : (dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH));
        } // end while
        for (var k in this._previousCharacList)
        {
            var _loc9 = this._previousCharacList[k].id;
            var _loc10 = false;
            for (var kk in _loc4)
            {
                var _loc11 = _loc4[kk].id;
                if (_loc9 == _loc11)
                {
                    _loc10 = true;
                    continue;
                } // end if
            } // end of for...in
            if (!_loc10)
            {
                this.layout_mc.items_mc["item" + _loc9].removeMovieClip();
            } // end if
        } // end of for...in
        var _loc13 = -_loc7;
        _loc5 = 0;
        
        while (++_loc5, _loc5 < _loc6)
        {
            var _loc16 = _loc4[_loc5];
            var _loc12 = _loc16.id;
            var _loc17 = this.layout_mc.items_mc["item" + _loc12];
            if (_loc17 == undefined)
            {
                _loc17 = this.layout_mc.items_mc.attachMovie("TimelineItem", "item" + _loc12, this._depth++, {index: _loc5, data: _loc16, api: this.api, gapi: this.gapi});
            } // end if
            if (_loc16.isSummoned)
            {
                _loc17._xscale = 80;
                _loc17._yscale = 80;
            } // end if
            _loc17._x = _loc13;
            _loc17._y = _loc16.isSummoned ? (dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA) : (0);
            if (!_loc16.isSummoned)
            {
                var _loc14 = _loc17;
                this.layout_mc.SummonedLayout["TISB" + _loc17.index].removeMovieClip();
            }
            else
            {
                var _loc18 = this.layout_mc.SummonedLayout["TISB" + _loc14.index];
                if (_loc18 == undefined)
                {
                    _loc18 = this.layout_mc.SummonedLayout.attachMovie("TimelineItemSummonedBg", "TISB" + _loc14.index, _loc14.index);
                } // end if
                _loc18._x = _loc14._x;
                _loc18._mcBody._width = _loc17._x - _loc14._x + _loc17._width + 1;
                _loc18._mcEnd._x = _loc18._mcBody._width;
            } // end else if
            _loc13 = _loc13 + (_loc16.isSummoned ? (dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH) : (dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH));
            var _loc15 = _loc17;
        } // end while
        this.nextTurn(this._currentDisplayIndex, true);
        this._previousCharacList = _loc4;
    };
    _loc1.addProperty("opened", _loc1.__get__opened, _loc1.__set__opened);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.Timeline = function ()
    {
        super();
    }).CLASS_NAME = "Timeline";
    (_global.dofus.graphics.gapi.controls.Timeline = function ()
    {
        super();
    }).ITEM_WIDTH = 34;
    (_global.dofus.graphics.gapi.controls.Timeline = function ()
    {
        super();
    }).ITEM_SUMMONED_HEIGHT_DELTA = 2;
    (_global.dofus.graphics.gapi.controls.Timeline = function ()
    {
        super();
    }).ITEM_SUMMONED_WIDTH = 28;
    (_global.dofus.graphics.gapi.controls.Timeline = function ()
    {
        super();
    }).HIDE_COLOR = 4473924;
    _loc1._currentDisplayIndex = 0;
    _loc1._itemsList = new Array();
    _loc1._previousCharacList = new Array();
    _loc1._depth = 0;
    _loc1._bOpened = true;
} // end if
#endinitclip
