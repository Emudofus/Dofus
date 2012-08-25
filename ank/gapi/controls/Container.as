// Action script...

// [Initial MovieClip Action of sprite 20849]
#initclip 114
if (!ank.gapi.controls.Container)
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
    var _loc1 = (_global.ank.gapi.controls.Container = function ()
    {
        super();
    }).prototype;
    _loc1.__set__contentPath = function (sContentPath)
    {
        this.addToQueue({object: this, method: function (sPath)
        {
            this._ldrContent.contentPath = sPath;
        }, params: [sContentPath]});
        //return (this.contentPath());
    };
    _loc1.__set__forceReload = function (bReload)
    {
        this._ldrContent.forceReload = bReload;
        //return (this.forceReload());
    };
    _loc1.__get__contentPath = function ()
    {
        return (this._ldrContent.contentPath);
    };
    _loc1.__set__contentData = function (oContentData)
    {
        this._oContentData = oContentData;
        if (this._oContentData.params != undefined)
        {
            this._ldrContent.contentParams = this._oContentData.params;
        } // end if
        if (oContentData.iconFile != undefined)
        {
            this.contentPath = oContentData.iconFile;
        }
        else
        {
            this.contentPath = "";
        } // end else if
        if (oContentData.label != undefined)
        {
            if (this.label != oContentData.label)
            {
                this.label = oContentData.label;
            } // end if
        }
        else
        {
            this.label = "";
        } // end else if
        //return (this.contentData());
    };
    _loc1.__get__contentData = function ()
    {
        return (this._oContentData);
    };
    _loc1.__get__content = function ()
    {
        return (this._ldrContent.content);
    };
    _loc1.__get__holder = function ()
    {
        return (this._ldrContent.holder);
    };
    _loc1.__set__selected = function (bSelected)
    {
        this._bSelected = bSelected;
        this.addToQueue({object: this, method: function ()
        {
            this._mcHighlight._visible = bSelected;
        }});
        //return (this.selected());
    };
    _loc1.__get__selected = function ()
    {
        return (this._bSelected);
    };
    _loc1.__set__backgroundRenderer = function (sBackground)
    {
        if (sBackground.length == 0 || sBackground == undefined)
        {
            return;
        } // end if
        this._sBackground = sBackground;
        this.attachBackground();
        if (this._bInitialized)
        {
            this.size();
        } // end if
        //return (this.backgroundRenderer());
    };
    _loc1.__set__borderRenderer = function (sBorder)
    {
        if (sBorder.length == 0 || sBorder == undefined)
        {
            return;
        } // end if
        this._sBorder = sBorder;
        this.attachBorder();
        if (this._bInitialized)
        {
            this.size();
        } // end if
        //return (this.borderRenderer());
    };
    _loc1.__set__highlightRenderer = function (sHighlight)
    {
        if (sHighlight.length == 0 || sHighlight == undefined)
        {
            return;
        } // end if
        this._sHighlight = sHighlight;
        this.attachHighlight();
        if (this._bInitialized)
        {
            this.size();
        } // end if
        //return (this.highlightRenderer());
    };
    _loc1.__set__dragAndDrop = function (bDragAndDrop)
    {
        if (bDragAndDrop == undefined)
        {
            return;
        } // end if
        this._bDragAndDrop = bDragAndDrop;
        if (this._bInitialized)
        {
            this.setEnabled();
        } // end if
        //return (this.dragAndDrop());
    };
    _loc1.__get__dragAndDrop = function ()
    {
        return (this._bDragAndDrop);
    };
    _loc1.__set__showLabel = function (bShowLabel)
    {
        if (bShowLabel == undefined)
        {
            return;
        } // end if
        this._bShowLabel = bShowLabel;
        if (bShowLabel)
        {
            if (this._sLabel != undefined)
            {
                if (this._lblText == undefined)
                {
                    this.attachMovie("Label", "_lblText", 30, {_width: this.__width, _height: this.__height, styleName: this.getStyle().labelstyle});
                } // end if
                this.addToQueue({object: this, method: this.setLabel, params: [this._sLabel]});
            } // end if
        }
        else
        {
            this._lblText.removeMovieClip();
            this._mcLabelBackground.clear();
        } // end else if
        //return (this.showLabel());
    };
    _loc1.__get__showLabel = function ()
    {
        return (this._bShowLabel);
    };
    _loc1.__set__label = function (sLabel)
    {
        this._sLabel = sLabel;
        if (this._bShowLabel)
        {
            if (this._lblText == undefined)
            {
                this.attachMovie("Label", "_lblText", 30, {_width: this.__width, _height: this.__height, styleName: this.getStyle().labelstyle});
            } // end if
            this.addToQueue({object: this, method: this.setLabel, params: [sLabel]});
        } // end if
        //return (this.label());
    };
    _loc1.__get__label = function ()
    {
        return (this._sLabel);
    };
    _loc1.__set__margin = function (nMargin)
    {
        nMargin = Number(nMargin);
        if (_global.isNaN(nMargin))
        {
            return;
        } // end if
        this._nMargin = nMargin;
        if (this.initialized)
        {
            this._ldrContent.move(this._nMargin, this._nMargin);
        } // end if
        //return (this.margin());
    };
    _loc1.__get__margin = function ()
    {
        return (this._nMargin);
    };
    _loc1.__set__highlightFront = function (bHighlightFront)
    {
        this._bHighlightFront = bHighlightFront;
        if (!bHighlightFront && this._mcHighlight != undefined)
        {
            this._mcHighlight.swapDepths(1);
        } // end if
        //return (this.highlightFront());
    };
    _loc1.__get__highlightFront = function ()
    {
        return (this._bHighlightFront);
    };
    _loc1.__set__id = function (nId)
    {
        this._nId = nId;
        //return (this.id());
    };
    _loc1.__get__id = function ()
    {
        return (this._nId);
    };
    _loc1.forceNextLoad = function ()
    {
        this._ldrContent.forceNextLoad();
    };
    _loc1.emulateClick = function ()
    {
        this.dispatchEvent({type: "click"});
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.Container.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.createEmptyMovieClip("_mcInteraction", 0);
        this.drawRoundRect(this._mcInteraction, 0, 0, 1, 1, 0, 0, 0);
        this._mcInteraction.trackAsMenu = true;
        this.attachMovie("Loader", "_ldrContent", 20, {scaleContent: true});
        this._ldrContent.move(this._nMargin, this._nMargin);
        this.createEmptyMovieClip("_mcLabelBackground", 29);
    };
    _loc1.size = function ()
    {
        super.size();
        if (this._bInitialized)
        {
            this.arrange();
        } // end if
    };
    _loc1.arrange = function ()
    {
        this._mcInteraction._width = this.__width;
        this._mcInteraction._height = this.__height;
        this._ldrContent.setSize(this.__width - this._nMargin * 2, this.__height - this._nMargin * 2);
        this._mcBg.setSize(this.__width, this.__height);
        this._mcHighlight.setSize(this.__width, this.__height);
        this._lblText.setSize(this.__width, this.__height);
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._mcBg.styleName = _loc2.backgroundstyle;
        this._lblText.styleName = _loc2.labelstyle;
    };
    _loc1.setEnabled = function ()
    {
        if (this._bEnabled)
        {
            this._mcInteraction.onRelease = function ()
            {
                if (this._parent._sLastMouseAction == "DragOver")
                {
                    this._parent.dispatchEvent({type: "drop"});
                }
                else if (getTimer() - this._parent._nLastClickTime < ank.gapi.Gapi.DBLCLICK_DELAY)
                {
                    ank.utils.Timer.removeTimer(this._parent, "container");
                    this._parent.dispatchEvent({type: "dblClick"});
                }
                else
                {
                    ank.utils.Timer.setTimer(this._parent, "container", this._parent, this._parent.dispatchEvent, ank.gapi.Gapi.DBLCLICK_DELAY, [{type: "click"}]);
                } // end else if
                this._parent._sLastMouseAction = "Release";
                this._parent._nLastClickTime = getTimer();
            };
            this._mcInteraction.onPress = function ()
            {
                this._parent._sLastMouseAction = "Press";
            };
            this._mcInteraction.onRollOver = function ()
            {
                this._parent._mcHighlight._visible = true;
                this._parent._sLastMouseAction = "RollOver";
                this._parent.dispatchEvent({type: "over"});
            };
            this._mcInteraction.onRollOut = function ()
            {
                if (!this._parent._bSelected)
                {
                    this._parent._mcHighlight._visible = false;
                } // end if
                this._parent._sLastMouseAction = "RollOver";
                this._parent.dispatchEvent({type: "out"});
            };
            if (this._bDragAndDrop)
            {
                this._mcInteraction.onDragOver = function ()
                {
                    this._parent._mcHighlight._visible = true;
                    this._parent._sLastMouseAction = "DragOver";
                    this._parent.dispatchEvent({type: "over"});
                };
                this._mcInteraction.onDragOut = function ()
                {
                    if (!this._parent._bSelected)
                    {
                        this._parent._mcHighlight._visible = false;
                    } // end if
                    if (this._parent._sLastMouseAction == "Press")
                    {
                        this._parent.dispatchEvent({type: "drag"});
                    } // end if
                    this._parent._sLastMouseAction = "DragOut";
                    this._parent.dispatchEvent({type: "out"});
                };
            } // end if
        }
        else
        {
            delete this._mcInteraction.onRelease;
            delete this._mcInteraction.onPress;
            delete this._mcInteraction.onRollOver;
            delete this._mcInteraction.onRollOut;
            delete this._mcInteraction.onDragOver;
            delete this._mcInteraction.onDragOut;
        } // end else if
    };
    _loc1.attachBackground = function ()
    {
        this.attachMovie(this._sBackground, "_mcBg", 10);
    };
    _loc1.attachBorder = function ()
    {
        this.attachMovie(this._sBorder, "_mcBorder", 90);
    };
    _loc1.attachHighlight = function ()
    {
        this.attachMovie(this._sHighlight, "_mcHighlight", this._bHighlightFront ? (100) : (5));
        this._mcHighlight._visible = false;
    };
    _loc1.setLabel = function (sLabel)
    {
        if (this._bShowLabel)
        {
            this._lblText.text = sLabel;
            var _loc3 = Math.min(this._lblText.textWidth + 2, this.__width - 4);
            var _loc4 = this._lblText.textHeight;
            this._mcLabelBackground.clear();
            if (_loc3 > 2 && _loc4 != 0)
            {
                this.drawRoundRect(this._mcLabelBackground, 2, 2, _loc3, _loc4 + 2, 0, 0, 50);
            } // end if
        }
        else
        {
            this._lblText.removeMovieClip();
            this._mcLabelBackground.clear();
        } // end else if
    };
    _loc1.addProperty("label", _loc1.__get__label, _loc1.__set__label);
    _loc1.addProperty("borderRenderer", function ()
    {
    }, _loc1.__set__borderRenderer);
    _loc1.addProperty("contentData", _loc1.__get__contentData, _loc1.__set__contentData);
    _loc1.addProperty("showLabel", _loc1.__get__showLabel, _loc1.__set__showLabel);
    _loc1.addProperty("contentPath", _loc1.__get__contentPath, _loc1.__set__contentPath);
    _loc1.addProperty("margin", _loc1.__get__margin, _loc1.__set__margin);
    _loc1.addProperty("holder", _loc1.__get__holder, function ()
    {
    });
    _loc1.addProperty("forceReload", function ()
    {
    }, _loc1.__set__forceReload);
    _loc1.addProperty("content", _loc1.__get__content, function ()
    {
    });
    _loc1.addProperty("dragAndDrop", _loc1.__get__dragAndDrop, _loc1.__set__dragAndDrop);
    _loc1.addProperty("highlightRenderer", function ()
    {
    }, _loc1.__set__highlightRenderer);
    _loc1.addProperty("selected", _loc1.__get__selected, _loc1.__set__selected);
    _loc1.addProperty("highlightFront", _loc1.__get__highlightFront, _loc1.__set__highlightFront);
    _loc1.addProperty("backgroundRenderer", function ()
    {
    }, _loc1.__set__backgroundRenderer);
    _loc1.addProperty("id", _loc1.__get__id, _loc1.__set__id);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.Container = function ()
    {
        super();
    }).CLASS_NAME = "Container";
    _loc1._sBackground = "DefaultBackground";
    _loc1._sHighlight = "DefaultHighlight";
    _loc1._bDragAndDrop = true;
    _loc1._bShowLabel = false;
    _loc1._bSelected = false;
    _loc1._nMargin = 2;
    _loc1._bHighlightFront = true;
} // end if
#endinitclip
