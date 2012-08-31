// Action script...

// [Initial MovieClip Action of sprite 35]
#initclip 9
class ank.gapi.controls.Label extends ank.gapi.core.UIBasicComponent
{
    var _bHTML, __get__html, __get__multiline, __get__wordWrap, _sText, _bSettingNewText, __get__text, _tText, __get__textHeight, __get__textWidth, setSize, _tfFormatter, __height, __width, createTextField, _tDotText, _mcDot, getStyle, createEmptyMovieClip, drawRoundRect, _parent, dispatchEvent, __set__html, __set__multiline, __set__text, __set__wordWrap;
    function Label()
    {
        super();
    } // End of the function
    function set html(bHTML)
    {
        _bHTML = bHTML;
        this.setTextFieldProperties();
        //return (this.html());
        null;
    } // End of the function
    function get html()
    {
        return (_bHTML);
    } // End of the function
    function set multiline(bMultiline)
    {
        _bMultiline = bMultiline;
        this.setTextFieldProperties();
        //return (this.multiline());
        null;
    } // End of the function
    function get multiline()
    {
        return (_bMultiline);
    } // End of the function
    function set wordWrap(bWordWrap)
    {
        _bWordWrap = bWordWrap;
        this.setTextFieldProperties();
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
        _bSettingNewText = true;
        this.setTextFieldProperties();
        //return (this.text());
        null;
    } // End of the function
    function get text()
    {
        return (_tText.text == undefined ? (_sText) : (_tText.text));
    } // End of the function
    function get textHeight()
    {
        return (_tText.textHeight);
    } // End of the function
    function get textWidth()
    {
        return (_tText.textWidth);
    } // End of the function
    function setPreferedSize(sAutoSizeAlign)
    {
        _tText.autoSize = sAutoSizeAlign;
        this.setSize(this.__get__textWidth() + 5, this.__get__textHeight());
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Label.CLASS_NAME);
        _tfFormatter = new TextFormat();
    } // End of the function
    function createChildren()
    {
        this.createTextField("_tText", 10, 0, 1, __width, __height - 1);
        _tText.addListener(this);
        this.setTextFieldProperties();
    } // End of the function
    function size()
    {
        super.size();
        _tText._height = __height - 1;
        _tDotText.removeTextField();
        _mcDot.removeMovieClip();
        if (_tText.textWidth > __width && _sTextfiledType == "dynamic")
        {
            this.createTextField("_tDotText", 20, 0, 1, __width, __height - 1);
            _tDotText.selectable = false;
            _tDotText.autoSize = "right";
            _tDotText.embedFonts = this.getStyle().labelembedfonts;
            _tDotText.text = "...";
            _tDotText.setNewTextFormat(_tfFormatter);
            _tDotText.setTextFormat(_tfFormatter);
            _tText._width = __width - _tDotText.textWidth;
            this.createEmptyMovieClip("_mcDot", 30);
            this.drawRoundRect(_mcDot, __width - _tDotText.textWidth, 0, _tDotText.textWidth + 5, __height, 0, 0, 0);
            _mcDot.onRollOver = function ()
            {
                _global.API.ui.showTooltip(_parent._sText, _parent, -20);
            };
            _mcDot.onRollOut = function ()
            {
                _global.API.ui.hideTooltip();
            };
        }
        else
        {
            _tText._width = __width;
        } // end else if
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _tfFormatter = _tText.getTextFormat();
        _tfFormatter.font = _loc2.labelfont;
        _tfFormatter.align = _loc2.labelalign;
        _tfFormatter.size = _loc2.labelsize;
        if (!_bHTML)
        {
            _tfFormatter.color = _loc2.labelcolor;
        } // end if
        _tfFormatter.bold = _loc2.labelbold;
        _tfFormatter.italic = _loc2.labelitalic;
        _tText.embedFonts = _loc2.labelembedfonts;
        this.setTextFieldProperties();
    } // End of the function
    function setTextFieldProperties()
    {
        if (_tText != undefined)
        {
            _tText.wordWrap = _bWordWrap;
            _tText.multiline = _bMultiline;
            _tText.selectable = _sTextfiledType == "input";
            _tText.type = _sTextfiledType;
            _tText.html = _bHTML ? (true) : (false);
            if (_tfFormatter.font != undefined)
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
            } // end if
            if (_tText.textWidth > __width && _sTextfiledType == "dynamic")
            {
                this.size();
            }
            else
            {
                _tDotText.removeTextField();
                _mcDot.removeMovieClip();
            } // end else if
            this.onChanged();
        } // end if
    } // End of the function
    function onChanged()
    {
        this.dispatchEvent({type: "change"});
    } // End of the function
    static var CLASS_NAME = "Label";
    var _sTextfiledType = "dynamic";
    var _bMultiline = false;
    var _bWordWrap = false;
} // End of Class
#endinitclip
