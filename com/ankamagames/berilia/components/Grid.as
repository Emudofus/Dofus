package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.gridRenderer.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;

    public class Grid extends GraphicContainer implements FinalizableUIComponent
    {
        protected var _dataProvider:Object;
        protected var _renderer:IGridRenderer;
        protected var _items:Array;
        protected var _scrollBarV:ScrollBar;
        protected var _scrollBarH:ScrollBar;
        protected var _horizontalScrollSpeed:Number = 1;
        protected var _verticalScrollSpeed:Number = 1;
        protected var _slotWidth:uint = 50;
        protected var _slotHeight:uint = 50;
        protected var _sRendererName:String;
        protected var _sRendererArgs:String;
        protected var _verticalScroll:Boolean = true;
        protected var _pageXOffset:int = 0;
        protected var _pageYOffset:int = 0;
        protected var _nSelectedIndex:int = 0;
        protected var _nSelectedItem:WeakReference;
        protected var _sVScrollCss:Uri;
        protected var _sHScrollCss:Uri;
        protected var _scrollBarSize:uint = 16;
        protected var _eventCatcher:Shape;
        protected var _finalized:Boolean = false;
        protected var _displayScrollbar:String = "auto";
        protected var _autoSelect:int = 1;
        protected var _sortProperty:String;
        protected var _autoPosition:Boolean = false;
        protected var _slotByRow:uint;
        protected var _slotByCol:uint;
        protected var _totalSlotByRow:uint;
        protected var _totalSlotByCol:uint;
        protected var _avaibleSpaceX:uint;
        protected var _avaibleSpaceY:uint;
        protected var _hiddenRow:uint = 0;
        protected var _hiddenCol:uint = 0;
        protected var _mask:Shape;
        public var keyboardIndexHandler:Function;
        public var silent:Boolean;
        private static var _include_XmlUiGridRenderer:XmlUiGridRenderer = null;
        private static var _include_LabelGridRenderer:LabelGridRenderer = null;
        private static var _include_SlotGridRenderer:SlotGridRenderer = null;
        private static var _include_EntityGridRenderer:EntityGridRenderer = null;
        private static var _include_InlineXmlGridRender:InlineXmlGridRender = null;
        private static var _include_MultiGridRenderer:MultiGridRenderer = null;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Grid));
        public static const AUTOSELECT_NONE:int = 0;
        public static const AUTOSELECT_BY_INDEX:int = 1;
        public static const AUTOSELECT_BY_ITEM:int = 2;

        public function Grid() : void
        {
            this._items = new Array();
            this._dataProvider = new Array();
            this._eventCatcher = new Shape();
            this._eventCatcher.alpha = 0;
            this._eventCatcher.graphics.beginFill(16711680);
            this._eventCatcher.graphics.drawRect(0, 0, 1, 1);
            addChild(this._eventCatcher);
            mouseEnabled = true;
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            this._eventCatcher.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            this._eventCatcher.height = param1;
            if (this._scrollBarV)
            {
                this._scrollBarV.height = param1;
            }
            return;
        }// end function

        public function set rendererName(param1:String) : void
        {
            if (param1.indexOf(".") == -1)
            {
                param1 = "com.ankamagames.berilia.components.gridRenderer." + param1;
            }
            this._sRendererName = param1;
            return;
        }// end function

        public function get rendererName() : String
        {
            return this._sRendererName;
        }// end function

        public function set rendererArgs(param1:String) : void
        {
            this._sRendererArgs = param1;
            if (this.finalized)
            {
                this.finalize();
            }
            return;
        }// end function

        public function get rendererArgs() : String
        {
            return this._sRendererArgs;
        }// end function

        public function get renderer() : IGridRenderer
        {
            return this._renderer;
        }// end function

        public function set dataProvider(param1) : void
        {
            if (!this.isIterable(param1))
            {
                throw new ArgumentError("dataProvider must be either Array or Vector.");
            }
            this._dataProvider = param1;
            this.finalize();
            this.initSlot();
            return;
        }// end function

        public function get dataProvider()
        {
            return this._dataProvider;
        }// end function

        public function resetScrollBar() : void
        {
            if (this._scrollBarH && this._scrollBarH.visible)
            {
                this._scrollBarH.value = this._pageXOffset;
            }
            if (this._scrollBarV && this._scrollBarV.visible)
            {
                this._scrollBarV.value = this._pageYOffset;
            }
            return;
        }// end function

        public function set horizontalScrollbarCss(param1:Uri) : void
        {
            this._sHScrollCss = param1;
            return;
        }// end function

        public function get horizontalScrollbarCss() : Uri
        {
            return this._sHScrollCss;
        }// end function

        public function set verticalScrollbarCss(param1:Uri) : void
        {
            this._sVScrollCss = param1;
            return;
        }// end function

        public function get verticalScrollbarCss() : Uri
        {
            return this._sVScrollCss;
        }// end function

        public function get selectedIndex() : int
        {
            return this._nSelectedIndex;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            this.setSelectedIndex(param1, SelectMethodEnum.MANUAL);
            return;
        }// end function

        public function set vertical(param1:Boolean) : void
        {
            if (this._verticalScroll != param1)
            {
                this._verticalScroll = param1;
                if (this._finalized)
                {
                    this.finalize();
                }
            }
            return;
        }// end function

        public function get vertical() : Boolean
        {
            return this._verticalScroll;
        }// end function

        public function set autoSelect(param1:Boolean) : void
        {
            this._autoSelect = AUTOSELECT_BY_INDEX;
            if (this._dataProvider.length && this._autoSelect == AUTOSELECT_BY_INDEX)
            {
                this.setSelectedIndex(Math.min(this._nSelectedIndex, (this._dataProvider.length - 1)), SelectMethodEnum.AUTO);
            }
            return;
        }// end function

        public function get autoSelect() : Boolean
        {
            return this._autoSelect == AUTOSELECT_BY_INDEX;
        }// end function

        public function set autoSelectMode(param1:int) : void
        {
            this._autoSelect = param1;
            if (this._dataProvider.length)
            {
                if (this._autoSelect == AUTOSELECT_BY_INDEX)
                {
                    this.setSelectedIndex(Math.min(this._nSelectedIndex, (this._dataProvider.length - 1)), SelectMethodEnum.AUTO);
                }
                else if (this._autoSelect == AUTOSELECT_BY_ITEM)
                {
                    if (this._nSelectedItem)
                    {
                        this.selectedItem = this._nSelectedItem.object;
                        if (this.selectedItem != this._nSelectedItem.object)
                        {
                            this._nSelectedItem = null;
                        }
                    }
                }
            }
            return;
        }// end function

        public function get autoSelectMode() : int
        {
            return this._autoSelect;
        }// end function

        public function get scrollDisplay() : String
        {
            return this._displayScrollbar;
        }// end function

        public function set scrollDisplay(param1:String) : void
        {
            this._displayScrollbar = param1;
            return;
        }// end function

        public function get pagesCount() : uint
        {
            var _loc_1:* = 0;
            if (this._verticalScroll)
            {
                _loc_1 = this._totalSlotByCol - this._slotByCol;
            }
            else
            {
                _loc_1 = this._totalSlotByRow - this._slotByRow;
            }
            if (_loc_1 < 0)
            {
                _loc_1 = 0;
            }
            return _loc_1;
        }// end function

        public function get selectedItem()
        {
            if (!this._dataProvider)
            {
                return null;
            }
            if (this._nSelectedIndex < 0)
            {
                return null;
            }
            if (this._nSelectedIndex >= this._dataProvider.length)
            {
                return null;
            }
            return this._dataProvider[this._nSelectedIndex];
        }// end function

        public function set selectedItem(param1) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            if (this._dataProvider)
            {
                _loc_2 = false;
                _loc_3 = 0;
                while (_loc_3 < this._dataProvider.length)
                {
                    
                    _loc_4 = SecureCenter.unsecure(this._dataProvider[_loc_3]);
                    if (_loc_4 === SecureCenter.unsecure(param1))
                    {
                        this.setSelectedIndex(_loc_3, SelectMethodEnum.MANUAL);
                        _loc_2 = true;
                        break;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public function get slotWidth() : uint
        {
            return this._slotWidth;
        }// end function

        public function set slotWidth(param1:uint) : void
        {
            this._slotWidth = param1;
            if (this.finalized)
            {
                this.finalize();
            }
            return;
        }// end function

        public function get slotHeight() : uint
        {
            return this._slotHeight;
        }// end function

        public function set slotHeight(param1:uint) : void
        {
            this._slotHeight = param1;
            if (this.finalized)
            {
                this.finalize();
            }
            return;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._finalized = param1;
            return;
        }// end function

        public function get finalized() : Boolean
        {
            return this._finalized;
        }// end function

        public function get slotByRow() : uint
        {
            return this._slotByRow;
        }// end function

        public function get slotByCol() : uint
        {
            return this._slotByCol;
        }// end function

        public function get verticalScrollValue() : int
        {
            if (this._scrollBarV)
            {
                return this._scrollBarV.value;
            }
            return 0;
        }// end function

        public function set verticalScrollValue(param1:int) : void
        {
            if (this._scrollBarV)
            {
                this._scrollBarV.value = param1;
                if (this._scrollBarV.value < 0)
                {
                    this.updateFromIndex(0);
                }
                else
                {
                    this.updateFromIndex(param1);
                }
            }
            return;
        }// end function

        public function get verticalScrollSpeed() : Number
        {
            return this._verticalScrollSpeed;
        }// end function

        public function get horizontalScrollSpeed() : Number
        {
            return this._horizontalScrollSpeed;
        }// end function

        public function set verticalScrollSpeed(param1:Number) : void
        {
            this._verticalScrollSpeed = param1;
            if (this._scrollBarV)
            {
                this._scrollBarV.scrollSpeed = param1;
            }
            return;
        }// end function

        public function set horizontalScrollSpeed(param1:Number) : void
        {
            this._horizontalScrollSpeed = param1;
            if (this._scrollBarH)
            {
                this._scrollBarH.scrollSpeed = param1;
            }
            return;
        }// end function

        public function get hiddenRow() : uint
        {
            return this._hiddenRow;
        }// end function

        public function get hiddenCol() : uint
        {
            return this._hiddenCol;
        }// end function

        public function set hiddenRow(param1:uint) : void
        {
            this._hiddenRow = param1;
            if (this.finalized)
            {
                this.finalize();
            }
            return;
        }// end function

        public function set hiddenCol(param1:uint) : void
        {
            this._hiddenCol = param1;
            if (this.finalized)
            {
                this.finalize();
            }
            return;
        }// end function

        public function renderModificator(param1:Array, param2:Object) : Array
        {
            var _loc_3:* = null;
            if (param2 != SecureCenter.ACCESS_KEY)
            {
                throw new IllegalOperationError();
            }
            if (this._sRendererName)
            {
                if (!this._renderer)
                {
                    _loc_3 = getDefinitionByName(this._sRendererName) as Class;
                    if (_loc_3)
                    {
                        this._renderer = new _loc_3(this._sRendererArgs);
                        this._renderer.grid = this;
                    }
                    else
                    {
                        _log.error("Invalid renderer specified for this grid.");
                        return param1;
                    }
                }
            }
            else
            {
                _log.error("No renderer specified for grid " + name + " " + parent + " son.");
                return param1;
            }
            this.configVar();
            return this._renderer.renderModificator(param1);
        }// end function

        public function finalize() : void
        {
            var _loc_1:* = 0;
            this.configVar();
            if (this._slotByRow < this._totalSlotByRow && this._displayScrollbar != "never")
            {
                if (!this._scrollBarH)
                {
                    this._scrollBarH = new ScrollBar();
                    addChild(this._scrollBarH);
                    this._scrollBarH.addEventListener(Event.CHANGE, this.onScroll, false, 0, true);
                    this._scrollBarH.css = this._sVScrollCss;
                    this._scrollBarH.min = 0;
                    this._scrollBarH.max = this._totalSlotByRow - this._slotByRow;
                    this._scrollBarH.total = this._totalSlotByRow;
                    this._scrollBarH.width = width;
                    this._scrollBarH.height = this._scrollBarSize;
                    this._scrollBarH.y = height - this._scrollBarH.height;
                    this._scrollBarH.step = 1;
                    this._scrollBarH.scrollSpeed = this._horizontalScrollSpeed;
                    this._scrollBarH.finalize();
                }
                else
                {
                    this._scrollBarH.max = this._totalSlotByRow - this._slotByRow;
                    addChild(this._scrollBarH);
                }
            }
            else if (this._slotByCol < this._totalSlotByCol && this._displayScrollbar != "never" || this._displayScrollbar == "always")
            {
                if (!this._scrollBarV)
                {
                    this._scrollBarV = new ScrollBar();
                    addChild(this._scrollBarV);
                    this._scrollBarV.addEventListener(Event.CHANGE, this.onScroll, false, 0, true);
                    this._scrollBarV.css = this._sVScrollCss;
                    this._scrollBarV.min = 0;
                    _loc_1 = this._totalSlotByCol - this._slotByCol;
                    if (_loc_1 < 0)
                    {
                        this._scrollBarV.max = 0;
                    }
                    else
                    {
                        this._scrollBarV.max = _loc_1;
                    }
                    this._scrollBarV.total = this._totalSlotByCol;
                    this._scrollBarV.width = this._scrollBarSize;
                    this._scrollBarV.height = height;
                    this._scrollBarV.x = width - this._scrollBarV.width;
                    this._scrollBarV.step = 1;
                    this._scrollBarV.scrollSpeed = this._verticalScrollSpeed;
                    this._scrollBarV.finalize();
                }
                else
                {
                    _loc_1 = this._totalSlotByCol - this._slotByCol;
                    if (_loc_1 < 0)
                    {
                        this._scrollBarV.max = 0;
                    }
                    else
                    {
                        this._scrollBarV.max = _loc_1;
                    }
                    this._scrollBarV.total = this._totalSlotByCol;
                    addChild(this._scrollBarV);
                    this._scrollBarV.finalize();
                }
            }
            else
            {
                if (this._scrollBarV && this._scrollBarV.parent)
                {
                    removeChild(this._scrollBarV);
                    this._scrollBarV.max = 0;
                    this._scrollBarV.finalize();
                }
                if (this._scrollBarH && this._scrollBarH.parent)
                {
                    removeChild(this._scrollBarH);
                    this._scrollBarH.max = 0;
                    this._scrollBarH.finalize();
                }
            }
            if (this._hiddenCol || this._hiddenRow)
            {
                if (!this._mask)
                {
                    this._mask = new Shape();
                }
                if (this._mask.width != width || this._mask.height != height)
                {
                    this._mask.graphics.clear();
                    this._mask.graphics.beginFill(16776960);
                    this._mask.graphics.drawRect(0, 0, width, height);
                    addChild(this._mask);
                    mask = this._mask;
                }
            }
            this._finalized = true;
            if (getUi())
            {
                getUi().iAmFinalized(this);
            }
            return;
        }// end function

        public function moveToPage(param1:uint) : void
        {
            if (param1 > this.pagesCount)
            {
                param1 = this.pagesCount;
            }
            this.updateFromIndex(param1);
            return;
        }// end function

        public function updateItem(param1:uint) : void
        {
            var _loc_2:* = null;
            _loc_2 = this._items[param1];
            if (!_loc_2)
            {
                return;
            }
            if (_loc_2.index == this._nSelectedIndex)
            {
                this._renderer.update(this._dataProvider[_loc_2.index], param1, _loc_2.container, true);
            }
            else
            {
                this._renderer.update(this._dataProvider[_loc_2.index], param1, _loc_2.container, false);
            }
            _loc_2.data = this._dataProvider[_loc_2.index];
            this.finalize();
            return;
        }// end function

        public function updateItems() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._items.length)
            {
                
                _loc_1 = this._items[_loc_2];
                if (!_loc_1 || this._nSelectedIndex < 0)
                {
                }
                else
                {
                    if (_loc_1.index == this._nSelectedIndex)
                    {
                        this._renderer.update(this._dataProvider[_loc_1.index], _loc_2, _loc_1.container, true);
                    }
                    else
                    {
                        this._renderer.update(this._dataProvider[_loc_1.index], _loc_2, _loc_1.container, false);
                    }
                    _loc_1.data = this._dataProvider[_loc_1.index];
                }
                _loc_2 = _loc_2 + 1;
            }
            this.finalize();
            return;
        }// end function

        public function get selectedSlot() : DisplayObject
        {
            var _loc_1:* = null;
            if (this._items == null || this._nSelectedIndex < 0 || this._nSelectedIndex >= this.dataProvider.length)
            {
                return null;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._items.length)
            {
                
                _loc_1 = this._items[_loc_2];
                if (_loc_1.data == this.selectedItem)
                {
                    return _loc_1.container;
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

        public function get slots() : Array
        {
            if (this._items == null || this.dataProvider.length == 0)
            {
                return new Array();
            }
            var _loc_1:* = new Array();
            var _loc_2:* = 0;
            while (_loc_2 < this._items.length)
            {
                
                if (this._items[_loc_2])
                {
                    _loc_1.push(this._items[_loc_2].container);
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_1;
        }// end function

        override public function remove() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (!__removed)
            {
                _loc_2 = 0;
                while (_loc_2 < this._items.length)
                {
                    
                    _loc_1 = this._items[_loc_2];
                    this._renderer.remove(_loc_1.container);
                    _loc_2 = _loc_2 + 1;
                }
                this._renderer.destroy();
                this._items = null;
                if (this._scrollBarH)
                {
                    this._scrollBarH.removeEventListener(Event.CHANGE, this.onScroll);
                }
                if (this._scrollBarV)
                {
                    this._scrollBarV.removeEventListener(Event.CHANGE, this.onScroll);
                }
            }
            super.remove();
            return;
        }// end function

        public function indexIsInvisibleSlot(param1:uint) : Boolean
        {
            if (this._verticalScroll)
            {
                return param1 / this._totalSlotByRow - this._pageYOffset >= this._slotByCol || param1 / this._totalSlotByRow - this._pageYOffset < 0;
            }
            return param1 % this._totalSlotByRow - this._pageXOffset >= this._slotByRow || param1 % this._totalSlotByRow - this._pageXOffset < 0;
        }// end function

        public function moveTo(param1:uint, param2:Boolean = false) : void
        {
            if (this.indexIsInvisibleSlot(param1) || param2)
            {
                if (this._scrollBarV)
                {
                    this._scrollBarV.value = Math.floor(param1 / this._totalSlotByRow);
                    if (this._scrollBarV.value < 0)
                    {
                        this.updateFromIndex(0);
                    }
                    else
                    {
                        this.updateFromIndex(this._scrollBarV.value);
                    }
                }
                else if (this._scrollBarH)
                {
                    this._scrollBarH.value = param1 % this._totalSlotByRow;
                    if (this._scrollBarH.value < 0)
                    {
                        this.updateFromIndex(0);
                    }
                    else
                    {
                        this.updateFromIndex(this._scrollBarH.value);
                    }
                }
            }
            return;
        }// end function

        public function getIndex() : uint
        {
            if (this._scrollBarV)
            {
                return Math.floor(this._scrollBarV.value * this._totalSlotByRow);
            }
            return 0;
        }// end function

        public function sortOn(param1:String, param2:int = 0) : void
        {
            this._sortProperty = param1;
            this._dataProvider.sortOn(param1, param2);
            this.finalize();
            this.initSlot();
            return;
        }// end function

        public function getItemIndex(param1) : int
        {
            var _loc_2:* = null;
            _loc_2 = SecureCenter.unsecure(param1);
            var _loc_3:* = this.getGridItem(_loc_2);
            if (_loc_3)
            {
                return _loc_3.index;
            }
            return -1;
        }// end function

        private function sortFunction(param1, param2) : Number
        {
            if (param1[this._sortProperty] < param2[this._sortProperty])
            {
                return -1;
            }
            if (param1[this._sortProperty] == param2[this._sortProperty])
            {
                return 0;
            }
            return 1;
        }// end function

        private function initSlot() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = false;
            var _loc_2:* = 0;
            if (this._dataProvider.length && !this._autoPosition)
            {
                _loc_6 = this._slotByCol * this._slotByRow;
                while (this._pageYOffset >= 0)
                {
                    
                    while (this._pageXOffset >= 0)
                    {
                        
                        _loc_2 = this._pageXOffset * this._slotByCol + this._pageYOffset * this._slotByRow;
                        if (_loc_2 <= this._dataProvider.length - _loc_6)
                        {
                            break;
                        }
                        var _loc_9:* = this;
                        var _loc_10:* = this._pageXOffset - 1;
                        _loc_9._pageXOffset = _loc_10;
                    }
                    if (_loc_2 <= this._dataProvider.length - _loc_6)
                    {
                        break;
                    }
                    this._pageXOffset = 0;
                    var _loc_9:* = this;
                    var _loc_10:* = this._pageYOffset - 1;
                    _loc_9._pageYOffset = _loc_10;
                }
                if (this._pageYOffset < 0)
                {
                    this._pageYOffset = 0;
                }
                if (this._pageXOffset < 0)
                {
                    this._pageXOffset = 0;
                }
                if (this._scrollBarH && this._scrollBarH.visible)
                {
                    this._scrollBarH.value = this._pageXOffset;
                }
                if (this._scrollBarV && this._scrollBarV.visible)
                {
                    this._scrollBarV.value = this._pageYOffset;
                }
            }
            var _loc_3:* = 0;
            var _loc_5:* = -this._hiddenRow;
            while (_loc_5 < this._slotByCol + this._hiddenRow)
            {
                
                _loc_7 = -this._hiddenCol;
                while (_loc_7 < this._slotByRow + this._hiddenCol)
                {
                    
                    _loc_2 = _loc_7 + this._pageXOffset * this._slotByCol + _loc_5 * this._totalSlotByRow + this._pageYOffset * this._slotByRow;
                    _loc_4 = this._items[_loc_3];
                    _loc_8 = this._nSelectedIndex == _loc_2 && this.autoSelect == true && this._dataProvider.length > 0 && _loc_2 < this._dataProvider.length && this._dataProvider[_loc_2] != null;
                    if (_loc_4)
                    {
                        _loc_4.index = _loc_2;
                        _loc_1 = _loc_4.container;
                        if (this._dataProvider.length > _loc_2)
                        {
                            _loc_4.data = this._dataProvider[_loc_2];
                            this._renderer.update(this._dataProvider[_loc_2], _loc_2, _loc_4.container, _loc_8);
                        }
                        else
                        {
                            _loc_4.data = null;
                            this._renderer.update(null, _loc_2, _loc_4.container, _loc_8);
                        }
                    }
                    else
                    {
                        if (this._dataProvider.length > _loc_2)
                        {
                            _loc_1 = this._renderer.render(this._dataProvider[_loc_2], _loc_2, _loc_8);
                        }
                        else
                        {
                            _loc_1 = this._renderer.render(null, _loc_2, _loc_8);
                        }
                        if (_loc_2 < this._dataProvider.length)
                        {
                            this._items.push(new GridItem(_loc_2, _loc_1, this._dataProvider[_loc_2]));
                        }
                        else
                        {
                            this._items.push(new GridItem(_loc_2, _loc_1, null));
                        }
                    }
                    _loc_1.x = _loc_7 * this._slotWidth + _loc_7 * (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow;
                    _loc_1.y = _loc_5 * this._slotHeight + _loc_5 * (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol;
                    addChild(_loc_1);
                    _loc_3 = _loc_3 + 1;
                    _loc_7++;
                }
                _loc_5++;
            }
            while (this._items[_loc_3])
            {
                
                this._renderer.remove(GridItem(this._items.pop()).container);
            }
            if (this._autoSelect == AUTOSELECT_BY_INDEX)
            {
                this.setSelectedIndex(Math.min(this._nSelectedIndex, (this._dataProvider.length - 1)), SelectMethodEnum.AUTO);
            }
            else if (this._autoSelect == AUTOSELECT_BY_ITEM)
            {
                if (this._nSelectedItem)
                {
                    this.selectedItem = this._nSelectedItem.object;
                    if (this.selectedItem != this._nSelectedItem.object)
                    {
                        this._nSelectedItem = null;
                    }
                }
            }
            return;
        }// end function

        private function updateFromIndex(param1:uint) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_2:* = param1 - (this._verticalScroll ? (this._pageYOffset) : (this._pageXOffset));
            if (!_loc_2)
            {
                return;
            }
            if (this._verticalScroll)
            {
                this._pageYOffset = param1;
            }
            else
            {
                this._pageXOffset = param1;
            }
            var _loc_6:* = new Array();
            var _loc_7:* = new Array();
            var _loc_8:* = 0;
            _loc_3 = 0;
            while (_loc_3 < this._items.length)
            {
                
                _loc_5 = this._items[_loc_3];
                if (this.indexIsInvisibleSlot(_loc_5.index))
                {
                    _loc_6.push(_loc_5);
                    _loc_8 = _loc_8 + 1;
                }
                else
                {
                    _loc_7[_loc_5.index] = _loc_5;
                }
                _loc_3++;
            }
            _loc_4 = -this._hiddenRow;
            while (_loc_4 < this._slotByCol + this._hiddenRow)
            {
                
                _loc_3 = -this._hiddenCol;
                while (_loc_3 < this._slotByRow + this._hiddenCol)
                {
                    
                    _loc_10 = this._totalSlotByRow * _loc_4 + _loc_3 + this._pageXOffset;
                    _loc_9 = _loc_10 + this._pageYOffset * this._totalSlotByRow;
                    _loc_5 = _loc_7[_loc_9];
                    if (!_loc_5)
                    {
                        _loc_5 = _loc_6.shift();
                        _loc_5.index = _loc_9;
                        if (_loc_9 < this._dataProvider.length)
                        {
                            _loc_5.data = this._dataProvider[_loc_9];
                        }
                        else
                        {
                            _loc_5.data = null;
                        }
                        if (this._dataProvider.length > _loc_9)
                        {
                            this._renderer.update(this._dataProvider[_loc_9], _loc_9, _loc_5.container, _loc_9 == this._nSelectedIndex);
                        }
                        else
                        {
                            this._renderer.update(null, _loc_9, _loc_5.container, _loc_9 == this._nSelectedIndex);
                        }
                    }
                    if (this._verticalScroll)
                    {
                        _loc_5.container.y = Math.floor(_loc_5.index / this._totalSlotByRow - param1) * (this._slotHeight + (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol);
                    }
                    else
                    {
                        _loc_5.container.x = Math.floor(_loc_5.index % this._totalSlotByRow - param1) * (this._slotWidth + (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow);
                    }
                    _loc_3++;
                }
                _loc_4++;
            }
            return;
        }// end function

        function setSelectedIndex(param1:int, param2:uint) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            if (param2 != SelectMethodEnum.MANUAL && param1 < 0 || param1 >= this._dataProvider.length)
            {
                return;
            }
            if (param1 < 0)
            {
                _loc_3 = this._nSelectedIndex;
                this._nSelectedIndex = param1;
                if (param1 >= 0)
                {
                    this._nSelectedItem = new WeakReference(this._dataProvider[param1]);
                }
                for each (_loc_5 in this._items)
                {
                    
                    if (_loc_5.index == _loc_3 && _loc_3 < this._dataProvider.length)
                    {
                        this._renderer.update(this._dataProvider[_loc_3], _loc_3, _loc_5.container, false);
                    }
                }
                this.dispatchMessage(new SelectItemMessage(this, param2, _loc_3 != this._nSelectedIndex));
            }
            else
            {
                if (this._nSelectedIndex > 0)
                {
                    _loc_3 = this._nSelectedIndex;
                }
                this._nSelectedIndex = param1;
                if (param1 >= 0)
                {
                    this._nSelectedItem = new WeakReference(this._dataProvider[param1]);
                }
                param1 = 0;
                while (param1 < this._items.length)
                {
                    
                    _loc_4 = this._items[param1];
                    if (_loc_4.index == this._nSelectedIndex)
                    {
                        this._renderer.update(this._dataProvider[this._nSelectedIndex], this._nSelectedIndex, _loc_4.container, true);
                    }
                    else if (_loc_4.index == _loc_3)
                    {
                        if (_loc_3 < this._dataProvider.length)
                        {
                            this._renderer.update(this._dataProvider[_loc_3], _loc_3, _loc_4.container, false);
                        }
                        else
                        {
                            this._renderer.update(null, _loc_3, _loc_4.container, false);
                        }
                    }
                    param1++;
                }
                this.moveTo(this._nSelectedIndex);
                this.dispatchMessage(new SelectItemMessage(this, param2, _loc_3 != this._nSelectedIndex));
            }
            return;
        }// end function

        private function configVar() : void
        {
            var _loc_2:* = false;
            if (this._autoPosition)
            {
                this._pageXOffset = 0;
                this._pageYOffset = 0;
            }
            var _loc_1:* = 0;
            while (_loc_1 < 2)
            {
                
                _loc_2 = _loc_1 && this._displayScrollbar == "auto" && (this._totalSlotByCol * this._slotHeight > height || this._totalSlotByRow * this._slotWidth > width) || this._displayScrollbar == "always";
                this._avaibleSpaceX = width - (this._verticalScroll && _loc_2 ? (this._scrollBarSize) : (0));
                this._avaibleSpaceY = height - (!this._verticalScroll && _loc_2 ? (this._scrollBarSize) : (0));
                this._slotByRow = Math.floor(this._avaibleSpaceX / this._slotWidth);
                if (this._slotByRow == 0)
                {
                    this._slotByRow = 1;
                }
                this._slotByCol = Math.floor(this._avaibleSpaceY / this._slotHeight);
                if (this._verticalScroll)
                {
                    this._totalSlotByRow = this._slotByRow;
                    this._totalSlotByCol = Math.ceil(this._dataProvider.length / this._slotByRow);
                }
                else
                {
                    this._totalSlotByCol = this._slotByCol;
                    this._totalSlotByRow = Math.ceil(this._dataProvider.length / this._slotByCol);
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        private function isIterable(param1) : Boolean
        {
            if (param1 is Array)
            {
                return true;
            }
            if (param1 is Vector.<null>)
            {
                return true;
            }
            if (!param1)
            {
                return false;
            }
            if (param1["length"] != null && param1["length"] != 0 && !isNaN(param1["length"]) && param1[0] != null && !(param1 is String))
            {
                return true;
            }
            return false;
        }// end function

        private function getGridItem(param1:DisplayObject) : GridItem
        {
            var _loc_2:* = null;
            if (!this._items)
            {
                return null;
            }
            var _loc_3:* = param1;
            while (_loc_3 && _loc_3.parent != this)
            {
                
                _loc_3 = _loc_3.parent;
            }
            var _loc_4:* = 0;
            while (_loc_4 < this._items.length)
            {
                
                _loc_2 = this._items[_loc_4];
                if (_loc_2.container === _loc_3)
                {
                    return _loc_2;
                }
                _loc_4 = _loc_4 + 1;
            }
            return null;
        }// end function

        private function getNearestSlot(event:MouseEvent) : Slot
        {
            var _loc_5:* = 0;
            var _loc_7:* = null;
            var _loc_9:* = NaN;
            var _loc_11:* = NaN;
            var _loc_15:* = 0;
            var _loc_2:* = event.localX;
            var _loc_3:* = event.localY;
            var _loc_4:* = 0;
            var _loc_6:* = Slot(GridItem(this._items[0]).container);
            var _loc_8:* = Math.abs(_loc_2 - (_loc_6.x + this.slotWidth));
            var _loc_10:* = Math.abs(_loc_3 - (_loc_6.y + this.slotHeight));
            var _loc_12:* = Math.max(1, (this.slotByRow - 1));
            var _loc_13:* = Math.max(1, (this.slotByCol - 1));
            var _loc_14:* = 1;
            while (_loc_14 <= _loc_12)
            {
                
                _loc_5 = GridItem(this._items[_loc_14]).index;
                _loc_7 = Slot(GridItem(this._items[_loc_14]).container);
                _loc_9 = Math.abs(_loc_2 - _loc_7.x);
                if (_loc_9 < _loc_8)
                {
                    _loc_4 = _loc_5;
                    _loc_6 = _loc_7;
                    _loc_8 = Math.abs(_loc_2 - (_loc_6.x + this.slotWidth));
                }
                else
                {
                    break;
                }
                _loc_14 = _loc_14 + 1;
            }
            var _loc_16:* = 1;
            while (_loc_16 <= _loc_13)
            {
                
                _loc_15 = _loc_4 + _loc_16 * this.slotByRow;
                if (_loc_15 >= this._items.length)
                {
                    break;
                }
                _loc_7 = Slot(GridItem(this._items[_loc_15]).container);
                _loc_11 = Math.abs(_loc_3 - _loc_7.y);
                if (_loc_11 < _loc_10)
                {
                    _loc_6 = _loc_7;
                    _loc_10 = Math.abs(_loc_3 - (_loc_6.y + this.slotHeight));
                }
                else
                {
                    break;
                }
                _loc_16 = _loc_16 + 1;
            }
            return _loc_6;
        }// end function

        private function onScroll(event:Event) : void
        {
            var _loc_2:* = 0;
            if (this._scrollBarV && this._scrollBarV.visible)
            {
                _loc_2 = this._scrollBarV.value;
            }
            if (this._scrollBarH && this._scrollBarH.visible)
            {
                _loc_2 = this._scrollBarH.value;
            }
            if (!isNaN(_loc_2))
            {
                this.updateFromIndex(_loc_2);
            }
            return;
        }// end function

        private function onListWheel(event:MouseEvent) : void
        {
            if (this._verticalScroll)
            {
                if (this._scrollBarV && this._scrollBarV.visible)
                {
                    this._scrollBarV.onWheel(event);
                }
                else
                {
                    this.moveTo(this._pageYOffset + event.delta);
                }
            }
            else if (this._scrollBarH && this._scrollBarH.visible)
            {
                this._scrollBarH.onWheel(event);
            }
            else
            {
                this.moveTo(this._pageXOffset + event.delta);
            }
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            switch(true)
            {
                case param1 is MouseRightClickMessage:
                {
                    _loc_3 = param1 as MouseRightClickMessage;
                    _loc_2 = this.getGridItem(_loc_3.target);
                    if (_loc_2)
                    {
                        if (UIEventManager.getInstance().isRegisteredInstance(this, ItemRightClickMessage))
                        {
                            this.dispatchMessage(new ItemRightClickMessage(this, _loc_2));
                        }
                    }
                    break;
                }
                case param1 is MouseOverMessage:
                {
                    _loc_4 = param1 as MouseOverMessage;
                    _loc_2 = this.getGridItem(_loc_4.target);
                    if (_loc_2)
                    {
                        if (UIEventManager.getInstance().isRegisteredInstance(this, ItemRollOverMessage))
                        {
                            this.dispatchMessage(new ItemRollOverMessage(this, _loc_2));
                        }
                    }
                    break;
                }
                case param1 is MouseOutMessage:
                {
                    _loc_5 = param1 as MouseOutMessage;
                    _loc_2 = this.getGridItem(_loc_5.target);
                    if (_loc_2)
                    {
                        if (UIEventManager.getInstance().isRegisteredInstance(this, ItemRollOutMessage))
                        {
                            this.dispatchMessage(new ItemRollOutMessage(this, _loc_2));
                        }
                    }
                    break;
                }
                case param1 is MouseWheelMessage:
                {
                    this.onListWheel(MouseWheelMessage(param1).mouseEvent);
                    break;
                }
                case param1 is MouseDoubleClickMessage:
                case param1 is MouseClickMessage:
                {
                    _loc_6 = MouseMessage(param1);
                    _loc_2 = this.getGridItem(_loc_6.target);
                    if (_loc_2)
                    {
                        if (param1 is MouseClickMessage)
                        {
                            if (!_loc_2.data)
                            {
                                if (UIEventManager.getInstance().isRegisteredInstance(this, SelectEmptyItemMessage))
                                {
                                    this.dispatchMessage(new SelectEmptyItemMessage(this, SelectMethodEnum.CLICK));
                                }
                                this.setSelectedIndex(-1, SelectMethodEnum.CLICK);
                            }
                            this.setSelectedIndex(_loc_2.index, SelectMethodEnum.CLICK);
                        }
                        else
                        {
                            if (KeyPoll.getInstance().isDown(Keyboard.CONTROL) == true || KeyPoll.getInstance().isDown(15) == true)
                            {
                                this.setSelectedIndex(_loc_2.index, SelectMethodEnum.CTRL_DOUBLE_CLICK);
                            }
                            else if (AirScanner.hasAir() && KeyPoll.getInstance().isDown(Keyboard["ALTERNATE"]) == true)
                            {
                                this.setSelectedIndex(_loc_2.index, SelectMethodEnum.ALT_DOUBLE_CLICK);
                            }
                            else
                            {
                                this.setSelectedIndex(_loc_2.index, SelectMethodEnum.DOUBLE_CLICK);
                            }
                            return true;
                        }
                    }
                    break;
                }
                case param1 is MouseUpMessage:
                {
                    _loc_7 = MouseUpMessage(param1);
                    _loc_2 = this.getGridItem(_loc_7.target);
                    if (this._items && this._items[0] is GridItem && GridItem(this._items[0]).container is Slot && !_loc_2)
                    {
                        this.dispatchMessage(_loc_7, this.getNearestSlot(_loc_7.mouseEvent));
                    }
                    break;
                }
                case param1 is KeyboardKeyDownMessage:
                {
                    _loc_8 = param1 as KeyboardKeyDownMessage;
                    _loc_10 = -1;
                    switch(_loc_8.keyboardEvent.keyCode)
                    {
                        case Keyboard.UP:
                        {
                            _loc_9 = this.selectedIndex - this._totalSlotByRow;
                            _loc_10 = SelectMethodEnum.UP_ARROW;
                            break;
                        }
                        case Keyboard.DOWN:
                        {
                            _loc_9 = this.selectedIndex + this._totalSlotByRow;
                            _loc_10 = SelectMethodEnum.DOWN_ARROW;
                            break;
                        }
                        case Keyboard.RIGHT:
                        {
                            _loc_9 = this.selectedIndex + 1;
                            _loc_10 = SelectMethodEnum.RIGHT_ARROW;
                            break;
                        }
                        case Keyboard.LEFT:
                        {
                            _loc_9 = this.selectedIndex - 1;
                            _loc_10 = SelectMethodEnum.LEFT_ARROW;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_10 != -1)
                    {
                        if (this.keyboardIndexHandler != null)
                        {
                            _loc_9 = this.keyboardIndexHandler(this.selectedIndex, _loc_9);
                        }
                        this.setSelectedIndex(_loc_9, _loc_10);
                        this.moveTo(this.selectedIndex);
                        return true;
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

        private function dispatchMessage(param1:Message, param2:MessageHandler = null) : void
        {
            if (!this.silent)
            {
                if (!param2)
                {
                    param2 = Berilia.getInstance().handler;
                }
                param2.process(param1);
            }
            return;
        }// end function

    }
}
