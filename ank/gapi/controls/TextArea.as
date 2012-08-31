// Action script...

// [Initial MovieClip Action of sprite 168]
#initclip 23
class ank.gapi.controls.TextArea extends ank.gapi.core.UIBasicComponent
{
    var _bBorder, border_mc, drawBorder, __get__border, _sURL, __get__url, _bInitialized, addToQueue, __get__editable, __get__autoHeight, __get__selectable, __get__wordWrap, __get__html, _sText, _bSettingNewText, __get__text, _tText, __get__scrollBarRight, __get__scrollBarMargin, _cssStyles, __get__styleSheet, __get__scrollPosition, __get__maxscroll, __get__maxChars, _tfFormatter, __height, __width, createTextField, _sbVertical, getStyle, _lvText, parent, attachMovie, setSize, dispatchEvent, _target, __set__autoHeight, __set__border, __set__editable, __set__html, __set__maxChars, __set__maxscroll, __set__scrollBarMargin, __set__scrollBarRight, __set__scrollPosition, __set__selectable, __set__styleSheet, __set__text, __set__url, __set__wordWrap;
    function TextArea()
    {
        super();
    } // End of the function
    function set border(bBorder)
    {
        _bBorder = bBorder;
        if (border_mc == undefined)
        {
            this.drawBorder();
        } // end if
        border_mc._visible = bBorder;
        //return (this.border());
        null;
    } // End of the function
    function get border()
    {
        return (_bBorder);
    } // End of the function
    function set url(sURL)
    {
        _sURL = sURL;
        if (_sURL != "")
        {
            this.loadText();
        } // end if
        //return (this.url());
        null;
    } // End of the function
    function set editable(bEditable)
    {
        _bEditable = bEditable;
        if (_bInitialized)
        {
            this.addToQueue({object: this, method: setTextFieldProperties});
        } // end if
        //return (this.editable());
        null;
    } // End of the function
    function get editable()
    {
        return (_bEditable);
    } // End of the function
    function set autoHeight(bAutoHeight)
    {
        _bAutoHeight = bAutoHeight;
        if (_bInitialized)
        {
            this.addToQueue({object: this, method: setTextFieldProperties});
        } // end if
        //return (this.autoHeight());
        null;
    } // End of the function
    function get autoHeight()
    {
        return (_bAutoHeight);
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
    function set html(bHTML)
    {
        _bHTML = bHTML;
        if (_bInitialized)
        {
            this.addToQueue({object: this, method: setTextFieldProperties});
        } // end if
        //return (this.html());
        null;
    } // End of the function
    function get html()
    {
        return (_bHTML);
    } // End of the function
    function set text(sText)
    {
        _sText = sText;
        _bSettingNewText = true;
        this.addToQueue({object: this, method: setTextFieldProperties});
        //return (this.text());
        null;
    } // End of the function
    function get text()
    {
        return (_tText.text);
    } // End of the function
    function set scrollBarRight(bScrollBarRight)
    {
        _bScrollBarRight = bScrollBarRight;
        //return (this.scrollBarRight());
        null;
    } // End of the function
    function get scrollBarRight()
    {
        return (_bScrollBarRight);
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
    function set styleSheet(sCSS)
    {
        if (sCSS != "")
        {
            var _owner = this;
            _cssStyles = new TextField.StyleSheet();
            _cssStyles.load(sCSS);
            _cssStyles.onLoad = function (bSuccess)
            {
                if (_owner._tText != undefined)
                {
                    _owner.addToQueue({object: _owner, method: _owner.setTextFieldProperties});
                } // end if
            };
        }
        else
        {
            _cssStyles = undefined;
            _tText.styleSheet = null;
        } // end else if
        //return (this.styleSheet());
        null;
    } // End of the function
    function set scrollPosition(nScrollPosition)
    {
        _tText.scroll = nScrollPosition;
        //return (this.scrollPosition());
        null;
    } // End of the function
    function get scrollPosition()
    {
        return (_tText.scroll);
    } // End of the function
    function set maxscroll(nMaxScroll)
    {
        _tText.maxscroll = nMaxScroll;
        //return (this.maxscroll());
        null;
    } // End of the function
    function get maxscroll()
    {
        return (_tText.maxscroll);
    } // End of the function
    function set maxChars(nMaxChars)
    {
        _tText.maxChars = nMaxChars;
        //return (this.maxChars());
        null;
    } // End of the function
    function get maxChars()
    {
        return (_tText.maxChars);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.TextArea.CLASS_NAME);
        if (_sURL != undefined)
        {
            this.loadText();
        } // end if
        _tfFormatter = new TextFormat();
    } // End of the function
    function createChildren()
    {
        this.createTextField("_tText", 10, 0, 0, __width - 2, __height - 2);
        _tText._x = 1;
        _tText._y = 1;
        _tText.addListener(this);
        ank.utils.MouseEvents.addListener(this);
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        _sbVertical.setSize(__height);
        _tText._height = __height;
        _tText._width = __width;
    } // End of the function
    function draw()
    {
        if (_bBorder)
        {
            this.drawBorder();
        } // end if
        if (!_bBorder != undefined)
        {
            border_mc._visible = _bBorder;
        } // end if
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
    function loadText()
    {
        if (_sURL == undefined || _sURL == "")
        {
            return;
        } // end if
        _lvText = new LoadVars();
        _lvText.parent = this;
        _lvText.onData = function (sData)
        {
            parent.text = sData;
        };
        _lvText.load(_sURL);
    } // End of the function
    function setTextFieldProperties()
    {
        if (_tText != undefined)
        {
            if (_bAutoHeight)
            {
                _tText.autoSize = "left";
            } // end if
            _tText.wordWrap = _bWordWrap ? (true) : (false);
            _tText.multiline = true;
            _tText.selectable = _bSelectable;
            _tText.type = _bEditable ? ("input") : ("dynamic");
            _tText.html = _bHTML;
            if (_cssStyles != undefined)
            {
                _tText.styleSheet = _cssStyles;
                if (_sText != undefined)
                {
                    if (_bHTML)
                    {
                        _tText.htmlText = _sText;
                    }
                    else
                    {
                        _tText.text = _sText;
                    } // end if
                } // end else if
            }
            else if (_tfFormatter.font != undefined)
            {
                if (_sText != undefined)
                {
                    if (_bHTML)
                    {
                        _tText.htmlText = _sText;
                    }
                    else
                    {
                        _tText.text = _sText;
                    } // end if
                } // end else if
                _tText.setNewTextFormat(_tfFormatter);
                _tText.setTextFormat(_tfFormatter);
            } // end else if
            this.onChanged();
        } // end if
    } // End of the function
    function addScrollBar()
    {
        if (_sbVertical == undefined)
        {
            this.attachMovie("ScrollBar", "_sbVertical", 20, {styleName: this.getStyle().scrollbarstyle});
            _sbVertical.setSize(__height - 2);
            _sbVertical._y = 1;
            _sbVertical._x = _bScrollBarRight ? (__width - _sbVertical._width - 3) : (0);
            _tText._width = __width - _sbVertical._width - 3 - _nScrollBarMargin;
            _tText._x = _bScrollBarRight ? (0) : (_sbVertical._width + _nScrollBarMargin);
            _sbVertical.addEventListener("scroll", this);
        } // end if
        var _loc3 = _tText.textHeight;
        var _loc2 = 9.000000E-001 * _tText._height / _loc3 * _tText.maxscroll;
        _sbVertical.setScrollProperties(_loc2, 0, _tText.maxscroll);
        _sbVertical.__set__scrollPosition(_tText.scroll);
        if (_bSettingNewText)
        {
            _sbVertical.__set__scrollPosition(0);
            _bSettingNewText = false;
        } // end if
    } // End of the function
    function removeScrollBar()
    {
        if (_sbVertical != undefined)
        {
            _sbVertical.removeMovieClip();
            _tText._width = __width;
        } // end if
    } // End of the function
    function onChanged()
    {
        if (_tText.textHeight >= _tText._height || _cssStyles != undefined && _tText.textHeight + 5 >= _tText._height)
        {
            this.addScrollBar();
        }
        else
        {
            this.removeScrollBar();
        } // end else if
        if (_bAutoHeight)
        {
            this.setSize(__width, _tText.textHeight);
        } // end if
        this.dispatchEvent({type: "change"});
    } // End of the function
    function scroll(oEvent)
    {
        if (oEvent.target == _sbVertical)
        {
            _tText.scroll = oEvent.target.scrollPosition;
        } // end if
    } // End of the function
    function onMouseWheel(nDelta, mc)
    {
        if (String(mc._target).indexOf(_target) != -1)
        {
            _sbVertical.scrollPosition = _sbVertical.scrollPosition - nDelta;
        } // end if
    } // End of the function
    static var CLASS_NAME = "TextArea";
    var _bEditable = true;
    var _bSelectable = true;
    var _bAutoHeight = false;
    var _bWordWrap = true;
    var _bScrollBarRight = true;
    var _bHTML = false;
    var _nScrollBarMargin = 0;
} // End of Class
#endinitclip
