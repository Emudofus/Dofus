package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import flash.display.DisplayObject;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.berilia.types.graphic.InternalComponentAccess;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.InteractiveObject;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import flash.ui.Keyboard;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.events.TimerEvent;
   
   public class ComboBox extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function ComboBox() {
         this._searchTimer = new Timer(SEARCH_DELAY,1);
         super();
         this._button = new ButtonContainer();
         this._button.soundId = "0";
         this._bgTexture = new Texture();
         this._listTexture = new Texture();
         this._list = new ComboBoxGrid();
         this.showList(false);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._searchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onSearchTimerComplete);
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const SEARCH_DELAY:int = 1000;
      
      protected var _list:ComboBoxGrid;
      
      protected var _button:ButtonContainer;
      
      protected var _mainContainer:DisplayObject;
      
      protected var _bgTexture:Texture;
      
      protected var _listTexture:Texture;
      
      protected var _finalized:Boolean;
      
      protected var _useKeyboard:Boolean = true;
      
      protected var _closeOnClick:Boolean = true;
      
      protected var _maxListSize:uint = 300;
      
      protected var _slotWidth:uint;
      
      protected var _slotHeight:uint;
      
      private var _previousState:Boolean = false;
      
      protected var _dataNameField:String = "label";
      
      protected var _searchString:String;
      
      private var _lastSearchIndex:int = 0;
      
      private var _searchStopped:Boolean = false;
      
      private var _searchTimer:Timer;
      
      public var listSizeOffset:uint;
      
      public var autoCenter:Boolean = true;
      
      public function set buttonTexture(param1:Uri) : void {
         this._bgTexture.uri = param1;
      }
      
      public function get buttonTexture() : Uri {
         return this._bgTexture.uri;
      }
      
      public function set listTexture(param1:Uri) : void {
         this._listTexture.uri = param1;
      }
      
      public function get listTexture() : Uri {
         return this._listTexture.uri;
      }
      
      public function get maxHeight() : uint {
         return this._maxListSize;
      }
      
      public function set maxHeight(param1:uint) : void {
         this._maxListSize = param1;
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
      
      public function set dataProvider(param1:*) : void {
         var _loc2_:uint = this._maxListSize / this._list.slotHeight;
         if(param1)
         {
            if(param1.length > _loc2_)
            {
               this._list.width = width - 6;
               this._list.height = this._maxListSize;
               this._list.slotWidth = this.slotWidth?this.slotWidth:this._list.width - 16;
            }
            else
            {
               this._list.width = width - this.listSizeOffset;
               this._list.height = this._list.slotHeight * param1.length;
               this._list.slotWidth = this.slotWidth?this.slotWidth:this._list.width;
            }
         }
         else
         {
            this._list.width = width - this.listSizeOffset;
            this._list.height = this._list.slotHeight;
            this._list.slotWidth = this.slotWidth?this.slotWidth:this._list.width;
         }
         this._listTexture.height = this._list.height + 8;
         this._listTexture.width = this._list.width + 3;
         this._list.dataProvider = param1;
      }
      
      public function get dataProvider() : * {
         return this._list.dataProvider;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function set scrollBarCss(param1:Uri) : void {
         this._list.verticalScrollbarCss = param1;
      }
      
      public function get scrollBarCss() : Uri {
         return this._list.verticalScrollbarCss;
      }
      
      public function set rendererName(param1:String) : void {
         this._list.rendererName = param1;
      }
      
      public function get rendererName() : String {
         return this._list.rendererName;
      }
      
      public function set rendererArgs(param1:String) : void {
         this._list.rendererArgs = param1;
      }
      
      public function get rendererArgs() : String {
         return this._list.rendererArgs;
      }
      
      public function get value() : * {
         return this._list.selectedItem;
      }
      
      public function set value(param1:*) : void {
         this._list.selectedItem = param1;
      }
      
      public function set autoSelect(param1:Boolean) : void {
         this._list.autoSelect = param1;
      }
      
      public function get autoSelect() : Boolean {
         return this._list.autoSelect;
      }
      
      public function set autoSelectMode(param1:int) : void {
         this._list.autoSelectMode = param1;
      }
      
      public function get autoSelectMode() : int {
         return this._list.autoSelectMode;
      }
      
      public function set useKeyboard(param1:Boolean) : void {
         this._useKeyboard = param1;
      }
      
      public function get useKeyboard() : Boolean {
         return this._useKeyboard;
      }
      
      public function set closeOnClick(param1:Boolean) : void {
         this._closeOnClick = param1;
      }
      
      public function get closeOnClick() : Boolean {
         return this._closeOnClick;
      }
      
      public function set selectedItem(param1:Object) : void {
         this._list.selectedItem = param1;
      }
      
      public function get selectedItem() : Object {
         return this._list.selectedItem;
      }
      
      public function get selectedIndex() : uint {
         return this._list.selectedIndex;
      }
      
      public function set selectedIndex(param1:uint) : void {
         this._list.selectedIndex = param1;
      }
      
      public function get container() : * {
         if(!this._mainContainer)
         {
            return null;
         }
         if(this._mainContainer is UiRootContainer)
         {
            return SecureCenter.secure(this._mainContainer as UiRootContainer,getUi().uiModule.trusted);
         }
         return SecureCenter.secure(this._mainContainer,getUi().uiModule.trusted);
      }
      
      public function set dataNameField(param1:String) : void {
         this._dataNameField = param1;
      }
      
      public function renderModificator(param1:Array, param2:Object) : Array {
         if(param2 != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            this.listSizeOffset = height;
            this._list.rendererName = this._list.rendererName?this._list.rendererName:"LabelGridRenderer";
            this._list.rendererArgs = this._list.rendererArgs?this._list.rendererArgs:",0xFFFFFF,0xEEEEFF,0xC0E272,0x99D321";
            this._list.width = width - this.listSizeOffset;
            this._list.slotWidth = this.slotWidth?this.slotWidth:this._list.width;
            this._list.slotHeight = this.slotHeight?this.slotHeight:height - 4;
            InternalComponentAccess.setProperty(this._list,"_uiRootContainer",InternalComponentAccess.getProperty(this,"_uiRootContainer"));
            return this._list.renderModificator(param1,param2);
         }
      }
      
      public function finalize() : void {
         this._button.width = width;
         this._button.height = height;
         this._bgTexture.width = width;
         this._bgTexture.height = height;
         this._bgTexture.autoGrid = true;
         this._bgTexture.finalize();
         this._button.addChild(this._bgTexture);
         getUi().registerId(this._bgTexture.name,new GraphicElement(this._bgTexture,new Array(),this._bgTexture.name));
         var _loc1_:Array = new Array();
         _loc1_[StatesEnum.STATE_OVER] = new Array();
         _loc1_[StatesEnum.STATE_OVER][this._bgTexture.name] = new Array();
         _loc1_[StatesEnum.STATE_OVER][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         _loc1_[StatesEnum.STATE_CLICKED] = new Array();
         _loc1_[StatesEnum.STATE_CLICKED][this._bgTexture.name] = new Array();
         _loc1_[StatesEnum.STATE_CLICKED][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         this._button.changingStateData = _loc1_;
         this._button.finalize();
         this._list.name = "grid_" + name;
         this._list.width = width - this.listSizeOffset;
         this._list.slotWidth = this.slotWidth?this.slotWidth:this._list.width;
         this._list.slotHeight = this.slotHeight?this.slotHeight:height - 4;
         this._list.x = 2;
         this._list.y = height + 2;
         this._list.finalize();
         this._listTexture.width = this._list.width + 4;
         this._listTexture.autoGrid = true;
         this._listTexture.y = height-1;
         this._listTexture.x = 2;
         this._listTexture.finalize();
         addChild(this._button);
         addChild(this._listTexture);
         addChild(this._list);
         this._listTexture.mouseEnabled = false;
         this._list.mouseEnabled = false;
         this._mainContainer = this._list.renderer.render(null,0,false);
         this._mainContainer.height = this._list.slotHeight;
         this._mainContainer.x = this._list.x;
         if(this.autoCenter)
         {
            this._mainContainer.y = (height - this._mainContainer.height) / 2;
         }
         this._button.addChild(this._mainContainer);
         this._finalized = true;
         this._searchString = "";
         getUi().iAmFinalized(this);
      }
      
      override public function process(param1:Message) : Boolean {
         var _loc2_:InteractiveObject = null;
         var _loc3_:uint = 0;
         switch(true)
         {
            case param1 is MouseReleaseOutsideMessage:
               this.showList(false);
               this._searchString = "";
               break;
            case param1 is SelectItemMessage:
               this._list.renderer.update(this._list.selectedItem,0,this._mainContainer,false);
               switch(SelectItemMessage(param1).selectMethod)
               {
                  case SelectMethodEnum.UP_ARROW:
                  case SelectMethodEnum.DOWN_ARROW:
                  case SelectMethodEnum.RIGHT_ARROW:
                  case SelectMethodEnum.LEFT_ARROW:
                  case SelectMethodEnum.SEARCH:
                  case SelectMethodEnum.AUTO:
                  case SelectMethodEnum.MANUAL:
                     break;
                  default:
                     this.showList(false);
               }
               break;
            case param1 is MouseDownMessage:
               if(!this._list.visible)
               {
                  if((this._list.dataProvider) && (this._list.dataProvider.length > 0) || MouseDownMessage(param1).target == this._button)
                  {
                     this.showList(true);
                     this._list.moveTo(this._list.selectedIndex);
                  }
               }
               else
               {
                  if(MouseDownMessage(param1).target == this._button)
                  {
                     this.showList(false);
                  }
               }
               this._searchString = "";
               break;
            case param1 is MouseWheelMessage:
               if(this._list.visible)
               {
                  this._list.process(param1);
               }
               else
               {
                  this._list.setSelectedIndex(this._list.selectedIndex + MouseWheelMessage(param1).mouseEvent.delta / Math.abs(MouseWheelMessage(param1).mouseEvent.delta) * -1,SelectMethodEnum.WHEEL);
               }
               return true;
            case param1 is KeyboardKeyUpMessage:
               _loc2_ = FocusHandler.getInstance().getFocus();
               if(!(_loc2_ is Input))
               {
                  _loc3_ = KeyboardMessage(param1).keyboardEvent.keyCode;
                  if(!(_loc3_ == Keyboard.DOWN) && !(_loc3_ == Keyboard.UP) && !(_loc3_ == Keyboard.LEFT) && !(_loc3_ == Keyboard.RIGHT) && !(_loc3_ == Keyboard.ENTER))
                  {
                     if(this._searchStopped)
                     {
                        this._searchStopped = false;
                        if(this._searchString.length == 1 && String.fromCharCode(KeyboardMessage(param1).keyboardEvent.charCode) == this._searchString)
                        {
                           this.searchStringInCB(this._searchString,this._lastSearchIndex + 1);
                           return true;
                        }
                        this._searchString = "";
                     }
                     this._searchString = this._searchString + String.fromCharCode(KeyboardMessage(param1).keyboardEvent.charCode);
                     this.searchStringInCB(this._searchString);
                     return true;
                  }
               }
               if(KeyboardMessage(param1).keyboardEvent.keyCode == Keyboard.ENTER && (this._list.visible))
               {
                  if(this._useKeyboard)
                  {
                     this.showList(false);
                     return true;
                  }
               }
               break;
            case param1 is KeyboardMessage:
               if(this._useKeyboard)
               {
                  this._list.process(param1);
               }
               break;
         }
         return false;
      }
      
      override public function remove() : void {
         if(!__removed)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onClick);
            this._listTexture.remove();
            this._list.remove();
            this._button.remove();
            this._list.renderer.remove(this._mainContainer);
            SecureCenter.destroy(this._mainContainer);
            SecureCenter.destroy(this._list);
            this._bgTexture.remove();
            this._bgTexture = null;
            this._list = null;
            this._button = null;
            this._mainContainer = null;
            this._listTexture = null;
         }
         super.remove();
      }
      
      protected function showList(param1:Boolean) : void {
         var _loc2_:IInterfaceListener = null;
         var _loc3_:IInterfaceListener = null;
         if(this._previousState != param1)
         {
            if(param1)
            {
               for each (_loc2_ in Berilia.getInstance().UISoundListeners)
               {
                  _loc2_.playUISound("16012");
               }
            }
            else
            {
               for each (_loc3_ in Berilia.getInstance().UISoundListeners)
               {
                  _loc3_.playUISound("16013");
               }
            }
         }
         this._listTexture.visible = param1;
         this._list.visible = param1;
         this._previousState = param1;
      }
      
      protected function searchStringInCB(param1:String, param2:int=0) : void {
         var _loc4_:* = 0;
         this._searchTimer.reset();
         this._searchTimer.start();
         var _loc3_:RegExp = new RegExp(param1 + "?","gi");
         var _loc5_:* = -1;
         var _loc6_:* = "";
         _loc4_ = param2;
         while(_loc4_ < this.dataProvider.length)
         {
            if(this._dataNameField == "" || this.dataProvider[_loc4_] is String)
            {
               _loc6_ = this.cleanString(this.dataProvider[_loc4_].toLowerCase());
            }
            else
            {
               _loc6_ = this.cleanString(this.dataProvider[_loc4_][this._dataNameField].toLowerCase());
            }
            _loc5_ = _loc6_.indexOf(this.cleanString(param1));
            if(_loc5_ != -1)
            {
               this._list.setSelectedIndex(_loc4_,SelectMethodEnum.SEARCH);
               this._lastSearchIndex = _loc4_;
               break;
            }
            _loc4_++;
         }
      }
      
      protected function cleanString(param1:String) : String {
         var _loc2_:RegExp = new RegExp("\\s","g");
         var _loc3_:* = " ";
         var _loc4_:RegExp = new RegExp(_loc2_);
         var _loc5_:String = param1.replace(_loc4_,"");
         _loc5_ = _loc5_.replace(_loc3_,"");
         return StringUtils.noAccent(_loc5_);
      }
      
      private function onClick(param1:MouseEvent) : void {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         while(_loc2_.parent)
         {
            if(_loc2_ == this)
            {
               return;
            }
            _loc2_ = _loc2_.parent;
         }
         this.showList(false);
      }
      
      private function onAddedToStage(param1:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onSearchTimerComplete(param1:TimerEvent) : void {
         this._searchStopped = true;
      }
   }
}
