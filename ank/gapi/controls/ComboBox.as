// Action script...

// [Initial MovieClip Action of sprite 20920]
#initclip 185
if (!ank.gapi.controls.ComboBox)
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
    var _loc1 = (_global.ank.gapi.controls.ComboBox = function ()
    {
        super();
    }).prototype;
    _loc1.__set__cellRenderer = function (sCellRenderer)
    {
        this._sCellRenderer = sCellRenderer;
        //return (this.cellRenderer());
    };
    _loc1.__get__cellRenderer = function ()
    {
        return (this._sCellRenderer);
    };
    _loc1.__set__isButtonLeft = function (bButtonLeft)
    {
        this._bButtonLeft = bButtonLeft;
        //return (this.isButtonLeft());
    };
    _loc1.__get__isButtonLeft = function ()
    {
        return (this._bButtonLeft);
    };
    _loc1.__set__rowHeight = function (nRowHeight)
    {
        if (nRowHeight == 0)
        {
            return;
        } // end if
        this._nRowHeight = nRowHeight;
        //return (this.rowHeight());
    };
    _loc1.__get__rowHeight = function ()
    {
        return (this._nRowHeight);
    };
    _loc1.__set__buttonWidth = function (nButtonWidth)
    {
        this._nButtonWidth = nButtonWidth;
        //return (this.buttonWidth());
    };
    _loc1.__get__buttonWidth = function ()
    {
        return (this._nButtonWidth);
    };
    _loc1.__set__labelLeftMargin = function (nLabelLeftMargin)
    {
        this._nLabelLeftMargin = nLabelLeftMargin;
        //return (this.labelLeftMargin());
    };
    _loc1.__get__labelLeftMargin = function ()
    {
        return (this._nLabelLeftMargin);
    };
    _loc1.__set__labelRightMargin = function (nLabelRightMargin)
    {
        this._nLabelRightMargin = nLabelRightMargin;
        //return (this.labelRightMargin());
    };
    _loc1.__get__labelRightMargin = function ()
    {
        return (this._nLabelRightMargin);
    };
    _loc1.__set__labelTopMargin = function (nLabelTopMargin)
    {
        this._nLabelTopMargin = nLabelTopMargin;
        //return (this.labelTopMargin());
    };
    _loc1.__get__labelTopMargin = function ()
    {
        return (this._nLabelTopMargin);
    };
    _loc1.__set__labelBottomMargin = function (nLabelBottomMargin)
    {
        this._nLabelBottomMargin = nLabelBottomMargin;
        //return (this.labelBottomMargin());
    };
    _loc1.__get__labelBottomMargin = function ()
    {
        return (this._nLabelBottomMargin);
    };
    _loc1.__set__listLeftMargin = function (nListLeftMargin)
    {
        this._nListLeftMargin = nListLeftMargin;
        //return (this.listLeftMargin());
    };
    _loc1.__get__listLeftMargin = function ()
    {
        return (this._nListLeftMargin);
    };
    _loc1.__set__listRightMargin = function (nListRightMargin)
    {
        this._nListRightMargin = nListRightMargin;
        //return (this.listRightMargin());
    };
    _loc1.__get__listRightMargin = function ()
    {
        return (this._nListRightMargin);
    };
    _loc1.__set__rowCount = function (nRowCount)
    {
        this._nRowCount = nRowCount;
        //return (this.rowCount());
    };
    _loc1.__get__rowCount = function ()
    {
        return (this._nRowCount);
    };
    _loc1.__set__mcListParent = function (sMcListParent)
    {
        this._sMcListParent = sMcListParent;
        //return (this.mcListParent());
    };
    _loc1.__get__mcListParent = function ()
    {
        return (this._sMcListParent);
    };
    _loc1.__set__background = function (sBackground)
    {
        this._sBackground = sBackground;
        //return (this.background());
    };
    _loc1.__get__background = function ()
    {
        return (this._sBackground);
    };
    _loc1.__set__buttonBackgroundUp = function (sButtonBackgroundUp)
    {
        this._sButtonBackgroundUp = sButtonBackgroundUp;
        //return (this.buttonBackgroundUp());
    };
    _loc1.__get__backgroundUp = function ()
    {
        return (this._sButtonBackgroundUp);
    };
    _loc1.__set__buttonBackgroundDown = function (sButtonBackgroundDown)
    {
        this._sButtonBackgroundDown = sButtonBackgroundDown;
        //return (this.buttonBackgroundDown());
    };
    _loc1.__get__buttonBackgroundDown = function ()
    {
        return (this._sButtonBackgroundDown);
    };
    _loc1.__set__buttonIcon = function (sButtonIcon)
    {
        this._sButtonIcon = sButtonIcon;
        if (this.initialized)
        {
            this._btnOpen.icon = sButtonIcon;
        } // end if
        //return (this.buttonIcon());
    };
    _loc1.__get__buttonIcon = function ()
    {
        return (this._sButtonIcon);
    };
    _loc1.__set__dataProvider = function (eaDataProvider)
    {
        this._eaDataProvider = eaDataProvider;
        this._eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        if (this.initialized)
        {
            this.removeList();
            this.calculateListSize();
        } // end if
        //return (this.dataProvider());
    };
    _loc1.__get__dataProvider = function ()
    {
        return (this._eaDataProvider);
    };
    _loc1.__set__selectedIndex = function (nSelectedIndex)
    {
        this._nSelectedIndex = nSelectedIndex;
        if (this.initialized)
        {
            this.removeList();
            this.setLabel(this.getSelectedItemText());
        } // end if
        //return (this.selectedIndex());
    };
    _loc1.__get__selectedIndex = function ()
    {
        return (this._nSelectedIndex);
    };
    _loc1.__get__selectedItem = function ()
    {
        return (this._eaDataProvider[this._nSelectedIndex]);
    };
    _loc1.init = function ()
    {
        super.init(false, ank.gapi.controls.ComboBox.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.attachMovie(this._sBackground, "_mcBack", this.getNextHighestDepth());
        this._mcBack.onRelease = function ()
        {
            this._parent.autoOpenCloseList();
        };
        this._mcBack.useHandCursor = false;
        this.attachMovie("Button", "_btnOpen", this.getNextHighestDepth(), {toggle: true, icon: this._sButtonIcon, backgroundUp: this._sButtonBackgroundUp, backgroundDown: this._sButtonBackgroundDown});
        this._btnOpen.addEventListener("click", this);
        this.attachMovie("Label", "_lblCombo", this.getNextHighestDepth(), {text: ""});
        Key.addListener(this);
    };
    _loc1.size = function ()
    {
        super.size();
        this.arrange();
    };
    _loc1.arrange = function ()
    {
        var _loc2 = Math.max(this.__width - this._nButtonWidth - this._nLabelLeftMargin - this._nLabelRightMargin, 0);
        var _loc3 = Math.max(this.__height - this._nLabelTopMargin - this._nLabelBottomMargin, 0);
        this._lblCombo.setSize(_loc2, _loc3);
        this._btnOpen.setSize(this._nButtonWidth, this.__height);
        this._lblCombo._y = this._nLabelTopMargin;
        if (this._bButtonLeft)
        {
            this._lblCombo._x = this._nButtonWidth + this._nLabelLeftMargin;
        }
        else
        {
            this._lblCombo._x = this._nLabelLeftMargin;
            this._btnOpen._x = this.__width - this._nButtonWidth;
        } // end else if
        this._mcBack.setSize(this.__width, this.__height, true);
        this.calculateListSize();
    };
    _loc1.draw = function ()
    {
        var _loc2 = this.getStyle();
        this._lblCombo.styleName = _loc2.labelstyle;
        this._btnOpen.styleName = _loc2.buttonstyle;
        this._mcBack.setStyleColor(_loc2, "color");
    };
    _loc1.setEnabled = function ()
    {
        this._btnOpen.enabled = this._bEnabled;
        if (!this._bEnabled)
        {
            this.setMovieClipTransform(this, this.getStyle().disabledtransform);
        }
        else
        {
            this.setMovieClipTransform(this, {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0, aa: 100, ab: 0});
        } // end else if
    };
    _loc1.calculateListSize = function ()
    {
        var _loc2 = this._eaDataProvider == undefined ? (1) : (this._eaDataProvider.length);
        var _loc3 = this._nListLeftMargin;
        var _loc4 = this.__height;
        this._nListWidth = this.__width - this._nListLeftMargin - this._nListRightMargin - 2;
        this._nListHeight = Math.min(_loc2, this._nRowCount) * this._nRowHeight + 1;
        var _loc5 = {x: _loc3, y: _loc4};
        this.localToGlobal(_loc5);
        this._nListX = _loc5.x;
        this._nListY = _loc5.y;
    };
    _loc1.clearDrawedList = function ()
    {
        this._mcComboBoxPopup.removeMovieClip();
    };
    _loc1.drawList = function ()
    {
        if (this._sMcListParent == "_parent")
        {
            var _loc2 = this._parent;
        }
        else
        {
            var _loc3 = new ank.utils.ExtendedString(String(this._sMcListParent));
            var _loc4 = _loc3.replace("this", String(this));
            _loc2 = String(_loc4);
        } // end else if
        if (_loc2 == undefined)
        {
            _loc2 = this._parent;
        } // end if
        if (_loc2._mcComboBoxPopup != undefined)
        {
            _loc2._mcComboBoxPopup.comboBox.removeList();
        } // end if
        this._mcComboBoxPopup = _loc2.createEmptyMovieClip("_mcComboBoxPopup", _loc2.getNextHighestDepth());
        this._mcComboBoxPopup.comboBox = this;
        this.drawRoundRect(this._mcComboBoxPopup, this._nListX, this._nListY, this._nListWidth, this._nListHeight, 0, this.getStyle().listbordercolor);
        this._mcComboBoxPopup.attachMovie("List", "_lstCombo", this._mcComboBoxPopup.getNextHighestDepth(), {styleName: this.getStyle().liststyle, rowHeight: this._nRowHeight, _x: this._nListX + 1, _y: this._nListY, _width: this._nListWidth - 2, _height: this._nListHeight - 1, dataProvider: this._eaDataProvider, selectedIndex: this._nSelectedIndex, cellRenderer: this._sCellRenderer});
        this._lstCombo = this._mcComboBoxPopup._lstCombo;
        this._lstCombo.addEventListener("itemSelected", this);
        this._btnOpen.selected = true;
    };
    _loc1.removeList = function ()
    {
        this._mcComboBoxPopup.removeMovieClip();
        this._btnOpen.selected = false;
    };
    _loc1.autoOpenCloseList = function ()
    {
        if (!this._bEnabled)
        {
            return;
        } // end if
        if (this._btnOpen.selected)
        {
            this.removeList();
        }
        else
        {
            this.drawList();
        } // end else if
    };
    _loc1.setLabel = function (sText)
    {
        this._lblCombo.text = sText == undefined ? ("") : (sText);
    };
    _loc1.getSelectedItemText = function ()
    {
        var _loc2 = this.selectedItem;
        if (typeof(_loc2) == "string")
        {
            return (String(_loc2));
        }
        else if (_loc2.label != undefined)
        {
            return (_loc2.label);
        }
        else
        {
            return ("");
        } // end else if
    };
    _loc1.modelChanged = function ()
    {
        this.setLabel(this.getSelectedItemText());
    };
    _loc1.onKeyUp = function ()
    {
        this.removeList();
    };
    _loc1.click = function (oEvent)
    {
        if (this._btnOpen.selected)
        {
            this.drawList();
        }
        else
        {
            this.removeList();
        } // end else if
    };
    _loc1.itemSelected = function (oEvent)
    {
        this._nSelectedIndex = this._lstCombo.selectedIndex;
        this.setLabel(this.getSelectedItemText());
        this.removeList();
        this.dispatchEvent({type: "itemSelected", target: this});
    };
    _loc1.addProperty("rowHeight", _loc1.__get__rowHeight, _loc1.__set__rowHeight);
    _loc1.addProperty("labelTopMargin", _loc1.__get__labelTopMargin, _loc1.__set__labelTopMargin);
    _loc1.addProperty("labelLeftMargin", _loc1.__get__labelLeftMargin, _loc1.__set__labelLeftMargin);
    _loc1.addProperty("mcListParent", _loc1.__get__mcListParent, _loc1.__set__mcListParent);
    _loc1.addProperty("listLeftMargin", _loc1.__get__listLeftMargin, _loc1.__set__listLeftMargin);
    _loc1.addProperty("labelBottomMargin", _loc1.__get__labelBottomMargin, _loc1.__set__labelBottomMargin);
    _loc1.addProperty("cellRenderer", _loc1.__get__cellRenderer, _loc1.__set__cellRenderer);
    _loc1.addProperty("dataProvider", _loc1.__get__dataProvider, _loc1.__set__dataProvider);
    _loc1.addProperty("listRightMargin", _loc1.__get__listRightMargin, _loc1.__set__listRightMargin);
    _loc1.addProperty("background", _loc1.__get__background, _loc1.__set__background);
    _loc1.addProperty("rowCount", _loc1.__get__rowCount, _loc1.__set__rowCount);
    _loc1.addProperty("buttonBackgroundDown", _loc1.__get__buttonBackgroundDown, _loc1.__set__buttonBackgroundDown);
    _loc1.addProperty("buttonBackgroundUp", function ()
    {
    }, _loc1.__set__buttonBackgroundUp);
    _loc1.addProperty("labelRightMargin", _loc1.__get__labelRightMargin, _loc1.__set__labelRightMargin);
    _loc1.addProperty("buttonIcon", _loc1.__get__buttonIcon, _loc1.__set__buttonIcon);
    _loc1.addProperty("buttonWidth", _loc1.__get__buttonWidth, _loc1.__set__buttonWidth);
    _loc1.addProperty("selectedIndex", _loc1.__get__selectedIndex, _loc1.__set__selectedIndex);
    _loc1.addProperty("selectedItem", _loc1.__get__selectedItem, function ()
    {
    });
    _loc1.addProperty("backgroundUp", _loc1.__get__backgroundUp, function ()
    {
    });
    _loc1.addProperty("isButtonLeft", _loc1.__get__isButtonLeft, _loc1.__set__isButtonLeft);
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.controls.ComboBox = function ()
    {
        super();
    }).CLASS_NAME = "ComboBox";
    _loc1._bButtonLeft = false;
    _loc1._nRowHeight = 20;
    _loc1._nButtonWidth = 20;
    _loc1._nLabelLeftMargin = 4;
    _loc1._nLabelRightMargin = 4;
    _loc1._nLabelTopMargin = 0;
    _loc1._nLabelBottomMargin = 0;
    _loc1._nListLeftMargin = 4;
    _loc1._nListRightMargin = 4;
    _loc1._nRowCount = 4;
    _loc1._sMcListParent = "_root";
    _loc1._sCellRenderer = "DefaultCellRenderer";
    _loc1._sButtonBackgroundUp = "ButtonComboBoxUp";
    _loc1._sButtonBackgroundDown = "ButtonComboBoxDown";
    _loc1._sButtonIcon = "ComboBoxButtonNormalIcon";
    _loc1._sBackground = "ComboBoxNormal";
} // end if
#endinitclip
