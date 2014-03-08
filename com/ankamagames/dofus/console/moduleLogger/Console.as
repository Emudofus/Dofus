package com.ankamagames.dofus.console.moduleLogger
{
   import flash.text.StyleSheet;
   import flash.display.NativeWindow;
   import __AS3__.vec.Vector;
   import flash.display.Sprite;
   import flash.text.TextField;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.events.NativeWindowDisplayStateEvent;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.dofus.Constants;
   import flash.display.NativeWindowInitOptions;
   import flash.events.NativeWindowBoundsEvent;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   
   public final class Console extends Object
   {
      
      {
         CONSOLE_STYLE.setStyle(".yellow",{"color":"#ADAE30"});
         CONSOLE_STYLE.setStyle(".orange",{"color":"#EDC597"});
         CONSOLE_STYLE.setStyle(".red",{"color":"#DD5555"});
         CONSOLE_STYLE.setStyle(".red+",{"color":"#FF0000"});
         CONSOLE_STYLE.setStyle(".gray",{"color":"#666688"});
         CONSOLE_STYLE.setStyle(".gray+",{"color":"#8888AA"});
         CONSOLE_STYLE.setStyle(".pink",{"color":"#DD55DD"});
         CONSOLE_STYLE.setStyle(".green",{"color":"#00BBBB"});
         CONSOLE_STYLE.setStyle(".blue",{"color":"#97A2ED"});
         CONSOLE_STYLE.setStyle(".white",{"color":"#C2C2DA"});
         CONSOLE_STYLE.setStyle("a:hover",{"color":"#EDC597"});
      }
      
      public function Console() {
         this._lines = new Vector.<String>();
         this._allInfo = new Vector.<TypeMessage>();
         this.regExp = new RegExp("<[^>]*>","g");
         this.regExp2 = new RegExp("•","g");
         super();
         if(_self)
         {
            throw new Error();
         }
         else
         {
            ModuleLogger.init(this.log);
            return;
         }
      }
      
      private static const OPTIONS_HEIGHT:uint = 30;
      
      private static const OPTIONS_BACKGROUND_COLOR:uint = 4473941;
      
      private static const ICON_SIZE:int = 24;
      
      private static const ICON_INTERVAL:int = 15;
      
      private static const SCROLLBAR_SIZE:uint = 10;
      
      private static const FILTER_UI_COLOR:uint = 4473941;
      
      private static const BACKGROUND_COLOR:uint = 2236962;
      
      private static const OUTPUT_COLOR:uint = 6710920;
      
      private static const SCROLL_BG_COLOR:uint = 4473941;
      
      private static const SCROLL_COLOR:uint = 6710920;
      
      public static const CONSOLE_STYLE:StyleSheet = new StyleSheet();
      
      public static var showActionLog:Boolean = true;
      
      private static var _self:Console;
      
      private static var _displayed:Boolean = false;
      
      public static function getInstance() : Console {
         if(!_self)
         {
            _self = new Console();
         }
         return _self;
      }
      
      public static function isVisible() : Boolean {
         return _displayed;
      }
      
      private var _window:NativeWindow;
      
      private var _filterUI:FilterUI;
      
      private var _lines:Vector.<String>;
      
      private var _allInfo:Vector.<TypeMessage>;
      
      private var _active:Boolean = false;
      
      private var _iconList:Sprite;
      
      private var _textField:TextField;
      
      private var _scrollBar:TextFieldScrollBar;
      
      private var _scrollBarH:TextFieldOldScrollBarH;
      
      private var _backGround:Sprite;
      
      private var _filterButton:Array;
      
      private var _showHook:Boolean = true;
      
      private var _showUI:Boolean = true;
      
      private var _showAction:Boolean = true;
      
      private var _showShortcut:Boolean = true;
      
      private function output(param1:TypeMessage) : void {
         var _loc2_:* = 0;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(this._active)
         {
            this._allInfo.push(param1);
            if(!_displayed)
            {
               return;
            }
            if((this._filterUI) && (this._filterUI.isOn) && (this._filterUI.isFiltered(param1.name)))
            {
               return;
            }
            _loc2_ = param1.type;
            if(_loc2_ == TypeMessage.TYPE_HOOK && !this._showHook)
            {
               return;
            }
            if(_loc2_ == TypeMessage.TYPE_UI && !this._showUI)
            {
               return;
            }
            if(_loc2_ == TypeMessage.TYPE_ACTION && !this._showAction)
            {
               return;
            }
            if(_loc2_ == TypeMessage.TYPE_SHORTCUT && !this._showShortcut)
            {
               return;
            }
            _loc3_ = param1.textInfo;
            _loc4_ = _loc3_.split("\n");
            this._lines.push.apply(this._lines,_loc4_);
            this._scrollBar.updateScrolling();
            this._scrollBarH.resize();
         }
      }
      
      public function close() : void {
         _displayed = false;
         if(this._window)
         {
            this._window.close();
            this._window = null;
         }
         this.saveData();
      }
      
      public function disableLogEvent() : void {
         var _loc1_:ConsoleIcon = null;
         this._showHook = false;
         this._showUI = false;
         this._showAction = false;
         this._showShortcut = false;
         for each (_loc1_ in this._filterButton)
         {
            _loc1_.disable(true);
         }
         this.onFilterChange();
      }
      
      public function display(param1:Boolean=false) : void {
         ModuleLogger.active = true;
         this._active = true;
         if(param1)
         {
            return;
         }
         if(!this._window)
         {
            this.createWindow();
         }
         _displayed = true;
         this._window.activate();
      }
      
      public function toggleDisplay() : void {
         if(_displayed)
         {
            this.close();
         }
         else
         {
            this.display();
         }
      }
      
      private function log(... rest) : void {
         var _loc2_:TypeMessage = null;
         if((this._active) && (rest.length))
         {
            _loc2_ = CallWithParameters.callConstructor(TypeMessage,rest);
            this.output(_loc2_);
         }
      }
      
      private function clearConsole(param1:Event=null) : void {
         this._lines.splice(0,this._lines.length);
         this._allInfo.splice(0,this._allInfo.length);
         this._scrollBar.updateScrolling();
         this._scrollBarH.resize();
         this._textField.text = "";
      }
      
      private function createUI() : void {
         var _loc9_:ConsoleIcon = null;
         this._backGround = new Sprite();
         this._textField = new TextField();
         this._textField.addEventListener(TextEvent.LINK,this.onTextClick);
         this._textField.multiline = true;
         this._textField.wordWrap = false;
         this._textField.mouseWheelEnabled = false;
         this._scrollBar = new TextFieldScrollBar(this._textField,this._lines,10,SCROLL_BG_COLOR,SCROLL_COLOR);
         this._scrollBarH = new TextFieldOldScrollBarH(this._textField,5,SCROLL_BG_COLOR,SCROLL_COLOR);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Courier New";
         _loc1_.size = 16;
         _loc1_.color = OUTPUT_COLOR;
         this._textField.defaultTextFormat = _loc1_;
         this._textField.styleSheet = CONSOLE_STYLE;
         var _loc2_:* = 0;
         this._iconList = new Sprite();
         var _loc3_:ConsoleIcon = new ConsoleIcon("cancel",ICON_SIZE);
         _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,this.clearConsole);
         this._iconList.addChild(_loc3_);
         _loc2_ = _loc2_ + (ICON_SIZE + ICON_INTERVAL);
         var _loc4_:ConsoleIcon = new ConsoleIcon("disk",ICON_SIZE);
         _loc4_.addEventListener(MouseEvent.MOUSE_DOWN,this.saveText);
         _loc4_.x = _loc2_;
         this._iconList.addChild(_loc4_);
         _loc2_ = _loc2_ + (ICON_SIZE + ICON_INTERVAL);
         var _loc5_:ConsoleIcon = new ConsoleIcon("list",ICON_SIZE);
         _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.onIconFilterMouseDown);
         _loc5_.x = _loc2_;
         this._iconList.addChild(_loc5_);
         this._filterButton = new Array();
         var _loc6_:Array = new Array(new ColorTransform(0.9,1,1.1),new ColorTransform(0.9,1.2,0.8),new ColorTransform(1.3,0.7,0.8),new ColorTransform(1.3,1.3,0.5));
         var _loc7_:* = 0;
         while(_loc7_ < _loc6_.length)
         {
            _loc9_ = new ConsoleIcon("book",ICON_SIZE);
            this._filterButton[_loc7_] = _loc9_;
            _loc9_.changeColor(_loc6_[_loc7_]);
            this._iconList.addChild(_loc9_);
            _loc9_.name = "_" + _loc7_;
            _loc9_.addEventListener(MouseEvent.MOUSE_DOWN,this.onBookClick);
            _loc7_++;
         }
         this._filterUI = new FilterUI(FILTER_UI_COLOR);
         this._filterUI.addEventListener(Event.CHANGE,this.onFilterChange);
         this._window.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onResize);
         this._window.stage.addChild(this._backGround);
         this._window.stage.addChild(this._textField);
         this._window.stage.addChild(this._scrollBar);
         this._window.stage.addChild(this._scrollBarH);
         this._window.stage.addChild(this._iconList);
         var _loc8_:Object = StoreDataManager.getInstance().getData(Constants.DATASTORE_MODULE_DEBUG,"console_pref");
         this.loadData(_loc8_);
         this.onResize();
      }
      
      private function openFilterUI(param1:Boolean) : void {
         if(param1)
         {
            this._window.stage.addChild(this._filterUI);
            this.onResize();
         }
         else
         {
            if(this._filterUI.parent)
            {
               this._filterUI.parent.removeChild(this._filterUI);
            }
         }
      }
      
      private function createWindow() : void {
         var _loc1_:NativeWindowInitOptions = null;
         if(!this._window)
         {
            _loc1_ = new NativeWindowInitOptions();
            _loc1_.resizable = true;
            this._window = new NativeWindow(_loc1_);
            this._window.width = 800;
            this._window.height = 600;
            this._window.title = "Module Console";
            this._window.addEventListener(Event.CLOSE,this.onClose);
            this._window.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onResize);
            this._window.stage.align = StageAlign.TOP_LEFT;
            this._window.stage.scaleMode = StageScaleMode.NO_SCALE;
            this._window.stage.tabChildren = false;
            this.createUI();
         }
      }
      
      private function saveData() : void {
         var _loc1_:Object = null;
         try
         {
            _loc1_ = new Object();
            if(this._filterUI)
            {
               _loc1_.filter = this._filterUI.getCurrentOptions();
            }
            _loc1_.showHook = this._showHook;
            _loc1_.showUI = this._showUI;
            _loc1_.showAction = this._showAction;
            _loc1_.showShortcut = this._showShortcut;
            StoreDataManager.getInstance().setData(Constants.DATASTORE_MODULE_DEBUG,"console_pref",_loc1_);
         }
         catch(e:Error)
         {
         }
      }
      
      private function loadData(param1:Object) : void {
         if(param1)
         {
            if(param1.filter)
            {
               this._filterUI.setOptions(param1.filter);
               if(param1.filter.isOn)
               {
                  this.openFilterUI(true);
               }
            }
            if((param1.hasOwnProperty("showHook")) && !param1.showHook)
            {
               this._filterButton[0].disable(true);
               this._showHook = false;
            }
            if((param1.hasOwnProperty("showUI")) && !param1.showUI)
            {
               this._filterButton[1].disable(true);
               this._showUI = false;
            }
            if((param1.hasOwnProperty("showAction")) && !param1.showAction)
            {
               this._filterButton[2].disable(true);
               this._showAction = false;
            }
            if((param1.hasOwnProperty("showShortcut")) && !param1.showShortcut)
            {
               this._filterButton[3].disable(true);
               this._showShortcut = false;
            }
            this.onFilterChange();
         }
      }
      
      private function onIconFilterMouseDown(param1:Event) : void {
         if(this._filterUI)
         {
            this.openFilterUI(!this._filterUI.parent);
         }
         else
         {
            this.openFilterUI(true);
         }
      }
      
      private function onFilterChange(param1:Event=null) : void {
         var _loc5_:TypeMessage = null;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         this._lines.splice(0,this._lines.length);
         var _loc2_:Boolean = (this._filterUI) && (this._filterUI.isOn);
         var _loc3_:int = this._allInfo.length;
         var _loc4_:* = -1;
         while(++_loc4_ < _loc3_)
         {
            _loc5_ = this._allInfo[_loc4_];
            if(!((_loc2_) && (this._filterUI.isFiltered(_loc5_.name))))
            {
               _loc6_ = _loc5_.type;
               if(!(_loc6_ == TypeMessage.TYPE_HOOK && !this._showHook))
               {
                  if(!(_loc6_ == TypeMessage.TYPE_UI && !this._showUI))
                  {
                     if(!(_loc6_ == TypeMessage.TYPE_ACTION && !this._showAction))
                     {
                        if(!(_loc6_ == TypeMessage.TYPE_SHORTCUT && !this._showShortcut))
                        {
                           _loc7_ = _loc5_.textInfo;
                           _loc8_ = _loc7_.split("\n");
                           this._lines.push.apply(this._lines,_loc8_);
                        }
                     }
                  }
               }
            }
         }
         this._scrollBar.scrollText(-1);
         this._scrollBarH.resize();
         this.onResize();
      }
      
      private function onResize(param1:Event=null) : void {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         this._backGround.graphics.clear();
         this._backGround.graphics.beginFill(BACKGROUND_COLOR);
         this._backGround.graphics.drawRect(0,0,this._window.stage.stageWidth,this._window.stage.stageHeight);
         this._backGround.graphics.endFill();
         this._backGround.graphics.beginFill(OPTIONS_BACKGROUND_COLOR);
         this._backGround.graphics.drawRect(0,0,this._window.stage.stageWidth,OPTIONS_HEIGHT);
         this._backGround.graphics.endFill();
         if(this._iconList)
         {
            this._iconList.x = 10;
            this._iconList.y = 3;
         }
         if(this._filterButton)
         {
            _loc5_ = this._window.stage.stageWidth - ICON_SIZE - 20;
            _loc6_ = this._filterButton.length-1;
            while(_loc6_ >= 0)
            {
               this._filterButton[_loc6_].x = _loc5_;
               _loc5_ = _loc5_ - (ICON_SIZE + 5);
               _loc6_--;
            }
         }
         if(this._filterUI)
         {
            this._filterUI.x = this._window.stage.stageWidth - this._filterUI.width - 20;
            this._filterUI.y = OPTIONS_HEIGHT + 10;
         }
         this._textField.y = OPTIONS_HEIGHT;
         this._textField.width = this._window.stage.stageWidth - TextFieldScrollBar.WIDTH;
         this._textField.height = this._window.stage.stageHeight - this._textField.y - SCROLLBAR_SIZE;
         this._textField.scrollV = 0;
         var _loc2_:* = "";
         var _loc3_:* = 0;
         while(_loc3_ < 200)
         {
            _loc2_ = _loc2_ + "o\n";
            _loc3_++;
         }
         this._textField.text = _loc2_;
         var _loc4_:int = this._textField.numLines - this._textField.maxScrollV;
         this._textField.text = "";
         this._scrollBar.addEventListener(Event.CHANGE,this.onScrollVChange);
         this._scrollBar.scrollAtEnd();
         this._scrollBar.resize(_loc4_);
         this._scrollBarH.resize();
      }
      
      private function onTextClick(param1:TextEvent) : void {
         var _loc2_:String = param1.text;
         if(_loc2_.charAt(0) == "@")
         {
            this._filterUI.addToFilter(_loc2_.substr(1));
         }
      }
      
      private function onBookClick(param1:MouseEvent) : void {
         var _loc2_:ConsoleIcon = param1.currentTarget as ConsoleIcon;
         var _loc3_:int = int(_loc2_.name.substr(1));
         if(_loc3_ == TypeMessage.TYPE_HOOK)
         {
            this._showHook = !this._showHook;
            _loc2_.disable(!this._showHook);
         }
         else
         {
            if(_loc3_ == TypeMessage.TYPE_UI)
            {
               this._showUI = !this._showUI;
               _loc2_.disable(!this._showUI);
            }
            else
            {
               if(_loc3_ == TypeMessage.TYPE_ACTION)
               {
                  this._showAction = !this._showAction;
                  _loc2_.disable(!this._showAction);
               }
               else
               {
                  if(_loc3_ == TypeMessage.TYPE_SHORTCUT)
                  {
                     this._showShortcut = !this._showShortcut;
                     _loc2_.disable(!this._showShortcut);
                  }
               }
            }
         }
         this.onFilterChange();
      }
      
      private function saveText(param1:Event) : void {
         var _loc2_:File = new File();
         _loc2_.browseForSave("Save");
         _loc2_.addEventListener(Event.SELECT,this.onFileSelect);
      }
      
      private function onClose(param1:Event) : void {
         _displayed = false;
         this._window = null;
         this.saveData();
      }
      
      private var regExp:RegExp;
      
      private var regExp2:RegExp;
      
      private function onFileSelect(param1:Event) : void {
         var fileStream:FileStream = null;
         var text:String = null;
         var e:Event = param1;
         try
         {
            text = this._lines.join(File.lineEnding);
            text = text.replace(this.regExp,"");
            text = text.replace(this.regExp2," ");
            fileStream = new FileStream();
            fileStream.open(e.target as File,FileMode.WRITE);
            fileStream.writeUTFBytes(text);
            fileStream.close();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onScrollVChange(param1:Event) : void {
         this._scrollBarH.resize();
      }
   }
}
