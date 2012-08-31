// Action script...

// [Initial MovieClip Action of sprite 865]
#initclip 77
class ank.battlefield.mc.OverHead extends MovieClip
{
    var _mcSprite, _nZoom, _nCurrentItemID, _oLayers, createEmptyMovieClip, _parent, _x, _y, __get__top, __get__moderator, _mcItems, __get__bottom, swapDepths, removeMovieClip;
    function OverHead(mcSprite, nZoom)
    {
        super();
        _mcSprite = mcSprite;
        _nZoom = nZoom == undefined ? (100) : (nZoom);
        this.initialize();
    } // End of the function
    function get top()
    {
        return (ank.battlefield.mc.OverHead.TOP_Y * _nZoom / 100);
    } // End of the function
    function get bottom()
    {
        return (ank.battlefield.mc.OverHead.BOTTOM_Y * _nZoom / 100);
    } // End of the function
    function get moderator()
    {
        return (ank.battlefield.mc.OverHead.MODERATOR_Y * _nZoom / 100);
    } // End of the function
    function initialize()
    {
        _nCurrentItemID = 0;
        this.clear();
    } // End of the function
    function clear()
    {
        _oLayers = new Object();
        this.clearView();
    } // End of the function
    function clearView()
    {
        this.createEmptyMovieClip("_mcItems", 10);
    } // End of the function
    function setPosition(nItemsHeight, nMaxWidth)
    {
        var _loc5 = {x: _parent._parent._x, y: _parent._parent._y};
        _parent._parent.localToGlobal(_loc5);
        _x = _mcSprite._x;
        _y = _mcSprite._y;
        var _loc6 = 100 / _nZoom;
        var _loc3 = this.__get__top();
        var _loc2 = this.__get__moderator();
        nItemsHeight = nItemsHeight * _loc6;
        if (_mcSprite._y < -_loc3 + nItemsHeight - _loc5.y + _loc2)
        {
            _mcItems._y = _mcItems._y + (this.__get__bottom() + nItemsHeight);
        }
        else
        {
            var _loc7 = Math.abs(_loc3);
            _mcItems._y = _mcItems._y + (_mcSprite._height > _loc7 + _loc2 ? (_loc3 - _loc2) : (_mcSprite._height < _loc7 - _loc2 ? (_loc3 + _loc2) : (_loc3)));
        } // end else if
        var _loc4 = nMaxWidth * _loc6 / 2;
        if (_mcSprite._x < _loc4 - _loc5.x)
        {
            _x = _loc4;
        } // end if
        if (_mcSprite._x > ank.battlefield.Constants.DISPLAY_WIDTH * _loc6 - _loc4 + _loc5.x)
        {
            _x = ank.battlefield.Constants.DISPLAY_WIDTH * _loc6 - _loc4;
        } // end if
    } // End of the function
    function addItem(sLayerName, className, args, delay)
    {
        var _loc2 = new Object();
        _loc2.id = _nCurrentItemID;
        _loc2.className = className;
        _loc2.args = args;
        if (delay != undefined)
        {
            ank.utils.Timer.setTimer(_loc2, "battlefield", this, removeItem, delay, [_nCurrentItemID]);
        } // end if
        _oLayers[sLayerName] = _loc2;
        ++_nCurrentItemID;
        this.refresh();
    } // End of the function
    function remove(Void)
    {
        this.swapDepths(1);
        this.removeMovieClip();
    } // End of the function
    function refresh()
    {
        this.clearView();
        var _loc4 = 0;
        var _loc5 = 0;
        var _loc6 = 0;
        for (var _loc7 in _oLayers)
        {
            var _loc3 = _oLayers[_loc7];
            var _loc2 = _mcItems.attachClassMovie(_loc3.className, "item" + _loc4, _loc4, _loc3.args);
            _loc5 = _loc5 - _loc2.height;
            _loc6 = Math.max(_loc6, _loc2.width);
            _loc2._y = _loc5;
            ++_loc4;
        } // end of for...in
        this.setPosition(Math.abs(_loc5), _loc6);
    } // End of the function
    function removeLayer(layerName)
    {
        delete _oLayers[layerName];
        this.refresh();
    } // End of the function
    function removeItem(nItemID)
    {
        var _loc2;
        for (var _loc2 in _oLayers)
        {
            if (_oLayers[_loc2].id == nItemID)
            {
                delete _oLayers[_loc2];
                this.refresh();
                break;
            } // end if
        } // end of for...in
    } // End of the function
    static var TOP_Y = -50;
    static var BOTTOM_Y = 10;
    static var MODERATOR_Y = 15;
} // End of Class
#endinitclip
