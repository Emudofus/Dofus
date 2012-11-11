package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import flash.ui.*;
    import flash.utils.*;

    public class TabSet extends GraphicContainer implements FinalizableUIComponent
    {
        private var _nSelected:int = -1;
        private var _nPreviousSelected:int = -1;
        private var _nNbTabs:uint = 0;
        private var _nTotalWidth:uint = 0;
        private var _nNbTabsRequired:uint;
        private var _nCurrentMaxIndex:uint = 0;
        private var _aTabsList:Array;
        private var _aCtrs:Array;
        private var _aCloses:Array;
        private var _aLbls:Array;
        private var _aInputs:Array;
        private var _uiClass:UiRootContainer;
        private var _tabCtr:GraphicContainer;
        private var _btnPlus:ButtonContainer;
        private var _sBgTextureUri:Uri;
        private var _sCloseTextureUri:Uri;
        private var _sPlusTextureUri:Uri;
        private var _sTabCss:Uri;
        private var _nWidthTab:int;
        private var _nWidthLabel:int;
        private var _nHeightLabel:int;
        private var _nWidthPlusTab:int;
        private var _nXCloseTab:int;
        private var _nYCloseTab:int;
        private var _nXPlusTab:int;
        private var _nYPlusTab:int;
        private var _nXLabelTab:int;
        private var _nYLabelTab:int;
        private var _finalized:Boolean = false;
        private var _bNameEdition:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TabSet));

        public function TabSet()
        {
            this._aTabsList = new Array();
            this._aCtrs = new Array();
            this._aCloses = new Array();
            this._aLbls = new Array();
            this._aInputs = new Array();
            this._tabCtr = new GraphicContainer();
            this._tabCtr.width = __width;
            this._tabCtr.height = __height;
            addChild(this._tabCtr);
            return;
        }// end function

        public function get widthTab() : int
        {
            return this._nWidthTab;
        }// end function

        public function set widthTab(param1:int) : void
        {
            this._nWidthTab = param1;
            return;
        }// end function

        public function get widthLabel() : int
        {
            return this._nWidthLabel;
        }// end function

        public function set widthLabel(param1:int) : void
        {
            this._nWidthLabel = param1;
            return;
        }// end function

        public function get heightLabel() : int
        {
            return this._nHeightLabel;
        }// end function

        public function set heightLabel(param1:int) : void
        {
            this._nHeightLabel = param1;
            return;
        }// end function

        public function get widthPlusTab() : int
        {
            return this._nWidthPlusTab;
        }// end function

        public function set widthPlusTab(param1:int) : void
        {
            this._nWidthPlusTab = param1;
            return;
        }// end function

        public function get tabUri() : Uri
        {
            return this._sBgTextureUri;
        }// end function

        public function set tabUri(param1:Uri) : void
        {
            this._sBgTextureUri = param1;
            return;
        }// end function

        public function get closeUri() : Uri
        {
            return this._sCloseTextureUri;
        }// end function

        public function set closeUri(param1:Uri) : void
        {
            this._sCloseTextureUri = param1;
            return;
        }// end function

        public function get plusUri() : Uri
        {
            return this._sPlusTextureUri;
        }// end function

        public function set plusUri(param1:Uri) : void
        {
            this._sPlusTextureUri = param1;
            return;
        }// end function

        public function get cssUri() : Uri
        {
            return this._sTabCss;
        }// end function

        public function set cssUri(param1:Uri) : void
        {
            this._sTabCss = param1;
            return;
        }// end function

        public function get xClose() : int
        {
            return this._nXCloseTab;
        }// end function

        public function set xClose(param1:int) : void
        {
            this._nXCloseTab = param1;
            return;
        }// end function

        public function get yClose() : int
        {
            return this._nYCloseTab;
        }// end function

        public function set yClose(param1:int) : void
        {
            this._nYCloseTab = param1;
            return;
        }// end function

        public function get xLabel() : int
        {
            return this._nXLabelTab;
        }// end function

        public function set xLabel(param1:int) : void
        {
            this._nXLabelTab = param1;
            return;
        }// end function

        public function get yLabel() : int
        {
            return this._nYLabelTab;
        }// end function

        public function set yLabel(param1:int) : void
        {
            this._nYLabelTab = param1;
            return;
        }// end function

        public function get xPlus() : int
        {
            return this._nXPlusTab;
        }// end function

        public function set xPlus(param1:int) : void
        {
            this._nXPlusTab = param1;
            return;
        }// end function

        public function get yPlus() : int
        {
            return this._nYPlusTab;
        }// end function

        public function set yPlus(param1:int) : void
        {
            this._nYPlusTab = param1;
            return;
        }// end function

        public function get length() : int
        {
            return this._nNbTabs;
        }// end function

        public function set length(param1:int) : void
        {
            this._nNbTabsRequired = param1;
            if (this._btnPlus && this._nNbTabsRequired >= 1)
            {
                if (this._nNbTabsRequired > this._nNbTabs)
                {
                    while (this._nNbTabsRequired > this._nNbTabs)
                    {
                        
                        this.addTab();
                    }
                }
                if (this._nNbTabsRequired < this._nNbTabs)
                {
                    while (this._nNbTabsRequired < this._nNbTabs)
                    {
                        
                        this.removeTab();
                    }
                }
            }
            return;
        }// end function

        public function get tabCtr() : GraphicContainer
        {
            return this._tabCtr;
        }// end function

        public function set tabCtr(param1:GraphicContainer) : void
        {
            this._tabCtr = param1;
            return;
        }// end function

        public function get selectedTab() : int
        {
            return this._nSelected;
        }// end function

        public function set selectedTab(param1:int) : void
        {
            if (!this._aCtrs[param1])
            {
                if (param1 < 0)
                {
                    this.selectedTab = param1 + 1;
                }
                else
                {
                    _loc_1 = ++param1 - 1;
                    this.selectedTab = ++param1 - 1;
                }
            }
            this._nPreviousSelected = this._nSelected;
            this._nSelected = _loc_1;
            if (this._nPreviousSelected != -1 && this._aCtrs[this._nPreviousSelected])
            {
                this._aCtrs[this._nPreviousSelected].selected = false;
                this._aCloses[this._nPreviousSelected].visible = false;
                this._aLbls[this._nPreviousSelected].cssClass = "p";
            }
            if (this._nSelected != -1)
            {
                this._aCtrs[this._nSelected].selected = false;
                this._aCtrs[this._nSelected].selected = true;
                this._aCloses[this._nSelected].visible = true;
            }
            if (UIEventManager.getInstance().isRegisteredInstance(this, SelectItemMessage))
            {
                Berilia.getInstance().handler.process(new SelectItemMessage(this, this._aCtrs[this._nSelected]));
            }
            return;
        }// end function

        public function get lastTab() : int
        {
            return (this._nNbTabs - 1);
        }// end function

        public function set dataProvider(param1) : void
        {
            if (!this.isIterable(param1))
            {
                throw new ArgumentError("dataProvider must be either Array or Vector.");
            }
            this._aTabsList = param1;
            this.finalize();
            return;
        }// end function

        public function get dataProvider()
        {
            return this._aTabsList;
        }// end function

        public function get finalized() : Boolean
        {
            return this._finalized;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._finalized = param1;
            return;
        }// end function

        public function finalize() : void
        {
            this._uiClass = getUi();
            if (this._aTabsList && this._aTabsList.length > 0)
            {
                this._nNbTabs = this._aTabsList.length;
                if (this._nNbTabs > 0)
                {
                    this.tabsDisplay();
                }
            }
            else
            {
                this.tabsDisplay();
            }
            this._finalized = true;
            if (this._uiClass)
            {
                this._uiClass.iAmFinalized(this);
            }
            return;
        }// end function

        override public function remove() : void
        {
            if (!__removed)
            {
                this._uiClass = null;
                this._tabCtr.remove();
                this._btnPlus.remove();
                this._tabCtr = null;
                this._btnPlus = null;
            }
            super.remove();
            return;
        }// end function

        public function highlight(param1:uint, param2:Boolean = true) : void
        {
            if (param2)
            {
                this._aLbls[param1].cssClass = "highlighted";
            }
            else
            {
                this._aLbls[param1].cssClass = "p";
            }
            return;
        }// end function

        public function renameTab(param1:uint, param2:String = null) : void
        {
            this._aInputs[this._nSelected].text = "";
            this._aLbls[param1].caretIndex = 0;
            if (param1 >= this._nCurrentMaxIndex)
            {
                return;
            }
            if (this._aCtrs[param1].selected)
            {
                this._aCtrs[param1].selected = false;
                this._aLbls[param1].text = param2;
                this._aCtrs[param1].reset();
                this._aCtrs[param1].selected = true;
            }
            else
            {
                this._aLbls[param1].text = param2;
                this._aCtrs[param1].reset();
            }
            return;
        }// end function

        private function tabsDisplay() : void
        {
            this.addPlusTab();
            this.addTab();
            this.length = this._nNbTabsRequired;
            this.selectedTab = 0;
            return;
        }// end function

        private function addTab() : void
        {
            var _loc_1:* = new ButtonContainer();
            _loc_1.soundId = "16009";
            _loc_1.width = this._nWidthTab;
            _loc_1.height = __height;
            _loc_1.name = "btn_tab" + this._nCurrentMaxIndex;
            var _loc_2:* = new Texture();
            _loc_2.width = this._nWidthTab;
            _loc_2.height = __height;
            _loc_2.autoGrid = true;
            _loc_2.uri = this._sBgTextureUri;
            _loc_2.name = "tx_bgTab" + this._nCurrentMaxIndex;
            _loc_2.finalize();
            var _loc_3:* = new Label();
            _loc_3.width = this._nWidthLabel;
            _loc_3.height = this._nHeightLabel;
            _loc_3.x = this._nXLabelTab;
            _loc_3.y = this._nYLabelTab;
            _loc_3.css = this._sTabCss;
            _loc_3.cssClass = "p";
            _loc_3.name = "lbl_tab" + this._nCurrentMaxIndex;
            _loc_3.text = "tab " + (this._nCurrentMaxIndex + 1);
            var _loc_4:* = new Input();
            new Input().width = this._nWidthLabel;
            _loc_4.height = this._nHeightLabel;
            _loc_4.x = this._nXLabelTab;
            _loc_4.y = this._nYLabelTab;
            _loc_4.css = this._sTabCss;
            _loc_4.cssClass = "p";
            _loc_4.name = "inp_tab" + this._nCurrentMaxIndex;
            _loc_1.addChild(_loc_2);
            _loc_1.addChild(_loc_3);
            _loc_1.addChild(_loc_4);
            getUi().registerId(_loc_1.name, new GraphicElement(_loc_1, new Array(), _loc_1.name));
            getUi().registerId(_loc_2.name, new GraphicElement(_loc_2, new Array(), _loc_2.name));
            getUi().registerId(_loc_3.name, new GraphicElement(_loc_3, new Array(), _loc_3.name));
            getUi().registerId(_loc_4.name, new GraphicElement(_loc_4, new Array(), _loc_4.name));
            var _loc_5:* = new Array();
            new Array()[StatesEnum.STATE_OVER] = new Array();
            _loc_5[StatesEnum.STATE_OVER][_loc_2.name] = new Array();
            _loc_5[StatesEnum.STATE_OVER][_loc_2.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
            _loc_5[StatesEnum.STATE_CLICKED] = new Array();
            _loc_5[StatesEnum.STATE_CLICKED][_loc_2.name] = new Array();
            _loc_5[StatesEnum.STATE_CLICKED][_loc_2.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
            _loc_5[StatesEnum.STATE_SELECTED] = new Array();
            _loc_5[StatesEnum.STATE_SELECTED][_loc_2.name] = new Array();
            _loc_5[StatesEnum.STATE_SELECTED][_loc_2.name]["gotoAndStop"] = StatesEnum.STATE_SELECTED_STRING.toLocaleLowerCase();
            _loc_5[StatesEnum.STATE_SELECTED][_loc_3.name] = new Array();
            _loc_5[StatesEnum.STATE_SELECTED][_loc_3.name]["cssClass"] = "selected";
            _loc_1.changingStateData = _loc_5;
            _loc_1.finalize();
            var _loc_6:* = new ButtonContainer();
            new ButtonContainer().x = this._nXCloseTab;
            _loc_6.y = this._nYCloseTab;
            _loc_6.width = this._nWidthPlusTab;
            _loc_6.height = __height;
            _loc_6.name = "btn_closeTab" + this._nCurrentMaxIndex;
            var _loc_7:* = new Texture();
            new Texture().uri = this._sCloseTextureUri;
            _loc_7.name = "tx_closeTab" + this._nCurrentMaxIndex;
            _loc_7.finalize();
            _loc_6.addChild(_loc_7);
            getUi().registerId(_loc_6.name, new GraphicElement(_loc_6, new Array(), _loc_6.name));
            getUi().registerId(_loc_7.name, new GraphicElement(_loc_7, new Array(), _loc_7.name));
            var _loc_8:* = new Array();
            new Array()[StatesEnum.STATE_OVER] = new Array();
            _loc_8[StatesEnum.STATE_OVER][_loc_7.name] = new Array();
            _loc_8[StatesEnum.STATE_OVER][_loc_7.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
            _loc_8[StatesEnum.STATE_CLICKED] = new Array();
            _loc_8[StatesEnum.STATE_CLICKED][_loc_7.name] = new Array();
            _loc_8[StatesEnum.STATE_CLICKED][_loc_7.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
            _loc_6.changingStateData = _loc_8;
            _loc_6.finalize();
            _loc_6.visible = false;
            this._tabCtr.addChild(_loc_1);
            this._tabCtr.addChild(_loc_6);
            this._aCtrs[this._nNbTabs] = _loc_1;
            this._aCloses[this._nNbTabs] = _loc_6;
            this._aLbls[this._nNbTabs] = _loc_3;
            this._aInputs[this._nNbTabs] = _loc_4;
            this._nTotalWidth = this._nTotalWidth + this._nWidthTab;
            var _loc_9:* = this;
            var _loc_10:* = this._nCurrentMaxIndex + 1;
            _loc_9._nCurrentMaxIndex = _loc_10;
            this.replaceTab();
            return;
        }// end function

        private function addPlusTab() : void
        {
            this._btnPlus = new ButtonContainer();
            this._btnPlus.soundId = "16090";
            this._btnPlus.width = this._nWidthPlusTab;
            this._btnPlus.height = __height;
            this._btnPlus.name = "btn_plus";
            var _loc_1:* = new Texture();
            _loc_1.width = this._nWidthPlusTab;
            _loc_1.height = __height;
            _loc_1.autoGrid = true;
            _loc_1.uri = this._sBgTextureUri;
            _loc_1.name = "tx_bgPlus";
            _loc_1.finalize();
            var _loc_2:* = new Texture();
            _loc_2.x = this._nXPlusTab;
            _loc_2.y = this._nYPlusTab;
            _loc_2.uri = this._sPlusTextureUri;
            _loc_2.name = "tx_plus";
            _loc_2.finalize();
            this._btnPlus.addChild(_loc_1);
            this._btnPlus.addChild(_loc_2);
            getUi().registerId(this._btnPlus.name, new GraphicElement(this._btnPlus, new Array(), this._btnPlus.name));
            getUi().registerId(_loc_1.name, new GraphicElement(_loc_1, new Array(), _loc_1.name));
            getUi().registerId(_loc_2.name, new GraphicElement(_loc_2, new Array(), _loc_2.name));
            addChild(this._btnPlus);
            var _loc_3:* = new Array();
            _loc_3[StatesEnum.STATE_OVER] = new Array();
            _loc_3[StatesEnum.STATE_OVER][_loc_1.name] = new Array();
            _loc_3[StatesEnum.STATE_OVER][_loc_1.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
            _loc_3[StatesEnum.STATE_OVER][_loc_2.name] = new Array();
            _loc_3[StatesEnum.STATE_OVER][_loc_2.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
            _loc_3[StatesEnum.STATE_CLICKED] = new Array();
            _loc_3[StatesEnum.STATE_CLICKED][_loc_1.name] = new Array();
            _loc_3[StatesEnum.STATE_CLICKED][_loc_1.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
            _loc_3[StatesEnum.STATE_CLICKED][_loc_2.name] = new Array();
            _loc_3[StatesEnum.STATE_CLICKED][_loc_2.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
            this._btnPlus.changingStateData = _loc_3;
            this._btnPlus.finalize();
            this._nTotalWidth = this._nTotalWidth + this._nWidthPlusTab;
            return;
        }// end function

        private function removeTab() : void
        {
            var _loc_1:* = 0;
            if (this._nNbTabs > 1)
            {
                _loc_1 = this._nSelected;
                this._nPreviousSelected = _loc_1 - 1;
                this.removeContainerContent(this._aCtrs[_loc_1]);
                this._aCtrs.splice(_loc_1, 1);
                this.removeContainerContent(this._aCloses[_loc_1]);
                this._aCloses.splice(_loc_1, 1);
                this._aLbls.splice(_loc_1, 1);
                this._nTotalWidth = this._nTotalWidth - this._nWidthTab;
                this.replaceTab();
                this.selectedTab = this._nPreviousSelected;
            }
            return;
        }// end function

        private function replaceTab() : void
        {
            var _loc_2:* = undefined;
            var _loc_1:* = 0;
            for (_loc_2 in this._aCtrs)
            {
                
                this._aCtrs[_loc_2].state = 0;
                this._aCtrs[_loc_2].x = _loc_1;
                this._aCloses[_loc_2].x = _loc_1 + this._nXCloseTab;
                this._aCtrs[_loc_2].reset();
                _loc_1 = _loc_1 + this._aCtrs[_loc_2].width;
            }
            this._btnPlus.x = _loc_1;
            if (this._nSelected == -1)
            {
                this.selectedTab = _loc_2;
            }
            this._nNbTabs = this._aCtrs.length;
            if (this._nTotalWidth + this._nWidthTab < __width)
            {
                this._btnPlus.visible = true;
            }
            else
            {
                this._btnPlus.visible = false;
            }
            return;
        }// end function

        private function isIterable(param1) : Boolean
        {
            if (param1 is Array)
            {
                return true;
            }
            if (param1["length"] != null && param1["length"] != 0 && !isNaN(param1["length"]) && param1[0] != null && !(param1 is String))
            {
                return true;
            }
            return false;
        }// end function

        private function removeContainerContent(param1:GraphicContainer) : void
        {
            param1.remove();
            return;
        }// end function

        private function switchToEdition(param1:Boolean) : void
        {
            this._bNameEdition = param1;
            if (param1)
            {
                this._aInputs[this._nSelected].text = this._aLbls[this._nSelected].text;
                this._aInputs[this._nSelected].focus();
                this._aInputs[this._nSelected].setSelection(0, this._aInputs[this._nSelected].text.length);
            }
            this._aInputs[this._nSelected].disabled = !param1;
            this._aInputs[this._nSelected].visible = param1;
            this._aLbls[this._nSelected].visible = !param1;
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            switch(true)
            {
                case param1 is MouseClickMessage:
                {
                    _loc_2 = param1 as MouseClickMessage;
                    if (this._bNameEdition)
                    {
                        this._bNameEdition = false;
                        _loc_5 = this._aInputs[this._nSelected].text;
                        this.renameTab(this._nSelected, _loc_5);
                        if (UIEventManager.getInstance().isRegisteredInstance(this, RenameTabMessage))
                        {
                            Berilia.getInstance().handler.process(new RenameTabMessage(this, this._nSelected, _loc_5));
                        }
                    }
                    switch(_loc_2.target.name)
                    {
                        case this._btnPlus.name:
                        {
                            if (this._nTotalWidth + this._nWidthTab < __width)
                            {
                                this.addTab();
                                this.selectedTab = this._nNbTabs - 1;
                                if (UIEventManager.getInstance().isRegisteredInstance(this, CreateTabMessage))
                                {
                                    Berilia.getInstance().handler.process(new CreateTabMessage(this));
                                }
                            }
                            break;
                        }
                        default:
                        {
                            for (_loc_6 in this._aCtrs)
                            {
                                
                                if (_loc_2.target == this._aCtrs[_loc_6])
                                {
                                    this.selectedTab = _loc_6;
                                }
                            }
                            if (_loc_2.target == this._aCloses[this._nSelected])
                            {
                                if (this._nNbTabs > 1)
                                {
                                    if (UIEventManager.getInstance().isRegisteredInstance(this, DeleteTabMessage))
                                    {
                                        Berilia.getInstance().handler.process(new DeleteTabMessage(this, this._nSelected));
                                    }
                                    this.removeTab();
                                }
                            }
                            break;
                            break;
                        }
                    }
                    break;
                }
                case param1 is MouseRightClickMessage:
                {
                    _loc_3 = param1 as MouseRightClickMessage;
                    if (_loc_3.target == this._aCtrs[this._nSelected] && !this._bNameEdition)
                    {
                        this.switchToEdition(true);
                    }
                    else if (this._bNameEdition)
                    {
                        this.switchToEdition(false);
                    }
                    break;
                }
                case param1 is KeyboardKeyUpMessage:
                {
                    _loc_4 = param1 as KeyboardKeyUpMessage;
                    if (this._bNameEdition)
                    {
                        if (_loc_4.keyboardEvent.keyCode == Keyboard.ENTER)
                        {
                            this._bNameEdition = false;
                            _loc_7 = this._aInputs[this._nSelected].text;
                            this.renameTab(this._nSelected, _loc_7);
                            if (UIEventManager.getInstance().isRegisteredInstance(this, RenameTabMessage))
                            {
                                Berilia.getInstance().handler.process(new RenameTabMessage(this, this._nSelected, _loc_7));
                            }
                        }
                        else if (_loc_4.keyboardEvent.keyCode == Keyboard.ESCAPE)
                        {
                            this.switchToEdition(false);
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

    }
}
