// Action script...

// [Initial MovieClip Action of sprite 198]
#initclip 35
class ank.gapi.controls.Container extends ank.gapi.core.UIBasicComponent
{
    var _ldrContent, addToQueue, __get__contentPath, _oContentData, __set__contentPath, __get__label, __set__label, __get__contentData, _mcHighlight, __get__selected, _bInitialized, __get__backgroundRenderer, _sBorder, __get__borderRenderer, __get__highlightRenderer, __get__dragAndDrop, _sLabel, _lblText, __width, __height, getStyle, attachMovie, _mcLabelBackground, __get__showLabel, __get__margin, __get__highlightFront, createEmptyMovieClip, _mcInteraction, drawRoundRect, _mcBg, _bEnabled, _parent, __set__backgroundRenderer, __set__borderRenderer, __get__content, __set__contentData, __set__dragAndDrop, __set__highlightFront, __set__highlightRenderer, __get__holder, __set__margin, __set__selected, __set__showLabel;
    function Container()
    {
        super();
    } // End of the function
    function set contentPath(sContentPath)
    {
        this.addToQueue({object: this, method: function (sPath)
        {
            _ldrContent.contentPath = sPath;
        }, params: [sContentPath]});
        //return (this.contentPath());
        null;
    } // End of the function
    function get contentPath()
    {
        //return (_ldrContent.contentPath());
    } // End of the function
    function set contentData(oContentData)
    {
        _oContentData = oContentData;
        if (_oContentData.params != undefined)
        {
            _ldrContent.__set__contentParams(_oContentData.params);
        } // end if
        if (oContentData.iconFile != undefined)
        {
            this.__set__contentPath(oContentData.iconFile);
        }
        else
        {
            this.__set__contentPath("");
        } // end else if
        if (oContentData.label != undefined)
        {
            if (this.__get__label() != oContentData.label)
            {
                this.__set__label(oContentData.label);
            } // end if
        }
        else
        {
            this.__set__label("");
        } // end else if
        //return (this.contentData());
        null;
    } // End of the function
    function get contentData()
    {
        return (_oContentData);
    } // End of the function
    function get content()
    {
        //return (_ldrContent.content());
    } // End of the function
    function get holder()
    {
        //return (_ldrContent.holder());
    } // End of the function
    function set selected(bSelected)
    {
        _bSelected = bSelected;
        this.addToQueue({object: this, method: function ()
        {
            _mcHighlight._visible = bSelected;
        }});
        //return (this.selected());
        null;
    } // End of the function
    function get selected()
    {
        return (_bSelected);
    } // End of the function
    function set backgroundRenderer(sBackground)
    {
        if (sBackground.length == 0 || sBackground == undefined)
        {
            return;
        } // end if
        _sBackground = sBackground;
        this.attachBackground();
        if (_bInitialized)
        {
            this.size();
        } // end if
        //return (this.backgroundRenderer());
        null;
    } // End of the function
    function set borderRenderer(sBorder)
    {
        if (sBorder.length == 0 || sBorder == undefined)
        {
            return;
        } // end if
        _sBorder = sBorder;
        this.attachBorder();
        if (_bInitialized)
        {
            this.size();
        } // end if
        //return (this.borderRenderer());
        null;
    } // End of the function
    function set highlightRenderer(sHighlight)
    {
        if (sHighlight.length == 0 || sHighlight == undefined)
        {
            return;
        } // end if
        _sHighlight = sHighlight;
        this.attachHighlight();
        if (_bInitialized)
        {
            this.size();
        } // end if
        //return (this.highlightRenderer());
        null;
    } // End of the function
    function set dragAndDrop(bDragAndDrop)
    {
        if (bDragAndDrop == undefined)
        {
            return;
        } // end if
        _bDragAndDrop = bDragAndDrop;
        if (_bInitialized)
        {
            this.setEnabled();
        } // end if
        //return (this.dragAndDrop());
        null;
    } // End of the function
    function get dragAndDrop()
    {
        return (_bDragAndDrop);
    } // End of the function
    function set showLabel(bShowLabel)
    {
        if (bShowLabel == undefined)
        {
            return;
        } // end if
        _bShowLabel = bShowLabel;
        if (bShowLabel)
        {
            if (_sLabel != undefined)
            {
                if (_lblText == undefined)
                {
                    this.attachMovie("Label", "_lblText", 30, {_width: __width, _height: __height, styleName: this.getStyle().labelstyle});
                } // end if
                this.addToQueue({object: this, method: setLabel, params: [_sLabel]});
            } // end if
        }
        else
        {
            _lblText.removeMovieClip();
            _mcLabelBackground.clear();
        } // end else if
        //return (this.showLabel());
        null;
    } // End of the function
    function get showLabel()
    {
        return (_bShowLabel);
    } // End of the function
    function set label(sLabel)
    {
        _sLabel = sLabel;
        if (_bShowLabel)
        {
            if (_lblText == undefined)
            {
                this.attachMovie("Label", "_lblText", 30, {_width: __width, _height: __height, styleName: this.getStyle().labelstyle});
            } // end if
            this.addToQueue({object: this, method: setLabel, params: [sLabel]});
        } // end if
        //return (this.label());
        null;
    } // End of the function
    function get label()
    {
        return (_sLabel);
    } // End of the function
    function set margin(nMargin)
    {
        nMargin = Number(nMargin);
        if (isNaN(nMargin))
        {
            return;
        } // end if
        _nMargin = nMargin;
        //return (this.margin());
        null;
    } // End of the function
    function get margin()
    {
        return (_nMargin);
    } // End of the function
    function set highlightFront(bHighlightFront)
    {
        _bHighlightFront = bHighlightFront;
        if (!bHighlightFront && _mcHighlight != undefined)
        {
            _mcHighlight.swapDepths(1);
        } // end if
        //return (this.highlightFront());
        null;
    } // End of the function
    function get highlightFront()
    {
        return (_bHighlightFront);
    } // End of the function
    function forceNextLoad()
    {
        _ldrContent.forceNextLoad();
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Container.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.createEmptyMovieClip("_mcInteraction", 0);
        this.drawRoundRect(_mcInteraction, 0, 0, 1, 1, 0, 0, 0);
        _mcInteraction.trackAsMenu = true;
        this.attachMovie("Loader", "_ldrContent", 20, {scaleContent: true});
        _ldrContent.move(_nMargin, _nMargin);
        this.createEmptyMovieClip("_mcLabelBackground", 29);
    } // End of the function
    function size()
    {
        super.size();
        if (_bInitialized)
        {
            this.arrange();
        } // end if
    } // End of the function
    function arrange()
    {
        _mcInteraction._width = __width;
        _mcInteraction._height = __height;
        _ldrContent.setSize(__width - _nMargin * 2, __height - _nMargin * 2);
        _mcBg.setSize(__width, __height);
        _mcHighlight.setSize(__width, __height);
        _lblText.setSize(__width, __height);
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _mcBg.styleName = _loc2.backgroundstyle;
        _lblText.__set__styleName(_loc2.labelstyle);
    } // End of the function
    function setEnabled()
    {
        if (_bEnabled)
        {
            _mcInteraction.onRelease = function ()
            {
                if (_parent._sLastMouseAction == "DragOver")
                {
                    _parent.dispatchEvent({type: "drop"});
                }
                else if (getTimer() - _parent._nLastClickTime < ank.gapi.controls.Container.DBLCLICK_DELAY)
                {
                    ank.utils.Timer.removeTimer(_parent, "container");
                    _parent.dispatchEvent({type: "dblClick"});
                }
                else
                {
                    ank.utils.Timer.setTimer(_parent, "container", _parent, _parent.dispatchEvent, ank.gapi.controls.Container.DBLCLICK_DELAY, [{type: "click"}]);
                } // end else if
                _parent._sLastMouseAction = "Release";
                _parent._nLastClickTime = getTimer();
            };
            _mcInteraction.onPress = function ()
            {
                _parent._sLastMouseAction = "Press";
            };
            _mcInteraction.onRollOver = function ()
            {
                _parent._mcHighlight._visible = true;
                _parent._sLastMouseAction = "RollOver";
                _parent.dispatchEvent({type: "over"});
            };
            _mcInteraction.onRollOut = function ()
            {
                if (!_parent._bSelected)
                {
                    _parent._mcHighlight._visible = false;
                } // end if
                _parent._sLastMouseAction = "RollOver";
                _parent.dispatchEvent({type: "out"});
            };
            if (_bDragAndDrop)
            {
                _mcInteraction.onDragOver = function ()
                {
                    _parent._mcHighlight._visible = true;
                    _parent._sLastMouseAction = "DragOver";
                    _parent.dispatchEvent({type: "over"});
                };
                _mcInteraction.onDragOut = function ()
                {
                    if (!_parent._bSelected)
                    {
                        _parent._mcHighlight._visible = false;
                    } // end if
                    if (_parent._sLastMouseAction == "Press")
                    {
                        _parent.dispatchEvent({type: "drag"});
                    } // end if
                    _parent._sLastMouseAction = "DragOut";
                    _parent.dispatchEvent({type: "out"});
                };
            } // end if
        }
        else
        {
            delete _mcInteraction.onRelease;
            delete _mcInteraction.onPress;
            delete _mcInteraction.onRollOver;
            delete _mcInteraction.onRollOut;
            delete _mcInteraction.onDragOver;
            delete _mcInteraction.onDragOut;
        } // end else if
    } // End of the function
    function attachBackground()
    {
        this.attachMovie(_sBackground, "_mcBg", 10);
    } // End of the function
    function attachBorder()
    {
        this.attachMovie(_sBorder, "_mcBorder", 90);
    } // End of the function
    function attachHighlight()
    {
        this.attachMovie(_sHighlight, "_mcHighlight", _bHighlightFront ? (100) : (5));
        _mcHighlight._visible = false;
    } // End of the function
    function setLabel(sLabel)
    {
        if (_bShowLabel)
        {
            _lblText.__set__text(sLabel);
            var _loc3 = Math.min(_lblText.__get__textWidth() + 2, __width - 4);
            var _loc2 = _lblText.__get__textHeight();
            _mcLabelBackground.clear();
            if (_loc3 > 2 && _loc2 != 0)
            {
                this.drawRoundRect(_mcLabelBackground, 2, 2, _loc3, _loc2 + 2, 0, 0, 50);
            } // end if
        }
        else
        {
            _lblText.removeMovieClip();
            _mcLabelBackground.clear();
        } // end else if
    } // End of the function
    static var CLASS_NAME = "Container";
    static var DBLCLICK_DELAY = 250;
    var _sBackground = "DefaultBackground";
    var _sHighlight = "DefaultHighlight";
    var _bDragAndDrop = true;
    var _bShowLabel = false;
    var _bSelected = false;
    var _nMargin = 2;
    var _bHighlightFront = true;
} // End of Class
#endinitclip
