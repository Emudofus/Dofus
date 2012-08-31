// Action script...

// [Initial MovieClip Action of sprite 178]
#initclip 17
class ank.gapi.controls.list.SelectableRow extends ank.gapi.core.UIBasicComponent
{
    var _nItemIndex, __get__itemIndex, _oItem, _nIndex, __get__index, cellRenderer_mc, getStyle, _parent, attachMovie, selected_mc, _bUsed, createEmptyMovieClip, bg_mc, over_mc, __height, __width, drawRoundRect, __set__index, __get__item, __set__itemIndex;
    function SelectableRow()
    {
        super();
    } // End of the function
    function set itemIndex(nItemIndex)
    {
        _nItemIndex = nItemIndex;
        //return (this.itemIndex());
        null;
    } // End of the function
    function get itemIndex()
    {
        return (_nItemIndex);
    } // End of the function
    function get item()
    {
        return (_oItem);
    } // End of the function
    function set index(nIndex)
    {
        _nIndex = nIndex;
        //return (this.index());
        null;
    } // End of the function
    function setCellRenderer(link)
    {
        cellRenderer_mc.removeMovieClip();
        this.attachMovie(link, "cellRenderer_mc", 100, {styleName: this.getStyle().cellrendererstyle, list: _parent._parent});
    } // End of the function
    function setState(sState)
    {
        cellRenderer_mc.setState(sState);
        switch (sState)
        {
            case "selected":
            {
                selected_mc._visible = true;
                break;
            } 
            case "normal":
            {
                selected_mc._visible = false;
                break;
            } 
        } // End of switch
    } // End of the function
    function setValue(sSuggested, oItem, sState)
    {
        _bUsed = oItem != undefined;
        _oItem = oItem;
        cellRenderer_mc.setValue(_bUsed, sSuggested, oItem);
        this.setState(sState);
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("over_mc", -10);
        this.createEmptyMovieClip("selected_mc", -20);
        this.createEmptyMovieClip("bg_mc", -30);
        bg_mc.trackAsMenu = true;
        over_mc._visible = false;
        selected_mc._visible = false;
        bg_mc.useHandCursor = false;
        bg_mc.onRollOver = function ()
        {
            if (_parent._bUsed && _parent._bEnabled)
            {
                _parent.over_mc._visible = true;
                _parent.dispatchEvent({type: "itemRollOver", target: _parent});
            } // end if
        };
        bg_mc.onRollOut = bg_mc.onReleaseOutside = function ()
        {
            if (_parent._bUsed && _parent._bEnabled)
            {
                _parent.dispatchEvent({type: "itemRollOut", target: _parent});
            } // end if
            _parent.over_mc._visible = false;
        };
        bg_mc.onPress = function ()
        {
        };
        bg_mc.onRelease = function ()
        {
            if (_parent._bUsed && _parent._bEnabled)
            {
                _parent.dispatchEvent({type: "itemSelected", target: _parent});
            } // end if
        };
        bg_mc.onDragOver = function ()
        {
            if (_parent._bUsed && _parent._bEnabled)
            {
                _parent.dispatchEvent({type: "itemDragOver", target: _parent});
            } // end if
        };
        bg_mc.onDragOut = function ()
        {
            if (_parent._bUsed && _parent._bEnabled)
            {
                _parent.dispatchEvent({type: "itemDragOut", target: _parent});
            } // end if
        };
    } // End of the function
    function size()
    {
        super.size();
        cellRenderer_mc.setSize(__width, __height);
        this.arrange();
    } // End of the function
    function arrange()
    {
        over_mc._width = selected_mc._width = bg_mc._width = __width;
        over_mc._height = selected_mc._height = bg_mc._height = __height;
    } // End of the function
    function draw()
    {
        var _loc3 = this.getStyle();
        var _loc2 = _loc3.cellbgcolor;
        var _loc5 = _loc3.cellselectedcolor;
        var _loc4 = _loc3.cellovercolor;
        over_mc.clear();
        selected_mc.clear();
        bg_mc.clear();
        this.drawRoundRect(over_mc, 0, 0, 1, 1, 0, _loc4, _loc4 == -1 ? (0) : (100));
        this.drawRoundRect(selected_mc, 0, 0, 1, 1, 0, _loc5, _loc5 == -1 ? (0) : (100));
        this.drawRoundRect(bg_mc, 0, 0, 1, 1, 0, typeof(_loc2) == "object" ? (Number(_loc2[_nIndex % _loc2.length])) : (Number(_loc2)), _loc2 == -1 ? (0) : (100));
        cellRenderer_mc.styleName = _loc3.cellrendererstyle;
    } // End of the function
} // End of Class
#endinitclip
