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
      
      public static var MEMORY_LOG:Dictionary;
      
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
      
      public function set buttonTexture(uri:Uri) : void {
         this._bgTexture.uri = uri;
      }
      
      public function get buttonTexture() : Uri {
         return this._bgTexture.uri;
      }
      
      public function set listTexture(uri:Uri) : void {
         this._listTexture.uri = uri;
      }
      
      public function get listTexture() : Uri {
         return this._listTexture.uri;
      }
      
      public function get maxHeight() : uint {
         return this._maxListSize;
      }
      
      public function set maxHeight(v:uint) : void {
         this._maxListSize = v;
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
      
      public function set dataProvider(data:*) : void {
         var nbSlot:uint = this._maxListSize / this._list.slotHeight;
         if(data)
         {
            if(data.length > nbSlot)
            {
               this._list.width = width - 6;
               this._list.height = this._maxListSize;
               this._list.slotWidth = this.slotWidth?this.slotWidth:this._list.width - 16;
            }
            else
            {
               this._list.width = width - this.listSizeOffset;
               this._list.height = this._list.slotHeight * data.length;
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
         this._list.dataProvider = data;
      }
      
      public function get dataProvider() : * {
         return this._list.dataProvider;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(b:Boolean) : void {
         this._finalized = b;
      }
      
      public function set scrollBarCss(uri:Uri) : void {
         this._list.verticalScrollbarCss = uri;
      }
      
      public function get scrollBarCss() : Uri {
         return this._list.verticalScrollbarCss;
      }
      
      public function set rendererName(name:String) : void {
         this._list.rendererName = name;
      }
      
      public function get rendererName() : String {
         return this._list.rendererName;
      }
      
      public function set rendererArgs(args:String) : void {
         this._list.rendererArgs = args;
      }
      
      public function get rendererArgs() : String {
         return this._list.rendererArgs;
      }
      
      public function get value() : * {
         return this._list.selectedItem;
      }
      
      public function set value(o:*) : void {
         this._list.selectedItem = o;
      }
      
      public function set autoSelect(b:Boolean) : void {
         this._list.autoSelect = b;
      }
      
      public function get autoSelect() : Boolean {
         return this._list.autoSelect;
      }
      
      public function set autoSelectMode(n:int) : void {
         this._list.autoSelectMode = n;
      }
      
      public function get autoSelectMode() : int {
         return this._list.autoSelectMode;
      }
      
      public function set useKeyboard(b:Boolean) : void {
         this._useKeyboard = b;
      }
      
      public function get useKeyboard() : Boolean {
         return this._useKeyboard;
      }
      
      public function set closeOnClick(b:Boolean) : void {
         this._closeOnClick = b;
      }
      
      public function get closeOnClick() : Boolean {
         return this._closeOnClick;
      }
      
      public function set selectedItem(v:Object) : void {
         this._list.selectedItem = v;
      }
      
      public function get selectedItem() : Object {
         return this._list.selectedItem;
      }
      
      public function get selectedIndex() : uint {
         return this._list.selectedIndex;
      }
      
      public function set selectedIndex(v:uint) : void {
         this._list.selectedIndex = v;
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
      
      public function set dataNameField(value:String) : void {
         this._dataNameField = value;
      }
      
      public function renderModificator(childs:Array, accessKey:Object) : Array {
         if(accessKey != SecureCenter.ACCESS_KEY)
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
            return this._list.renderModificator(childs,accessKey);
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
         var stateChangingProperties:Array = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][this._bgTexture.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_CLICKED] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][this._bgTexture.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][this._bgTexture.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         this._button.changingStateData = stateChangingProperties;
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
         this._listTexture.y = height - 1;
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
      
      override public function process(msg:Message) : Boolean {
         var focusedObject:InteractiveObject = null;
         var keyCode:uint = 0;
         switch(true)
         {
            case msg is MouseReleaseOutsideMessage:
               this.showList(false);
               this._searchString = "";
               break;
            case msg is SelectItemMessage:
               this._list.renderer.update(this._list.selectedItem,0,this._mainContainer,false);
               switch(SelectItemMessage(msg).selectMethod)
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
            case msg is MouseDownMessage:
               if(!this._list.visible)
               {
                  if((this._list.dataProvider) && (this._list.dataProvider.length > 0) || (MouseDownMessage(msg).target == this._button))
                  {
                     this.showList(true);
                     this._list.moveTo(this._list.selectedIndex);
                  }
               }
               else if(MouseDownMessage(msg).target == this._button)
               {
                  this.showList(false);
               }
               
               this._searchString = "";
               break;
            case msg is MouseWheelMessage:
               if(this._list.visible)
               {
                  this._list.process(msg);
               }
               else
               {
                  this._list.setSelectedIndex(this._list.selectedIndex + MouseWheelMessage(msg).mouseEvent.delta / Math.abs(MouseWheelMessage(msg).mouseEvent.delta) * -1,SelectMethodEnum.WHEEL);
               }
               return true;
            case msg is KeyboardKeyUpMessage:
               focusedObject = FocusHandler.getInstance().getFocus();
               if(!(focusedObject is Input))
               {
                  keyCode = KeyboardMessage(msg).keyboardEvent.keyCode;
                  if((!(keyCode == Keyboard.DOWN)) && (!(keyCode == Keyboard.UP)) && (!(keyCode == Keyboard.LEFT)) && (!(keyCode == Keyboard.RIGHT)) && (!(keyCode == Keyboard.ENTER)))
                  {
                     if(this._searchStopped)
                     {
                        this._searchStopped = false;
                        if((this._searchString.length == 1) && (String.fromCharCode(KeyboardMessage(msg).keyboardEvent.charCode) == this._searchString))
                        {
                           this.searchStringInCB(this._searchString,this._lastSearchIndex + 1);
                           return true;
                        }
                        this._searchString = "";
                     }
                     this._searchString = this._searchString + String.fromCharCode(KeyboardMessage(msg).keyboardEvent.charCode);
                     this.searchStringInCB(this._searchString);
                     return true;
                  }
               }
               if((KeyboardMessage(msg).keyboardEvent.keyCode == Keyboard.ENTER) && (this._list.visible))
               {
                  if(this._useKeyboard)
                  {
                     this.showList(false);
                     return true;
                  }
               }
               break;
            case msg is KeyboardMessage:
               if(this._useKeyboard)
               {
                  this._list.process(msg);
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
      
      protected function showList(show:Boolean) : void {
         var listener:IInterfaceListener = null;
         var listener2:IInterfaceListener = null;
         if(this._previousState != show)
         {
            if(show)
            {
               for each(listener in Berilia.getInstance().UISoundListeners)
               {
                  listener.playUISound("16012");
               }
            }
            else
            {
               for each(listener2 in Berilia.getInstance().UISoundListeners)
               {
                  listener2.playUISound("16013");
               }
            }
         }
         this._listTexture.visible = show;
         this._list.visible = show;
         this._previousState = show;
      }
      
      protected function searchStringInCB(searchPhrase:String, startIndex:int = 0) : void {
         var i:* = 0;
         this._searchTimer.reset();
         this._searchTimer.start();
         var comparRegexp:RegExp = new RegExp(searchPhrase + "?","gi");
         var indexOfString:int = -1;
         var compareString:String = "";
         i = startIndex;
         while(i < this.dataProvider.length)
         {
            if((this._dataNameField == "") || (this.dataProvider[i] is String))
            {
               compareString = this.cleanString(this.dataProvider[i].toLowerCase());
            }
            else
            {
               compareString = this.cleanString(this.dataProvider[i][this._dataNameField].toLowerCase());
            }
            indexOfString = compareString.indexOf(this.cleanString(searchPhrase));
            if(indexOfString != -1)
            {
               this._list.setSelectedIndex(i,SelectMethodEnum.SEARCH);
               this._lastSearchIndex = i;
               break;
            }
            i++;
         }
      }
      
      protected function cleanString(spaced:String) : String {
         var regSpace:RegExp = new RegExp("\\s","g");
         var numberSeparator:String = " ";
         var pattern1:RegExp = new RegExp(regSpace);
         var tempString:String = spaced.replace(pattern1,"");
         tempString = tempString.replace(numberSeparator,"");
         return StringUtils.noAccent(tempString);
      }
      
      private function onClick(e:MouseEvent) : void {
         var p:DisplayObject = DisplayObject(e.target);
         while(p.parent)
         {
            if(p == this)
            {
               return;
            }
            p = p.parent;
         }
         this.showList(false);
      }
      
      private function onAddedToStage(e:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onSearchTimerComplete(e:TimerEvent) : void {
         this._searchStopped = true;
      }
   }
}
