package com.ankamagames.dofus.console.moduleLogger
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.text.StyleSheet;
   import flash.display.NativeMenu;
   import flash.display.NativeWindow;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.events.Event;
   import com.ankamagames.jerakine.managers.OptionManager;
   import flash.events.MouseEvent;
   import flash.events.NativeWindowDisplayStateEvent;
   import flash.events.TextEvent;
   import flash.text.TextFormat;
   import flash.geom.ColorTransform;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.datacenter.communication.ChatChannel;
   import flash.display.NativeMenuItem;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.display.NativeWindowInitOptions;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import flash.events.NativeWindowBoundsEvent;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.filesystem.File;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.jerakine.data.I18n;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   
   public final class Console extends Object
   {
      
      public function Console()
      {
         this._lines = new Vector.<String>();
         this._allInfo = new Vector.<TypeMessage>();
         this._updateWordWrapTimer = new Timer(50);
         this._wordWrapLinesCache = new Dictionary(true);
         this.regExp = new RegExp("<[^>]*>","g");
         this.regExp2 = new RegExp("•","g");
         super();
         if(_self)
         {
            throw new Error();
         }
         else
         {
            ModuleLogger.addCallback(this.log);
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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Console));
      
      private static const ALL_HTML_TAGS:RegExp = new RegExp("<\\/?\\w+((\\s+\\w+(\\s*=\\s*(?:\".*?\"|\'.*?\'|[^\'\">\\s]+))?)+\\s*|\\s*)\\/?>","g");
      
      public static var showActionLog:Boolean = true;
      
      public static var logChatMessagesOnly:Boolean;
      
      private static var _self:Console;
      
      private static var _displayed:Boolean = false;
      
      public static function getInstance() : Console
      {
         if(!_self)
         {
            _self = new Console();
         }
         return _self;
      }
      
      public static function isVisible() : Boolean
      {
         return _displayed;
      }
      
      private var _consoleStyle:StyleSheet;
      
      private var _bgColor:uint;
      
      private var _chatChannelsMenu:NativeMenu;
      
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
      
      private var _posX:int;
      
      private var _chatMode:Boolean;
      
      private var _updateWordWrapTimer:Timer;
      
      private var _wordWrapLinesCache:Dictionary;
      
      public function get consoleStyle() : StyleSheet
      {
         if(!this._consoleStyle)
         {
            this.initConsoleStyle();
         }
         return this._consoleStyle;
      }
      
      public function get chatMode() : Boolean
      {
         return this._chatMode;
      }
      
      public function set chatMode(param1:Boolean) : void
      {
         this._chatMode = param1;
      }
      
      public function get opened() : Boolean
      {
         return !(this._window == null);
      }
      
      private function output(param1:TypeMessage) : void
      {
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
            if((this._chatMode) && !(_loc2_ == TypeMessage.LOG_CHAT))
            {
               return;
            }
            _loc3_ = param1.textInfo;
            _loc4_ = _loc3_.split("\n");
            this._lines.push.apply(this._lines,_loc4_);
            if(this._textField.wordWrap)
            {
               this._updateWordWrapTimer.reset();
               this._updateWordWrapTimer.start();
               return;
            }
            this._scrollBar.updateScrolling();
            this._scrollBarH.resize();
         }
      }
      
      public function close() : void
      {
         _displayed = false;
         if(this._window)
         {
            this._window.close();
            this._window = null;
         }
         this.saveData();
      }
      
      public function disableLogEvent() : void
      {
         var _loc1_:ConsoleIcon = null;
         this._showHook = false;
         this._showUI = false;
         this._showAction = false;
         this._showShortcut = false;
         for each(_loc1_ in this._filterButton)
         {
            _loc1_.disable(true);
         }
         this.onFilterChange();
      }
      
      public function activate() : void
      {
         this._active = ModuleLogger.active = true;
      }
      
      public function display(param1:Boolean = false) : void
      {
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
      
      public function toggleDisplay() : void
      {
         if(_displayed)
         {
            this.close();
         }
         else
         {
            this.display();
         }
      }
      
      private function log(... rest) : void
      {
         var _loc2_:TypeMessage = null;
         if((this._active) && (rest.length))
         {
            _loc2_ = CallWithParameters.callConstructor(TypeMessage,rest);
            if(!logChatMessagesOnly || (logChatMessagesOnly) && _loc2_.type == TypeMessage.LOG_CHAT)
            {
               this.output(_loc2_);
            }
         }
      }
      
      public function clearConsole(param1:Event = null) : void
      {
         var _loc2_:* = undefined;
         if(this._chatMode)
         {
            for(_loc2_ in this._wordWrapLinesCache)
            {
               delete this._wordWrapLinesCache[_loc2_];
               true;
            }
         }
         this._lines.splice(0,this._lines.length);
         this._allInfo.splice(0,this._allInfo.length);
         this._scrollBar.updateScrolling();
         this._scrollBarH.resize();
         this._textField.text = "";
      }
      
      private function initConsoleStyle() : void
      {
         var _loc1_:* = 0;
         this._consoleStyle = new StyleSheet();
         this._consoleStyle.setStyle(".yellow",{"color":"#ADAE30"});
         this._consoleStyle.setStyle(".orange",{"color":"#EDC597"});
         this._consoleStyle.setStyle(".red",{"color":"#DD5555"});
         this._consoleStyle.setStyle(".red+",{"color":"#FF0000"});
         this._consoleStyle.setStyle(".gray",{"color":"#666688"});
         this._consoleStyle.setStyle(".gray+",{"color":"#8888AA"});
         this._consoleStyle.setStyle(".pink",{"color":"#DD55DD"});
         this._consoleStyle.setStyle(".green",{"color":"#00BBBB"});
         this._consoleStyle.setStyle(".blue",{"color":"#97A2ED"});
         this._consoleStyle.setStyle(".white",{"color":"#C2C2DA"});
         this._consoleStyle.setStyle("a:hover",{"color":"#EDC597"});
         this._consoleStyle.setStyle(".p",{"color":"#" + OptionManager.getOptionManager("chat")["alertColor"].toString(16)});
         _loc1_ = 0;
         while(_loc1_ <= 13)
         {
            this._consoleStyle.setStyle(".p" + _loc1_,{"color":"#" + OptionManager.getOptionManager("chat")["channelColor" + _loc1_].toString(16)});
            _loc1_++;
         }
      }
      
      private function createIcons() : void
      {
         this._posX = 0;
         this._iconList = new Sprite();
         var _loc1_:ConsoleIcon = new ConsoleIcon("cancel",ICON_SIZE);
         _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.clearConsole);
         this._iconList.addChild(_loc1_);
         this._posX = this._posX + (ICON_SIZE + ICON_INTERVAL);
         var _loc2_:ConsoleIcon = new ConsoleIcon("disk",ICON_SIZE);
         _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.saveText);
         _loc2_.x = this._posX;
         this._iconList.addChild(_loc2_);
         this._posX = this._posX + (ICON_SIZE + ICON_INTERVAL);
      }
      
      private function initUI() : void
      {
         this._window.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onResize);
         this._window.stage.addChild(this._backGround);
         this._window.stage.addChild(this._textField);
         this._window.stage.addChild(this._scrollBar);
         this._window.stage.addChild(this._scrollBarH);
         this._window.stage.addChild(this._iconList);
         this.onResize();
      }
      
      private function createUI() : void
      {
         var _loc6_:ConsoleIcon = null;
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
         this._textField.styleSheet = this.consoleStyle;
         this.createIcons();
         var _loc2_:ConsoleIcon = new ConsoleIcon("list",ICON_SIZE);
         _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.onIconFilterMouseDown);
         _loc2_.x = this._posX;
         this._iconList.addChild(_loc2_);
         this._filterButton = new Array();
         var _loc3_:Array = new Array(new ColorTransform(0.9,1,1.1),new ColorTransform(0.9,1.2,0.8),new ColorTransform(1.3,0.7,0.8),new ColorTransform(1.3,1.3,0.5));
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc6_ = new ConsoleIcon("book",ICON_SIZE);
            this._filterButton[_loc4_] = _loc6_;
            _loc6_.changeColor(_loc3_[_loc4_]);
            this._iconList.addChild(_loc6_);
            _loc6_.name = "_" + _loc4_;
            _loc6_.addEventListener(MouseEvent.MOUSE_DOWN,this.onBookClick);
            _loc4_++;
         }
         this._filterUI = new FilterUI(FILTER_UI_COLOR);
         this._filterUI.addEventListener(Event.CHANGE,this.onFilterChange);
         this._bgColor = BACKGROUND_COLOR;
         this.initUI();
         var _loc5_:Object = StoreDataManager.getInstance().getData(Constants.DATASTORE_MODULE_DEBUG,"console_pref");
         this.loadData(_loc5_);
      }
      
      private function createChatUI() : void
      {
         this._backGround = new Sprite();
         this._textField = new TextField();
         this._textField.addEventListener(TextEvent.LINK,this.onTextClick);
         this._textField.multiline = true;
         this._textField.wordWrap = true;
         this._textField.mouseWheelEnabled = false;
         this._scrollBar = new TextFieldScrollBar(this._textField,this._lines,10,SCROLL_BG_COLOR,SCROLL_COLOR);
         this._scrollBarH = new TextFieldOldScrollBarH(this._textField,5,SCROLL_BG_COLOR,SCROLL_COLOR);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Tahoma";
         _loc1_.size = 16;
         _loc1_.color = OUTPUT_COLOR;
         this._textField.defaultTextFormat = _loc1_;
         this._textField.styleSheet = this.consoleStyle;
         this.createIcons();
         this._chatChannelsMenu = null;
         var _loc2_:ConsoleIcon = new ConsoleIcon("list",ICON_SIZE);
         _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.openChatChannelsMenu);
         _loc2_.x = this._posX;
         this._iconList.addChild(_loc2_);
         this._bgColor = XmlConfig.getInstance().getEntry("colors.chat.bgColor");
         this._updateWordWrapTimer.addEventListener(TimerEvent.TIMER,this.onUpdateWordWrap);
         this.initUI();
      }
      
      private function openChatChannelsMenu(param1:MouseEvent) : void
      {
         var _loc2_:ChatFrame = null;
         var _loc3_:Array = null;
         var _loc4_:ChatChannel = null;
         var _loc5_:NativeMenuItem = null;
         var _loc6_:Array = null;
         if(!this._chatChannelsMenu)
         {
            this._chatChannelsMenu = new NativeMenu();
            this._chatChannelsMenu.addEventListener(Event.SELECT,this.filterChatChannel);
            _loc2_ = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
            _loc3_ = ChatChannel.getChannels();
            _loc6_ = OptionManager.getOptionManager("chat")["externalChatEnabledChannels"];
            for each(_loc4_ in _loc3_)
            {
               if(_loc2_.disallowedChannels.indexOf(_loc4_.id) == -1)
               {
                  _loc5_ = new NativeMenuItem(_loc4_.name);
                  _loc5_.data = _loc4_;
                  if(_loc6_.indexOf(_loc4_.id) != -1)
                  {
                     _loc5_.checked = true;
                  }
                  _loc5_.addEventListener(Event.SELECT,this.filterChatChannel);
                  this._chatChannelsMenu.addItem(_loc5_);
               }
            }
         }
         this._chatChannelsMenu.display(this._window.stage,this._window.stage.mouseX,this._window.stage.mouseY);
      }
      
      private function filterChatChannel(param1:Event) : void
      {
         var _loc3_:ChatChannel = null;
         var _loc4_:Array = null;
         var _loc2_:NativeMenuItem = param1.currentTarget as NativeMenuItem;
         if(_loc2_)
         {
            _loc3_ = _loc2_.data as ChatChannel;
            _loc2_.checked = !_loc2_.checked;
            _loc4_ = OptionManager.getOptionManager("chat")["externalChatEnabledChannels"];
            if(_loc2_.checked)
            {
               _loc4_.push(_loc3_.id);
            }
            else
            {
               _loc4_.splice(_loc4_.indexOf(_loc3_.id),1);
            }
         }
      }
      
      public function updateEnabledChatChannels() : void
      {
         var _loc2_:NativeMenuItem = null;
         if(!this._chatChannelsMenu)
         {
            return;
         }
         var _loc1_:Array = OptionManager.getOptionManager("chat")["externalChatEnabledChannels"];
         for each(_loc2_ in this._chatChannelsMenu.items)
         {
            if(_loc1_.indexOf(_loc2_.data.id) != -1)
            {
               _loc2_.checked = true;
            }
            else
            {
               _loc2_.checked = false;
            }
         }
      }
      
      private function openFilterUI(param1:Boolean) : void
      {
         if(param1)
         {
            this._window.stage.addChild(this._filterUI);
            this.onResize();
         }
         else if(this._filterUI.parent)
         {
            this._filterUI.parent.removeChild(this._filterUI);
         }
         
      }
      
      private function createWindow() : void
      {
         var _loc1_:NativeWindowInitOptions = null;
         if(!this._window)
         {
            _loc1_ = new NativeWindowInitOptions();
            _loc1_.resizable = true;
            this._window = new NativeWindow(_loc1_);
            this._window.width = !this._chatMode?800:600;
            this._window.height = !this._chatMode?600:400;
            this._window.title = this._chatMode?"Dofus Chat - " + PlayedCharacterManager.getInstance().infos.name:"Module Console";
            this._window.addEventListener(Event.CLOSE,this.onClose);
            this._window.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onResize);
            this._window.stage.align = StageAlign.TOP_LEFT;
            this._window.stage.scaleMode = StageScaleMode.NO_SCALE;
            this._window.stage.tabChildren = false;
            if(this._chatMode)
            {
               if(this._filterUI)
               {
                  this.openFilterUI(false);
               }
               this.createChatUI();
            }
            else
            {
               this.createUI();
            }
         }
      }
      
      private function saveData() : void
      {
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
      
      private function loadData(param1:Object) : void
      {
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
      
      private function onUpdateWordWrap(param1:TimerEvent) : void
      {
         this._updateWordWrapTimer.stop();
         this.updateWordWrapLines();
         this._scrollBar.updateScrolling();
         this._scrollBarH.resize();
      }
      
      private function updateWordWrapLines() : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:String = null;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:Array = null;
         var _loc18_:Array = null;
         var _loc19_:* = 0;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:* = false;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:Array = null;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         this._textField.text = this._lines.join("\n");
         this._scrollBar.textFieldNumLines = this._textField.numLines;
         if(!this._scrollBar.wordWrapLines)
         {
            this._scrollBar.wordWrapLines = new Vector.<String>(0);
         }
         this._scrollBar.wordWrapLines.length = 0;
         var _loc1_:uint = this._lines.length;
         var _loc32_:Dictionary = new Dictionary(true);
         var _loc33_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < this._scrollBar.textFieldNumLines)
         {
            _loc20_ = _loc21_ = this._textField.getLineText(_loc2_).replace("\r","");
            if(this._wordWrapLinesCache[_loc20_])
            {
               this._scrollBar.wordWrapLines.push(this._wordWrapLinesCache[_loc20_]);
            }
            else
            {
               _loc3_ = _loc33_;
               while(_loc3_ < _loc1_)
               {
                  _loc7_ = this._lines[_loc3_];
                  _loc8_ = _loc7_.match(ALL_HTML_TAGS);
                  _loc15_ = _loc8_.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc15_)
                  {
                     if(_loc8_[_loc4_].indexOf("span") == -1)
                     {
                        _loc7_ = _loc7_.replace(_loc8_[_loc4_],"");
                     }
                     _loc4_++;
                  }
                  _loc24_ = _loc7_.indexOf(_loc21_);
                  if(!(_loc24_ == -1) && (_loc3_ > _loc23_ || _loc3_ == _loc23_ && _loc24_ > _loc25_))
                  {
                     _loc9_ = [];
                     for each(_loc10_ in _loc8_)
                     {
                        if(!(_loc10_.indexOf("span") == -1) || !(_loc10_.indexOf("</") == -1))
                        {
                           _loc9_.push(_loc10_);
                        }
                     }
                     for each(_loc10_ in _loc9_)
                     {
                        _loc8_.splice(_loc8_.indexOf(_loc10_),1);
                     }
                     _loc12_ = _loc21_.split(" ");
                     if((_loc12_[0] as String).match(new RegExp("\\[(\\d{2}:?){3}\\]","g")).length > 0)
                     {
                        _loc12_.splice(0,1);
                     }
                     _loc14_ = _loc12_.length;
                     _loc15_ = _loc8_.length;
                     _loc4_ = 0;
                     while(_loc4_ < _loc14_)
                     {
                        _loc13_ = _loc12_[_loc4_];
                        _loc13_ = _loc13_.replace(".","");
                        _loc13_ = _loc13_.replace("(","");
                        _loc13_ = _loc13_.replace(")","");
                        if(_loc13_.length != 0)
                        {
                           if(!_loc32_[_loc3_])
                           {
                              _loc32_[_loc3_] = new Dictionary(true);
                           }
                           if(!_loc32_[_loc3_][_loc13_])
                           {
                              _loc32_[_loc3_][_loc13_] = 1;
                           }
                           else
                           {
                              _loc32_[_loc3_][_loc13_]++;
                           }
                           _loc30_ = _loc32_[_loc3_][_loc13_] - 1;
                           _loc17_ = [];
                           _loc18_ = [];
                           _loc11_ = this._lines[_loc3_];
                           _loc5_ = 0;
                           while(_loc5_ < _loc15_)
                           {
                              if(this.isWithinTag(_loc11_,_loc8_[_loc5_],_loc13_,_loc30_))
                              {
                                 _loc17_.push(_loc8_[_loc5_]);
                              }
                              _loc11_ = _loc11_.replace(_loc8_[_loc5_],"");
                              _loc11_ = _loc11_.replace(this.getCloseTag(_loc8_[_loc5_]),"");
                              _loc5_++;
                           }
                           _loc5_ = _loc17_.length - 1;
                           while(_loc5_ >= 0)
                           {
                              _loc18_.push(this.getCloseTag(_loc17_[_loc5_]));
                              _loc5_--;
                           }
                           _loc27_ = this.getTextWithoutTimeStamp(_loc21_);
                           _loc31_ = this.getWordIndex(_loc27_,_loc13_,_loc30_);
                           if(_loc31_ != -1)
                           {
                              _loc28_ = _loc27_.substr(_loc31_,_loc27_.length - _loc31_).replace(_loc13_,_loc17_.join("") + _loc13_ + _loc18_.join(""));
                              _loc26_ = !(_loc21_ == _loc27_) && !(_loc21_.indexOf("]") == -1)?_loc21_.substr(0,_loc21_.indexOf("]") + 2):"";
                              _loc21_ = _loc26_ + _loc27_.substr(0,_loc31_) + _loc28_;
                           }
                        }
                        _loc4_++;
                     }
                     _loc25_ = _loc24_;
                     _loc19_ = _loc7_.indexOf("<span");
                     if(_loc19_ != -1)
                     {
                        if((_loc22_) && _loc2_ > 0)
                        {
                           this._scrollBar.wordWrapLines[_loc2_ - 1] = this._scrollBar.wordWrapLines[_loc2_ - 1] + "</span>";
                        }
                        _loc21_ = _loc7_.substring(_loc19_,_loc7_.indexOf(">") + 1) + _loc21_;
                        _loc22_ = true;
                     }
                     if(_loc3_ > _loc23_)
                     {
                        _loc23_ = _loc3_;
                     }
                     _loc33_ = _loc3_;
                     break;
                  }
                  _loc25_ = -1;
                  _loc3_++;
               }
               if(_loc2_ == this._scrollBar.textFieldNumLines - 1)
               {
                  _loc21_ = _loc21_ + "</span>";
               }
               this._scrollBar.wordWrapLines.push(_loc21_);
               this._wordWrapLinesCache[_loc20_] = _loc21_;
            }
            _loc2_++;
         }
      }
      
      private function getCloseTag(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:* = !(param1.indexOf(" ") == -1);
         if(!_loc3_)
         {
            _loc2_ = "</" + param1.substring(param1.indexOf("<") + 1,param1.indexOf(">") + 1);
         }
         else
         {
            _loc2_ = "</" + param1.substring(param1.indexOf("<") + 1,param1.indexOf(" ")) + ">";
         }
         return _loc2_;
      }
      
      private function isWithinTag(param1:String, param2:String, param3:String, param4:int) : Boolean
      {
         var _loc8_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc5_:String = this.getTextWithoutTimeStamp(param1);
         var _loc6_:int = _loc5_.indexOf(param2);
         var _loc7_:int = _loc5_.indexOf(this.getCloseTag(param2),_loc6_);
         if(param4 == 0)
         {
            _loc8_ = param2.indexOf(param3) != -1?_loc6_ + param2.length:0;
         }
         else
         {
            _loc11_ = _loc5_.indexOf(param3);
            _loc10_ = 0;
            while(_loc10_ < param4)
            {
               _loc8_ = _loc5_.indexOf(param3,_loc11_ + param3.length);
               _loc11_ = _loc8_;
               _loc10_++;
            }
         }
         var _loc9_:int = _loc5_.indexOf(param3,_loc8_);
         return _loc6_ < _loc9_ && _loc7_ > _loc9_;
      }
      
      private function getTextWithoutTimeStamp(param1:String) : String
      {
         if(param1.match(new RegExp("\\[(\\d{2}:?){3}\\]","g")).length == 0)
         {
            return param1;
         }
         var _loc2_:int = param1.indexOf("]") + 2;
         return param1.substr(_loc2_,param1.length - _loc2_);
      }
      
      private function getWordIndex(param1:String, param2:String, param3:int) : int
      {
         var _loc5_:String = null;
         var _loc7_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = false;
         var _loc12_:* = 0;
         var _loc4_:Array = param1.match(ALL_HTML_TAGS);
         var _loc6_:* = -1;
         var _loc8_:int = param2.length;
         while(!_loc11_)
         {
            _loc7_ = param1.indexOf(param2,_loc9_);
            if(_loc7_ != -1)
            {
               _loc5_ = param1.substring(_loc9_ + param1.substring(_loc9_,_loc7_).lastIndexOf("<"),_loc7_) + param1.substring(_loc7_,param1.indexOf(">",_loc7_ + _loc8_) + 1);
               if(_loc4_.indexOf(_loc5_) == -1)
               {
                  _loc6_ = _loc7_;
                  if(_loc10_ == param3)
                  {
                     _loc11_ = true;
                  }
                  else
                  {
                     _loc10_++;
                  }
               }
               _loc9_ = _loc7_ + _loc8_;
               continue;
            }
            return _loc6_;
         }
         return _loc7_;
      }
      
      private function onIconFilterMouseDown(param1:Event) : void
      {
         if(this._filterUI)
         {
            this.openFilterUI(!this._filterUI.parent);
         }
         else
         {
            this.openFilterUI(true);
         }
      }
      
      private function onFilterChange(param1:Event = null) : void
      {
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
                           if(!((this._chatMode) && !(_loc6_ == TypeMessage.LOG_CHAT)))
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
         }
         this._scrollBar.scrollText(-1);
         this._scrollBarH.resize();
         this.onResize();
      }
      
      private function onResize(param1:Event = null) : void
      {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         this._backGround.graphics.clear();
         this._backGround.graphics.beginFill(this._bgColor);
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
            _loc6_ = this._filterButton.length - 1;
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
         if(this._textField.wordWrap)
         {
            this.updateWordWrapLines();
         }
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
      
      private function onTextClick(param1:TextEvent) : void
      {
         var _loc2_:String = param1.text;
         if(_loc2_.charAt(0) == "@")
         {
            this._filterUI.addToFilter(_loc2_.substr(1));
         }
      }
      
      private function onBookClick(param1:MouseEvent) : void
      {
         var _loc2_:ConsoleIcon = param1.currentTarget as ConsoleIcon;
         var _loc3_:int = int(_loc2_.name.substr(1));
         if(_loc3_ == TypeMessage.TYPE_HOOK)
         {
            this._showHook = !this._showHook;
            _loc2_.disable(!this._showHook);
         }
         else if(_loc3_ == TypeMessage.TYPE_UI)
         {
            this._showUI = !this._showUI;
            _loc2_.disable(!this._showUI);
         }
         else if(_loc3_ == TypeMessage.TYPE_ACTION)
         {
            this._showAction = !this._showAction;
            _loc2_.disable(!this._showAction);
         }
         else if(_loc3_ == TypeMessage.TYPE_SHORTCUT)
         {
            this._showShortcut = !this._showShortcut;
            _loc2_.disable(!this._showShortcut);
         }
         
         
         
         this.onFilterChange();
      }
      
      private function saveText(param1:Event) : void
      {
         var _loc2_:* = File.desktopDirectory.nativePath + File.separator + "dofus_chat-";
         var _loc3_:Date = new Date();
         _loc2_ = _loc2_ + TimeManager.getInstance().formatDateIRL(_loc3_.time).split("/").join("-");
         _loc2_ = _loc2_ + ("." + TimeManager.getInstance().formatClock(_loc3_.time).replace(":",""));
         _loc2_ = _loc2_ + ".txt";
         var _loc4_:File = new File(_loc2_);
         _loc4_.browseForSave(I18n.getUiText("ui.common.save"));
         _loc4_.addEventListener(Event.SELECT,this.onFileSelect);
      }
      
      private function onClose(param1:Event) : void
      {
         var _loc2_:ChatFrame = null;
         var _loc3_:* = undefined;
         _displayed = false;
         this._window = null;
         this.saveData();
         if(this._chatMode)
         {
            _loc2_ = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
            if(_loc2_)
            {
               _loc2_.getHistoryMessages().length = 0;
            }
            this._updateWordWrapTimer.removeEventListener(TimerEvent.TIMER,this.onUpdateWordWrap);
            for(_loc3_ in this._wordWrapLinesCache)
            {
               delete this._wordWrapLinesCache[_loc3_];
               true;
            }
         }
      }
      
      private var regExp:RegExp;
      
      private var regExp2:RegExp;
      
      private function onFileSelect(param1:Event) : void
      {
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
         finally
         {
            if(fileStream)
            {
               fileStream.close();
            }
         }
      }
      
      private function onScrollVChange(param1:Event) : void
      {
         this._scrollBarH.resize();
      }
   }
}
