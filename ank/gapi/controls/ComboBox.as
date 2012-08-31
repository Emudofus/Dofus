// Action script...

// [Initial MovieClip Action of sprite 416]
#initclip 226
class ank.gapi.controls.ComboBox extends ank.gapi.core.UIBasicComponent
{
    var __get__isButtonLeft, __get__rowHeight, __get__buttonWidth, __get__labelLeftMargin, __get__labelRightMargin, __get__listLeftMargin, __get__listRightMargin, __get__rowCount, __get__mcListParent, __get__background, __get__buttonBackgroundUp, __get__buttonBackgroundDown, __get__initialized, _btnOpen, __get__buttonIcon, _eaDataProvider, __get__dataProvider, _nSelectedIndex, __get__selectedIndex, getNextHighestDepth, attachMovie, _mcBack, _parent, __width, __height, _lblCombo, getStyle, _bEnabled, _nListWidth, _nListHeight, localToGlobal, _nListX, _nListY, _mcComboBoxPopup, drawRoundRect, _lstCombo, __get__selectedItem, dispatchEvent, __set__background, __get__backgroundUp, __set__buttonBackgroundDown, __set__buttonBackgroundUp, __set__buttonIcon, __set__buttonWidth, __set__dataProvider, __set__isButtonLeft, __set__labelLeftMargin, __set__labelRightMargin, __set__listLeftMargin, __set__listRightMargin, __set__mcListParent, __set__rowCount, __set__rowHeight, __set__selectedIndex;
    function ComboBox()
    {
        super();
    } // End of the function
    function set isButtonLeft(bButtonLeft)
    {
        _bButtonLeft = bButtonLeft;
        //return (this.isButtonLeft());
        null;
    } // End of the function
    function get isButtonLeft()
    {
        return (_bButtonLeft);
    } // End of the function
    function set rowHeight(nRowHeight)
    {
        if (nRowHeight == 0)
        {
            return;
        } // end if
        _nRowHeight = nRowHeight;
        //return (this.rowHeight());
        null;
    } // End of the function
    function get rowHeight()
    {
        return (_nRowHeight);
    } // End of the function
    function set buttonWidth(nButtonWidth)
    {
        _nButtonWidth = nButtonWidth;
        //return (this.buttonWidth());
        null;
    } // End of the function
    function get buttonWidth()
    {
        return (_nButtonWidth);
    } // End of the function
    function set labelLeftMargin(nLabelLeftMargin)
    {
        _nLabelLeftMargin = nLabelLeftMargin;
        //return (this.labelLeftMargin());
        null;
    } // End of the function
    function get labelLeftMargin()
    {
        return (_nLabelLeftMargin);
    } // End of the function
    function set labelRightMargin(nLabelRightMargin)
    {
        _nLabelRightMargin = nLabelRightMargin;
        //return (this.labelRightMargin());
        null;
    } // End of the function
    function get labelRightMargin()
    {
        return (_nLabelRightMargin);
    } // End of the function
    function set listLeftMargin(nListLeftMargin)
    {
        _nListLeftMargin = nListLeftMargin;
        //return (this.listLeftMargin());
        null;
    } // End of the function
    function get listLeftMargin()
    {
        return (_nListLeftMargin);
    } // End of the function
    function set listRightMargin(nListRightMargin)
    {
        _nListRightMargin = nListRightMargin;
        //return (this.listRightMargin());
        null;
    } // End of the function
    function get listRightMargin()
    {
        return (_nListRightMargin);
    } // End of the function
    function set rowCount(nRowCount)
    {
        _nRowCount = nRowCount;
        //return (this.rowCount());
        null;
    } // End of the function
    function get rowCount()
    {
        return (_nRowCount);
    } // End of the function
    function set mcListParent(sMcListParent)
    {
        _sMcListParent = sMcListParent;
        //return (this.mcListParent());
        null;
    } // End of the function
    function get mcListParent()
    {
        return (_sMcListParent);
    } // End of the function
    function set background(sBackground)
    {
        _sBackground = sBackground;
        //return (this.background());
        null;
    } // End of the function
    function get background()
    {
        return (_sBackground);
    } // End of the function
    function set buttonBackgroundUp(sButtonBackgroundUp)
    {
        _sButtonBackgroundUp = sButtonBackgroundUp;
        //return (this.buttonBackgroundUp());
        null;
    } // End of the function
    function get backgroundUp()
    {
        return (_sButtonBackgroundUp);
    } // End of the function
    function set buttonBackgroundDown(sButtonBackgroundDown)
    {
        _sButtonBackgroundDown = sButtonBackgroundDown;
        //return (this.buttonBackgroundDown());
        null;
    } // End of the function
    function get buttonBackgroundDown()
    {
        return (_sButtonBackgroundDown);
    } // End of the function
    function set buttonIcon(sButtonIcon)
    {
        _sButtonIcon = sButtonIcon;
        if (this.__get__initialized())
        {
            _btnOpen.__set__icon(sButtonIcon);
        } // end if
        //return (this.buttonIcon());
        null;
    } // End of the function
    function get buttonIcon()
    {
        return (_sButtonIcon);
    } // End of the function
    function set dataProvider(eaDataProvider)
    {
        _eaDataProvider = eaDataProvider;
        _eaDataProvider.addEventListener("modelChanged", this);
        this.modelChanged();
        if (this.__get__initialized())
        {
            this.removeList();
            this.calculateListSize();
        } // end if
        //return (this.dataProvider());
        null;
    } // End of the function
    function get dataProvider()
    {
        return (_eaDataProvider);
    } // End of the function
    function set selectedIndex(nSelectedIndex)
    {
        _nSelectedIndex = nSelectedIndex;
        if (this.__get__initialized())
        {
            this.removeList();
            this.setLabel(this.getSelectedItemText());
        } // end if
        //return (this.selectedIndex());
        null;
    } // End of the function
    function get selectedIndex()
    {
        return (_nSelectedIndex);
    } // End of the function
    function get selectedItem()
    {
        return (_eaDataProvider[_nSelectedIndex]);
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.ComboBox.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie(_sBackground, "_mcBack", this.getNextHighestDepth());
        _mcBack.onRelease = function ()
        {
            _parent.autoOpenCloseList();
        };
        _mcBack.useHandCursor = false;
        this.attachMovie("Button", "_btnOpen", this.getNextHighestDepth(), {toggle: true, icon: _sButtonIcon, backgroundUp: _sButtonBackgroundUp, backgroundDown: _sButtonBackgroundDown});
        _btnOpen.addEventListener("click", this);
        this.attachMovie("Label", "_lblCombo", this.getNextHighestDepth(), {text: ""});
        Key.addListener(this);
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        var _loc2 = Math.max(__width - _nButtonWidth - _nLabelLeftMargin - _nLabelRightMargin, 0);
        _lblCombo.setSize(_loc2, __height);
        _btnOpen.setSize(_nButtonWidth, __height);
        if (_bButtonLeft)
        {
            _lblCombo._x = _nButtonWidth + _nLabelLeftMargin;
        }
        else
        {
            _lblCombo._x = _nLabelLeftMargin;
            _btnOpen._x = __width - _nButtonWidth;
        } // end else if
        _mcBack.setSize(__width, __height, true);
        this.calculateListSize();
    } // End of the function
    function draw()
    {
        var _loc2 = this.getStyle();
        _lblCombo.__set__styleName(_loc2.labelstyle);
        _btnOpen.__set__styleName(_loc2.buttonstyle);
        _mcBack.setStyleColor(_loc2, "color");
    } // End of the function
    function setEnabled()
    {
        _btnOpen.__set__enabled(_bEnabled);
    } // End of the function
    function calculateListSize()
    {
        var _loc3 = _eaDataProvider == undefined ? (1) : (_eaDataProvider.length);
        var _loc5 = _nListLeftMargin;
        var _loc4 = __height;
        _nListWidth = __width - _nListLeftMargin - _nListRightMargin - 2;
        _nListHeight = Math.min(_loc3, _nRowCount) * _nRowHeight + 1;
        var _loc2 = {x: _loc5, y: _loc4};
        this.localToGlobal(_loc2);
        _nListX = _loc2.x;
        _nListY = _loc2.y;
    } // End of the function
    function drawList()
    {
        var mcLstRoot = String(this._sMcListParent);
        if (mcLstRoot._mcComboBoxPopup != undefined)
        {
            mcLstRoot._mcComboBoxPopup.comboBox.removeList();
        } // end if
        mcLstRoot.createEmptyMovieClip("_mcComboBoxPopup", this.getNextHighestDepth());
        this._mcComboBoxPopup = mcLstRoot._mcComboBoxPopup;
        this._mcComboBoxPopup.comboBox = this;
        this.drawRoundRect(this._mcComboBoxPopup, this._nListX, this._nListY, this._nListWidth, this._nListHeight, 0, this.getStyle().listbordercolor);
        this._mcComboBoxPopup.attachMovie("List", "_lstCombo", this.getNextHighestDepth(), {styleName: this.getStyle().liststyle, rowHeight: this._nRowHeight, _x: this._nListX + 1, _y: this._nListY, _width: this._nListWidth - 2, _height: this._nListHeight - 1, dataProvider: this._eaDataProvider, selectedIndex: this._nSelectedIndex});
        this._lstCombo = this._mcComboBoxPopup._lstCombo;
        this._lstCombo.addEventListener("itemSelected", this);
        this._btnOpen.__set__selected(true);
    } // End of the function
    function removeList()
    {
        _mcComboBoxPopup.removeMovieClip();
        _btnOpen.__set__selected(false);
    } // End of the function
    function autoOpenCloseList()
    {
        if (!_bEnabled)
        {
            return;
        } // end if
        if (_btnOpen.__get__selected())
        {
            this.removeList();
        }
        else
        {
            this.drawList();
        } // end else if
    } // End of the function
    function setLabel(sText)
    {
        _lblCombo.__set__text(sText == undefined ? ("") : (sText));
    } // End of the function
    function getSelectedItemText()
    {
        var _loc2 = this.__get__selectedItem();
        return (typeof(_loc2) == "string" ? (String(_loc2)) : (_loc2.label));
    } // End of the function
    function modelChanged()
    {
        this.setLabel(this.getSelectedItemText());
    } // End of the function
    function onKeyUp()
    {
        this.removeList();
    } // End of the function
    function click(oEvent)
    {
        if (_btnOpen.__get__selected())
        {
            this.drawList();
        }
        else
        {
            this.removeList();
        } // end else if
    } // End of the function
    function itemSelected(oEvent)
    {
        _nSelectedIndex = _lstCombo.selectedIndex;
        this.setLabel(this.getSelectedItemText());
        this.removeList();
        this.dispatchEvent({type: "itemSelected"});
    } // End of the function
    static var CLASS_NAME = "ComboBox";
    var _bButtonLeft = false;
    var _nRowHeight = 20;
    var _nButtonWidth = 20;
    var _nLabelLeftMargin = 4;
    var _nLabelRightMargin = 4;
    var _nListLeftMargin = 4;
    var _nListRightMargin = 4;
    var _nRowCount = 4;
    var _sMcListParent = "_root";
    var _sButtonBackgroundUp = "ButtonComboBoxUp";
    var _sButtonBackgroundDown = "ButtonComboBoxDown";
    var _sButtonIcon = "ComboBoxButtonNormalIcon";
    var _sBackground = "ComboBoxNormal";
} // End of Class
#endinitclip
