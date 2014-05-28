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
      
      public static var MEMORY_LOG:Dictionary;
      
      protected static const _log:Logger;
      
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
      
      override public function set width(nW:Number) : void {
         super.width = nW;
         this._eventCatcher.width = nW;
      }
      
      override public function set height(nH:Number) : void {
         super.height = nH;
         this._eventCatcher.height = nH;
         if(this._scrollBarV)
         {
            this._scrollBarV.height = nH;
         }
      }
      
      public function set rendererName(value:String) : void {
         if(value.indexOf(".") == -1)
         {
            value = "com.ankamagames.berilia.components.gridRenderer." + value;
         }
         this._sRendererName = value;
      }
      
      public function get rendererName() : String {
         return this._sRendererName;
      }
      
      public function set rendererArgs(value:String) : void {
         this._sRendererArgs = value;
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
      
      public function set dataProvider(data:*) : void {
         if(!data)
         {
            return;
         }
         if(!this.isIterable(data))
         {
            throw new ArgumentError("dataProvider must be either Array or Vector.");
         }
         else
         {
            this._dataProvider = data;
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
      
      public function set horizontalScrollbarCss(sValue:Uri) : void {
         this._sHScrollCss = sValue;
      }
      
      public function get horizontalScrollbarCss() : Uri {
         return this._sHScrollCss;
      }
      
      public function set verticalScrollbarCss(sValue:Uri) : void {
         this._sVScrollCss = sValue;
      }
      
      public function get verticalScrollbarCss() : Uri {
         return this._sVScrollCss;
      }
      
      public function get selectedIndex() : int {
         return this._nSelectedIndex;
      }
      
      public function set selectedIndex(i:int) : void {
         this.setSelectedIndex(i,SelectMethodEnum.MANUAL);
      }
      
      public function set vertical(b:Boolean) : void {
         if(this._verticalScroll != b)
         {
            this._verticalScroll = b;
            if(this._finalized)
            {
               this.finalize();
            }
         }
      }
      
      public function get vertical() : Boolean {
         return this._verticalScroll;
      }
      
      public function set autoSelect(b:Boolean) : void {
         this._autoSelect = AUTOSELECT_BY_INDEX;
         if((this._dataProvider.length) && (this._autoSelect == AUTOSELECT_BY_INDEX))
         {
            this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length - 1),SelectMethodEnum.AUTO);
         }
      }
      
      public function get autoSelect() : Boolean {
         return this._autoSelect == AUTOSELECT_BY_INDEX;
      }
      
      public function set autoSelectMode(mode:int) : void {
         this._autoSelect = mode;
         if(this._dataProvider.length)
         {
            if(this._autoSelect == AUTOSELECT_BY_INDEX)
            {
               this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length - 1),SelectMethodEnum.AUTO);
            }
            else if(this._autoSelect == AUTOSELECT_BY_ITEM)
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
      
      public function get autoSelectMode() : int {
         return this._autoSelect;
      }
      
      public function get scrollDisplay() : String {
         return this._displayScrollbar;
      }
      
      public function set scrollDisplay(sValue:String) : void {
         this._displayScrollbar = sValue;
      }
      
      public function get pagesCount() : uint {
         var count:* = 0;
         if(this._verticalScroll)
         {
            count = this._totalSlotByCol - this._slotByCol;
         }
         else
         {
            count = this._totalSlotByRow - this._slotByRow;
         }
         if(count < 0)
         {
            count = 0;
         }
         return count;
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
      
      public function set selectedItem(o:*) : void {
         var isSet:* = false;
         var i:uint = 0;
         var data:* = undefined;
         if(this._dataProvider)
         {
            isSet = false;
            i = 0;
            while(i < this._dataProvider.length)
            {
               data = SecureCenter.unsecure(this._dataProvider[i]);
               if(data === SecureCenter.unsecure(o))
               {
                  this.setSelectedIndex(i,SelectMethodEnum.MANUAL);
                  isSet = true;
                  break;
               }
               i++;
            }
         }
      }
      
      public function get slotWidth() : uint {
         return this._slotWidth;
      }
      
      public function set slotWidth(value:uint) : void {
         this._slotWidth = value;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public function get slotHeight() : uint {
         return this._slotHeight;
      }
      
      public function set slotHeight(value:uint) : void {
         this._slotHeight = value;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public function set finalized(b:Boolean) : void {
         this._finalized = b;
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
      
      public function set verticalScrollValue(value:int) : void {
         if(this._scrollBarV)
         {
            this._scrollBarV.value = value;
            if(this._scrollBarV.value < 0)
            {
               this.updateFromIndex(0);
            }
            else
            {
               this.updateFromIndex(value);
            }
         }
      }
      
      public function get verticalScrollSpeed() : Number {
         return this._verticalScrollSpeed;
      }
      
      public function get horizontalScrollSpeed() : Number {
         return this._horizontalScrollSpeed;
      }
      
      public function set verticalScrollSpeed(speed:Number) : void {
         this._verticalScrollSpeed = speed;
         if(this._scrollBarV)
         {
            this._scrollBarV.scrollSpeed = speed;
         }
      }
      
      public function set horizontalScrollSpeed(speed:Number) : void {
         this._horizontalScrollSpeed = speed;
         if(this._scrollBarH)
         {
            this._scrollBarH.scrollSpeed = speed;
         }
      }
      
      public function get hiddenRow() : uint {
         return this._hiddenRow;
      }
      
      public function get hiddenCol() : uint {
         return this._hiddenCol;
      }
      
      public function set hiddenRow(v:uint) : void {
         this._hiddenRow = v;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public function set hiddenCol(v:uint) : void {
         this._hiddenCol = v;
         if(this.finalized)
         {
            this.finalize();
         }
      }
      
      public var keyboardIndexHandler:Function;
      
      public var silent:Boolean;
      
      public function renderModificator(childs:Array, accessKey:Object) : Array {
         var cRenderer:Class = null;
         if(accessKey != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            if(this._sRendererName)
            {
               if(!this._renderer)
               {
                  cRenderer = getDefinitionByName(this._sRendererName) as Class;
                  if(cRenderer)
                  {
                     this._renderer = new cRenderer(this._sRendererArgs);
                     this._renderer.grid = this;
                  }
                  else
                  {
                     _log.error("Invalid renderer specified for this grid.");
                     return childs;
                  }
               }
               this.configVar();
               return this._renderer.renderModificator(childs);
            }
            _log.error("No renderer specified for grid " + name + " " + parent + " son.");
            return childs;
         }
      }
      
      public function finalize() : void {
         var maxValue:* = 0;
         this.configVar();
         if((this._slotByRow < this._totalSlotByRow) && (!(this._displayScrollbar == "never")))
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
         else if((this._slotByCol < this._totalSlotByCol) && (!(this._displayScrollbar == "never")) || (this._displayScrollbar == "always"))
         {
            if(!this._scrollBarV)
            {
               this._scrollBarV = new ScrollBar();
               addChild(this._scrollBarV);
               this._scrollBarV.addEventListener(Event.CHANGE,this.onScroll,false,0,true);
               this._scrollBarV.css = this._sVScrollCss;
               this._scrollBarV.min = 0;
               maxValue = this._totalSlotByCol - this._slotByCol;
               if(maxValue < 0)
               {
                  this._scrollBarV.max = 0;
               }
               else
               {
                  this._scrollBarV.max = maxValue;
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
               maxValue = this._totalSlotByCol - this._slotByCol;
               if(maxValue < 0)
               {
                  this._scrollBarV.max = 0;
               }
               else
               {
                  this._scrollBarV.max = maxValue;
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
         
         if((this._hiddenCol) || (this._hiddenRow))
         {
            if(!this._mask)
            {
               this._mask = new Shape();
            }
            if((!(this._mask.width == width)) || (!(this._mask.height == height)))
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
      
      public function moveToPage(page:uint) : void {
         if(page > this.pagesCount)
         {
            page = this.pagesCount;
         }
         this.updateFromIndex(page);
      }
      
      public function updateItem(index:uint) : void {
         var currenItem:GridItem = null;
         currenItem = this._items[index];
         if(!currenItem)
         {
            return;
         }
         if(currenItem.index == this._nSelectedIndex)
         {
            this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,true);
         }
         else
         {
            this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,false);
         }
         currenItem.data = this._dataProvider[currenItem.index];
         this.finalize();
      }
      
      public function updateItems() : void {
         var currenItem:GridItem = null;
         var index:uint = 0;
         while(index < this._items.length)
         {
            currenItem = this._items[index];
            if(!((!currenItem) || (this._nSelectedIndex < 0)))
            {
               if(currenItem.index == this._nSelectedIndex)
               {
                  this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,true);
               }
               else
               {
                  this._renderer.update(this._dataProvider[currenItem.index],index,currenItem.container,false);
               }
               currenItem.data = this._dataProvider[currenItem.index];
            }
            index++;
         }
         this.finalize();
      }
      
      public function get selectedSlot() : DisplayObject {
         var currentItem:GridItem = null;
         if((this._items == null) || (this._nSelectedIndex < 0) || (this._nSelectedIndex >= this.dataProvider.length))
         {
            return null;
         }
         var i:uint = 0;
         while(i < this._items.length)
         {
            currentItem = this._items[i];
            if(currentItem.data == this.selectedItem)
            {
               return currentItem.container;
            }
            i++;
         }
         return null;
      }
      
      public function get slots() : Array {
         if((this._items == null) || (this.dataProvider.length == 0))
         {
            return new Array();
         }
         var slots:Array = new Array();
         var i:uint = 0;
         while(i < this._items.length)
         {
            if(this._items[i])
            {
               slots.push(this._items[i].container);
            }
            i++;
         }
         return slots;
      }
      
      override public function remove() : void {
         var currentItem:GridItem = null;
         var i:uint = 0;
         if(!__removed)
         {
            if(this._renderer)
            {
               i = 0;
               while(i < this._items.length)
               {
                  currentItem = this._items[i];
                  this._renderer.remove(currentItem.container);
                  i++;
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
      
      public function indexIsInvisibleSlot(index:uint) : Boolean {
         if(this._verticalScroll)
         {
            return (index / this._totalSlotByRow - this._pageYOffset >= this._slotByCol) || (index / this._totalSlotByRow - this._pageYOffset < 0);
         }
         return (index % this._totalSlotByRow - this._pageXOffset >= this._slotByRow) || (index % this._totalSlotByRow - this._pageXOffset < 0);
      }
      
      public function moveTo(index:uint, force:Boolean = false) : void {
         if((this.indexIsInvisibleSlot(index)) || (force))
         {
            if(this._scrollBarV)
            {
               this._scrollBarV.value = Math.floor(index / this._totalSlotByRow);
               if(this._scrollBarV.value < 0)
               {
                  this.updateFromIndex(0);
               }
               else
               {
                  this.updateFromIndex(this._scrollBarV.value);
               }
            }
            else if(this._scrollBarH)
            {
               this._scrollBarH.value = index % this._totalSlotByRow;
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
      
      public function getIndex() : uint {
         if(this._scrollBarV)
         {
            return Math.floor(this._scrollBarV.value * this._totalSlotByRow);
         }
         return 0;
      }
      
      public function sortOn(col:String, options:int = 0) : void {
         this._sortProperty = col;
         this._dataProvider.sortOn(col,options);
         this.finalize();
         this.initSlot();
      }
      
      public function getItemIndex(item:*) : int {
         var realItem:DisplayObject = null;
         realItem = SecureCenter.unsecure(item);
         var res:GridItem = this.getGridItem(realItem);
         if(res)
         {
            return res.index;
         }
         return -1;
      }
      
      private function sortFunction(a:*, b:*) : Number {
         if(a[this._sortProperty] < b[this._sortProperty])
         {
            return -1;
         }
         if(a[this._sortProperty] == b[this._sortProperty])
         {
            return 0;
         }
         return 1;
      }
      
      private function itemExists(o:*) : Boolean {
         var i:* = 0;
         var len:* = 0;
         var data:* = undefined;
         if(this._dataProvider)
         {
            len = this._dataProvider.length;
            i = 0;
            while(i < len)
            {
               data = SecureCenter.unsecure(this._dataProvider[i]);
               if(data === SecureCenter.unsecure(o))
               {
                  return true;
               }
               i++;
            }
         }
         return false;
      }
      
      private function initSlot() : void {
         var slot:DisplayObject = null;
         var item:GridItem = null;
         var totalSlot:uint = 0;
         var i:* = 0;
         var isSelected:* = false;
         var dataPos:int = 0;
         if((this._dataProvider.length) && (!this._autoPosition))
         {
            totalSlot = this._slotByCol * this._slotByRow;
            while(this._pageYOffset >= 0)
            {
               while(this._pageXOffset >= 0)
               {
                  dataPos = this._pageXOffset * this._slotByCol + this._pageYOffset * this._slotByRow;
                  if(dataPos <= this._dataProvider.length - totalSlot)
                  {
                     break;
                  }
                  this._pageXOffset--;
               }
               if(dataPos <= this._dataProvider.length - totalSlot)
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
         var slotIndex:uint = 0;
         var j:int = -this._hiddenRow;
         while(j < this._slotByCol + this._hiddenRow)
         {
            i = -this._hiddenCol;
            while(i < this._slotByRow + this._hiddenCol)
            {
               dataPos = i + this._pageXOffset * this._slotByCol + j * this._totalSlotByRow + this._pageYOffset * this._slotByRow;
               item = this._items[slotIndex];
               isSelected = (this._nSelectedIndex == dataPos) && (this._autoSelect > 0) && (this._dataProvider.length > 0) && (dataPos < this._dataProvider.length) && (!(this._dataProvider[dataPos] == null));
               if(item)
               {
                  item.index = dataPos;
                  slot = item.container;
                  if(this._dataProvider.length > dataPos)
                  {
                     item.data = this._dataProvider[dataPos];
                     this._renderer.update(this._dataProvider[dataPos],dataPos,item.container,isSelected);
                  }
                  else
                  {
                     item.data = null;
                     this._renderer.update(null,dataPos,item.container,isSelected);
                  }
               }
               else
               {
                  if(this._dataProvider.length > dataPos)
                  {
                     slot = this._renderer.render(this._dataProvider[dataPos],dataPos,isSelected);
                  }
                  else
                  {
                     slot = this._renderer.render(null,dataPos,isSelected);
                  }
                  if(dataPos < this._dataProvider.length)
                  {
                     this._items.push(new GridItem(dataPos,slot,this._dataProvider[dataPos]));
                  }
                  else
                  {
                     this._items.push(new GridItem(dataPos,slot,null));
                  }
               }
               slot.x = i * this._slotWidth + i * (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow;
               slot.y = j * this._slotHeight + j * (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol;
               addChild(slot);
               slotIndex++;
               i++;
            }
            j++;
         }
         while(this._items[slotIndex])
         {
            this._renderer.remove(GridItem(this._items.pop()).container);
         }
         if(this._autoSelect == AUTOSELECT_BY_INDEX)
         {
            if((((this._nSelectedItem) && (this.itemExists(this._nSelectedItem.object))) && (this._verticalScroll)) && (this._scrollBarV) && (this._scrollBarV.value >= 0))
            {
               this.updateFromIndex(this._scrollBarV.value);
            }
            else
            {
               this.setSelectedIndex(Math.min(this._nSelectedIndex,this._dataProvider.length - 1),SelectMethodEnum.AUTO);
            }
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
      
      private function updateFromIndex(newIndex:uint) : void {
         var i:* = 0;
         var j:* = 0;
         var currentItem:GridItem = null;
         var currIndex:uint = 0;
         var pos:* = 0;
         var diff:int = newIndex - (this._verticalScroll?this._pageYOffset:this._pageXOffset);
         if(!diff)
         {
            return;
         }
         if(this._verticalScroll)
         {
            this._pageYOffset = newIndex;
         }
         else
         {
            this._pageXOffset = newIndex;
         }
         var aAvaibleSlot:Array = new Array();
         var aOkSlot:Array = new Array();
         var nAvaible:uint = 0;
         i = 0;
         while(i < this._items.length)
         {
            currentItem = this._items[i];
            if(this.indexIsInvisibleSlot(currentItem.index))
            {
               aAvaibleSlot.push(currentItem);
               nAvaible++;
            }
            else
            {
               aOkSlot[currentItem.index] = currentItem;
            }
            i++;
         }
         j = -this._hiddenRow;
         while(j < this._slotByCol + this._hiddenRow)
         {
            i = -this._hiddenCol;
            while(i < this._slotByRow + this._hiddenCol)
            {
               pos = this._totalSlotByRow * j + i + this._pageXOffset;
               currIndex = pos + this._pageYOffset * this._totalSlotByRow;
               currentItem = aOkSlot[currIndex];
               if(!currentItem)
               {
                  currentItem = aAvaibleSlot.shift();
                  currentItem.index = currIndex;
                  if(currIndex < this._dataProvider.length)
                  {
                     currentItem.data = this._dataProvider[currIndex];
                  }
                  else
                  {
                     currentItem.data = null;
                  }
                  if(this._dataProvider.length > currIndex)
                  {
                     this._renderer.update(this._dataProvider[currIndex],currIndex,currentItem.container,currIndex == this._nSelectedIndex);
                  }
                  else
                  {
                     this._renderer.update(null,currIndex,currentItem.container,currIndex == this._nSelectedIndex);
                  }
               }
               if(this._verticalScroll)
               {
                  currentItem.container.y = Math.floor(currentItem.index / this._totalSlotByRow - newIndex) * (this._slotHeight + (this._avaibleSpaceY - this._slotByCol * this._slotHeight) / this._slotByCol);
               }
               else
               {
                  currentItem.container.x = Math.floor(currentItem.index % this._totalSlotByRow - newIndex) * (this._slotWidth + (this._avaibleSpaceX - this._slotByRow * this._slotWidth) / this._slotByRow);
               }
               i++;
            }
            j++;
         }
      }
      
      function setSelectedIndex(index:int, method:uint) : void {
         var lastIndex:* = 0;
         var currenItem:GridItem = null;
         var iDes:* = undefined;
         if((!(method == SelectMethodEnum.MANUAL)) && (index < 0) || (index >= this._dataProvider.length))
         {
            return;
         }
         if(index < 0)
         {
            lastIndex = this._nSelectedIndex;
            this._nSelectedIndex = index;
            if(index >= 0)
            {
               this._nSelectedItem = new WeakReference(this._dataProvider[index]);
            }
            for each(iDes in this._items)
            {
               if((iDes.index == lastIndex) && (lastIndex < this._dataProvider.length))
               {
                  this._renderer.update(this._dataProvider[lastIndex],lastIndex,iDes.container,false);
               }
            }
            this.dispatchMessage(new SelectItemMessage(this,method,!(lastIndex == this._nSelectedIndex)));
         }
         else
         {
            if(this._nSelectedIndex > 0)
            {
               lastIndex = this._nSelectedIndex;
            }
            this._nSelectedIndex = index;
            if(index >= 0)
            {
               this._nSelectedItem = new WeakReference(this._dataProvider[index]);
            }
            index = 0;
            while(index < this._items.length)
            {
               currenItem = this._items[index];
               if(currenItem.index == this._nSelectedIndex)
               {
                  this._renderer.update(this._dataProvider[this._nSelectedIndex],this._nSelectedIndex,currenItem.container,true);
               }
               else if(currenItem.index == lastIndex)
               {
                  if(lastIndex < this._dataProvider.length)
                  {
                     this._renderer.update(this._dataProvider[lastIndex],lastIndex,currenItem.container,false);
                  }
                  else
                  {
                     this._renderer.update(null,lastIndex,currenItem.container,false);
                  }
               }
               
               index++;
            }
            this.moveTo(this._nSelectedIndex);
            this.dispatchMessage(new SelectItemMessage(this,method,!(lastIndex == this._nSelectedIndex)));
         }
      }
      
      private function configVar() : void {
         var useScrollBar:* = false;
         if(this._autoPosition)
         {
            this._pageXOffset = 0;
            this._pageYOffset = 0;
         }
         var i:uint = 0;
         while(i < 2)
         {
            useScrollBar = (i && this._displayScrollbar == "auto") && (this._totalSlotByCol * this._slotHeight > height || this._totalSlotByRow * this._slotWidth > width) || (this._displayScrollbar == "always");
            this._avaibleSpaceX = width - ((this._verticalScroll) && (useScrollBar)?this._scrollBarSize:0);
            this._avaibleSpaceY = height - ((!this._verticalScroll) && (useScrollBar)?this._scrollBarSize:0);
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
            i++;
         }
      }
      
      private function isIterable(obj:*) : Boolean {
         if(obj is Array)
         {
            return true;
         }
         if(obj is Vector.<*>)
         {
            return true;
         }
         if(!obj)
         {
            return false;
         }
         if((!(obj["length"] == null)) && (!(obj["length"] == 0)) && (!isNaN(obj["length"])) && (!(obj[0] == null)) && (!(obj is String)))
         {
            return true;
         }
         return false;
      }
      
      protected function getGridItem(item:DisplayObject) : GridItem {
         var currentItem:GridItem = null;
         if(!this._items)
         {
            return null;
         }
         var currentDo:DisplayObject = item;
         while((currentDo) && (!(currentDo.parent == this)))
         {
            currentDo = currentDo.parent;
         }
         var i:uint = 0;
         while(i < this._items.length)
         {
            currentItem = this._items[i];
            if(currentItem.container === currentDo)
            {
               return currentItem;
            }
            i++;
         }
         return null;
      }
      
      private function getNearestSlot(mouseEvent:MouseEvent) : Slot {
         var nextSlotIndexX:* = 0;
         var nextSlot:Slot = null;
         var nextDiffX:* = NaN;
         var nextDiffY:* = NaN;
         var index:* = 0;
         var mouseEventX:Number = mouseEvent.localX;
         var mouseEventY:Number = mouseEvent.localY;
         var currentSlotIndexX:int = 0;
         var currentSlot:Slot = Slot(GridItem(this._items[0]).container);
         var currentDiffX:Number = Math.abs(mouseEventX - (currentSlot.x + this.slotWidth));
         var currentDiffY:Number = Math.abs(mouseEventY - (currentSlot.y + this.slotHeight));
         var xLimit:int = Math.max(1,this.slotByRow - 1);
         var yLimit:int = Math.max(1,this.slotByCol - 1);
         var x:int = 1;
         while(x <= xLimit)
         {
            nextSlotIndexX = GridItem(this._items[x]).index;
            nextSlot = Slot(GridItem(this._items[x]).container);
            nextDiffX = Math.abs(mouseEventX - nextSlot.x);
            if(nextDiffX < currentDiffX)
            {
               currentSlotIndexX = nextSlotIndexX;
               currentSlot = nextSlot;
               currentDiffX = Math.abs(mouseEventX - (currentSlot.x + this.slotWidth));
               x = x + 1;
               continue;
            }
            break;
         }
         var y:int = 1;
         while(y <= yLimit)
         {
            index = currentSlotIndexX + y * this.slotByRow;
            if(index >= this._items.length)
            {
               break;
            }
            nextSlot = Slot(GridItem(this._items[index]).container);
            nextDiffY = Math.abs(mouseEventY - nextSlot.y);
            if(nextDiffY < currentDiffY)
            {
               currentSlot = nextSlot;
               currentDiffY = Math.abs(mouseEventY - (currentSlot.y + this.slotHeight));
               y = y + 1;
               continue;
            }
            break;
         }
         return currentSlot;
      }
      
      private function onScroll(e:Event) : void {
         var i:* = 0;
         if((this._scrollBarV) && (this._scrollBarV.visible))
         {
            i = this._scrollBarV.value;
         }
         if((this._scrollBarH) && (this._scrollBarH.visible))
         {
            i = this._scrollBarH.value;
         }
         if(!isNaN(i))
         {
            this.updateFromIndex(i);
         }
      }
      
      private function onListWheel(e:MouseEvent) : void {
         if(this._verticalScroll)
         {
            if((this._scrollBarV) && (this._scrollBarV.visible))
            {
               this._scrollBarV.onWheel(e);
            }
            else
            {
               this.moveTo(this._pageYOffset + e.delta);
            }
         }
         else if((this._scrollBarH) && (this._scrollBarH.visible))
         {
            this._scrollBarH.onWheel(e);
         }
         else
         {
            this.moveTo(this._pageXOffset + e.delta);
         }
         
      }
      
      override public function process(msg:Message) : Boolean {
         var currentItem:GridItem = null;
         var mrcm:MouseRightClickMessage = null;
         var mom:MouseOverMessage = null;
         var mom2:MouseOutMessage = null;
         var scrollIndex:* = 0;
         var mmsg:MouseMessage = null;
         var mummsg:MouseUpMessage = null;
         var kdmsg:KeyboardKeyDownMessage = null;
         var newIndex:* = 0;
         var method:* = 0;
         switch(true)
         {
            case msg is MouseRightClickMessage:
               mrcm = msg as MouseRightClickMessage;
               currentItem = this.getGridItem(mrcm.target);
               if(currentItem)
               {
                  if(UIEventManager.getInstance().isRegisteredInstance(this,ItemRightClickMessage))
                  {
                     this.dispatchMessage(new ItemRightClickMessage(this,currentItem));
                  }
               }
               break;
            case msg is MouseOverMessage:
               mom = msg as MouseOverMessage;
               currentItem = this.getGridItem(mom.target);
               if(currentItem)
               {
                  if((UIEventManager.getInstance().isRegisteredInstance(this,ItemRollOverMessage)) || (parent) && (parent is ComboBox))
                  {
                     if((parent) && (parent is ComboBox))
                     {
                        this.dispatchMessage(new ItemRollOverMessage(parent as ComboBox,currentItem));
                     }
                     else
                     {
                        this.dispatchMessage(new ItemRollOverMessage(this,currentItem));
                     }
                  }
               }
               break;
            case msg is MouseOutMessage:
               mom2 = msg as MouseOutMessage;
               currentItem = this.getGridItem(mom2.target);
               if(currentItem)
               {
                  if((UIEventManager.getInstance().isRegisteredInstance(this,ItemRollOverMessage)) || (parent) && (parent is ComboBox))
                  {
                     if((parent) && (parent is ComboBox))
                     {
                        this.dispatchMessage(new ItemRollOutMessage(parent as ComboBox,currentItem));
                     }
                     else
                     {
                        this.dispatchMessage(new ItemRollOutMessage(this,currentItem));
                     }
                  }
               }
               break;
            case msg is MouseWheelMessage:
               if(this._scrollBarH)
               {
                  scrollIndex = this._scrollBarH.value;
               }
               if(this._scrollBarV)
               {
                  scrollIndex = this._scrollBarV.value;
               }
               this.onListWheel(MouseWheelMessage(msg).mouseEvent);
               if((this._scrollBarH) && (!(this._scrollBarH.value == scrollIndex)) || (this._scrollBarV) && (!(this._scrollBarV.value == scrollIndex)))
               {
                  MouseWheelMessage(msg).canceled = true;
                  return true;
               }
               break;
            case msg is MouseDoubleClickMessage:
            case msg is MouseClickMessage:
               mmsg = MouseMessage(msg);
               currentItem = this.getGridItem(mmsg.target);
               if(currentItem)
               {
                  if(msg is MouseClickMessage)
                  {
                     if(!currentItem.data)
                     {
                        if(UIEventManager.getInstance().isRegisteredInstance(this,SelectEmptyItemMessage))
                        {
                           this.dispatchMessage(new SelectEmptyItemMessage(this,SelectMethodEnum.CLICK));
                        }
                        this.setSelectedIndex(-1,SelectMethodEnum.CLICK);
                     }
                     this.setSelectedIndex(currentItem.index,SelectMethodEnum.CLICK);
                  }
                  else
                  {
                     if((KeyPoll.getInstance().isDown(Keyboard.CONTROL) == true) || (KeyPoll.getInstance().isDown(15) == true))
                     {
                        this.setSelectedIndex(currentItem.index,SelectMethodEnum.CTRL_DOUBLE_CLICK);
                     }
                     else if((AirScanner.hasAir()) && (KeyPoll.getInstance().isDown(Keyboard["ALTERNATE"]) == true))
                     {
                        this.setSelectedIndex(currentItem.index,SelectMethodEnum.ALT_DOUBLE_CLICK);
                     }
                     else
                     {
                        this.setSelectedIndex(currentItem.index,SelectMethodEnum.DOUBLE_CLICK);
                     }
                     
                     return true;
                  }
               }
               break;
            case msg is MouseUpMessage:
               mummsg = MouseUpMessage(msg);
               currentItem = this.getGridItem(mummsg.target);
               if((this._items && this._items[0] is GridItem) && (GridItem(this._items[0]).container is Slot) && (!currentItem))
               {
                  this.dispatchMessage(mummsg,this.getNearestSlot(mummsg.mouseEvent));
               }
               break;
            case msg is KeyboardKeyDownMessage:
               kdmsg = msg as KeyboardKeyDownMessage;
               method = -1;
               switch(kdmsg.keyboardEvent.keyCode)
               {
                  case Keyboard.UP:
                     newIndex = this.selectedIndex - this._totalSlotByRow;
                     method = SelectMethodEnum.UP_ARROW;
                     break;
                  case Keyboard.DOWN:
                     newIndex = this.selectedIndex + this._totalSlotByRow;
                     method = SelectMethodEnum.DOWN_ARROW;
                     break;
                  case Keyboard.RIGHT:
                     newIndex = this.selectedIndex + 1;
                     method = SelectMethodEnum.RIGHT_ARROW;
                     break;
                  case Keyboard.LEFT:
                     newIndex = this.selectedIndex - 1;
                     method = SelectMethodEnum.LEFT_ARROW;
                     break;
               }
               if(method != -1)
               {
                  if(this.keyboardIndexHandler != null)
                  {
                     newIndex = this.keyboardIndexHandler(this.selectedIndex,newIndex);
                  }
                  this.setSelectedIndex(newIndex,method);
                  this.moveTo(this.selectedIndex);
                  return true;
               }
               break;
         }
         return false;
      }
      
      protected function dispatchMessage(msg:Message, handler:MessageHandler = null) : void {
         if(!this.silent)
         {
            if(!handler)
            {
               handler = Berilia.getInstance().handler;
            }
            handler.process(msg);
         }
      }
   }
}
