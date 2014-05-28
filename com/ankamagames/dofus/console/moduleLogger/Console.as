package com.ankamagames.dofus.console.moduleLogger
{
   import flash.text.StyleSheet;
   import flash.display.NativeWindow;
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
      
      public static const CONSOLE_STYLE:StyleSheet;
      
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
      
      private function output(message:TypeMessage) : void {
         var type:* = 0;
         var text:String = null;
         var newLines:Array = null;
         if(this._active)
         {
            this._allInfo.push(message);
            if(!_displayed)
            {
               return;
            }
            if((this._filterUI) && (this._filterUI.isOn) && (this._filterUI.isFiltered(message.name)))
            {
               return;
            }
            type = message.type;
            if((type == TypeMessage.TYPE_HOOK) && (!this._showHook))
            {
               return;
            }
            if((type == TypeMessage.TYPE_UI) && (!this._showUI))
            {
               return;
            }
            if((type == TypeMessage.TYPE_ACTION) && (!this._showAction))
            {
               return;
            }
            if((type == TypeMessage.TYPE_SHORTCUT) && (!this._showShortcut))
            {
               return;
            }
            text = message.textInfo;
            newLines = text.split("\n");
            this._lines.push.apply(this._lines,newLines);
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
         var icon:ConsoleIcon = null;
         this._showHook = false;
         this._showUI = false;
         this._showAction = false;
         this._showShortcut = false;
         for each(icon in this._filterButton)
         {
            icon.disable(true);
         }
         this.onFilterChange();
      }
      
      public function display(quietMode:Boolean = false) : void {
         ModuleLogger.active = true;
         this._active = true;
         if(quietMode)
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
      
      private function log(... args) : void {
         var message:TypeMessage = null;
         if((this._active) && (args.length))
         {
            message = CallWithParameters.callConstructor(TypeMessage,args);
            this.output(message);
         }
      }
      
      private function clearConsole(e:Event = null) : void {
         this._lines.splice(0,this._lines.length);
         this._allInfo.splice(0,this._allInfo.length);
         this._scrollBar.updateScrolling();
         this._scrollBarH.resize();
         this._textField.text = "";
      }
      
      private function createUI() : void {
         var book:ConsoleIcon = null;
         this._backGround = new Sprite();
         this._textField = new TextField();
         this._textField.addEventListener(TextEvent.LINK,this.onTextClick);
         this._textField.multiline = true;
         this._textField.wordWrap = false;
         this._textField.mouseWheelEnabled = false;
         this._scrollBar = new TextFieldScrollBar(this._textField,this._lines,10,SCROLL_BG_COLOR,SCROLL_COLOR);
         this._scrollBarH = new TextFieldOldScrollBarH(this._textField,5,SCROLL_BG_COLOR,SCROLL_COLOR);
         var textFormat:TextFormat = new TextFormat();
         textFormat.font = "Courier New";
         textFormat.size = 16;
         textFormat.color = OUTPUT_COLOR;
         this._textField.defaultTextFormat = textFormat;
         this._textField.styleSheet = CONSOLE_STYLE;
         var posX:int = 0;
         this._iconList = new Sprite();
         var erase:ConsoleIcon = new ConsoleIcon("cancel",ICON_SIZE);
         erase.addEventListener(MouseEvent.MOUSE_DOWN,this.clearConsole);
         this._iconList.addChild(erase);
         posX = posX + (ICON_SIZE + ICON_INTERVAL);
         var disk:ConsoleIcon = new ConsoleIcon("disk",ICON_SIZE);
         disk.addEventListener(MouseEvent.MOUSE_DOWN,this.saveText);
         disk.x = posX;
         this._iconList.addChild(disk);
         posX = posX + (ICON_SIZE + ICON_INTERVAL);
         var filter:ConsoleIcon = new ConsoleIcon("list",ICON_SIZE);
         filter.addEventListener(MouseEvent.MOUSE_DOWN,this.onIconFilterMouseDown);
         filter.x = posX;
         this._iconList.addChild(filter);
         this._filterButton = new Array();
         var bookList:Array = new Array(new ColorTransform(0.9,1,1.1),new ColorTransform(0.9,1.2,0.8),new ColorTransform(1.3,0.7,0.8),new ColorTransform(1.3,1.3,0.5));
         var i:int = 0;
         while(i < bookList.length)
         {
            book = new ConsoleIcon("book",ICON_SIZE);
            this._filterButton[i] = book;
            book.changeColor(bookList[i]);
            this._iconList.addChild(book);
            book.name = "_" + i;
            book.addEventListener(MouseEvent.MOUSE_DOWN,this.onBookClick);
            i++;
         }
         this._filterUI = new FilterUI(FILTER_UI_COLOR);
         this._filterUI.addEventListener(Event.CHANGE,this.onFilterChange);
         this._window.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onResize);
         this._window.stage.addChild(this._backGround);
         this._window.stage.addChild(this._textField);
         this._window.stage.addChild(this._scrollBar);
         this._window.stage.addChild(this._scrollBarH);
         this._window.stage.addChild(this._iconList);
         var data:Object = StoreDataManager.getInstance().getData(Constants.DATASTORE_MODULE_DEBUG,"console_pref");
         this.loadData(data);
         this.onResize();
      }
      
      private function openFilterUI(open:Boolean) : void {
         if(open)
         {
            this._window.stage.addChild(this._filterUI);
            this.onResize();
         }
         else if(this._filterUI.parent)
         {
            this._filterUI.parent.removeChild(this._filterUI);
         }
         
      }
      
      private function createWindow() : void {
         var options:NativeWindowInitOptions = null;
         if(!this._window)
         {
            options = new NativeWindowInitOptions();
            options.resizable = true;
            this._window = new NativeWindow(options);
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
         var data:Object = null;
         try
         {
            data = new Object();
            if(this._filterUI)
            {
               data.filter = this._filterUI.getCurrentOptions();
            }
            data.showHook = this._showHook;
            data.showUI = this._showUI;
            data.showAction = this._showAction;
            data.showShortcut = this._showShortcut;
            StoreDataManager.getInstance().setData(Constants.DATASTORE_MODULE_DEBUG,"console_pref",data);
         }
         catch(e:Error)
         {
         }
      }
      
      private function loadData(data:Object) : void {
         if(data)
         {
            if(data.filter)
            {
               this._filterUI.setOptions(data.filter);
               if(data.filter.isOn)
               {
                  this.openFilterUI(true);
               }
            }
            if((data.hasOwnProperty("showHook")) && (!data.showHook))
            {
               this._filterButton[0].disable(true);
               this._showHook = false;
            }
            if((data.hasOwnProperty("showUI")) && (!data.showUI))
            {
               this._filterButton[1].disable(true);
               this._showUI = false;
            }
            if((data.hasOwnProperty("showAction")) && (!data.showAction))
            {
               this._filterButton[2].disable(true);
               this._showAction = false;
            }
            if((data.hasOwnProperty("showShortcut")) && (!data.showShortcut))
            {
               this._filterButton[3].disable(true);
               this._showShortcut = false;
            }
            this.onFilterChange();
         }
      }
      
      private function onIconFilterMouseDown(e:Event) : void {
         if(this._filterUI)
         {
            this.openFilterUI(!this._filterUI.parent);
         }
         else
         {
            this.openFilterUI(true);
         }
      }
      
      private function onFilterChange(event:Event = null) : void {
         var message:TypeMessage = null;
         var type:* = 0;
         var text:String = null;
         var newLines:Array = null;
         this._lines.splice(0,this._lines.length);
         var filterIsOn:Boolean = (this._filterUI) && (this._filterUI.isOn);
         var num:int = this._allInfo.length;
         var i:int = -1;
         while(++i < num)
         {
            message = this._allInfo[i];
            if(!((filterIsOn) && (this._filterUI.isFiltered(message.name))))
            {
               type = message.type;
               if(!((type == TypeMessage.TYPE_HOOK) && (!this._showHook)))
               {
                  if(!((type == TypeMessage.TYPE_UI) && (!this._showUI)))
                  {
                     if(!((type == TypeMessage.TYPE_ACTION) && (!this._showAction)))
                     {
                        if(!((type == TypeMessage.TYPE_SHORTCUT) && (!this._showShortcut)))
                        {
                           text = message.textInfo;
                           newLines = text.split("\n");
                           this._lines.push.apply(this._lines,newLines);
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
      
      private function onResize(event:Event = null) : void {
         var posX:* = 0;
         var k:* = 0;
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
            posX = this._window.stage.stageWidth - ICON_SIZE - 20;
            k = this._filterButton.length - 1;
            while(k >= 0)
            {
               this._filterButton[k].x = posX;
               posX = posX - (ICON_SIZE + 5);
               k--;
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
         var text:String = "";
         var i:int = 0;
         while(i < 200)
         {
            text = text + "o\n";
            i++;
         }
         this._textField.text = text;
         var numLines:int = this._textField.numLines - this._textField.maxScrollV;
         this._textField.text = "";
         this._scrollBar.addEventListener(Event.CHANGE,this.onScrollVChange);
         this._scrollBar.scrollAtEnd();
         this._scrollBar.resize(numLines);
         this._scrollBarH.resize();
      }
      
      private function onTextClick(textEvent:TextEvent) : void {
         var text:String = textEvent.text;
         if(text.charAt(0) == "@")
         {
            this._filterUI.addToFilter(text.substr(1));
         }
      }
      
      private function onBookClick(e:MouseEvent) : void {
         var target:ConsoleIcon = e.currentTarget as ConsoleIcon;
         var type:int = int(target.name.substr(1));
         if(type == TypeMessage.TYPE_HOOK)
         {
            this._showHook = !this._showHook;
            target.disable(!this._showHook);
         }
         else if(type == TypeMessage.TYPE_UI)
         {
            this._showUI = !this._showUI;
            target.disable(!this._showUI);
         }
         else if(type == TypeMessage.TYPE_ACTION)
         {
            this._showAction = !this._showAction;
            target.disable(!this._showAction);
         }
         else if(type == TypeMessage.TYPE_SHORTCUT)
         {
            this._showShortcut = !this._showShortcut;
            target.disable(!this._showShortcut);
         }
         
         
         
         this.onFilterChange();
      }
      
      private function saveText(e:Event) : void {
         var file:File = new File();
         file.browseForSave("Save");
         file.addEventListener(Event.SELECT,this.onFileSelect);
      }
      
      private function onClose(e:Event) : void {
         _displayed = false;
         this._window = null;
         this.saveData();
      }
      
      private var regExp:RegExp;
      
      private var regExp2:RegExp;
      
      private function onFileSelect(e:Event) : void {
         var fileStream:FileStream = null;
         var text:String = null;
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
      
      private function onScrollVChange(e:Event) : void {
         this._scrollBarH.resize();
      }
   }
}
