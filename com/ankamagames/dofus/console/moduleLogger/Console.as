package com.ankamagames.dofus.console.moduleLogger
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.text.StyleSheet;
    import flash.display.NativeMenu;
    import flash.display.NativeWindow;
    import __AS3__.vec.Vector;
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
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import __AS3__.vec.*;

    public final class Console 
    {

        private static const OPTIONS_HEIGHT:uint = 30;
        private static const OPTIONS_BACKGROUND_COLOR:uint = 4473941;
        private static const ICON_SIZE:int = 24;
        private static const ICON_INTERVAL:int = 15;
        private static const SCROLLBAR_SIZE:uint = 10;
        private static const FILTER_UI_COLOR:uint = 4473941;
        private static const BACKGROUND_COLOR:uint = 0x222222;
        private static const OUTPUT_COLOR:uint = 6710920;
        private static const SCROLL_BG_COLOR:uint = 4473941;
        private static const SCROLL_COLOR:uint = 6710920;
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Console));
        private static const ALL_HTML_TAGS:RegExp = /<\/?\w+((\s+\w+(\s*=\s*(?:".*?"|'.*?'|[^'">\s]+))?)+\s*|\s*)\/?>/g;
        public static var showActionLog:Boolean = true;
        public static var logChatMessagesOnly:Boolean;
        private static var _self:Console;
        private static var _displayed:Boolean = false;

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
        private var regExp:RegExp;
        private var regExp2:RegExp;

        public function Console()
        {
            this._lines = new Vector.<String>();
            this._allInfo = new Vector.<TypeMessage>();
            this._updateWordWrapTimer = new Timer(50);
            this._wordWrapLinesCache = new Dictionary(true);
            this.regExp = new RegExp("<[^>]*>", "g");
            this.regExp2 = new RegExp("•", "g");
            super();
            if (_self)
            {
                throw (new Error());
            };
            ModuleLogger.addCallback(this.log);
        }

        public static function getInstance():Console
        {
            if (!(_self))
            {
                _self = new (Console)();
            };
            return (_self);
        }

        public static function isVisible():Boolean
        {
            return (_displayed);
        }


        public function get consoleStyle():StyleSheet
        {
            if (!(this._consoleStyle))
            {
                this.initConsoleStyle();
            };
            return (this._consoleStyle);
        }

        public function get chatMode():Boolean
        {
            return (this._chatMode);
        }

        public function set chatMode(pValue:Boolean):void
        {
            this._chatMode = pValue;
        }

        public function get opened():Boolean
        {
            return (!((this._window == null)));
        }

        private function output(message:TypeMessage):void
        {
            var type:int;
            var text:String;
            var newLines:Array;
            if (this._active)
            {
                this._allInfo.push(message);
                if (!(_displayed))
                {
                    return;
                };
                if (((((this._filterUI) && (this._filterUI.isOn))) && (this._filterUI.isFiltered(message.name))))
                {
                    return;
                };
                type = message.type;
                if ((((type == TypeMessage.TYPE_HOOK)) && (!(this._showHook))))
                {
                    return;
                };
                if ((((type == TypeMessage.TYPE_UI)) && (!(this._showUI))))
                {
                    return;
                };
                if ((((type == TypeMessage.TYPE_ACTION)) && (!(this._showAction))))
                {
                    return;
                };
                if ((((type == TypeMessage.TYPE_SHORTCUT)) && (!(this._showShortcut))))
                {
                    return;
                };
                if (((this._chatMode) && (!((type == TypeMessage.LOG_CHAT)))))
                {
                    return;
                };
                text = message.textInfo;
                newLines = text.split("\n");
                this._lines.push.apply(this._lines, newLines);
                if (this._textField.wordWrap)
                {
                    this._updateWordWrapTimer.reset();
                    this._updateWordWrapTimer.start();
                    return;
                };
                this._scrollBar.updateScrolling();
                this._scrollBarH.resize();
            };
        }

        public function close():void
        {
            _displayed = false;
            if (this._window)
            {
                this._window.close();
                this._window = null;
            };
            this.saveData();
        }

        public function disableLogEvent():void
        {
            var icon:ConsoleIcon;
            this._showHook = false;
            this._showUI = false;
            this._showAction = false;
            this._showShortcut = false;
            for each (icon in this._filterButton)
            {
                icon.disable(true);
            };
            this.onFilterChange();
        }

        public function activate():void
        {
            this._active = (ModuleLogger.active = true);
        }

        public function display(quietMode:Boolean=false):void
        {
            ModuleLogger.active = true;
            this._active = true;
            if (quietMode)
            {
                return;
            };
            if (!(this._window))
            {
                this.createWindow();
            };
            _displayed = true;
            this._window.activate();
        }

        public function toggleDisplay():void
        {
            if (_displayed)
            {
                this.close();
            }
            else
            {
                this.display();
            };
        }

        private function log(... args):void
        {
            var message:TypeMessage;
            if (((this._active) && (args.length)))
            {
                message = CallWithParameters.callConstructor(TypeMessage, args);
                if (((!(logChatMessagesOnly)) || (((logChatMessagesOnly) && ((message.type == TypeMessage.LOG_CHAT))))))
                {
                    this.output(message);
                };
            };
        }

        public function clearConsole(e:Event=null):void
        {
            var text:*;
            if (this._chatMode)
            {
                for (text in this._wordWrapLinesCache)
                {
                    delete this._wordWrapLinesCache[text];
                };
            };
            this._lines.splice(0, this._lines.length);
            this._allInfo.splice(0, this._allInfo.length);
            this._scrollBar.updateScrolling();
            this._scrollBarH.resize();
            this._textField.text = "";
        }

        private function initConsoleStyle():void
        {
            var i:int;
            this._consoleStyle = new StyleSheet();
            this._consoleStyle.setStyle(".yellow", {"color":"#ADAE30"});
            this._consoleStyle.setStyle(".orange", {"color":"#EDC597"});
            this._consoleStyle.setStyle(".red", {"color":"#DD5555"});
            this._consoleStyle.setStyle(".red+", {"color":"#FF0000"});
            this._consoleStyle.setStyle(".gray", {"color":"#666688"});
            this._consoleStyle.setStyle(".gray+", {"color":"#8888AA"});
            this._consoleStyle.setStyle(".pink", {"color":"#DD55DD"});
            this._consoleStyle.setStyle(".green", {"color":"#00BBBB"});
            this._consoleStyle.setStyle(".blue", {"color":"#97A2ED"});
            this._consoleStyle.setStyle(".white", {"color":"#C2C2DA"});
            this._consoleStyle.setStyle("a:hover", {"color":"#EDC597"});
            this._consoleStyle.setStyle(".p", {"color":("#" + OptionManager.getOptionManager("chat")["alertColor"].toString(16))});
            i = 0;
            while (i <= 13)
            {
                this._consoleStyle.setStyle((".p" + i), {"color":("#" + OptionManager.getOptionManager("chat")[("channelColor" + i)].toString(16))});
                i++;
            };
        }

        private function createIcons():void
        {
            this._posX = 0;
            this._iconList = new Sprite();
            var erase:ConsoleIcon = new ConsoleIcon("cancel", ICON_SIZE);
            erase.addEventListener(MouseEvent.MOUSE_DOWN, this.clearConsole);
            this._iconList.addChild(erase);
            this._posX = (this._posX + (ICON_SIZE + ICON_INTERVAL));
            var disk:ConsoleIcon = new ConsoleIcon("disk", ICON_SIZE);
            disk.addEventListener(MouseEvent.MOUSE_DOWN, this.saveText);
            disk.x = this._posX;
            this._iconList.addChild(disk);
            this._posX = (this._posX + (ICON_SIZE + ICON_INTERVAL));
        }

        private function initUI():void
        {
            this._window.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.onResize);
            this._window.stage.addChild(this._backGround);
            this._window.stage.addChild(this._textField);
            this._window.stage.addChild(this._scrollBar);
            this._window.stage.addChild(this._scrollBarH);
            this._window.stage.addChild(this._iconList);
            this.onResize();
        }

        private function createUI():void
        {
            var book:ConsoleIcon;
            this._backGround = new Sprite();
            this._textField = new TextField();
            this._textField.addEventListener(TextEvent.LINK, this.onTextClick);
            this._textField.multiline = true;
            this._textField.wordWrap = false;
            this._textField.mouseWheelEnabled = false;
            this._scrollBar = new TextFieldScrollBar(this._textField, this._lines, 10, SCROLL_BG_COLOR, SCROLL_COLOR);
            this._scrollBarH = new TextFieldOldScrollBarH(this._textField, 5, SCROLL_BG_COLOR, SCROLL_COLOR);
            var textFormat:TextFormat = new TextFormat();
            textFormat.font = "Courier New";
            textFormat.size = 16;
            textFormat.color = OUTPUT_COLOR;
            this._textField.defaultTextFormat = textFormat;
            this._textField.styleSheet = this.consoleStyle;
            this.createIcons();
            var filter:ConsoleIcon = new ConsoleIcon("list", ICON_SIZE);
            filter.addEventListener(MouseEvent.MOUSE_DOWN, this.onIconFilterMouseDown);
            filter.x = this._posX;
            this._iconList.addChild(filter);
            this._filterButton = new Array();
            var bookList:Array = new Array(new ColorTransform(0.9, 1, 1.1), new ColorTransform(0.9, 1.2, 0.8), new ColorTransform(1.3, 0.7, 0.8), new ColorTransform(1.3, 1.3, 0.5));
            var i:int;
            while (i < bookList.length)
            {
                book = new ConsoleIcon("book", ICON_SIZE);
                this._filterButton[i] = book;
                book.changeColor(bookList[i]);
                this._iconList.addChild(book);
                book.name = ("_" + i);
                book.addEventListener(MouseEvent.MOUSE_DOWN, this.onBookClick);
                i++;
            };
            this._filterUI = new FilterUI(FILTER_UI_COLOR);
            this._filterUI.addEventListener(Event.CHANGE, this.onFilterChange);
            this._bgColor = BACKGROUND_COLOR;
            this.initUI();
            var data:Object = StoreDataManager.getInstance().getData(Constants.DATASTORE_MODULE_DEBUG, "console_pref");
            this.loadData(data);
        }

        private function createChatUI():void
        {
            this._backGround = new Sprite();
            this._textField = new TextField();
            this._textField.addEventListener(TextEvent.LINK, this.onTextClick);
            this._textField.multiline = true;
            this._textField.wordWrap = true;
            this._textField.mouseWheelEnabled = false;
            this._scrollBar = new TextFieldScrollBar(this._textField, this._lines, 10, SCROLL_BG_COLOR, SCROLL_COLOR);
            this._scrollBarH = new TextFieldOldScrollBarH(this._textField, 5, SCROLL_BG_COLOR, SCROLL_COLOR);
            var textFormat:TextFormat = new TextFormat();
            textFormat.font = "Tahoma";
            textFormat.size = 16;
            textFormat.color = OUTPUT_COLOR;
            this._textField.defaultTextFormat = textFormat;
            this._textField.styleSheet = this.consoleStyle;
            this.createIcons();
            this._chatChannelsMenu = null;
            var channelsFilter:ConsoleIcon = new ConsoleIcon("list", ICON_SIZE);
            channelsFilter.addEventListener(MouseEvent.MOUSE_DOWN, this.openChatChannelsMenu);
            channelsFilter.x = this._posX;
            this._iconList.addChild(channelsFilter);
            this._bgColor = XmlConfig.getInstance().getEntry("colors.chat.bgColor");
            this._updateWordWrapTimer.addEventListener(TimerEvent.TIMER, this.onUpdateWordWrap);
            this.initUI();
        }

        private function openChatChannelsMenu(pEvent:MouseEvent):void
        {
            var chatFrame:ChatFrame;
            var channels:Array;
            var chan:ChatChannel;
            var item:NativeMenuItem;
            var externalChatChannels:Array;
            if (!(this._chatChannelsMenu))
            {
                this._chatChannelsMenu = new NativeMenu();
                this._chatChannelsMenu.addEventListener(Event.SELECT, this.filterChatChannel);
                chatFrame = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
                channels = ChatChannel.getChannels();
                externalChatChannels = OptionManager.getOptionManager("chat")["externalChatEnabledChannels"];
                for each (chan in channels)
                {
                    if (chatFrame.disallowedChannels.indexOf(chan.id) == -1)
                    {
                        item = new NativeMenuItem(chan.name);
                        item.data = chan;
                        if (externalChatChannels.indexOf(chan.id) != -1)
                        {
                            item.checked = true;
                        };
                        item.addEventListener(Event.SELECT, this.filterChatChannel);
                        this._chatChannelsMenu.addItem(item);
                    };
                };
            };
            this._chatChannelsMenu.display(this._window.stage, this._window.stage.mouseX, this._window.stage.mouseY);
        }

        private function filterChatChannel(pEvent:Event):void
        {
            var chan:ChatChannel;
            var externalChatChannels:Array;
            var item:NativeMenuItem = (pEvent.currentTarget as NativeMenuItem);
            if (item)
            {
                chan = (item.data as ChatChannel);
                item.checked = !(item.checked);
                externalChatChannels = OptionManager.getOptionManager("chat")["externalChatEnabledChannels"];
                if (item.checked)
                {
                    externalChatChannels.push(chan.id);
                }
                else
                {
                    externalChatChannels.splice(externalChatChannels.indexOf(chan.id), 1);
                };
            };
        }

        public function updateEnabledChatChannels():void
        {
            var item:NativeMenuItem;
            if (!(this._chatChannelsMenu))
            {
                return;
            };
            var externalChatChannels:Array = OptionManager.getOptionManager("chat")["externalChatEnabledChannels"];
            for each (item in this._chatChannelsMenu.items)
            {
                if (externalChatChannels.indexOf(item.data.id) != -1)
                {
                    item.checked = true;
                }
                else
                {
                    item.checked = false;
                };
            };
        }

        private function openFilterUI(open:Boolean):void
        {
            if (open)
            {
                this._window.stage.addChild(this._filterUI);
                this.onResize();
            }
            else
            {
                if (this._filterUI.parent)
                {
                    this._filterUI.parent.removeChild(this._filterUI);
                };
            };
        }

        private function createWindow():void
        {
            var options:NativeWindowInitOptions;
            if (!(this._window))
            {
                options = new NativeWindowInitOptions();
                options.resizable = true;
                this._window = new NativeWindow(options);
                this._window.width = ((!(this._chatMode)) ? 800 : 600);
                this._window.height = ((!(this._chatMode)) ? 600 : 400);
                this._window.title = ((this._chatMode) ? ("Dofus Chat - " + PlayedCharacterManager.getInstance().infos.name) : "Module Console");
                this._window.addEventListener(Event.CLOSE, this.onClose);
                this._window.addEventListener(NativeWindowBoundsEvent.RESIZE, this.onResize);
                this._window.stage.align = StageAlign.TOP_LEFT;
                this._window.stage.scaleMode = StageScaleMode.NO_SCALE;
                this._window.stage.tabChildren = false;
                if (this._chatMode)
                {
                    if (this._filterUI)
                    {
                        this.openFilterUI(false);
                    };
                    this.createChatUI();
                }
                else
                {
                    this.createUI();
                };
            };
        }

        private function saveData():void
        {
            var data:Object;
            try
            {
                data = new Object();
                if (this._filterUI)
                {
                    data.filter = this._filterUI.getCurrentOptions();
                };
                data.showHook = this._showHook;
                data.showUI = this._showUI;
                data.showAction = this._showAction;
                data.showShortcut = this._showShortcut;
                StoreDataManager.getInstance().setData(Constants.DATASTORE_MODULE_DEBUG, "console_pref", data);
            }
            catch(e:Error)
            {
            };
        }

        private function loadData(data:Object):void
        {
            if (data)
            {
                if (data.filter)
                {
                    this._filterUI.setOptions(data.filter);
                    if (data.filter.isOn)
                    {
                        this.openFilterUI(true);
                    };
                };
                if (((data.hasOwnProperty("showHook")) && (!(data.showHook))))
                {
                    this._filterButton[0].disable(true);
                    this._showHook = false;
                };
                if (((data.hasOwnProperty("showUI")) && (!(data.showUI))))
                {
                    this._filterButton[1].disable(true);
                    this._showUI = false;
                };
                if (((data.hasOwnProperty("showAction")) && (!(data.showAction))))
                {
                    this._filterButton[2].disable(true);
                    this._showAction = false;
                };
                if (((data.hasOwnProperty("showShortcut")) && (!(data.showShortcut))))
                {
                    this._filterButton[3].disable(true);
                    this._showShortcut = false;
                };
                this.onFilterChange();
            };
        }

        private function onUpdateWordWrap(pEvent:TimerEvent):void
        {
            this._updateWordWrapTimer.stop();
            this.updateWordWrapLines();
            this._scrollBar.updateScrolling();
            this._scrollBarH.resize();
        }

        private function updateWordWrapLines():void
        {
            var i:int;
            var j:int;
            var k:int;
            var l:int;
            var m:int;
            var htmlLine:String;
            var htmlTags:Array;
            var deleteTags:Array;
            var htmlTag:String;
            var tmpText:String;
            var words:Array;
            var w:String;
            var numWords:int;
            var numTags:int;
            var len:int;
            var openTags:Array;
            var closeTags:Array;
            var newSpanIndex:int;
            var rawText:String;
            var lineText:String;
            var openedSpanTag:Boolean;
            var currentLine:int;
            var tmpIndex:int;
            var lastIndex:int;
            var tsText:String;
            var tmpLineText:String;
            var tmpReplaceText:String;
            var tmpWords:Array;
            var wordOccurenceIndex:int;
            var wordIndex:int;
            this._textField.text = this._lines.join("\n");
            this._scrollBar.textFieldNumLines = this._textField.numLines;
            if (!(this._scrollBar.wordWrapLines))
            {
                this._scrollBar.wordWrapLines = new Vector.<String>(0);
            };
            this._scrollBar.wordWrapLines.length = 0;
            var numLines:uint = this._lines.length;
            var wordCount:Dictionary = new Dictionary(true);
            var lastLine:int;
            i = 0;
            while (i < this._scrollBar.textFieldNumLines)
            {
                lineText = this._textField.getLineText(i).replace("\r", "");
                rawText = lineText;
                if (this._wordWrapLinesCache[rawText])
                {
                    this._scrollBar.wordWrapLines.push(this._wordWrapLinesCache[rawText]);
                }
                else
                {
                    j = lastLine;
                    while (j < numLines)
                    {
                        htmlLine = this._lines[j];
                        htmlTags = htmlLine.match(ALL_HTML_TAGS);
                        numTags = htmlTags.length;
                        k = 0;
                        while (k < numTags)
                        {
                            if (htmlTags[k].indexOf("span") == -1)
                            {
                                htmlLine = htmlLine.replace(htmlTags[k], "");
                            };
                            k++;
                        };
                        tmpIndex = htmlLine.indexOf(lineText);
                        if (((!((tmpIndex == -1))) && ((((j > currentLine)) || ((((j == currentLine)) && ((tmpIndex > lastIndex))))))))
                        {
                            deleteTags = [];
                            for each (htmlTag in htmlTags)
                            {
                                if (((!((htmlTag.indexOf("span") == -1))) || (!((htmlTag.indexOf("</") == -1)))))
                                {
                                    deleteTags.push(htmlTag);
                                };
                            };
                            for each (htmlTag in deleteTags)
                            {
                                htmlTags.splice(htmlTags.indexOf(htmlTag), 1);
                            };
                            words = lineText.split(" ");
                            if ((words[0] as String).match(/\[(\d{2}:?){3}\]/g).length > 0)
                            {
                                words.splice(0, 1);
                            };
                            numWords = words.length;
                            numTags = htmlTags.length;
                            k = 0;
                            while (k < numWords)
                            {
                                w = words[k];
                                w = w.replace(".", "");
                                w = w.replace("(", "");
                                w = w.replace(")", "");
                                if (w.length == 0)
                                {
                                }
                                else
                                {
                                    if (!(wordCount[j]))
                                    {
                                        wordCount[j] = new Dictionary(true);
                                    };
                                    if (!(wordCount[j][w]))
                                    {
                                        wordCount[j][w] = 1;
                                    }
                                    else
                                    {
                                        var _local_34 = wordCount[j];
                                        var _local_35 = w;
                                        var _local_36 = (_local_34[_local_35] + 1);
                                        _local_34[_local_35] = _local_36;
                                    };
                                    wordOccurenceIndex = (wordCount[j][w] - 1);
                                    openTags = [];
                                    closeTags = [];
                                    tmpText = this._lines[j];
                                    l = 0;
                                    while (l < numTags)
                                    {
                                        if (this.isWithinTag(tmpText, htmlTags[l], w, wordOccurenceIndex))
                                        {
                                            openTags.push(htmlTags[l]);
                                        };
                                        tmpText = tmpText.replace(htmlTags[l], "");
                                        tmpText = tmpText.replace(this.getCloseTag(htmlTags[l]), "");
                                        l++;
                                    };
                                    l = (openTags.length - 1);
                                    while (l >= 0)
                                    {
                                        closeTags.push(this.getCloseTag(openTags[l]));
                                        l--;
                                    };
                                    tmpLineText = this.getTextWithoutTimeStamp(lineText);
                                    wordIndex = this.getWordIndex(tmpLineText, w, wordOccurenceIndex);
                                    if (wordIndex != -1)
                                    {
                                        tmpReplaceText = tmpLineText.substr(wordIndex, (tmpLineText.length - wordIndex)).replace(w, ((openTags.join("") + w) + closeTags.join("")));
                                        tsText = ((((!((lineText == tmpLineText))) && (!((lineText.indexOf("]") == -1))))) ? lineText.substr(0, (lineText.indexOf("]") + 2)) : "");
                                        lineText = ((tsText + tmpLineText.substr(0, wordIndex)) + tmpReplaceText);
                                    };
                                };
                                k++;
                            };
                            lastIndex = tmpIndex;
                            newSpanIndex = htmlLine.indexOf("<span");
                            if (newSpanIndex != -1)
                            {
                                if (((openedSpanTag) && ((i > 0))))
                                {
                                    this._scrollBar.wordWrapLines[(i - 1)] = (this._scrollBar.wordWrapLines[(i - 1)] + "</span>");
                                };
                                lineText = (htmlLine.substring(newSpanIndex, (htmlLine.indexOf(">") + 1)) + lineText);
                                openedSpanTag = true;
                            };
                            if (j > currentLine)
                            {
                                currentLine = j;
                            };
                            lastLine = j;
                            break;
                        };
                        lastIndex = -1;
                        j++;
                    };
                    if (i == (this._scrollBar.textFieldNumLines - 1))
                    {
                        lineText = (lineText + "</span>");
                    };
                    this._scrollBar.wordWrapLines.push(lineText);
                    this._wordWrapLinesCache[rawText] = lineText;
                };
                i++;
            };
        }

        private function getCloseTag(pOpenTag:String):String
        {
            var closeTag:String;
            var hasParams:Boolean = !((pOpenTag.indexOf(" ") == -1));
            if (!(hasParams))
            {
                closeTag = ("</" + pOpenTag.substring((pOpenTag.indexOf("<") + 1), (pOpenTag.indexOf(">") + 1)));
            }
            else
            {
                closeTag = (("</" + pOpenTag.substring((pOpenTag.indexOf("<") + 1), pOpenTag.indexOf(" "))) + ">");
            };
            return (closeTag);
        }

        private function isWithinTag(pSourceText:String, pSourceTag:String, pText:String, pWordOccurrenceIndex:int):Boolean
        {
            var textStartIndex:int;
            var _local_10:int;
            var _local_11:int;
            var sourceText:String = this.getTextWithoutTimeStamp(pSourceText);
            var openTagIndex:int = sourceText.indexOf(pSourceTag);
            var closeTagIndex:int = sourceText.indexOf(this.getCloseTag(pSourceTag), openTagIndex);
            if (pWordOccurrenceIndex == 0)
            {
                textStartIndex = ((!((pSourceTag.indexOf(pText) == -1))) ? (openTagIndex + pSourceTag.length) : 0);
            }
            else
            {
                _local_11 = sourceText.indexOf(pText);
                _local_10 = 0;
                while (_local_10 < pWordOccurrenceIndex)
                {
                    textStartIndex = sourceText.indexOf(pText, (_local_11 + pText.length));
                    _local_11 = textStartIndex;
                    _local_10++;
                };
            };
            var textIndex:int = sourceText.indexOf(pText, textStartIndex);
            return ((((openTagIndex < textIndex)) && ((closeTagIndex > textIndex))));
        }

        private function getTextWithoutTimeStamp(pText:String):String
        {
            if (pText.match(/\[(\d{2}:?){3}\]/g).length == 0)
            {
                return (pText);
            };
            var textStart:int = (pText.indexOf("]") + 2);
            return (pText.substr(textStart, (pText.length - textStart)));
        }

        private function getWordIndex(pFullText:String, pWord:String, pWordOcurrence:int):int
        {
            var testTag:String;
            var wordIndex:int;
            var startIndex:int;
            var numWord:int;
            var found:Boolean;
            var i:int;
            var tags:Array = pFullText.match(ALL_HTML_TAGS);
            var previousIndex:int = -1;
            var wordLen:int = pWord.length;
            while (!(found))
            {
                wordIndex = pFullText.indexOf(pWord, startIndex);
                if (wordIndex != -1)
                {
                    testTag = (pFullText.substring((startIndex + pFullText.substring(startIndex, wordIndex).lastIndexOf("<")), wordIndex) + pFullText.substring(wordIndex, (pFullText.indexOf(">", (wordIndex + wordLen)) + 1)));
                    if (tags.indexOf(testTag) == -1)
                    {
                        previousIndex = wordIndex;
                        if (numWord == pWordOcurrence)
                        {
                            found = true;
                        }
                        else
                        {
                            numWord++;
                        };
                    };
                    startIndex = (wordIndex + wordLen);
                }
                else
                {
                    return (previousIndex);
                };
            };
            return (wordIndex);
        }

        private function onIconFilterMouseDown(e:Event):void
        {
            if (this._filterUI)
            {
                this.openFilterUI(!(this._filterUI.parent));
            }
            else
            {
                this.openFilterUI(true);
            };
        }

        private function onFilterChange(event:Event=null):void
        {
            var message:TypeMessage;
            var type:int;
            var text:String;
            var newLines:Array;
            this._lines.splice(0, this._lines.length);
            var filterIsOn:Boolean = ((this._filterUI) && (this._filterUI.isOn));
            var num:int = this._allInfo.length;
            var i:int = -1;
            while (++i < num)
            {
                message = this._allInfo[i];
                if (((filterIsOn) && (this._filterUI.isFiltered(message.name))))
                {
                }
                else
                {
                    type = message.type;
                    if ((((type == TypeMessage.TYPE_HOOK)) && (!(this._showHook))))
                    {
                    }
                    else
                    {
                        if ((((type == TypeMessage.TYPE_UI)) && (!(this._showUI))))
                        {
                        }
                        else
                        {
                            if ((((type == TypeMessage.TYPE_ACTION)) && (!(this._showAction))))
                            {
                            }
                            else
                            {
                                if ((((type == TypeMessage.TYPE_SHORTCUT)) && (!(this._showShortcut))))
                                {
                                }
                                else
                                {
                                    if (((this._chatMode) && (!((type == TypeMessage.LOG_CHAT)))))
                                    {
                                    }
                                    else
                                    {
                                        text = message.textInfo;
                                        newLines = text.split("\n");
                                        this._lines.push.apply(this._lines, newLines);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            this._scrollBar.scrollText(-1);
            this._scrollBarH.resize();
            this.onResize();
        }

        private function onResize(event:Event=null):void
        {
            var posX:int;
            var k:int;
            this._backGround.graphics.clear();
            this._backGround.graphics.beginFill(this._bgColor);
            this._backGround.graphics.drawRect(0, 0, this._window.stage.stageWidth, this._window.stage.stageHeight);
            this._backGround.graphics.endFill();
            this._backGround.graphics.beginFill(OPTIONS_BACKGROUND_COLOR);
            this._backGround.graphics.drawRect(0, 0, this._window.stage.stageWidth, OPTIONS_HEIGHT);
            this._backGround.graphics.endFill();
            if (this._iconList)
            {
                this._iconList.x = 10;
                this._iconList.y = 3;
            };
            if (this._filterButton)
            {
                posX = ((this._window.stage.stageWidth - ICON_SIZE) - 20);
                k = (this._filterButton.length - 1);
                while (k >= 0)
                {
                    this._filterButton[k].x = posX;
                    posX = (posX - (ICON_SIZE + 5));
                    k--;
                };
            };
            if (this._filterUI)
            {
                this._filterUI.x = ((this._window.stage.stageWidth - this._filterUI.width) - 20);
                this._filterUI.y = (OPTIONS_HEIGHT + 10);
            };
            this._textField.y = OPTIONS_HEIGHT;
            this._textField.width = (this._window.stage.stageWidth - TextFieldScrollBar.WIDTH);
            this._textField.height = ((this._window.stage.stageHeight - this._textField.y) - SCROLLBAR_SIZE);
            if (this._textField.wordWrap)
            {
                this.updateWordWrapLines();
            };
            this._textField.scrollV = 0;
            var text:String = "";
            var i:int;
            while (i < 200)
            {
                text = (text + "o\n");
                i++;
            };
            this._textField.text = text;
            var numLines:int = (this._textField.numLines - this._textField.maxScrollV);
            this._textField.text = "";
            this._scrollBar.addEventListener(Event.CHANGE, this.onScrollVChange);
            this._scrollBar.scrollAtEnd();
            this._scrollBar.resize(numLines);
            this._scrollBarH.resize();
        }

        private function onTextClick(textEvent:TextEvent):void
        {
            var text:String = textEvent.text;
            if (text.charAt(0) == "@")
            {
                this._filterUI.addToFilter(text.substr(1));
            };
        }

        private function onBookClick(e:MouseEvent):void
        {
            var target:ConsoleIcon = (e.currentTarget as ConsoleIcon);
            var type:int = int(target.name.substr(1));
            if (type == TypeMessage.TYPE_HOOK)
            {
                this._showHook = !(this._showHook);
                target.disable(!(this._showHook));
            }
            else
            {
                if (type == TypeMessage.TYPE_UI)
                {
                    this._showUI = !(this._showUI);
                    target.disable(!(this._showUI));
                }
                else
                {
                    if (type == TypeMessage.TYPE_ACTION)
                    {
                        this._showAction = !(this._showAction);
                        target.disable(!(this._showAction));
                    }
                    else
                    {
                        if (type == TypeMessage.TYPE_SHORTCUT)
                        {
                            this._showShortcut = !(this._showShortcut);
                            target.disable(!(this._showShortcut));
                        };
                    };
                };
            };
            this.onFilterChange();
        }

        private function saveText(e:Event):void
        {
            var file:File = new File();
            file.browseForSave("Save");
            file.addEventListener(Event.SELECT, this.onFileSelect);
        }

        private function onClose(e:Event):void
        {
            var chatFrame:ChatFrame;
            var text:*;
            _displayed = false;
            this._window = null;
            this.saveData();
            if (this._chatMode)
            {
                chatFrame = (Kernel.getWorker().getFrame(ChatFrame) as ChatFrame);
                if (chatFrame)
                {
                    chatFrame.getHistoryMessages().length = 0;
                };
                this._updateWordWrapTimer.removeEventListener(TimerEvent.TIMER, this.onUpdateWordWrap);
                for (text in this._wordWrapLinesCache)
                {
                    delete this._wordWrapLinesCache[text];
                };
            };
        }

        private function onFileSelect(e:Event):void
        {
            var fileStream:FileStream;
            var text:String;
            try
            {
                text = this._lines.join(File.lineEnding);
                text = text.replace(this.regExp, "");
                text = text.replace(this.regExp2, " ");
                fileStream = new FileStream();
                fileStream.open((e.target as File), FileMode.WRITE);
                fileStream.writeUTFBytes(text);
                fileStream.close();
            }
            catch(e:Error)
            {
            }
            finally
            {
                if (fileStream)
                {
                    fileStream.close();
                };
            };
        }

        private function onScrollVChange(e:Event):void
        {
            this._scrollBarH.resize();
        }


    }
}//package com.ankamagames.dofus.console.moduleLogger

