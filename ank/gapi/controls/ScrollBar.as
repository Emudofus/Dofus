// Action script...

// [Initial MovieClip Action of sprite 20950]
#initclip 215
if (!ank.gapi.controls.ScrollBar)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.controls)
    {
        _global.ank.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.controls.ScrollBar = function ()
    {
        super();
    }).prototype;
    _loc1.__set__min = function (nMin)
    {
        this._nMin = nMin;
        //return (this.min());
    };
    _loc1.__get__min = function ()
    {
        return (this._nMin);
    };
    _loc1.__set__max = function (nMax)
    {
        this._nMax = nMax;
        //return (this.max());
    };
    _loc1.__get__max = function ()
    {
        return (this._nMax);
    };
    _loc1.__set__page = function (nPage)
    {
        this._nPage = nPage;
        //return (this.page());
    };
    _loc1.__get__page = function ()
    {
        return (this._nPage);
    };
    _loc1.__set__scrollTarget = function (tTarget)
    {
        if (tTarget == undefined)
        {
            return;
        } // end if
        this._tTarget = typeof(tTarget) == "string" ? (this._parent[tTarget]) : (tTarget);
        if (this.addEventListener != undefined)
        {
            this.addTargetListener();
        } // end if
        this._tTarget.removeListener(this);
        this._tTarget.addListener(this);
        this.addToQueue({object: this, method: this.addTargetListener});
        if (this._sSnapTo != undefined && this._sSnapTo != "none")
        {
            this.addToQueue({object: this, method: this.snapToTextField});
        } // end if
        //return (this.scrollTarget());
    };
    _loc1.__get__scrollTarget = function ()
    {
        return (this._tTarget);
    };
    _loc1.__set__snapTo = function (sSnapTo)
    {
        if (sSnapTo == undefined)
        {
            return;
        } // end if
        this._sSnapTo = sSnapTo;
        if (this._tTarget != undefined)
        {
            if (this.addEventListener != undefined)
            {
                this.snapToTextField();
            }
            else
            {
                this.addToQueue({object: this, method: this.snapToTextField});
            } // end if
        } // end else if
        //return (this.snapTo());
    };
    _loc1.__set__scrollPosition = function (nScrollPosition)
    {
        if (nScrollPosition > this._nMax)
        {
            nScrollPosition = this._nMax;
        } // end if
        if (nScrollPosition < this._nMin)
        {
            nScrollPosition = this._nMin;
        } // end if
        var _loc3 = nScrollPosition * (this._mcHolder.track_mc._height - this._mcHolder.thumb_mc._height) / (this._nMax - this._nMin) + this._mcHolder.track_mc._y;
        this.moveThumb(_loc3);
        //return (this.scrollPosition());
    };
    _loc1.__get__scrollPosition = function ()
    {
        return (Math.round((this._mcHolder.thumb_mc._y - this._mcHolder.track_mc._y) / (this._mcHolder.track_mc._height - this._mcHolder.thumb_mc._height) * (this._nMax - this._nMin)));
    };
    _loc1.__set__horizontal = function (bHorizontal)
    {
        this._bHorizontal = bHorizontal;
        this.arrange();
        //return (this.horizontal());
    };
    _loc1.setSize = function (nHeight)
    {
        super.setSize(null, nHeight);
    };
    _loc1.setScrollProperties = function (nPage, nMin, nMax)
    {
        this._nPage = nPage;
        this._nMin = Math.max(nMin, 0);
        this._nMax = Math.max(nMax, 0);
        this.resizeThumb();
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ScrollBar.CLASS_NAME);
        if (this._nMin == undefined)
        {
            this._nMin = 0;
        } // end if
        if (this._nMax == undefined)
        {
            this._nMax = 100;
        } // end if
        if (this._nPage == undefined)
        {
            this._nPage = 10;
        } // end if
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcHolder", 10);
        var _loc2 = this._mcHolder.attachMovie("ScrollBarTrack", "track_mc", 10);
        var _loc3 = this._mcHolder.attachMovie("ScrollBarUpArrow", "upArrow_mc", 20);
        var _loc4 = this._mcHolder.attachMovie("ScrollBarDownArrow", "downArrow_mc", 30);
        var _loc5 = this._mcHolder.attachMovie("ScrollBarThumb", "thumb_mc", 40);
        _loc3.onRollOver = _loc4.onRollOver = function ()
        {
            this.up_mc._visible = false;
            this.over_mc._visible = true;
            this.down_mc._visible = false;
        };
        _loc3.onRollOut = _loc4.onRollOut = function ()
        {
            this.up_mc._visible = true;
            this.over_mc._visible = false;
            this.down_mc._visible = false;
        };
        _loc3.onPress = function ()
        {
            this.up_mc._visible = false;
            this.over_mc._visible = false;
            this.down_mc._visible = true;
            this.interval = _global.setInterval(this._parent._parent, "addToScrollPosition", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL, -1);
        };
        _loc4.onPress = function ()
        {
            this.up_mc._visible = false;
            this.over_mc._visible = false;
            this.down_mc._visible = true;
            this.interval = _global.setInterval(this._parent._parent, "addToScrollPosition", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL, 1);
        };
        _loc3.onRelease = _loc4.onRelease = function ()
        {
            this.onRollOver();
            _global.clearInterval(this.interval);
        };
        _loc3.onReleaseOutside = _loc4.onReleaseOutside = function ()
        {
            this.onRelease();
            this.onRollOut();
        };
        _loc5.onRollOver = function ()
        {
        };
        _loc5.onRollOut = function ()
        {
        };
        _loc5.onPress = function ()
        {
            this._parent._parent._nDragOffset = -this._ymouse;
            this.dispatchInterval = _global.setInterval(this._parent._parent, "dispatchScrollEvent", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL);
            this.scrollInterval = _global.setInterval(this._parent._parent, "scrollThumb", ank.gapi.controls.ScrollBar.SCROLL_INTERVAL, null, true);
        };
        _loc5.onRelease = function ()
        {
            _global.clearInterval(this.scrollInterval);
            _global.clearInterval(this.dispatchInterval);
        };
        _loc5.onReleaseOutside = function ()
        {
            this.onRelease();
            this.onRollOut();
        };
        _loc2.onPress = function ()
        {
            var _loc2 = this._parent._ymouse;
            var _loc3 = this._parent._parent._nPage;
            if (_loc2 < this._parent.thumb_mc._y)
            {
                _loc3 = -_loc3;
            } // end if
            this._parent._parent.addToScrollPosition(_loc3);
        };
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        var _loc3 = this._mcHolder.downArrow_mc;
        this.setMovieClipColor(_loc3.up_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.up_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.down_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.down_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.over_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.over_mc.arrow_mc, _loc2.sbarrowcolor);
        _loc3 = this._mcHolder.upArrow_mc;
        this.setMovieClipColor(_loc3.up_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.up_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.down_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.down_mc.arrow_mc, _loc2.sbarrowcolor);
        this.setMovieClipColor(_loc3.over_mc.bg_mc, _loc2.sbarrowbgcolor);
        this.setMovieClipColor(_loc3.over_mc.arrow_mc, _loc2.sbarrowcolor);
        for (var k in this._mcHolder.thumb_mc)
        {
            this.setMovieClipColor(this._mcHolder.thumb_mc[k], _loc2.sbthumbcolor);
        } // end of for...in
        this.setMovieClipColor(this._mcHolder.track_mc, _loc2.sbtrackcolor);
    };
    _loc1.size = function ()
    {
        super.size();
        this._nSize = this.__height;
        this.arrange();
        if (this.scrollTarget != undefined)
        {
            this.setScrollPropertiesToTarget();
        } // end if
    };
    _loc1.arrange = function ()
    {
        if (this._nSize == undefined)
        {
            return;
        } // end if
        if (this._bHorizontal)
        {
            this._rotation = -90;
        } // end if
        this._mcHolder.track_mc._height = Math.max(this._nSize - this._mcHolder.upArrow_mc._height - this._mcHolder.downArrow_mc._height, 0);
        this._mcHolder.track_mc._y = this._mcHolder.upArrow_mc._height;
        this._mcHolder.downArrow_mc._y = this._mcHolder.track_mc._y + this._mcHolder.track_mc._height;
        this._mcHolder.thumb_mc._y = this._mcHolder.track_mc._y;
        this.setScrollProperties(this._nPage, this._nMin, this._nMax);
    };
    _loc1.resizeThumb = function ()
    {
        if (this._nMax != this._nMin && this._nPage != 0)
        {
            this._mcHolder.thumb_mc.height = Math.min(Math.abs(this._nPage / (this._nMax - this._nMin)), 1) * this._mcHolder.track_mc._height;
            this._mcHolder.thumb_mc._y = this._mcHolder.upArrow_mc._height;
            if (this._mcHolder.thumb_mc._height > this._mcHolder.track_mc._height)
            {
                this._mcHolder.thumb_mc._visible = false;
            }
            else
            {
                this._mcHolder.thumb_mc._visible = true;
            } // end else if
        }
        else
        {
            this._mcHolder.thumb_mc._visible = false;
        } // end else if
    };
    _loc1.addToScrollPosition = function (nAmount)
    {
        this.scrollPosition = this.scrollPosition + nAmount;
    };
    _loc1.scrollThumb = function (nAmount, bDrag)
    {
        if (bDrag)
        {
            this.moveThumb(this._mcHolder._ymouse + this._nDragOffset);
        }
        else
        {
            this.moveThumb(this._mcHolder.thumb_mc._y + nAmount);
        } // end else if
        _global.updateAfterEvent();
    };
    _loc1.moveThumb = function (nY)
    {
        this._mcHolder.thumb_mc._y = nY;
        if (this._mcHolder.thumb_mc._y < this._mcHolder.upArrow_mc._height)
        {
            this._mcHolder.thumb_mc._y = this._mcHolder.upArrow_mc._height;
        }
        else if (this._mcHolder.thumb_mc._y > this._mcHolder.downArrow_mc._y - this._mcHolder.thumb_mc._height)
        {
            this._mcHolder.thumb_mc._y = this._mcHolder.downArrow_mc._y - this._mcHolder.thumb_mc._height;
        } // end else if
        this.dispatchScrollEvent();
    };
    _loc1.dispatchScrollEvent = function ()
    {
        if (this._mcHolder.thumb_mc._y != this._nPrevScrollPosition)
        {
            this._nPrevScrollPosition = Math.max(this._mcHolder.upArrow_mc._height, this._mcHolder.thumb_mc._y);
            this.dispatchEvent({type: "scroll", target: this});
        } // end if
    };
    _loc1.snapToTextField = function ()
    {
        if (this._sSnapTo == "right")
        {
            this._x = this._tTarget._x + this._tTarget._width - this._width;
            this._y = this._tTarget._y;
            this._tTarget._width = this._tTarget._width - this._width;
            this.height = this._tTarget._height;
            this.setScrollPropertiesToTarget();
        } // end if
    };
    _loc1.addTargetListener = function ()
    {
        this.removeEventListener("scroll", this._oListener);
        this._oListener = new Object();
        this._oListener.target = this._tTarget;
        this._oListener.parent = this;
        this._oListener.scroll = function (oEvent)
        {
            this.target.scroll = this.target.maxscroll * (this.parent.scrollPosition / Math.abs(this.parent._nMax - this.parent._nMin));
        };
        this.addEventListener("scroll", this._oListener);
        this.setScrollPropertiesToTarget();
    };
    _loc1.setScrollPropertiesToTarget = function ()
    {
        if (this._tTarget == undefined)
        {
            this.setScrollProperties(this._nPage, this._nMin, this._nMax);
        }
        else
        {
            var _loc2 = _global.isNaN(Number(this._tTarget.maxscroll)) ? (1) : (this._tTarget.maxscroll);
            var _loc3 = _global.isNaN(Number(this._tTarget._height)) ? (0) : (this._tTarget._height);
            var _loc4 = _global.isNaN(Number(this._tTarget.textHeight)) ? (1) : (this._tTarget.textHeight);
            var _loc5 = 9.000000E-001 * _loc3 / _loc4 * _loc2;
            this.setScrollProperties(_loc5, 0, _loc2);
        } // end else if
    };
    _loc1.onChanged = function ()
    {
        this.setScrollPropertiesToTarget();
        this.scrollPosition = this._tTarget.scroll;
    };
    _loc1.onScroller = function ()
    {
        this.scrollPosition = this._tTarget.scroll;
    };
    _loc1.addProperty("scrollPosition", _loc1.__get__scrollPosition, _loc1.__set__scrollPosition);
    _loc1.addProperty("snapTo", function ()
    {
    }, _loc1.__set__snapTo);
    _loc1.addProperty("page", _loc1.__get__page, _loc1.__set__page);
    _loc1.addProperty("horizontal", function ()
    {
    }, _loc1.__set__horizontal);
    _loc1.addProperty("scrollTarget", _loc1.__get__scrollTarget, _loc1.__set__scrollTarget);
    _loc1.addProperty("max", _loc1.__get__max, _loc1.__set__max);
    _loc1.addProperty("min", _loc1.__get__min, _loc1.__set__min);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ScrollBar = function ()
    {
        super();
    }).CLASS_NAME = "ScrollBar";
    (_global.ank.gapi.controls.ScrollBar = function ()
    {
        super();
    }).SCROLL_INTERVAL = 40;
} // end if
#endinitclip
