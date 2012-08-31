// Action script...

// [Initial MovieClip Action of sprite 976]
#initclip 190
class dofus.graphics.gapi.controls.Timeline extends ank.gapi.core.UIAdvancedComponent
{
    var layout_mc, __get__opened, _vcChrono, createEmptyMovieClip, api, __get__api, __get__gapi, __set__opened;
    function Timeline()
    {
        super();
    } // End of the function
    function set opened(bOpened)
    {
        _bOpened = bOpened;
        layout_mc._visible = bOpened;
        //return (this.opened());
        null;
    } // End of the function
    function get opened()
    {
        return (_bOpened);
    } // End of the function
    function update()
    {
        this.generate();
    } // End of the function
    function nextTurn(id, bWithoutTween)
    {
        bWithoutTween = undefined;
        if (undefined)
        {
            bWithoutTween = false;
        } // end if
        var _loc2 = layout_mc.items_mc["item" + id];
        if (_loc2 == undefined)
        {
            return;
        } // end if
        layout_mc.pointer_mc._visible = true;
        _vcChrono = _loc2.chrono;
        if (bWithoutTween)
        {
            layout_mc.pointer_mc.move(_loc2._x, 0);
        }
        else
        {
            layout_mc.pointer_mc.moveTween(_loc2._x);
        } // end else if
        _currentDisplayIndex = id;
    } // End of the function
    function hideItem(id)
    {
        var _loc2 = layout_mc.items_mc["item" + id];
        var _loc3 = new Color(_loc2.sprite);
        _loc3.setRGB(dofus.graphics.gapi.controls.Timeline.HIDE_COLOR);
    } // End of the function
    function startChrono(nDuration)
    {
        _vcChrono.startTimer(nDuration);
    } // End of the function
    function stopChrono()
    {
        _vcChrono.stopTimer();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.Timeline.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("layout_mc", 10);
        var _loc2 = layout_mc.attachMovie("TimelinePointer", "pointer_mc", 10);
        _loc2._visible = false;
        this.generate();
    } // End of the function
    function generate(cs)
    {
        var _loc19 = api.datacenter;
        if (cs == undefined)
        {
            cs = _loc19.Game.turnSequence;
        } // end if
        var _loc3 = new Array();
        var _loc2;
        for (var _loc2 = 0; _loc2 < cs.length; ++_loc2)
        {
            _loc3.push(_loc19.Sprites.getItemAt(cs[_loc2]));
        } // end of for
        var _loc18 = _loc3.length;
        if (layout_mc.items_mc == undefined)
        {
            layout_mc.createEmptyMovieClip("items_mc", 20);
        } // end if
        var _loc10 = _loc18 * dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH + 20;
        for (var _loc20 in _previousCharacList)
        {
            var _loc6 = _previousCharacList[_loc20].id;
            var _loc5 = false;
            for (var _loc16 in _loc3)
            {
                var _loc4 = _loc3[_loc16].id;
                if (_loc6 == _loc4)
                {
                    _loc5 = true;
                    continue;
                } // end if
            } // end of for...in
            if (!_loc5)
            {
                layout_mc.items_mc["item" + _loc6].removeMovieClip();
            } // end if
        } // end of for...in
        var _loc9;
        for (var _loc2 = 0; _loc2 < _loc18; ++_loc2)
        {
            var _loc8 = _loc3[_loc2];
            _loc9 = _loc8.id;
            var _loc7 = layout_mc.items_mc["item" + _loc9];
            if (_loc7 == undefined)
            {
                layout_mc.items_mc.attachMovie("TimelineItem", "item" + _loc9, _depth++, {_x: _loc2 * dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH - _loc10, index: _loc2, data: _loc8, api: this.__get__api(), gapi: this.__get__gapi()});
                continue;
            } // end if
            _loc7._x = _loc2 * dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH - _loc10;
        } // end of for
        this.nextTurn(_currentDisplayIndex, true);
        _previousCharacList = _loc3;
    } // End of the function
    static var CLASS_NAME = "Timeline";
    static var ITEM_WIDTH = 30;
    static var HIDE_COLOR = 4473924;
    var _currentDisplayIndex = 0;
    var _itemsList = new Array();
    var _previousCharacList = new Array();
    var _depth = 0;
    var _bOpened = true;
} // End of Class
#endinitclip
