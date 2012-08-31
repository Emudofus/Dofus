// Action script...

// [Initial MovieClip Action of sprite 12]
#initclip 15
class ank.gapi.controls.ScrollBar extends ank.gapi.core.UIBasicComponent
{
    var _nMin, __get__min, _nMax, __get__max, _nPage, __get__page, _parent, _tTarget, addEventListener, addToQueue, _sSnapTo, __get__scrollTarget, __get__snapTo, _mcHolder, __get__scrollPosition, _bHorizontal, __get__horizontal, createEmptyMovieClip, up_mc, over_mc, down_mc, interval, onRollOver, onRelease, onRollOut, _ymouse, dispatchInterval, scrollInterval, getStyle, setMovieClipColor, __height, _nSize, _rotation, _nDragOffset, _nPrevScrollPosition, dispatchEvent, _width, _x, _y, __set__height, _oListener, removeEventListener, target, parent, __set__scrollPosition, __set__horizontal, __set__max, __set__min, __set__page, __set__scrollTarget, __set__snapTo;
    function ScrollBar()
    {
        super();
    } // End of the function
    function set min(nMin)
    {
        _nMin = nMin;
        //return (this.min());
        null;
    } // End of the function
    function get min()
    {
        return (_nMin);
    } // End of the function
    function set max(nMax)
    {
        _nMax = nMax;
        //return (this.max());
        null;
    } // End of the function
    function get max()
    {
        return (_nMax);
    } // End of the function
    function set page(nPage)
    {
        _nPage = nPage;
        //return (this.page());
        null;
    } // End of the function
    function get page()
    {
        return (_nPage);
    } // End of the function
    function set scrollTarget(tTarget)
    {
        if (tTarget == undefined)
        {
            return;
        } // end if
        _tTarget = typeof(tTarget) == "string" ? (_parent[tTarget]) : (tTarget);
        if (addEventListener != undefined)
        {
            this.addTargetListener();
        } // end if
        _tTarget.removeListener(this);
        _tTarget.addListener(this);
        this.addToQueue({object: this, method: addTargetListener});
        if (_sSnapTo != undefined && _sSnapTo != "none")
        {
            this.addToQueue({object: this, method: snapToTextField});
        } // end if
        //return (this.scrollTarget());
        null;
    } // End of the function
    function get scrollTarget()
    {
        return (_tTarget);
    } // End of the function
    function set snapTo(sSnapTo)
    {
        if (sSnapTo == undefined)
        {
            return;
        } // end if
        _sSnapTo = sSnapTo;
        if (_tTarget != undefined)
        {
            if (addEventListener != undefined)
            {
                this.snapToTextField();
            }
            else
            {
                this.addToQueue({object: this, method: snapToTextField});
            } // end if
        } // end else if
        //return (this.snapTo());
        null;
    } // End of the function
    function set scrollPosition(nScrollPosition)
    {
        if (nScrollPosition > _nMax)
        {
            nScrollPosition = _nMax;
        } // end if
        if (nScrollPosition < _nMin)
        {
            nScrollPosition = _nMin;
        } // end if
        var _loc3 = nScrollPosition * (_mcHolder.track_mc._height - _mcHolder.thumb_mc._height) / (_nMax - _nMin) + _mcHolder.track_mc._y;
        this.moveThumb(_loc3);
        //return (this.scrollPosition());
        null;
    } // End of the function
    function get scrollPosition()
    {
        return (Math.round((_mcHolder.thumb_mc._y - _mcHolder.track_mc._y) / (_mcHolder.track_mc._height - _mcHolder.thumb_mc._height) * (_nMax - _nMin)));
    } // End of the function
    function set horizontal(bHorizontal)
    {
        _bHorizontal = bHorizontal;
        this.arrange();
        //return (this.horizontal());
        null;
    } // End of the function
    function setSize(nHeight)
    {
        super.setSize(null, nHeight);
    } // End of the function
    function setScrollProperties(nPage, nMin, nMax)
    {
        _nPage = nPage;
        _nMin = Math.max(nMin, 0);
        _nMax = Math.max(nMax, 0);
        this.resizeThumb();
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ScrollBar.CLASS_NAME);
        if (_nMin == undefined)
        {
            _nMin = 0;
        } // end if
        if (_nMax == undefined)
        {
            _nMax = 100;
        } // end if
        if (_nPage == undefined)
        {
            _nPage = 10;
        } // end if
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcHolder", 10);
        var _loc6 = _mcHolder.attachMovie("ScrollBarTrack", "track_mc", 10);
        var _loc3 = _mcHolder.attachMovie("ScrollBarUpArrow", "upArrow_mc", 20);
        var _loc4 = _mcHolder.attachMovie("ScrollBarDownArrow", "downArrow_mc", 30);
        var _loc2 = _mcHolder.attachMovie("ScrollBarThumb", "thumb_mc", 40);
        _loc3.onRollOver = _loc4.onRollOver = function ()
        {
            up_mc._visible = false;
            over_mc._visible = true;
            down_mc._visible = false;
        };
        _loc3.onRollOut = _loc4.onRollOut = function ()
        {
            up_mc._visible = true;
            over_mc._visible = false;
            down_mc._visible = false;
        };
        _loc3.onPress = function ()
        {
            up_mc._visible = false;
            over_mc._visible = false;
            down_mc._visible = true;
            interval = setInterval(_parent._parent, "addToScrollPosition", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL, -1);
        };
        _loc4.onPress = function ()
        {
            up_mc._visible = false;
            over_mc._visible = false;
            down_mc._visible = true;
            interval = setInterval(_parent._parent, "addToScrollPosition", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL, 1);
        };
        _loc3.onRelease = _loc4.onRelease = function ()
        {
            this.onRollOver();
            clearInterval(interval);
        };
        _loc3.onReleaseOutside = _loc4.onReleaseOutside = function ()
        {
            this.onRelease();
            this.onRollOut();
        };
        _loc2.onRollOver = function ()
        {
        };
        _loc2.onRollOut = function ()
        {
        };
        _loc2.onPress = function ()
        {
            _parent._parent._nDragOffset = -_ymouse;
            dispatchInterval = setInterval(_parent._parent, "dispatchScrollEvent", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL);
            scrollInterval = setInterval(_parent._parent, "scrollThumb", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL, null, true);
        };
        _loc2.onRelease = function ()
        {
            clearInterval(scrollInterval);
            clearInterval(dispatchInterval);
        };
        _loc2.onReleaseOutside = function ()
        {
            this.onRelease();
            this.onRollOut();
        };
        _loc6.onPress = function ()
        {
            var _loc3 = _parent._ymouse;
            var _loc2 = _parent._parent._nPage;
            if (_loc3 < _parent.thumb_mc._y)
            {
                _loc2 = -_loc2;
            } // end if
            _parent._parent.addToScrollPosition(_loc2);
        };
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        var _loc3;
        _loc3 = _mcHolder.downArrow_mc;
        this.setMovieClipColor(_loc3.up_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.up_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.down_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.down_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.over_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.over_mc.arrow_mc, _loc2.sbarrowcolor);
        _loc3 = _mcHolder.upArrow_mc;
        this.setMovieClipColor(_loc3.up_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.up_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.down_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.down_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.over_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.over_mc.arrow_mc, _loc2.sbarrowcolor);
        for (var _loc4 in _mcHolder.thumb_mc)
        {
            this.setMovieClipColor(_mcHolder.thumb_mc[_loc4], _loc2.sbthumbcolor);
        } // end of for...in
        this.setMovieClipColor(_mcHolder.track_mc, _loc2.sbtrackcolor);
    } // End of the function
    function size()
    {
        super.size();
        _nSize = __height;
        this.arrange();
        if (this.__get__scrollTarget() != undefined)
        {
            this.setScrollPropertiesToTarget();
        } // end if
    } // End of the function
    function arrange()
    {
        if (_nSize == undefined)
        {
            return;
        } // end if
        if (_bHorizontal)
        {
            _rotation = -90;
        } // end if
        _mcHolder.track_mc._height = Math.max(_nSize - _mcHolder.upArrow_mc._height - _mcHolder.downArrow_mc._height, 0);
        _mcHolder.track_mc._y = _mcHolder.upArrow_mc._height;
        _mcHolder.downArrow_mc._y = _mcHolder.track_mc._y + _mcHolder.track_mc._height;
        _mcHolder.thumb_mc._y = _mcHolder.track_mc._y;
        this.setScrollProperties(_nPage, _nMin, _nMax);
    } // End of the function
    function resizeThumb()
    {
        if (_nMax != _nMin)
        {
            _mcHolder.thumb_mc.height = Math.min(Math.abs(_nPage / (_nMax - _nMin)), 1) * _mcHolder.track_mc._height;
            _mcHolder.thumb_mc._y = _mcHolder.upArrow_mc._height;
            if (_mcHolder.thumb_mc._height > _mcHolder.track_mc._height)
            {
                _mcHolder.thumb_mc._visible = false;
            }
            else
            {
                _mcHolder.thumb_mc._visible = true;
            } // end else if
        }
        else
        {
            _mcHolder.thumb_mc._visible = false;
        } // end else if
    } // End of the function
    function addToScrollPosition(nAmount)
    {
        scrollPosition = scrollPosition + nAmount;
    } // End of the function
    function scrollThumb(nAmount, bDrag)
    {
        if (bDrag)
        {
            this.moveThumb(_mcHolder._ymouse + _nDragOffset);
        }
        else
        {
            this.moveThumb(_mcHolder.thumb_mc._y + nAmount);
        } // end else if
        updateAfterEvent();
    } // End of the function
    function moveThumb(nY)
    {
        _mcHolder.thumb_mc._y = nY;
        if (_mcHolder.thumb_mc._y < _mcHolder.upArrow_mc._height)
        {
            _mcHolder.thumb_mc._y = _mcHolder.upArrow_mc._height;
        }
        else if (_mcHolder.thumb_mc._y > _mcHolder.downArrow_mc._y - _mcHolder.thumb_mc._height)
        {
            _mcHolder.thumb_mc._y = _mcHolder.downArrow_mc._y - _mcHolder.thumb_mc._height;
        } // end else if
        this.dispatchScrollEvent();
    } // End of the function
    function dispatchScrollEvent()
    {
        if (_mcHolder.thumb_mc._y != _nPrevScrollPosition)
        {
            _nPrevScrollPosition = _mcHolder.thumb_mc._y;
            this.dispatchEvent({type: "scroll", target: this});
        } // end if
    } // End of the function
    function snapToTextField()
    {
        if (_sSnapTo == "right")
        {
            _x = _tTarget._x + _tTarget._width - _width;
            _y = _tTarget._y;
            _tTarget._width = _tTarget._width - _width;
            this.__set__height(_tTarget._height);
            this.setScrollPropertiesToTarget();
        } // end if
    } // End of the function
    function addTargetListener()
    {
        this.removeEventListener("scroll", _oListener);
        _oListener = new Object();
        _oListener.target = _tTarget;
        _oListener.parent = this;
        _oListener.scroll = function (oEvent)
        {
            target.scroll = target.maxscroll * (parent.scrollPosition / Math.abs(parent._nMax - parent._nMin));
        };
        this.addEventListener("scroll", _oListener);
        this.setScrollPropertiesToTarget();
    } // End of the function
    function setScrollPropertiesToTarget()
    {
        if (_tTarget == undefined)
        {
            this.setScrollProperties(_nPage, _nMin, _nMax);
        }
        else
        {
            var _loc2 = isNaN(Number(_tTarget.maxscroll)) ? (1) : (_tTarget.maxscroll);
            var _loc5 = isNaN(Number(_tTarget._height)) ? (0) : (_tTarget._height);
            var _loc3 = isNaN(Number(_tTarget.textHeight)) ? (1) : (_tTarget.textHeight);
            var _loc4 = 9.000000E-001 * _loc5 / _loc3 * _loc2;
            this.setScrollProperties(_loc4, 0, _loc2);
        } // end else if
    } // End of the function
    function onChanged()
    {
        this.setScrollPropertiesToTarget();
        this.__set__scrollPosition(_tTarget.scroll);
    } // End of the function
    function onScroller()
    {
        this.__set__scrollPosition(_tTarget.scroll);
    } // End of the function
    static var CLASS_NAME = "ScrollBar";
    static var SCROLL_INTERVAL = 40;
} // End of Class
#endinitclip
