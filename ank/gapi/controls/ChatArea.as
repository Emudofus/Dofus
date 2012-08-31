// Action script...

// [Initial MovieClip Action of sprite 459]
#initclip 233
class ank.gapi.controls.ChatArea extends ank.gapi.core.UIBasicComponent
{
    var _bInitialized, addToQueue, __get__selectable, __get__wordWrap, _sText, __get__initialized, __get__text, _tText, __get__scrollBarSide, __get__scrollBarMargin, __get__hideScrollBar, _tfFormatter, __height, __width, createTextField, getStyle, _sbVertical, attachMovie, _target, dispatchEvent, __set__hideScrollBar, __get__htmlText, __set__scrollBarMargin, __set__scrollBarSide, __set__selectable, __set__text, __set__wordWrap;
    function ChatArea()
    {
        super();
    } // End of the function
    function set selectable(bSelectable)
    {
        _bSelectable = bSelectable;
        if (_bInitialized)
        {
            this.addToQueue({object: this, method: setTextFieldProperties});
        } // end if
        //return (this.selectable());
        null;
    } // End of the function
    function get selectable()
    {
        return (_bSelectable);
    } // End of the function
    function set wordWrap(bWordWrap)
    {
        _bWordWrap = bWordWrap;
        if (_bInitialized)
        {
            this.addToQueue({object: this, method: setTextFieldProperties});
        } // end if
        //return (this.wordWrap());
        null;
    } // End of the function
    function get wordWrap()
    {
        return (_bWordWrap);
    } // End of the function
    function set text(sText)
    {
        _sText = sText;
        if (this.__get__initialized())
        {
            this.setTextFieldProperties();
        } // end if
        //return (this.text());
        null;
    } // End of the function
    function get text()
    {
        return (_tText.text);
    } // End of the function
    function get htmlText()
    {
        return (_tText.htmlText);
    } // End of the function
    function set scrollBarSide(sScrollBarSide)
    {
        _sScrollBarSide = sScrollBarSide;
        //return (this.scrollBarSide());
        null;
    } // End of the function
    function get scrollBarSide()
    {
        return (_sScrollBarSide);
    } // End of the function
    function set scrollBarMargin(nScrollBarMargin)
    {
        _nScrollBarMargin = nScrollBarMargin;
        //return (this.scrollBarMargin());
        null;
    } // End of the function
    function get scrollBarMargin()
    {
        return (_nScrollBarMargin);
    } // End of the function
    function set hideScrollBar(bHideScrollBar)
    {
        _bHideScrollBar = bHideScrollBar;
        //return (this.hideScrollBar());
        null;
    } // End of the function
    function get hideScrollBar()
    {
        return (_bHideScrollBar);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ChatArea.CLASS_NAME);
        _tfFormatter = new TextFormat();
    } // End of the function
    function createChildren()
    {
        this.createTextField("_tText", 10, 0, 0, __width - 2, __height - 2);
        _tText._x = 1;
        _tText._y = 1;
        _tText.addListener(this);
        _tText.mouseWheelEnabled = true;
        this.addToQueue({object: this, method: setTextFieldProperties});
        ank.utils.MouseEvents.addListener(this);
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        _tText._height = __height;
        _tText._width = __width;
        _bInvalidateMaxScrollStop = true;
        this.setTextFieldProperties();
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _tfFormatter = new TextFormat();
        _tfFormatter.font = _loc2.font;
        _tfFormatter.align = _loc2.align;
        _tfFormatter.size = _loc2.size;
        _tfFormatter.color = _loc2.color;
        _tfFormatter.bold = _loc2.bold;
        _tfFormatter.italic = _loc2.italic;
        _tText.embedFonts = _loc2.embedfonts;
        _sbVertical.__set__styleName(_loc2.scrollbarstyle);
    } // End of the function
    function setTextFieldProperties()
    {
        if (_tText != undefined)
        {
            _tText.wordWrap = _bWordWrap ? (true) : (false);
            _tText.multiline = true;
            _tText.selectable = _bSelectable;
            _tText.embedFonts = this.getStyle().embedfonts;
            _tText.type = "dynamic";
            _tText.html = true;
            if (_tfFormatter.font != undefined)
            {
                if (_sText != undefined)
                {
                    _nPreviousMaxscroll = _tText.maxscroll;
                    this.setTextWithBottomStart();
                } // end if
                _tText.setNewTextFormat(_tfFormatter);
                _tText.setTextFormat(_tfFormatter);
            } // end if
            this.onChanged();
        } // end if
    } // End of the function
    function addScrollBar()
    {
        if (_sbVertical == undefined)
        {
            this.attachMovie("ScrollBar", "_sbVertical", 20, {styleName: this.getStyle().scrollbarstyle, _visible: !_bHideScrollBar});
            _sbVertical.addEventListener("scroll", this);
        } // end if
        _sbVertical.setSize(__height - 2);
        _sbVertical._y = 1;
        _sbVertical._x = _sScrollBarSide == "right" ? (__width - _sbVertical._width - 3) : (0);
        if (_bHideScrollBar)
        {
            _tText._width = __width;
            _tText._x = 0;
        }
        else
        {
            _tText._width = __width - _sbVertical._width - 3 - _nScrollBarMargin;
            _tText._x = _sScrollBarSide == "right" ? (0) : (_sbVertical._width + _nScrollBarMargin);
        } // end else if
        this.setScrollBarPosition();
        if (Math.abs(_nPreviousMaxscroll - _tText.scroll) < ank.gapi.controls.ChatArea.STOP_SCROLL_LENGTH || _bInvalidateMaxScrollStop)
        {
            _tText.scroll = _tText.maxscroll;
        } // end if
        _bInvalidateMaxScrollStop = false;
    } // End of the function
    function setScrollBarPosition()
    {
        var _loc3 = _tText.textHeight;
        var _loc2 = 9.000000E-001 * _tText._height / _loc3 * _tText.maxscroll;
        _sbVertical.setScrollProperties(_loc2, 0, _tText.maxscroll);
        _sbVertical.__set__scrollPosition(_tText.scroll);
    } // End of the function
    function setTextWithBottomStart()
    {
        _tText.text = "";
        for (var _loc2 = 0; _tText.maxscroll == 1 && _loc2 < 50; ++_loc2)
        {
            _tText.text = _tText.text + "\n";
        } // end of for
        _tText.htmlText = _tText.htmlText + _sText;
    } // End of the function
    function onMouseWheel(nDelta, mc)
    {
        if (String(mc._target).indexOf(_target) != -1)
        {
            _sbVertical.scrollPosition = _sbVertical.scrollPosition - nDelta;
        } // end if
    } // End of the function
    function onChanged()
    {
        this.addScrollBar();
    } // End of the function
    function onScroller()
    {
        this.setScrollBarPosition();
    } // End of the function
    function scroll(oEvent)
    {
        if (oEvent.target == _sbVertical)
        {
            _tText.scroll = oEvent.target.scrollPosition;
        } // end if
    } // End of the function
    function onHref(sParams)
    {
        this.dispatchEvent({type: "href", params: sParams});
    } // End of the function
    static var CLASS_NAME = "ChatArea";
    static var STOP_SCROLL_LENGTH = 6;
    var _bSelectable = true;
    var _bWordWrap = true;
    var _sScrollBarSide = "right";
    var _nScrollBarMargin = 0;
    var _bHideScrollBar = false;
    var _bInvalidateMaxScrollStop = false;
    var _nPreviousMaxscroll = 1;
} // End of Class
#endinitclip
