package com.ankamagames.dofus.console.moduleLogger
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.text.*;

    final public class Console extends Object
    {
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
        private var regExp:RegExp;
        private var regExp2:RegExp;
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

        public function Console()
        {
            this._lines = new Vector.<String>;
            this._allInfo = new Vector.<TypeMessage>;
            this.regExp = new RegExp("<[^>]*>", "g");
            this.regExp2 = new RegExp("•", "g");
            if (_self)
            {
                throw new Error();
            }
            ModuleLogger.init(this.log);
            return;
        }// end function

        private function output(param1:TypeMessage) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._active)
            {
                this._allInfo.push(param1);
                if (!_displayed)
                {
                    return;
                }
                if (this._filterUI && this._filterUI.isOn && this._filterUI.isFiltered(param1.name))
                {
                    return;
                }
                _loc_2 = param1.type;
                if (_loc_2 == TypeMessage.TYPE_HOOK && !this._showHook)
                {
                    return;
                }
                if (_loc_2 == TypeMessage.TYPE_UI && !this._showUI)
                {
                    return;
                }
                if (_loc_2 == TypeMessage.TYPE_ACTION && !this._showAction)
                {
                    return;
                }
                if (_loc_2 == TypeMessage.TYPE_SHORTCUT && !this._showShortcut)
                {
                    return;
                }
                _loc_3 = param1.textInfo;
                _loc_4 = _loc_3.split("\n");
                this._lines.push.apply(this._lines, _loc_4);
                this._scrollBar.updateScrolling();
                this._scrollBarH.resize();
            }
            return;
        }// end function

        public function close() : void
        {
            _displayed = false;
            if (this._window)
            {
                this._window.close();
                this._window = null;
            }
            this.saveData();
            return;
        }// end function

        public function disableLogEvent() : void
        {
            var _loc_1:* = null;
            this._showHook = false;
            this._showUI = false;
            this._showAction = false;
            this._showShortcut = false;
            for each (_loc_1 in this._filterButton)
            {
                
                _loc_1.disable(true);
            }
            this.onFilterChange();
            return;
        }// end function

        public function display(param1:Boolean = false) : void
        {
            ModuleLogger.active = true;
            this._active = true;
            if (param1)
            {
                return;
            }
            if (!this._window)
            {
                this.createWindow();
            }
            _displayed = true;
            this._window.activate();
            return;
        }// end function

        public function toggleDisplay() : void
        {
            if (_displayed)
            {
                this.close();
            }
            else
            {
                this.display();
            }
            return;
        }// end function

        private function log(... args) : void
        {
            args = null;
            if (this._active && args.length)
            {
                args = CallWithParameters.callConstructor(TypeMessage, args);
                this.output(args);
            }
            return;
        }// end function

        private function clearConsole(event:Event = null) : void
        {
            this._lines.splice(0, this._lines.length);
            this._allInfo.splice(0, this._allInfo.length);
            this._scrollBar.updateScrolling();
            this._scrollBarH.resize();
            this._textField.text = "";
            return;
        }// end function

        private function createUI() : void
        {
            var _loc_9:* = null;
            this._backGround = new Sprite();
            this._textField = new TextField();
            this._textField.addEventListener(TextEvent.LINK, this.onTextClick);
            this._textField.multiline = true;
            this._textField.wordWrap = false;
            this._textField.mouseWheelEnabled = false;
            this._scrollBar = new TextFieldScrollBar(this._textField, this._lines, 10, SCROLL_BG_COLOR, SCROLL_COLOR);
            this._scrollBarH = new TextFieldOldScrollBarH(this._textField, 5, SCROLL_BG_COLOR, SCROLL_COLOR);
            var _loc_1:* = new TextFormat();
            _loc_1.font = "Courier New";
            _loc_1.size = 16;
            _loc_1.color = OUTPUT_COLOR;
            this._textField.defaultTextFormat = _loc_1;
            this._textField.styleSheet = CONSOLE_STYLE;
            var _loc_2:* = 0;
            this._iconList = new Sprite();
            var _loc_3:* = new ConsoleIcon("cancel", ICON_SIZE);
            _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.clearConsole);
            this._iconList.addChild(_loc_3);
            _loc_2 = _loc_2 + (ICON_SIZE + ICON_INTERVAL);
            var _loc_4:* = new ConsoleIcon("disk", ICON_SIZE);
            new ConsoleIcon("disk", ICON_SIZE).addEventListener(MouseEvent.MOUSE_DOWN, this.saveText);
            _loc_4.x = _loc_2;
            this._iconList.addChild(_loc_4);
            _loc_2 = _loc_2 + (ICON_SIZE + ICON_INTERVAL);
            var _loc_5:* = new ConsoleIcon("list", ICON_SIZE);
            new ConsoleIcon("list", ICON_SIZE).addEventListener(MouseEvent.MOUSE_DOWN, this.onIconFilterMouseDown);
            _loc_5.x = _loc_2;
            this._iconList.addChild(_loc_5);
            this._filterButton = new Array();
            var _loc_6:* = new Array(new ColorTransform(0.9, 1, 1.1), new ColorTransform(0.9, 1.2, 0.8), new ColorTransform(1.3, 0.7, 0.8), new ColorTransform(1.3, 1.3, 0.5));
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6.length)
            {
                
                _loc_9 = new ConsoleIcon("book", ICON_SIZE);
                this._filterButton[_loc_7] = _loc_9;
                _loc_9.changeColor(_loc_6[_loc_7]);
                this._iconList.addChild(_loc_9);
                _loc_9.name = "_" + _loc_7;
                _loc_9.addEventListener(MouseEvent.MOUSE_DOWN, this.onBookClick);
                _loc_7++;
            }
            this._filterUI = new FilterUI(FILTER_UI_COLOR);
            this._filterUI.addEventListener(Event.CHANGE, this.onFilterChange);
            this._window.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onResize);
            this._window.stage.addChild(this._backGround);
            this._window.stage.addChild(this._textField);
            this._window.stage.addChild(this._scrollBar);
            this._window.stage.addChild(this._scrollBarH);
            this._window.stage.addChild(this._iconList);
            var _loc_8:* = StoreDataManager.getInstance().getData(Constants.DATASTORE_MODULE_DEBUG, "console_pref");
            this.loadData(_loc_8);
            this.onResize();
            return;
        }// end function

        private function openFilterUI(param1:Boolean) : void
        {
            if (param1)
            {
                this._window.stage.addChild(this._filterUI);
                this.onResize();
            }
            else if (this._filterUI.parent)
            {
                this._filterUI.parent.removeChild(this._filterUI);
            }
            return;
        }// end function

        private function createWindow() : void
        {
            var _loc_1:* = null;
            if (!this._window)
            {
                _loc_1 = new NativeWindowInitOptions();
                _loc_1.resizable = true;
                this._window = new NativeWindow(_loc_1);
                this._window.width = 800;
                this._window.height = 600;
                this._window.title = "Console";
                this._window.addEventListener(Event.CLOSE, this.onClose);
                this._window.addEventListener(NativeWindowBoundsEvent.RESIZE, this.onResize);
                this._window.stage.align = StageAlign.TOP_LEFT;
                this._window.stage.scaleMode = StageScaleMode.NO_SCALE;
                this._window.stage.tabChildren = false;
                this.createUI();
            }
            return;
        }// end function

        private function saveData() : void
        {
            var data:Object;
            try
            {
                data = new Object();
                if (this._filterUI)
                {
                    data.filter = this._filterUI.getCurrentOptions();
                }
                data.showHook = this._showHook;
                data.showUI = this._showUI;
                data.showAction = this._showAction;
                data.showShortcut = this._showShortcut;
                StoreDataManager.getInstance().setData(Constants.DATASTORE_MODULE_DEBUG, "console_pref", data);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function loadData(param1:Object) : void
        {
            if (param1)
            {
                if (param1.filter)
                {
                    this._filterUI.setOptions(param1.filter);
                    if (param1.filter.isOn)
                    {
                        this.openFilterUI(true);
                    }
                }
                if (param1.hasOwnProperty("showHook") && !param1.showHook)
                {
                    this._filterButton[0].disable(true);
                    this._showHook = false;
                }
                if (param1.hasOwnProperty("showUI") && !param1.showUI)
                {
                    this._filterButton[1].disable(true);
                    this._showUI = false;
                }
                if (param1.hasOwnProperty("showAction") && !param1.showAction)
                {
                    this._filterButton[2].disable(true);
                    this._showAction = false;
                }
                if (param1.hasOwnProperty("showShortcut") && !param1.showShortcut)
                {
                    this._filterButton[3].disable(true);
                    this._showShortcut = false;
                }
                this.onFilterChange();
            }
            return;
        }// end function

        private function onIconFilterMouseDown(event:Event) : void
        {
            if (this._filterUI)
            {
                this.openFilterUI(!this._filterUI.parent);
            }
            else
            {
                this.openFilterUI(true);
            }
            return;
        }// end function

        private function onFilterChange(event:Event = null) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this._lines.splice(0, this._lines.length);
            var _loc_2:* = this._filterUI && this._filterUI.isOn;
            var _loc_3:* = this._allInfo.length;
            var _loc_4:* = -1;
            while (++_loc_4 < _loc_3)
            {
                
                _loc_5 = this._allInfo[_loc_4];
                if (_loc_2 && this._filterUI.isFiltered(_loc_5.name))
                {
                    continue;
                }
                _loc_6 = _loc_5.type;
                if (_loc_6 == TypeMessage.TYPE_HOOK && !this._showHook)
                {
                    continue;
                }
                else if (_loc_6 == TypeMessage.TYPE_UI && !this._showUI)
                {
                    continue;
                }
                else if (_loc_6 == TypeMessage.TYPE_ACTION && !this._showAction)
                {
                    continue;
                }
                else if (_loc_6 == TypeMessage.TYPE_SHORTCUT && !this._showShortcut)
                {
                    continue;
                }
                _loc_7 = _loc_5.textInfo;
                _loc_8 = _loc_7.split("\n");
                this._lines.push.apply(this._lines, _loc_8);
            }
            this._scrollBar.scrollText(-1);
            this._scrollBarH.resize();
            this.onResize();
            return;
        }// end function

        private function onResize(event:Event = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            this._backGround.graphics.clear();
            this._backGround.graphics.beginFill(BACKGROUND_COLOR);
            this._backGround.graphics.drawRect(0, 0, this._window.stage.stageWidth, this._window.stage.stageHeight);
            this._backGround.graphics.endFill();
            this._backGround.graphics.beginFill(OPTIONS_BACKGROUND_COLOR);
            this._backGround.graphics.drawRect(0, 0, this._window.stage.stageWidth, OPTIONS_HEIGHT);
            this._backGround.graphics.endFill();
            if (this._iconList)
            {
                this._iconList.x = 10;
                this._iconList.y = 3;
            }
            if (this._filterButton)
            {
                _loc_5 = this._window.stage.stageWidth - ICON_SIZE - 20;
                _loc_6 = this._filterButton.length - 1;
                while (_loc_6 >= 0)
                {
                    
                    this._filterButton[_loc_6].x = _loc_5;
                    _loc_5 = _loc_5 - (ICON_SIZE + 5);
                    _loc_6 = _loc_6 - 1;
                }
            }
            if (this._filterUI)
            {
                this._filterUI.x = this._window.stage.stageWidth - this._filterUI.width - 20;
                this._filterUI.y = OPTIONS_HEIGHT + 10;
            }
            this._textField.y = OPTIONS_HEIGHT;
            this._textField.width = this._window.stage.stageWidth - TextFieldScrollBar.WIDTH;
            this._textField.height = this._window.stage.stageHeight - this._textField.y - SCROLLBAR_SIZE;
            this._textField.scrollV = 0;
            var _loc_2:* = "";
            var _loc_3:* = 0;
            while (_loc_3 < 200)
            {
                
                _loc_2 = _loc_2 + "o\n";
                _loc_3++;
            }
            this._textField.text = _loc_2;
            var _loc_4:* = this._textField.numLines - this._textField.maxScrollV;
            this._textField.text = "";
            this._scrollBar.addEventListener(Event.CHANGE, this.onScrollVChange);
            this._scrollBar.scrollAtEnd();
            this._scrollBar.resize(_loc_4);
            this._scrollBarH.resize();
            return;
        }// end function

        private function onTextClick(event:TextEvent) : void
        {
            var _loc_2:* = event.text;
            if (_loc_2.charAt(0) == "@")
            {
                this._filterUI.addToFilter(_loc_2.substr(1));
            }
            return;
        }// end function

        private function onBookClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as ConsoleIcon;
            var _loc_3:* = int(_loc_2.name.substr(1));
            if (_loc_3 == TypeMessage.TYPE_HOOK)
            {
                this._showHook = !this._showHook;
                _loc_2.disable(!this._showHook);
            }
            else if (_loc_3 == TypeMessage.TYPE_UI)
            {
                this._showUI = !this._showUI;
                _loc_2.disable(!this._showUI);
            }
            else if (_loc_3 == TypeMessage.TYPE_ACTION)
            {
                this._showAction = !this._showAction;
                _loc_2.disable(!this._showAction);
            }
            else if (_loc_3 == TypeMessage.TYPE_SHORTCUT)
            {
                this._showShortcut = !this._showShortcut;
                _loc_2.disable(!this._showShortcut);
            }
            this.onFilterChange();
            return;
        }// end function

        private function saveText(event:Event) : void
        {
            var _loc_2:* = new File();
            _loc_2.browseForSave("Save");
            _loc_2.addEventListener(Event.SELECT, this.onFileSelect);
            return;
        }// end function

        private function onClose(event:Event) : void
        {
            _displayed = false;
            this._window = null;
            this.saveData();
            return;
        }// end function

        private function onFileSelect(event:Event) : void
        {
            var fileStream:FileStream;
            var text:String;
            var e:* = event;
            try
            {
                text = this._lines.join(File.lineEnding);
                text = text.replace(this.regExp, "");
                text = text.replace(this.regExp2, " ");
                fileStream = new FileStream();
                fileStream.open(e.target as File, FileMode.WRITE);
                fileStream.writeUTFBytes(text);
                fileStream.close();
            }
            catch (e:Error)
            {
            }
            finally
            {
                if (fileStream)
                {
                    fileStream.close();
                }
            }
            return;
        }// end function

        private function onScrollVChange(event:Event) : void
        {
            this._scrollBarH.resize();
            return;
        }// end function

        public static function getInstance() : Console
        {
            if (!_self)
            {
                _self = new Console;
            }
            return _self;
        }// end function

        public static function isVisible() : Boolean
        {
            return _displayed;
        }// end function

        CONSOLE_STYLE.setStyle(".yellow", {color:"#ADAE30"});
        CONSOLE_STYLE.setStyle(".orange", {color:"#EDC597"});
        CONSOLE_STYLE.setStyle(".red", {color:"#DD5555"});
        CONSOLE_STYLE.setStyle(".red+", {color:"#FF0000"});
        CONSOLE_STYLE.setStyle(".gray", {color:"#666688"});
        CONSOLE_STYLE.setStyle(".gray+", {color:"#8888AA"});
        CONSOLE_STYLE.setStyle(".pink", {color:"#DD55DD"});
        CONSOLE_STYLE.setStyle(".green", {color:"#00BBBB"});
        CONSOLE_STYLE.setStyle(".blue", {color:"#97A2ED"});
        CONSOLE_STYLE.setStyle(".white", {color:"#C2C2DA"});
        CONSOLE_STYLE.setStyle("a:hover", {color:"#EDC597"});
    }
}
