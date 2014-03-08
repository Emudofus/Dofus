package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.gridRenderer.XmlUiGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.LabelGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.EntityGridRenderer;
   import com.ankamagames.berilia.components.gridRenderer.InlineXmlGridRender;
   import com.ankamagames.berilia.components.gridRenderer.MultiGridRenderer;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.Shape;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   import flash.utils.getDefinitionByName;
   import flash.events.Event;
   import com.ankamagames.berilia.types.data.GridItem;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.components.messages.ItemRightClickMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.berilia.components.messages.SelectEmptyItemMessage;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import flash.ui.Keyboard;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.berilia.Berilia;
   
   public class Grid extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function Grid() {
         super();
         this._items = new Array();
         this._dataProvider = new Array();
         this._eventCatcher = new Shape();
         this._eventCatcher.alpha = 0;
         this._eventCatcher.graphics.beginFill(16711680);
         this._eventCatcher.graphics.drawRect(0,0,1,1);
         addChild(this._eventCatcher);
         mouseEnabled = true;
         MEMORY_LOG[this] = 1;
      }
      
      private static var _include_XmlUiGridRenderer:XmlUiGridRenderer = null;
      
      private static var _include_LabelGridRenderer:LabelGridRenderer = null;
      
      private static var _include_SlotGridRenderer:SlotGridRenderer = null;
      
      private static var _include_EntityGridRenderer:EntityGridRenderer = null;
      
      private static var _include_InlineXmlGridRender:InlineXmlGridRender = null;
      
      private static var _include_MultiGridRenderer:MultiGridRenderer = null;
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Grid));
      
      public static const AUTOSELECT_NONE:int = 0;
      
      public static const AUTOSELECT_BY_INDEX:int = 1;
      
      public static const AUTOSELECT_BY_ITEM:int = 2;
      
      protected var _dataProvider;
      
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
      
      override public function set width(param1:Number) : void {
         super.width = param1;
         this._eventCatcher.width = param1;
      }
      
      override public function set height(param1:Number) : void {
         super.height = param1;
         this._eventCatcher.height = param1;
         if(this._scrollBarV)
         {
            this._scrollBarV.height = param1;
         }
      }
      
      public function set rendererName(param1:String) : void {
         if(param1.indexOf(".") == -1)
         {
            param1 = "com.ankamagames.berilia.components.gridRenderer." + param1;
         }
         this._sRendererName = param1;
      }
      
      public function get rendererName() : String {
         return this._sRendererName;
      }
      
      public function set rendererArgs(param1:String) : void {
         this._sRendererArgs = param1;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public function get rendererArgs() : String {
         return this._sRendererArgs;
      }
      
      public function get renderer() : IGridRenderer {
         return this._renderer;
      }
      
      public function set dataProvider(param1:*) : void {
         if(!param1)
         {
            return;
         }
         if(!this.isIterable(param1))
         {
            throw new ArgumentError("dataProvider must be either Array or Vector.");
         }
         else
         {
            this._dataProvider = param1;
            this.finalize();
            this.initSlot();
            return;
         }
      }
      
      public function get dataProvider() : * {
         return this._dataProvider;
      }
      
      public function resetScrollBar() : void {
         if((this._scrollBarH) && (this._scrollBarH.visible))
         {
            this._scrollBarH.value = this._pageXOffset;
         }
         if((this._scrollBarV) && (this._scrollBarV.visible))
         {
            this._scrollBarV.value = this._pageYOffset;
         }
      }
      
      public function set horizontalScrollbarCss(param1:Uri) : void {
         this._sHScrollCss = param1;
      }
      
      public function get horizontalScrollbarCss() : Uri {
         return this._sHScrollCss;
      }
      
      public function set verticalScrollbarCss(param1:Uri) : void {
         this._sVScrollCss = param1;
      }
      
      public function get verticalScrollbarCss() : Uri {
         return this._sVScrollCss;
      }
      
      public function get selectedIndex() : int {
         return this._nSelectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void {
         this.setSelectedIndex(param1,SelectMethodEnum.MANUAL);
      }
      
      public function set vertical(param1:Boolean) : void {
         if(this._verticalScroll != param1)
         {
            this._verticalScroll = param1;
            if(this._finalized)
            {
               this.finalize();
            }
         }
      }
      
      public function get vertical() : Boolean {
         return this._verticalScroll;
      }
      
      public function set autoSelect(param1:Boolean) : void {
         this._autoSelect = AUTOSELECT_BY_INDEX;
         if((this._dataProvider.length) && this._autoSelect == AUTOSELECT_BY_INDEX)
         {
            this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length-1),SelectMethodEnum.AUTO);
         }
      }
      
      public function get autoSelect() : Boolean {
         return this._autoSelect == AUTOSELECT_BY_INDEX;
      }
      
      public function set autoSelectMode(param1:int) : void {
         this._autoSelect = param1;
         if(this._dataProvider.length)
         {
            if(this._autoSelect == AUTOSELECT_BY_INDEX)
            {
               this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length-1),SelectMethodEnum.AUTO);
            }
            else
            {
               if(this._autoSelect == AUTOSELECT_BY_ITEM)
               {
                  if(this._nSelectedItem)
                  {
                     this.selectedItem = this._nSelectedItem.object;
                     if(this.selectedItem != this._nSelectedItem.object)
                     {
                        this._nSelectedItem = null;
                     }
                  }
               }
            }
         }
      }
      
      public function get autoSelectMode() : int {
         return this._autoSelect;
      }
      
      public function get scrollDisplay() : String {
         return this._displayScrollbar;
      }
      
      public function set scrollDisplay(param1:String) : void {
         this._displayScrollbar = param1;
      }
      
      public function get pagesCount() : uint {
         var _loc1_:* = 0;
         if(this._verticalScroll)
         {
            _loc1_ = this._totalSlotByCol - this._slotByCol;
         }
         else
         {
            _loc1_ = this._totalSlotByRow - this._slotByRow;
         }
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      public function get selectedItem() : * {
         if(!this._dataProvider)
         {
            return null;
         }
         if(this._nSelectedIndex < 0)
         {
            return null;
         }
         if(this._nSelectedIndex >= this._dataProvider.length)
         {
            return null;
         }
         return this._dataProvider[this._nSelectedIndex];
      }
      
      public function set selectedItem(param1:*) : void {
         var _loc2_:* = false;
         var _loc3_:uint = 0;
         var _loc4_:* = undefined;
         if(this._dataProvider)
         {
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < this._dataProvider.length)
            {
               _loc4_ = SecureCenter.unsecure(this._dataProvider[_loc3_]);
               if(_loc4_ === SecureCenter.unsecure(param1))
               {
                  this.setSelectedIndex(_loc3_,SelectMethodEnum.MANUAL);
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      public function get slotWidth() : uint {
         return this._slotWidth;
      }
      
      public function set slotWidth(param1:uint) : void {
         this._slotWidth = param1;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public function get slotHeight() : uint {
         return this._slotHeight;
      }
      
      public function set slotHeight(param1:uint) : void {
         this._slotHeight = param1;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function get slotByRow() : uint {
         return this._slotByRow;
      }
      
      public function get slotByCol() : uint {
         return this._slotByCol;
      }
      
      public function get verticalScrollValue() : int {
         if(this._scrollBarV)
         {
            return this._scrollBarV.value;
         }
         return 0;
      }
      
      public function set verticalScrollValue(param1:int) : void {
         if(this._scrollBarV)
         {
            this._scrollBarV.value = param1;
            if(this._scrollBarV.value < 0)
            {
               this.updateFromIndex(0);
            }
            else
            {
               this.updateFromIndex(param1);
            }
         }
      }
      
      public function get verticalScrollSpeed() : Number {
         return this._verticalScrollSpeed;
      }
      
      public function get horizontalScrollSpeed() : Number {
         return this._horizontalScrollSpeed;
      }
      
      public function set verticalScrollSpeed(param1:Number) : void {
         this._verticalScrollSpeed = param1;
         if(this._scrollBarV)
         {
            this._scrollBarV.scrollSpeed = param1;
         }
      }
      
      public function set horizontalScrollSpeed(param1:Number) : void {
         this._horizontalScrollSpeed = param1;
         if(this._scrollBarH)
         {
            this._scrollBarH.scrollSpeed = param1;
         }
      }
      
      public function get hiddenRow() : uint {
         return this._hiddenRow;
      }
      
      public function get hiddenCol() : uint {
         return this._hiddenCol;
      }
      
      public function set hiddenRow(param1:uint) : void {
         this._hiddenRow = param1;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public function set hiddenCol(param1:uint) : void {
         this._hiddenCol = param1;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public var keyboardIndexHandler:Function;
      
      public var silent:Boolean;
      
      public function renderModificator(param1:Array, param2:Object) : Array {
         var _loc3_:Class = null;
         if(param2 != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            if(this._sRendererName)
            {
               if(!this._renderer)
               {
                  _loc3_ = getDefinitionByName(this._sRendererName) as Class;
                  if(_loc3_)
                  {
                     this._renderer = new _loc3_(this._sRendererArgs);
                     this._renderer.grid = this;
                  }
                  else
                  {
                     _log.error("Invalid renderer specified for this grid.");
                     return param1;
                  }
               }
               this.configVar();
               return this._renderer.renderModificator(param1);
            }
            _log.error("No renderer specified for grid " + name + " " + parent + " son.");
            return param1;
         }
      }
      
      public function finalize() : void {
         var _loc1_:* = 0;
         this.configVar();
         if(this._slotByRow < this._totalSlotByRow && !(this._displayScrollbar == "never"))
         {
            if(!this._scrollBarH)
            {
               this._scrollBarH = new ScrollBar();
               addChild(this._scrollBarH);
               this._scrollBarH.addEventListener(Event.CHANGE,this.onScroll,false,0,true);
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
         else
         {
            if(this._slotByCol < this._totalSlotByCol && !(this._displayScrollbar == "never") || this._displayScrollbar == "always")
            {
               if(!this._scrollBarV)
               {
                  this._scrollBarV = new ScrollBar();
                  addChild(this._scrollBarV);
                  this._scrollBarV.addEventListener(Event.CHANGE,this.onScroll,false,0,true);
                  this._scrollBarV.css = this._sVScrollCss;
                  this._scrollBarV.min = 0;
                  _loc1_ = this._totalSlotByCol - this._slotByCol;
                  if(_loc1_ < 0)
                  {
                     this._scrollBarV.max = 0;
                  }
                  else
                  {
                     this._scrollBarV.max = _loc1_;
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
                  _loc1_ = this._totalSlotByCol - this._slotByCol;
                  if(_loc1_ < 0)
                  {
                     this._scrollBarV.max = 0;
                  }
                  else
                  {
                     this._scrollBarV.max = _loc1_;
                  }
                  this._scrollBarV.total = this._totalSlotByCol;
                  addChild(this._scrollBarV);
                  this._scrollBarV.finalize();
               }
            }
            else
            {
               if((this._scrollBarV) && (this._scrollBarV.parent))
               {
                  removeChild(this._scrollBarV);
                  this._scrollBarV.max = 0;
                  this._scrollBarV.finalize();
               }
               if((this._scrollBarH) && (this._scrollBarH.parent))
               {
                  removeChild(this._scrollBarH);
                  this._scrollBarH.max = 0;
                  this._scrollBarH.finalize();
               }
            }
         }
         if((this._hiddenCol) || (this._hiddenRow))
         {
            if(!this._mask)
            {
               this._mask = new Shape();
            }
            if(!(this._mask.width == width) || !(this._mask.height == height))
            {
               this._mask.graphics.clear();
               this._mask.graphics.beginFill(16776960);
               this._mask.graphics.drawRect(0,0,width,height);
               addChild(this._mask);
               mask = this._mask;
            }
         }
         this._finalized = true;
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      public function moveToPage(param1:uint) : void {
         if(param1 > this.pagesCount)
         {
            param1 = this.pagesCount;
         }
         this.updateFromIndex(param1);
      }
      
      public function updateItem(param1:uint) : void {
         var _loc2_:GridItem = null;
         _loc2_ = this._items[param1];
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.index == this._nSelectedIndex)
         {
            this._renderer.update(this._dataProvider[_loc2_.index],param1,_loc2_.container,true);
         }
         else
         {
            this._renderer.update(this._dataProvider[_loc2_.index],param1,_loc2_.container,false);
         }
         _loc2_.data = this._dataProvider[_loc2_.index];
         this.finalize();
      }
      
      public function updateItems() : void {
         var _loc1_:GridItem = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._items.length)
         {
            _loc1_ = this._items[_loc2_];
            if(!(!_loc1_ || this._nSelectedIndex < 0))
            {
               if(_loc1_.index == this._nSelectedIndex)
               {
                  this._renderer.update(this._dataProvider[_loc1_.index],_loc2_,_loc1_.container,true);
               }
               else
               {
                  this._renderer.update(this._dataProvider[_loc1_.index],_loc2_,_loc1_.container,false);
               }
               _loc1_.data = this._dataProvider[_loc1_.index];
            }
            _loc2_++;
         }
         this.finalize();
      }
      
      public function get selectedSlot() : DisplayObject {
         var _loc1_:GridItem = null;
         if(this._items == null || this._nSelectedIndex < 0 || this._nSelectedIndex >= this.dataProvider.length)
         {
            return null;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this._items.length)
         {
            _loc1_ = this._items[_loc2_];
            if(_loc1_.data == this.selectedItem)
            {
               return _loc1_.container;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get slots() : Array {
         if(this._items == null || this.dataProvider.length == 0)
         {
            return new Array();
         }
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this._items.length)
         {
            if(this._items[_loc2_])
            {
               _loc1_.push(this._items[_loc2_].container);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function remove() : void {
         var _loc1_:GridItem = null;
         var _loc2_:uint = 0;
         if(!__removed)
         {
            if(this._renderer)
            {
               _loc2_ = 0;
               while(_loc2_ < this._items.length)
               {
                  _loc1_ = this._items[_loc2_];
                  this._renderer.remove(_loc1_.container);
                  _loc2_++;
               }
               this._renderer.destroy();
            }
            this._items = null;
            if(this._scrollBarH)
            {
               this._scrollBarH.removeEventListener(Event.CHANGE,this.onScroll);
            }
            if(this._scrollBarV)
            {
               this._scrollBarV.removeEventListener(Event.CHANGE,this.onScroll);
            }
         }
         super.remove();
      }
      
      public function indexIsInvisibleSlot(param1:uint) : Boolean {
         if(this._verticalScroll)
         {
            return param1 / this._totalSlotByRow - this._pageYOffset >= this._slotByCol || param1 / this._totalSlotByRow - this._pageYOffset < 0;
         }
         return param1 % this._totalSlotByRow - this._pageXOffset >= this._slotByRow || param1 % this._totalSlotByRow - this._pageXOffset < 0;
      }
      
      public function moveTo(param1:uint, param2:Boolean=false) : void {
         if((this.indexIsInvisibleSlot(param1)) || (param2))
         {
            if(this._scrollBarV)
            {
               this._scrollBarV.value = Math.floor(param1 / this._totalSlotByRow);
               if(this._scrollBarV.value < 0)
               {
                  this.updateFromIndex(0);
               }
               else
               {
                  this.updateFromIndex(this._scrollBarV.value);
               }
            }
            else
            {
               if(this._scrollBarH)
               {
                  this._scrollBarH.value = param1 % this._totalSlotByRow;
                  if(this._scrollBarH.value < 0)
                  {
                     this.updateFromIndex(0);
                  }
                  else
                  {
                     this.updateFromIndex(this._scrollBarH.value);
                  }
               }
            }
         }
      }
      
      public function getIndex() : uint {
         if(this._scrollBarV)
         {
            return Math.floor(this._scrollBarV.value * this._totalSlotByRow);
         }
         return 0;
      }
      
      public function sortOn(param1:String, param2:int=0) : void {
         this._sortProperty = param1;
         this._dataProvider.sortOn(param1,param2);
         this.finalize();
         this.initSlot();
      }
      
      public function getItemIndex(param1:*) : int {
         var _loc2_:DisplayObject = null;
         _loc2_ = SecureCenter.unsecure(param1);
         var _loc3_:GridItem = this.getGridItem(_loc2_);
         if(_loc3_)
         {
            return _loc3_.index;
         }
         return -1;
      }
      
      private function sortFunction(param1:*, param2:*) : Number {
         if(param1[this._sortProperty] < param2[this._sortProperty])
         {
            return -1;
         }
         if(param1[this._sortProperty] == param2[this._sortProperty])
         {
            return 0;
         }
         return 1;
      }
      
      private function initSlot() : void {
         var _loc1_:DisplayObject = null;
         var _loc4_:GridItem = null;
         var _loc6_:uint = 0;
         var _loc7_:* = 0;
         var _loc8_:* = false;
         var _loc2_:* = 0;
         if((this._dataProvider.length) && !this._autoPosition)
         {
            _loc6_ = this._slotByCol * this._slotByRow;
            while(this._pageYOffset >= 0)
            {
               while(this._pageXOffset >= 0)
               {
                  _loc2_ = this._pageXOffset * this._slotByCol + this._pageYOffset * this._slotByRow;
                  if(_loc2_ <= this._dataProvider.length - _loc6_)
                  {
                     break;
                  }
                  this._pageXOffset--;
               }
               if(_loc2_ <= this._dataProvider.length - _loc6_)
               {
                  break;
               }
               this._pageXOffset = 0;
               this._pageYOffset--;
            }
            if(this._pageYOffset < 0)
            {
               this._pageYOffset = 0;
            }
            if(this._pageXOffset < 0)
            {
               this._pageXOffset = 0;
            }
            if((this._scrollBarH) && (this._scrollBarH.visible))
            {
               this._scrollBarH.value = this._pageXOffset;
            }
            if((this._scrollBarV) && (this._scrollBarV.visible))
            {
               this._scrollBarV.value = this._pageYOffset;
            }
         }
         var _loc3_:uint = 0;
         var _loc5_:int = -this._hiddenRow;
         while(_loc5_ < this._slotByCol + this._hiddenRow)
         {
            _loc7_ = -this._hiddenCol;
            while(_loc7_ < this._slotByRow + this._hiddenCol)
            {
               _loc2_ = _loc7_ + this._pageXOffset * this._slotByCol + _loc5_ * this._totalSlotByRow + this._pageYOffset * this._slotByRow;
               _loc4_ = this._items[_loc3_];
               _loc8_ = this._nSelectedIndex == _loc2_ && this._autoSelect > 0 && this._dataProvider.length > 0 && _loc2_ < this._dataProvider.length && !(this._dataProvider[_loc2_] == null);
               if(_loc4_)
               {
                  _loc4_.index = _loc2_;
                  _loc1_ = _loc4_.container;
                  if(this._dataProvider.length > _loc2_)
                  {
                     _loc4_.data = this._dataProvider[_loc2_];
                     this._renderer.update(this._dataProvider[_loc2_],_loc2_,_loc4_.container,_loc8_);
                  }
                  else
                  {
                     _loc4_.data = null;
                     this._renderer.update(null,_loc2_,_loc4_.container,_loc8_);
                  }
               }
               else
               {
                  if(this._dataProvider.length > _loc2_)
                  {
                     _loc1_ = this._renderer.render(this._dataProvider[_loc2_],_loc2_,_loc8_);
                  }
                  else
                  {
                     _loc1_ = this._renderer.render(null,_loc2_,_loc8_);
                  }
                  if(_loc2_ < this._dataProvider.length)
                  {
                     this._items.push(new GridItem(_loc2_,_loc1_,this._dataProvider[_loc2_]));
                  }
                  else
                  {
                     this._items.push(new GridItem(_loc2_,_loc1_,null));
                  }
               }
               _loc1_.x = _loc7_ * this._slotWidth + _loc7_ * (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow;
               _loc1_.y = _loc5_ * this._slotHeight + _loc5_ * (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol;
               addChild(_loc1_);
               _loc3_++;
               _loc7_++;
            }
            _loc5_++;
         }
         while(this._items[_loc3_])
         {
            this._renderer.remove(GridItem(this._items.pop()).container);
         }
         if(this._autoSelect == AUTOSELECT_BY_INDEX)
         {
            this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length-1),SelectMethodEnum.AUTO);
         }
         else
         {
            if(this._autoSelect == AUTOSELECT_BY_ITEM)
            {
               if(this._nSelectedItem)
               {
                  this.selectedItem = this._nSelectedItem.object;
                  if(this.selectedItem != this._nSelectedItem.object)
                  {
                     this._nSelectedItem = null;
                  }
               }
            }
         }
      }
      
      private function updateFromIndex(param1:uint) : void {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:GridItem = null;
         var _loc9_:uint = 0;
         var _loc10_:* = 0;
         var _loc2_:int = param1 - (this._verticalScroll?this._pageYOffset:this._pageXOffset);
         if(!_loc2_)
         {
            return;
         }
         if(this._verticalScroll)
         {
            this._pageYOffset = param1;
         }
         else
         {
            this._pageXOffset = param1;
         }
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         var _loc8_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < this._items.length)
         {
            _loc5_ = this._items[_loc3_];
            if(this.indexIsInvisibleSlot(_loc5_.index))
            {
               _loc6_.push(_loc5_);
               _loc8_++;
            }
            else
            {
               _loc7_[_loc5_.index] = _loc5_;
            }
            _loc3_++;
         }
         _loc4_ = -this._hiddenRow;
         while(_loc4_ < this._slotByCol + this._hiddenRow)
         {
            _loc3_ = -this._hiddenCol;
            while(_loc3_ < this._slotByRow + this._hiddenCol)
            {
               _loc10_ = this._totalSlotByRow * _loc4_ + _loc3_ + this._pageXOffset;
               _loc9_ = _loc10_ + this._pageYOffset * this._totalSlotByRow;
               _loc5_ = _loc7_[_loc9_];
               if(!_loc5_)
               {
                  _loc5_ = _loc6_.shift();
                  _loc5_.index = _loc9_;
                  if(_loc9_ < this._dataProvider.length)
                  {
                     _loc5_.data = this._dataProvider[_loc9_];
                  }
                  else
                  {
                     _loc5_.data = null;
                  }
                  if(this._dataProvider.length > _loc9_)
                  {
                     this._renderer.update(this._dataProvider[_loc9_],_loc9_,_loc5_.container,_loc9_ == this._nSelectedIndex);
                  }
                  else
                  {
                     this._renderer.update(null,_loc9_,_loc5_.container,_loc9_ == this._nSelectedIndex);
                  }
               }
               if(this._verticalScroll)
               {
                  _loc5_.container.y = Math.floor(_loc5_.index / this._totalSlotByRow - param1) * (this._slotHeight + (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol);
               }
               else
               {
                  _loc5_.container.x = Math.floor(_loc5_.index % this._totalSlotByRow - param1) * (this._slotWidth + (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow);
               }
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      function setSelectedIndex(param1:int, param2:uint) : void {
         var _loc3_:* = 0;
         var _loc4_:GridItem = null;
         var _loc5_:* = undefined;
         if(!(param2 == SelectMethodEnum.MANUAL) && param1 < 0 || param1 >= this._dataProvider.length)
         {
            return;
         }
         if(param1 < 0)
         {
            _loc3_ = this._nSelectedIndex;
            this._nSelectedIndex = param1;
            if(param1 >= 0)
            {
               this._nSelectedItem = new WeakReference(this._dataProvider[param1]);
            }
            for each (_loc5_ in this._items)
            {
               if(_loc5_.index == _loc3_ && _loc3_ < this._dataProvider.length)
               {
                  this._renderer.update(this._dataProvider[_loc3_],_loc3_,_loc5_.container,false);
               }
            }
            this.dispatchMessage(new SelectItemMessage(this,param2,!(_loc3_ == this._nSelectedIndex)));
         }
         else
         {
            if(this._nSelectedIndex > 0)
            {
               _loc3_ = this._nSelectedIndex;
            }
            this._nSelectedIndex = param1;
            if(param1 >= 0)
            {
               this._nSelectedItem = new WeakReference(this._dataProvider[param1]);
            }
            param1 = 0;
            while(param1 < this._items.length)
            {
               _loc4_ = this._items[param1];
               if(_loc4_.index == this._nSelectedIndex)
               {
                  this._renderer.update(this._dataProvider[this._nSelectedIndex],this._nSelectedIndex,_loc4_.container,true);
               }
               else
               {
                  if(_loc4_.index == _loc3_)
                  {
                     if(_loc3_ < this._dataProvider.length)
                     {
                        this._renderer.update(this._dataProvider[_loc3_],_loc3_,_loc4_.container,false);
                     }
                     else
                     {
                        this._renderer.update(null,_loc3_,_loc4_.container,false);
                     }
                  }
               }
               param1++;
            }
            this.moveTo(this._nSelectedIndex);
            this.dispatchMessage(new SelectItemMessage(this,param2,!(_loc3_ == this._nSelectedIndex)));
         }
      }
      
      private function configVar() : void {
         var _loc2_:* = false;
         if(this._autoPosition)
         {
            this._pageXOffset = 0;
            this._pageYOffset = 0;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = ((_loc1_) && (this._displayScrollbar == "auto")) && (this._totalSlotByCol * this._slotHeight > height || this._totalSlotByRow * this._slotWidth > width) || this._displayScrollbar == "always";
            this._avaibleSpaceX = width - ((this._verticalScroll) && (_loc2_)?this._scrollBarSize:0);
            this._avaibleSpaceY = height - (!this._verticalScroll && (_loc2_)?this._scrollBarSize:0);
            this._slotByRow = Math.floor(this._avaibleSpaceX / this._slotWidth);
            if(this._slotByRow == 0)
            {
               this._slotByRow = 1;
            }
            this._slotByCol = Math.floor(this._avaibleSpaceY / this._slotHeight);
            if(this._verticalScroll)
            {
               this._totalSlotByRow = this._slotByRow;
               this._totalSlotByCol = Math.ceil(this._dataProvider.length / this._slotByRow);
            }
            else
            {
               this._totalSlotByCol = this._slotByCol;
               this._totalSlotByRow = Math.ceil(this._dataProvider.length / this._slotByCol);
            }
            _loc1_++;
         }
      }
      
      private function isIterable(param1:*) : Boolean {
         if(param1 is Array)
         {
            return true;
         }
         if(param1 is Vector.<*>)
         {
            return true;
         }
         if(!param1)
         {
            return false;
         }
         if(!(param1["length"] == null) && !(param1["length"] == 0) && !isNaN(param1["length"]) && !(param1[0] == null) && !(param1 is String))
         {
            return true;
         }
         return false;
      }
      
      protected function getGridItem(param1:DisplayObject) : GridItem {
         var _loc2_:GridItem = null;
         if(!this._items)
         {
            return null;
         }
         var _loc3_:DisplayObject = param1;
         while((_loc3_) && !(_loc3_.parent == this))
         {
            _loc3_ = _loc3_.parent;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < this._items.length)
         {
            _loc2_ = this._items[_loc4_];
            if(_loc2_.container === _loc3_)
            {
               return _loc2_;
            }
            _loc4_++;
         }
         return null;
      }
      
      private function getNearestSlot(param1:MouseEvent) : Slot {
         var _loc5_:* = 0;
         var _loc7_:Slot = null;
         var _loc9_:* = NaN;
         var _loc11_:* = NaN;
         var _loc15_:* = 0;
         var _loc2_:Number = param1.localX;
         var _loc3_:Number = param1.localY;
         var _loc4_:* = 0;
         var _loc6_:Slot = Slot(GridItem(this._items[0]).container);
         var _loc8_:Number = Math.abs(_loc2_ - (_loc6_.x + this.slotWidth));
         var _loc10_:Number = Math.abs(_loc3_ - (_loc6_.y + this.slotHeight));
         var _loc12_:int = Math.max(1,this.slotByRow-1);
         var _loc13_:int = Math.max(1,this.slotByCol-1);
         var _loc14_:* = 1;
         while(_loc14_ <= _loc12_)
         {
            _loc5_ = GridItem(this._items[_loc14_]).index;
            _loc7_ = Slot(GridItem(this._items[_loc14_]).container);
            _loc9_ = Math.abs(_loc2_ - _loc7_.x);
            if(_loc9_ < _loc8_)
            {
               _loc4_ = _loc5_;
               _loc6_ = _loc7_;
               _loc8_ = Math.abs(_loc2_ - (_loc6_.x + this.slotWidth));
               _loc14_ = _loc14_ + 1;
               continue;
            }
            break;
         }
         var _loc16_:* = 1;
         while(_loc16_ <= _loc13_)
         {
            _loc15_ = _loc4_ + _loc16_ * this.slotByRow;
            if(_loc15_ >= this._items.length)
            {
               break;
            }
            _loc7_ = Slot(GridItem(this._items[_loc15_]).container);
            _loc11_ = Math.abs(_loc3_ - _loc7_.y);
            if(_loc11_ < _loc10_)
            {
               _loc6_ = _loc7_;
               _loc10_ = Math.abs(_loc3_ - (_loc6_.y + this.slotHeight));
               _loc16_ = _loc16_ + 1;
               continue;
            }
            break;
         }
         return _loc6_;
      }
      
      private function onScroll(param1:Event) : void {
         var _loc2_:* = 0;
         if((this._scrollBarV) && (this._scrollBarV.visible))
         {
            _loc2_ = this._scrollBarV.value;
         }
         if((this._scrollBarH) && (this._scrollBarH.visible))
         {
            _loc2_ = this._scrollBarH.value;
         }
         if(!isNaN(_loc2_))
         {
            this.updateFromIndex(_loc2_);
         }
      }
      
      private function onListWheel(param1:MouseEvent) : void {
         if(this._verticalScroll)
         {
            if((this._scrollBarV) && (this._scrollBarV.visible))
            {
               this._scrollBarV.onWheel(param1);
            }
            else
            {
               this.moveTo(this._pageYOffset + param1.delta);
            }
         }
         else
         {
            if((this._scrollBarH) && (this._scrollBarH.visible))
            {
               this._scrollBarH.onWheel(param1);
            }
            else
            {
               this.moveTo(this._pageXOffset + param1.delta);
            }
         }
      }
      
      override public function process(param1:Message) : Boolean {
         var _loc2_:GridItem = null;
         var _loc3_:MouseRightClickMessage = null;
         var _loc4_:MouseOverMessage = null;
         var _loc5_:MouseOutMessage = null;
         var _loc6_:* = 0;
         var _loc7_:MouseMessage = null;
         var _loc8_:MouseUpMessage = null;
         var _loc9_:KeyboardKeyDownMessage = null;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         switch(true)
         {
            case param1 is MouseRightClickMessage:
               _loc3_ = param1 as MouseRightClickMessage;
               _loc2_ = this.getGridItem(_loc3_.target);
               if(_loc2_)
               {
                  if(UIEventManager.getInstance().isRegisteredInstance(this,ItemRightClickMessage))
                  {
                     this.dispatchMessage(new ItemRightClickMessage(this,_loc2_));
                  }
               }
               break;
            case param1 is MouseOverMessage:
               _loc4_ = param1 as MouseOverMessage;
               _loc2_ = this.getGridItem(_loc4_.target);
               if(_loc2_)
               {
                  if((UIEventManager.getInstance().isRegisteredInstance(this,ItemRollOverMessage)) || (parent) && (parent is ComboBox))
                  {
                     if((parent) && parent is ComboBox)
                     {
                        this.dispatchMessage(new ItemRollOverMessage(parent as ComboBox,_loc2_));
                     }
                     else
                     {
                        this.dispatchMessage(new ItemRollOverMessage(this,_loc2_));
                     }
                  }
               }
               break;
            case param1 is MouseOutMessage:
               _loc5_ = param1 as MouseOutMessage;
               _loc2_ = this.getGridItem(_loc5_.target);
               if(_loc2_)
               {
                  if((UIEventManager.getInstance().isRegisteredInstance(this,ItemRollOverMessage)) || (parent) && (parent is ComboBox))
                  {
                     if((parent) && parent is ComboBox)
                     {
                        this.dispatchMessage(new ItemRollOutMessage(parent as ComboBox,_loc2_));
                     }
                     else
                     {
                        this.dispatchMessage(new ItemRollOutMessage(this,_loc2_));
                     }
                  }
               }
               break;
            case param1 is MouseWheelMessage:
               if(this._scrollBarH)
               {
                  _loc6_ = this._scrollBarH.value;
               }
               if(this._scrollBarV)
               {
                  _loc6_ = this._scrollBarV.value;
               }
               this.onListWheel(MouseWheelMessage(param1).mouseEvent);
               if((this._scrollBarH) && (!(this._scrollBarH.value == _loc6_)) || (this._scrollBarV) && (!(this._scrollBarV.value == _loc6_)))
               {
                  MouseWheelMessage(param1).canceled = true;
                  return true;
               }
               break;
            case param1 is MouseDoubleClickMessage:
            case param1 is MouseClickMessage:
               _loc7_ = MouseMessage(param1);
               _loc2_ = this.getGridItem(_loc7_.target);
               if(_loc2_)
               {
                  if(param1 is MouseClickMessage)
                  {
                     if(!_loc2_.data)
                     {
                        if(UIEventManager.getInstance().isRegisteredInstance(this,SelectEmptyItemMessage))
                        {
                           this.dispatchMessage(new SelectEmptyItemMessage(this,SelectMethodEnum.CLICK));
                        }
                        this.setSelectedIndex(-1,SelectMethodEnum.CLICK);
                     }
                     this.setSelectedIndex(_loc2_.index,SelectMethodEnum.CLICK);
                  }
                  else
                  {
                     if(KeyPoll.getInstance().isDown(Keyboard.CONTROL) == true || KeyPoll.getInstance().isDown(15) == true)
                     {
                        this.setSelectedIndex(_loc2_.index,SelectMethodEnum.CTRL_DOUBLE_CLICK);
                     }
                     else
                     {
                        if((AirScanner.hasAir()) && KeyPoll.getInstance().isDown(Keyboard["ALTERNATE"]) == true)
                        {
                           this.setSelectedIndex(_loc2_.index,SelectMethodEnum.ALT_DOUBLE_CLICK);
                        }
                        else
                        {
                           this.setSelectedIndex(_loc2_.index,SelectMethodEnum.DOUBLE_CLICK);
                        }
                     }
                     return true;
                  }
               }
               break;
            case param1 is MouseUpMessage:
               _loc8_ = MouseUpMessage(param1);
               _loc2_ = this.getGridItem(_loc8_.target);
               if(((this._items) && (this._items[0] is GridItem)) && (GridItem(this._items[0]).container is Slot) && !_loc2_)
               {
                  this.dispatchMessage(_loc8_,this.getNearestSlot(_loc8_.mouseEvent));
               }
               break;
            case param1 is KeyboardKeyDownMessage:
               _loc9_ = param1 as KeyboardKeyDownMessage;
               _loc11_ = -1;
               switch(_loc9_.keyboardEvent.keyCode)
               {
                  case Keyboard.UP:
                     _loc10_ = this.selectedIndex - this._totalSlotByRow;
                     _loc11_ = SelectMethodEnum.UP_ARROW;
                     break;
                  case Keyboard.DOWN:
                     _loc10_ = this.selectedIndex + this._totalSlotByRow;
                     _loc11_ = SelectMethodEnum.DOWN_ARROW;
                     break;
                  case Keyboard.RIGHT:
                     _loc10_ = this.selectedIndex + 1;
                     _loc11_ = SelectMethodEnum.RIGHT_ARROW;
                     break;
                  case Keyboard.LEFT:
                     _loc10_ = this.selectedIndex-1;
                     _loc11_ = SelectMethodEnum.LEFT_ARROW;
                     break;
               }
               if(_loc11_ != -1)
               {
                  if(this.keyboardIndexHandler != null)
                  {
                     _loc10_ = this.keyboardIndexHandler(this.selectedIndex,_loc10_);
                  }
                  this.setSelectedIndex(_loc10_,_loc11_);
                  this.moveTo(this.selectedIndex);
                  return true;
               }
               break;
         }
         return false;
      }
      
      protected function dispatchMessage(param1:Message, param2:MessageHandler=null) : void {
         if(!this.silent)
         {
            if(!param2)
            {
               param2 = Berilia.getInstance().handler;
            }
            param2.process(param1);
         }
      }
   }
}
