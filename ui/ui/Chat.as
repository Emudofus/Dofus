package ui
{
    import d2enums.PlayerStatusEnum;
    import d2api.BindsApi;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.TimeApi;
    import d2api.DataApi;
    import d2api.ChatApi;
    import d2api.ConfigApi;
    import d2api.TooltipApi;
    import d2api.PlayedCharacterApi;
    import d2api.SoundApi;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Input;
    import d2components.Label;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.ChatServer;
    import d2hooks.NewMessage;
    import d2hooks.ChatSendPreInit;
    import d2hooks.ChatServerWithObject;
    import d2hooks.ChatServerCopy;
    import d2hooks.ChatServerCopyWithObject;
    import d2hooks.ChatSpeakingItem;
    import d2hooks.TextActionInformation;
    import d2hooks.TextInformation;
    import d2hooks.ChannelEnablingChange;
    import d2hooks.EnabledChannels;
    import d2hooks.UpdateChatOptions;
    import d2hooks.ChatSmiley;
    import d2hooks.ChatFocus;
    import d2hooks.MouseShiftClick;
    import d2hooks.FocusChange;
    import d2hooks.InsertHyperlink;
    import d2hooks.InsertRecipeHyperlink;
    import d2hooks.ChatHyperlink;
    import d2hooks.AddItemHyperlink;
    import d2hooks.LivingObjectMessage;
    import d2hooks.ChatWarning;
    import d2hooks.PopupWarning;
    import d2hooks.ChatLinkRelease;
    import d2hooks.EmoteUnabledListUpdated;
    import d2hooks.GameFightLeave;
    import d2hooks.GameFightJoin;
    import d2hooks.ToggleChatLog;
    import d2hooks.ClearChat;
    import d2hooks.ChatRollOverLink;
    import d2hooks.ShowSmilies;
    import d2hooks.PlayerStatusUpdate;
    import d2hooks.InactivityNotification;
    import d2hooks.NewAwayMessage;
    import d2enums.EventEnums;
    import d2enums.ShortcutHookListEnum;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.text.AntiAliasType;
    import flash.events.KeyboardEvent;
    import d2actions.TabsUpdate;
    import d2actions.ChatLoaded;
    import d2enums.ChatActivableChannelsEnum;
    import __AS3__.vec.Vector;
    import d2data.ItemWrapper;
    import flash.geom.ColorTransform;
    import d2actions.ChannelEnabling;
    import d2actions.OpenSmileys;
    import flash.system.IMEConversionMode;
    import flash.system.IME;
    import d2hooks.OpenStatusMenu;
    import d2actions.ChatTextOutput;
    import flash.ui.Keyboard;
    import d2actions.ChatCommand;
    import d2actions.SaveMessage;
    import d2actions.ClearChat;
    import d2data.ShortcutWrapper;
    import d2data.ButtonWrapper;
    import d2data.EmoteWrapper;
    import d2data.SmileyWrapper;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2data.Achievement;
    import d2data.Monster;
    import d2data.AllianceWrapper;
    import d2data.GuildFactSheetWrapper;
    import d2actions.PlayerStatusUpdateRequest;
    import d2hooks.*;
    import d2actions.*;
    import __AS3__.vec.*;

    public class Chat 
    {

        private static var _shortcutColor:String;
        private static const SMALL_SIZE:uint = 14;
        private static const SMALL_SIZE_LINE_HEIGHT:uint = (SMALL_SIZE + 1);//15
        private static const MEDIUM_SIZE:uint = 16;
        private static const MEDIUM_SIZE_LINE_HEIGHT:uint = (MEDIUM_SIZE + 2);//18
        private static const LARGE_SIZE:uint = 19;
        private static const LARGE_SIZE_LINE_HEIGHT:uint = (LARGE_SIZE + 3);//22
        private static const ITEM_INDEX_CODE:String = String.fromCharCode(65532);
        private static const MAX_CHAT_ITEMS:int = 16;
        private static const LINK_CONTENT_REGEXP:RegExp = /<a.*?>\s*(.*?)\s*<\/a>/g;
        private static var _currentStatus:int = PlayerStatusEnum.PLAYER_STATUS_AVAILABLE;//10

        public var output:Object;
        public var bindsApi:BindsApi;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var timeApi:TimeApi;
        public var dataApi:DataApi;
        public var chatApi:ChatApi;
        public var configApi:ConfigApi;
        public var tooltipApi:TooltipApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var playerApi:PlayedCharacterApi;
        public var soundApi:SoundApi;
        private var _aChannels:Array;
        private var _aTabs:Object;
        private var _aTabsPicto:Array;
        private var _aMiscReplacement:Array;
        private var _aItemReplacement:Array;
        private var _dItemIndex:Dictionary;
        private var _aCheckColors:Array;
        private var _aChecks:Array;
        private var _aCheckChans:Array;
        private var _aTabsViewStamp:Array;
        private var _maxCmdHistoryIndex:uint = 100;
        private var _aHistory:Array;
        private var _nHistoryIndex:int = 0;
        private var _privateHistory:PrivateHistory;
        private var _nCurrentTab:uint = 0;
        private var _tabsCache:Dictionary;
        private var _tmpLabel:Object;
        private var _refreshingChat:Boolean;
        private var _sFrom:String;
        private var _sTo:String;
        private var _sChan:String = "/s";
        private var _sChanLocked:String = "/s";
        private var _sChanLockedBeforeSpec:String = "/s";
        private var _sLastChan:String;
        private var _sDest:String;
        private var _sText:String;
        private var _sCssClass:String = "p0";
        private var _focusTimer:Timer;
        private var tx_backgroundMinHeight:int;
        private var texta_tchatMinHeight:int;
        private var ctrMinHeight:int;
        private var _nOffsetYResize:int = 300;
        private var _nOffsetYSmallResize:int = 100;
        private var _bNormalSize:uint = 0;
        private var _smileyOpened:Boolean = false;
        private var _emoteOpened:Boolean = false;
        private var _bCurrentChannelSelected:Boolean = false;
        private var _bChanCheckChange:Boolean = false;
        private var _aTxHighlights:Array;
        private var _aBtnTabs:Array;
        private var _nFontSize:uint;
        private var _timerLowQuality:Timer;
        private var _iconsPath:String;
        private var _autocompletionCount:int = 0;
        private var _autocompletionLastCompletion:String = null;
        private var _autocompletionSubString:String = null;
        private var _delaySendChat:Boolean = false;
        private var _delayWaitingMessage:Boolean = false;
        private var _delaySendChatTimer:Timer;
        private var _lastText:String = null;
        private var _numMessages:int;
        private var _isStreaming:Boolean;
        private var _chatLog:Boolean = false;
        public var _awayMessage:String = "";
        public var _idle:Boolean = false;
        public var realTchatCtr:GraphicContainer;
        public var tchatCtr:GraphicContainer;
        public var tabs_ctr:GraphicContainer;
        public var checks_ctr:GraphicContainer;
        public var tx_background:Texture;
        public var tx_focus:Texture;
        public var inp_tchatinput:Input;
        public var texta_tchat:ChatComponentHandler;
        public var lbl_btn_menu:Object;
        public var btn_lbl_btn_ime:Label;
        public var btn_menu:ButtonContainer;
        public var btn_ime:ButtonContainer;
        public var btn_plus:ButtonContainer;
        public var btn_minus:ButtonContainer;
        public var btn_smiley:ButtonContainer;
        public var btn_emote:ButtonContainer;
        public var btn_tab0:ButtonContainer;
        public var btn_tab1:ButtonContainer;
        public var btn_tab2:ButtonContainer;
        public var btn_tab3:ButtonContainer;
        public var tx_tab0:Texture;
        public var tx_tab1:Texture;
        public var tx_tab2:Texture;
        public var tx_tab3:Texture;
        public var tx_arrow_btn_menu:Texture;
        public var tx_checkColor0:Texture;
        public var tx_checkColor1:Texture;
        public var tx_checkColor2:Texture;
        public var tx_checkColor3:Texture;
        public var tx_checkColor4:Texture;
        public var tx_checkColor5:Texture;
        public var tx_checkColor6:Texture;
        public var tx_checkColor7:Texture;
        public var bgTexturebtn_status:Texture;
        public var btn_check0:ButtonContainer;
        public var btn_check1:ButtonContainer;
        public var btn_check2:ButtonContainer;
        public var btn_check3:ButtonContainer;
        public var btn_check4:ButtonContainer;
        public var btn_check5:ButtonContainer;
        public var btn_check6:ButtonContainer;
        public var btn_check7:ButtonContainer;
        public var btn_status:ButtonContainer;

        public function Chat()
        {
            this._aMiscReplacement = new Array();
            this._aItemReplacement = new Array();
            this._dItemIndex = new Dictionary();
            this._tabsCache = new Dictionary();
            this._focusTimer = new Timer(1, 1);
            this._timerLowQuality = new Timer(100, 1);
            super();
        }

        public function main(args:Array):void
        {
            var c:*;
            var iPicto:uint;
            var modifiedNames:Boolean;
            var name:*;
            var canal:*;
            var obj:*;
            var lh:uint;
            this.btn_plus.soundId = SoundEnum.WINDOW_OPEN;
            this.btn_minus.soundId = SoundEnum.WINDOW_OPEN;
            this.btn_menu.soundId = SoundEnum.WINDOW_OPEN;
            this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
            this.btn_emote.soundId = SoundEnum.WINDOW_OPEN;
            this.sysApi.createHook("InsertHyperlink");
            this.sysApi.addHook(ChatServer, this.onChatServer);
            this.sysApi.addHook(NewMessage, this.onNewMessage);
            this.sysApi.addHook(ChatSendPreInit, this.onChatSendPreInit);
            this.sysApi.addHook(ChatServerWithObject, this.onChatServerWithObject);
            this.sysApi.addHook(ChatServerCopy, this.onChatServerCopy);
            this.sysApi.addHook(ChatServerCopyWithObject, this.onChatServerCopyWithObject);
            this.sysApi.addHook(ChatSpeakingItem, this.onChatSpeakingItem);
            this.sysApi.addHook(TextActionInformation, this.onTextActionInformation);
            this.sysApi.addHook(TextInformation, this.onTextInformation);
            this.sysApi.addHook(ChannelEnablingChange, this.onChannelEnablingChange);
            this.sysApi.addHook(EnabledChannels, this.onEnabledChannels);
            this.sysApi.addHook(UpdateChatOptions, this.onUpdateChatOptions);
            this.sysApi.addHook(ChatSmiley, this.onChatSmiley);
            this.sysApi.addHook(ChatFocus, this.onChatFocus);
            this.sysApi.addHook(MouseShiftClick, this.onMouseShiftClick);
            this.sysApi.addHook(FocusChange, this.onFocusChange);
            this.sysApi.addHook(InsertHyperlink, this.onInsertHyperlink);
            this.sysApi.addHook(InsertRecipeHyperlink, this.onInsertRecipeHyperlink);
            this.sysApi.addHook(ChatHyperlink, this.onChatHyperlink);
            this.sysApi.addHook(AddItemHyperlink, this.onInsertHyperlink);
            this.sysApi.addHook(LivingObjectMessage, this.onLivingObjectMessage);
            this.sysApi.addHook(ChatWarning, this.onChatWarning);
            this.sysApi.addHook(PopupWarning, this.onPopupWarning);
            this.sysApi.addHook(ChatLinkRelease, this.onChatLinkRelease);
            this.sysApi.addHook(EmoteUnabledListUpdated, this.onEmoteUnabledListUpdated);
            this.sysApi.addHook(GameFightLeave, this.onGameFightLeave);
            this.sysApi.addHook(GameFightJoin, this.onGameFightJoin);
            this.sysApi.addHook(ToggleChatLog, this.onToggleChatLog);
            this.sysApi.addHook(ClearChat, this.onClearChat);
            this.sysApi.addHook(ChatRollOverLink, this.onChatRollOverLink);
            this.sysApi.addHook(ShowSmilies, this.onActivateSmilies);
            this.sysApi.addHook(PlayerStatusUpdate, this.onPlayerStatusUpdate);
            this.sysApi.addHook(InactivityNotification, this.onInactivityNotification);
            this.sysApi.addHook(NewAwayMessage, this.onNewAwayMessage);
            this.uiApi.addComponentHook(this.btn_tab0, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab0, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab0, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_tab1, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab1, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab1, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_tab2, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab2, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab2, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_tab3, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_tab3, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addComponentHook(this.btn_tab3, EventEnums.EVENT_ONRIGHTCLICK);
            this.uiApi.addComponentHook(this.btn_status, EventEnums.EVENT_ONROLLOVER);
            this.uiApi.addComponentHook(this.btn_status, EventEnums.EVENT_ONROLLOUT);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.HISTORY_UP, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.HISTORY_DOWN, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_UP, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_DOWN, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_VALID, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.ALT_VALID, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CTRL_VALID, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT2, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SHRINK_CHAT, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_EMOTES, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_ATTITUDES, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_0, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_1, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_2, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_3, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.NEXT_CHAT_TAB, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.PREVIOUS_CHAT_TAB, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_AUTOCOMPLETE, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_GLOBAL, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_TEAM, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_GUILD, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_ALLIANCE, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_PARTY, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_ARENA, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_SALES, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_SEEK, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_FIGHT, this.onShortcut, true);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.SWITCH_TEXT_SIZE, this.onShortcut, true);
            this.uiApi.addShortcutHook("focusChat", this.onShortcut);
            if (this.sysApi.getCurrentLanguage() == "ja")
            {
                this.inp_tchatinput.useEmbedFonts = false;
            };
            this.inp_tchatinput.textfield.addEventListener(Event.CHANGE, this.onChatChange);
            this._focusTimer.addEventListener(TimerEvent.TIMER, this.onFocusTimer);
            this._aCheckChans = new Array([0], [9, 1, 4, 13], [10, 11], [2], [3], [5], [6], [12]);
            this._aCheckColors = new Array(this.tx_checkColor0, this.tx_checkColor1, this.tx_checkColor2, this.tx_checkColor3, this.tx_checkColor4, this.tx_checkColor5, this.tx_checkColor6, this.tx_checkColor7);
            this._aChecks = new Array(this.btn_check0, this.btn_check1, this.btn_check2, this.btn_check3, this.btn_check4, this.btn_check5, this.btn_check6, this.btn_check7);
            if (this.uiApi.useIME())
            {
                this.btn_ime.visible = true;
                this.uiApi.addComponentHook(this.btn_ime, EventEnums.EVENT_ONRELEASE);
                this.setImeMode(null);
                this.inp_tchatinput.width = (this.inp_tchatinput.width - this.btn_ime.width);
                this.btn_status.x = (this.btn_ime.x - 25);
            }
            else
            {
                this.btn_ime.visible = false;
            };
            this.texta_tchat = new ChatComponentHandler(ChatComponentHandler.CHAT_NORMAL, this.realTchatCtr);
            this._tmpLabel = this.uiApi.createComponent("Label");
            this._tmpLabel.useEmbedFonts = false;
            this._tmpLabel.hyperlinkEnabled = true;
            this._tmpLabel.antialias = AntiAliasType.ADVANCED;
            this._tmpLabel.css = this.uiApi.createUri((this.uiApi.getUi("chat").getConstant("css") + "chat_input.css"));
            this._tmpLabel.cssClass = "p";
            this.tx_focus.mouseEnabled = false;
            this.tx_focus.mouseChildren = false;
            this._sFrom = this.uiApi.getText("ui.chat.from");
            this._sTo = this.uiApi.getText("ui.chat.to");
            this._aHistory = this.sysApi.getData("aTchatHistory");
            if (this._aHistory == null)
            {
                this._aHistory = new Array();
            };
            this._nHistoryIndex = this._aHistory.length;
            this._privateHistory = new PrivateHistory(this._maxCmdHistoryIndex);
            this.inp_tchatinput.html = false;
            this.inp_tchatinput.maxChars = 0x0100;
            this.inp_tchatinput.antialias = AntiAliasType.ADVANCED;
            this.inp_tchatinput.textfield.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            this._aTxHighlights = [this.tx_tab0, this.tx_tab1, this.tx_tab2, this.tx_tab3];
            this._aBtnTabs = [this.btn_tab0, this.btn_tab1, this.btn_tab2, this.btn_tab3];
            var tmpChanel:Object = this.chatApi.getChannelsId();
            this._aChannels = new Array();
            for each (c in tmpChanel)
            {
                this._aChannels.push(c);
            };
            this.setTabsChannels();
            this._aTabsPicto = new Array();
            iPicto = 0;
            modifiedNames = false;
            for each (name in this.sysApi.getOption("tabsNames", "chat"))
            {
                if (!(Number(name)))
                {
                    name = iPicto;
                    modifiedNames = true;
                };
                this._aTabsPicto.push(name);
                this.uiApi.me().getElement(("bgTexture" + this._aBtnTabs[iPicto].name)).uri = this.uiApi.createUri(((this.uiApi.me().getConstant("tab_uri") + "") + name));
                iPicto++;
            };
            if (modifiedNames)
            {
                this.sysApi.sendAction(new TabsUpdate(null, this._aTabsPicto));
            };
            this.uiApi.setRadioGroupSelectedItem("tabChatGroup", this.btn_tab0, this.uiApi.me());
            this.init();
            this.onUpdateChatOptions();
            this.sysApi.sendAction(new ChatLoaded());
            for each (canal in this._aChannels)
            {
                if (canal != ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)
                {
                    this.texta_tchat.setCssColor(("#" + this.sysApi.getOption(("channelColor" + canal), "chat").toString(16)), ("p" + canal));
                };
            };
            if (args)
            {
                this.onEnabledChannels(args[0]);
                if (((args[1]) && (!((args[1].length == 0)))))
                {
                    for each (obj in args[1])
                    {
                        this.onTextInformation(obj.content, obj.channel, obj.timestamp, obj.saveMsg);
                    };
                };
            };
            this._nFontSize = this.configApi.getConfigProperty("chat", "chatFontSize");
            if (((this._nFontSize) && ((((((this._nFontSize == SMALL_SIZE)) || ((this._nFontSize == MEDIUM_SIZE)))) || ((this._nFontSize == LARGE_SIZE))))))
            {
                switch (this._nFontSize)
                {
                    case SMALL_SIZE:
                        lh = SMALL_SIZE_LINE_HEIGHT;
                        break;
                    case MEDIUM_SIZE:
                        lh = MEDIUM_SIZE_LINE_HEIGHT;
                        break;
                    case LARGE_SIZE:
                        lh = LARGE_SIZE_LINE_HEIGHT;
                        break;
                };
                this.textResize(this._nFontSize, lh);
            }
            else
            {
                this.configApi.setConfigProperty("chat", "chatFontSize", MEDIUM_SIZE);
            };
            this._delaySendChat = false;
            this._delayWaitingMessage = false;
            this._delaySendChatTimer = new Timer(500, 1);
            this._delaySendChatTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onDelaySendChatTimer);
            this.resizeToPos(3);
            this.texta_tchat.initSmileyTab(this.uiApi.me().getConstant("smilies_uri"), this.dataApi.getAllSmiley());
            this._iconsPath = this.uiApi.me().getConstant("icons_uri");
            this.bgTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "|available"));
            this.chatApi.setExternalChatChannels(this._aTabs[this._nCurrentTab]);
            this._isStreaming = this.sysApi.isStreaming();
        }

        public function unload():void
        {
            this._delaySendChatTimer.stop();
            this._delaySendChatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onDelaySendChatTimer);
            this._focusTimer.removeEventListener(TimerEvent.TIMER, this.onFocusTimer);
            this.inp_tchatinput.textfield.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        }

        public function resize(way:int=1):void
        {
            if ((((way == -1)) && ((this._bNormalSize == 0))))
            {
                this.resizeToPos(2);
            }
            else
            {
                this.resizeToPos(((this._bNormalSize + way) % 3));
            };
        }

        public function resizeToPos(pos:int=-1):void
        {
            if (pos < 0)
            {
                pos = ((this._bNormalSize + 1) % 3);
            };
            this.tx_background.autoGrid = true;
            if (!(this.tx_backgroundMinHeight))
            {
                this.tx_backgroundMinHeight = this.tx_background.height;
            };
            if (!(this.ctrMinHeight))
            {
                this.ctrMinHeight = this.tchatCtr.height;
            };
            if (!(this.texta_tchatMinHeight))
            {
                this.texta_tchatMinHeight = this.texta_tchat.height;
            };
            if (pos == 1)
            {
                this.tx_background.height = (this.tx_backgroundMinHeight + this._nOffsetYSmallResize);
                this.texta_tchat.height = (this.texta_tchatMinHeight + this._nOffsetYSmallResize);
                this.tchatCtr.height = (this.ctrMinHeight + this._nOffsetYSmallResize);
                this._bNormalSize = 1;
                this.btn_plus.selected = false;
            }
            else
            {
                if (pos == 2)
                {
                    this.tx_background.height = ((this.tx_backgroundMinHeight + this._nOffsetYSmallResize) + this._nOffsetYResize);
                    this.texta_tchat.height = ((this.texta_tchatMinHeight + this._nOffsetYSmallResize) + this._nOffsetYResize);
                    this.tchatCtr.height = ((this.ctrMinHeight + this._nOffsetYSmallResize) + this._nOffsetYResize);
                    this._bNormalSize = 2;
                    this.btn_plus.selected = true;
                }
                else
                {
                    this.tx_background.height = this.tx_backgroundMinHeight;
                    this.texta_tchat.height = this.texta_tchatMinHeight;
                    this.tchatCtr.height = this.ctrMinHeight;
                    this._bNormalSize = 0;
                    this.btn_plus.selected = false;
                };
            };
            this.uiApi.me().render();
            this.texta_tchat.scrollV = this.texta_tchat.maxScrollV;
        }

        public function sendMessage(txt:String):void
        {
            this.inp_tchatinput.text = txt;
            this.chanSearch(txt);
            this.inp_tchatinput.focus();
            this.validUiShortcut();
        }

        private function getChannelTabs(pChannelId:uint):Vector.<uint>
        {
            var tab:*;
            var chan:*;
            var tabs:Vector.<uint> = new Vector.<uint>(0);
            for (tab in this._aTabs)
            {
                for each (chan in this._aTabs[tab])
                {
                    if (chan == pChannelId)
                    {
                        tabs.push(tab);
                    };
                };
            };
            return (tabs);
        }

        private function setTabsChannels():void
        {
            var iTab:int;
            var tabs:*;
            var temp:Array;
            var chan:*;
            this._aTabs = new Array();
            iTab = 0;
            while (iTab < 4)
            {
                tabs = this.sysApi.getOption("channelTabs", "chat")[iTab];
                temp = new Array();
                if (tabs)
                {
                    for each (chan in tabs)
                    {
                        if (((this.chatApi.getDisallowedChannelsId()) && ((this.chatApi.getDisallowedChannelsId().indexOf(chan) == -1))))
                        {
                            temp.push(chan);
                        };
                    };
                };
                this._aTabs.push(temp);
                iTab++;
            };
        }

        private function textOutput():void
        {
            var dest:String = "";
            if (this._sDest.length > 0)
            {
                dest = (this._sDest + " ");
            };
            var textToSave:String = (((this._sChan + " ") + dest) + this._sText);
            this.addToHistory(textToSave);
            if (this._sDest.length > 0)
            {
                this._privateHistory.addName(this._sDest);
            };
        }

        private function addToHistory(msg:String):void
        {
            msg = this.trim(msg);
            var hisLength:uint = this._aHistory.length;
            if (((!(hisLength)) || (!((msg == this._aHistory[(hisLength - 1)])))))
            {
                this._aHistory.push(msg);
                if ((hisLength + 1) > this._maxCmdHistoryIndex)
                {
                    this._aHistory = this._aHistory.slice(((hisLength + 10) - this._maxCmdHistoryIndex), (hisLength + 1));
                };
                this._nHistoryIndex = (this._aHistory.length - 1);
                this.sysApi.setData("_nHistoryIndex ", this._nHistoryIndex);
                this.sysApi.setData("aTchatHistory", this._aHistory, false);
            };
            this._nHistoryIndex++;
        }

        private function chanSearch(input:String):void
        {
            var chan:String;
            if (input.toLocaleLowerCase().indexOf(this._sChan) != 0)
            {
                if (input.charAt(0) == "/")
                {
                    chan = input.toLocaleLowerCase().substring(0, input.indexOf(" "));
                }
                else
                {
                    chan = this._sChanLocked;
                };
                if (this.sysApi.getOption("channelLocked", "chat"))
                {
                    this.changeDefaultChannel(chan);
                }
                else
                {
                    this.changeCurrentChannel(chan);
                };
            };
        }

        private function init():void
        {
            this._sDest = "";
            this._sText = "";
            this.changeCurrentChannel(this._sChanLocked);
        }

        private function appendFakeLine(s:String, cssClass:String, time:Number=0):Object
        {
            return (this.texta_tchat.appendText(this.addTimeToText(s, time), cssClass, false));
        }

        private function appendLine(s:String, cssClass:String, time:Number=0, scrollv:Boolean=true, channel:int=0):Object
        {
            var val:int;
            var scrollNeed:Boolean = this.texta_tchat.scrollNeeded();
            var scrollTemp:int = this.texta_tchat.scrollV;
            var paragraph:Object = this.texta_tchat.appendText(this.addTimeToText(s, time), cssClass, true);
            if (((scrollv) && (scrollNeed)))
            {
                this.texta_tchat.scrollV = this.texta_tchat.maxScrollV;
            };
            if (this.texta_tchat.maxScrollV > this.chatApi.getMaxMessagesStored())
            {
                val = (this.texta_tchat.maxScrollV - this.chatApi.getMaxMessagesStored());
                this.texta_tchat.removeLines(val);
            };
            return (paragraph);
        }

        private function appendLineToTabCache(pTab:uint, pText:String, pTimeStamp:Number, pCssClass:String):void
        {
            if (!(this._tabsCache[pTab]))
            {
                this._tabsCache[pTab] = "";
            };
            this._tmpLabel.text = "";
            this._tmpLabel.appendText(this.addTimeToText(pText, pTimeStamp), pCssClass);
            this._tabsCache[pTab] = (this._tabsCache[pTab] + this._tmpLabel.htmlText);
        }

        private function addTimeToText(inValue:String, inTime:Number):String
        {
            if (this.sysApi.getOption("showTime", "chat"))
            {
                inValue = ((("[" + this.timeApi.getClock(inTime, true)) + "] ") + inValue);
            };
            return (inValue);
        }

        private function textResize(size:uint, lineHeight:uint):void
        {
            var oldSize:uint;
            var tab:*;
            var cachedText:String;
            var oldSizeRegExp:RegExp;
            this.texta_tchat.setCssSize(size, lineHeight);
            if (this._nFontSize != size)
            {
                oldSize = this._nFontSize;
                this._nFontSize = size;
                this.configApi.setConfigProperty("chat", "chatFontSize", size);
                if (this.sysApi.getOption("chatExpertMode", "chat"))
                {
                    oldSizeRegExp = new RegExp((('SIZE="' + oldSize) + '"'), "g");
                    for (tab in this._aTabs)
                    {
                        if (this._tabsCache[tab])
                        {
                            cachedText = this._tabsCache[tab];
                            this._tabsCache[tab] = cachedText.replace(oldSizeRegExp, (('SIZE="' + size) + '"'));
                        };
                    };
                };
            };
            this.refreshChat(false);
        }

        private function formatLine(channel:uint=0, content:String="", timestamp:Number=0, fingerprint:String="", senderId:uint=0, senderName:String="", objects:Object=null, receiverName:String="", receiverId:uint=0, livingObject:Boolean=false, admin:Boolean=false, forceDisplay:Boolean=false):void
        {
            var textToShow:String;
            var headerToSave:String;
            var realChannel:uint;
            var classCss:String;
            var numItem:int;
            var i:int;
            var item:ItemWrapper;
            var index:int;
            var channelToShow:*;
            var prefix:String;
            var channelClass:String;
            var paragraph:Object;
            var tabs:Vector.<uint>;
            var tab:uint;
            var externalChatChannels:Object;
            var result:Object;
            var noLinksText:String;
            var senderBaseName:String = senderName;
            if (((content) && ((content.length > 1))))
            {
                content = this.chatApi.unEscapeChatString(content);
            };
            if (objects)
            {
                numItem = objects.length;
                i = 0;
                while (i < numItem)
                {
                    item = objects[i];
                    index = content.indexOf(ITEM_INDEX_CODE);
                    if (index == -1)
                    {
                        break;
                    };
                    content = ((content.substr(0, index) + this.chatApi.newChatItem(item)) + content.substr((index + 1)));
                    i++;
                };
            };
            var showMsg:Boolean;
            if ((((channel == this.chatApi.getRedChannelId())) || (forceDisplay)))
            {
                showMsg = true;
            }
            else
            {
                for each (channelToShow in this._aTabs[this._nCurrentTab])
                {
                    if (channel == channelToShow)
                    {
                        showMsg = true;
                    };
                };
            };
            textToShow = "";
            realChannel = channel;
            classCss = ("p" + channel);
            if (receiverName == "")
            {
                if (senderName == "")
                {
                    prefix = "";
                    if (channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO)
                    {
                        prefix = (("(" + this.uiApi.getText("ui.chat.channel.information")) + ") ");
                    }
                    else
                    {
                        if (channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)
                        {
                            prefix = (("(" + this.uiApi.getText("ui.common.fight")) + ") ");
                            channel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
                        };
                    };
                    if (channel == this.chatApi.getRedChannelId())
                    {
                        prefix = (("(" + this.uiApi.getText("ui.chat.channel.important")) + ") ");
                        classCss = "p";
                    }
                    else
                    {
                        classCss = ("p" + channel);
                    };
                    if (this.sysApi.getOption("showInfoPrefix", "chat"))
                    {
                        textToShow = (prefix + content);
                    }
                    else
                    {
                        textToShow = content;
                    };
                }
                else
                {
                    if (((!(livingObject)) && (!((senderId == 0)))))
                    {
                        senderName = (((((((((((("{player," + escape(senderName)) + ",") + senderId) + ",") + timestamp) + ",") + fingerprint) + ",") + channel) + "::<b>") + senderName) + "</b>}");
                    };
                    if (((!(this.dataApi.getChatChannel(channel).isPrivate)) && (!((channel == ChatActivableChannelsEnum.CHANNEL_GLOBAL)))))
                    {
                        channelClass = ((admin) ? "p" : ("p" + channel));
                        if (!(this.sysApi.getOption("showShortcut", "chat")))
                        {
                            textToShow = ((((("(" + this.dataApi.getChatChannel(channel).name) + ") ") + senderName) + this.uiApi.getText("ui.common.colon")) + content);
                            classCss = channelClass;
                        }
                        else
                        {
                            textToShow = ((((("(" + this.dataApi.getChatChannel(channel).shortcut) + ") ") + senderName) + this.uiApi.getText("ui.common.colon")) + content);
                            classCss = channelClass;
                        };
                    }
                    else
                    {
                        if (channel == ChatActivableChannelsEnum.CHANNEL_GLOBAL)
                        {
                            if (content.substr(0, 4).toLowerCase() == "/me")
                            {
                                content = content.substr(3);
                                textToShow = ((((senderName + this.uiApi.getText("ui.common.colon")) + " <i>") + content) + "</i>");
                                classCss = ("p" + channel);
                            }
                            else
                            {
                                if (content.substr(0, 6).toLowerCase() == "/think")
                                {
                                    content = content.substr(7);
                                    textToShow = ((((((senderName + " ") + this.uiApi.getText("ui.chat.think")) + this.uiApi.getText("ui.common.colon")) + "<i>") + content) + "</i>");
                                    classCss = ("p" + channel);
                                }
                                else
                                {
                                    if ((((((content.length > 1)) && ((content.charAt(0) == "*")))) && ((content.charAt((content.length - 1)) == "*"))))
                                    {
                                        content = content.substr(1, (content.length - 2));
                                        textToShow = (((("<i>" + senderName) + " ") + content) + "</i>");
                                        classCss = ("p" + channel);
                                    }
                                    else
                                    {
                                        if (content.substr(0, 3).toLowerCase() == "/me")
                                        {
                                            content = content.substr(4);
                                            textToShow = (((("<i>" + senderName) + " ") + content) + "</i>");
                                            classCss = ("p" + channel);
                                        }
                                        else
                                        {
                                            textToShow = ((senderName + this.uiApi.getText("ui.common.colon")) + content);
                                            classCss = ("p" + channel);
                                        };
                                    };
                                };
                            };
                        }
                        else
                        {
                            if (senderName != "")
                            {
                                if (!(livingObject))
                                {
                                    this._privateHistory.addName(senderBaseName);
                                };
                                textToShow = ((((this._sFrom + " ") + senderName) + this.uiApi.getText("ui.common.colon")) + content);
                            };
                        };
                    };
                };
            }
            else
            {
                textToShow = ((((((((this._sTo + " {player,") + receiverName) + ",") + receiverId) + "::<b>") + receiverName) + "</b>} : ") + content);
            };
            if (textToShow != "")
            {
                if (showMsg)
                {
                    paragraph = this.appendLine(textToShow, classCss, timestamp, true, realChannel);
                    if (this.sysApi.getOption("chatExpertMode", "chat"))
                    {
                        this._tabsCache[this._nCurrentTab] = this.texta_tchat.htmlText;
                        tabs = this.getChannelTabs(realChannel);
                        for each (tab in tabs)
                        {
                            if (tab != this._nCurrentTab)
                            {
                                this.appendLineToTabCache(tab, textToShow, timestamp, classCss);
                            };
                        };
                    };
                }
                else
                {
                    paragraph = this.appendFakeLine(textToShow, classCss, timestamp);
                    if (this.sysApi.getOption("chatExpertMode", "chat"))
                    {
                        tabs = this.getChannelTabs(realChannel);
                        for each (tab in tabs)
                        {
                            if (tab != this._nCurrentTab)
                            {
                                this.appendLineToTabCache(tab, textToShow, timestamp, classCss);
                            };
                        };
                    };
                };
                this.chatApi.addParagraphToHistory(realChannel, paragraph);
                if (!(this._refreshingChat))
                {
                    externalChatChannels = this.sysApi.getOption("externalChatEnabledChannels", "chat");
                    if (((!((externalChatChannels.indexOf(realChannel) == -1))) || ((realChannel == this.chatApi.getRedChannelId()))))
                    {
                        result = LINK_CONTENT_REGEXP.exec(textToShow);
                        noLinksText = textToShow;
                        while (result)
                        {
                            noLinksText = noLinksText.replace(result[0], result[1]);
                            result = LINK_CONTENT_REGEXP.exec(textToShow);
                        };
                        this.chatApi.logChat(this.chatApi.getStaticHyperlink(noLinksText), classCss);
                    };
                };
                this._numMessages++;
            };
        }

        private function refreshChat(pScrollToBottom:Boolean=true):void
        {
            var channelToShow:*;
            var messageRed:*;
            var messageForThisChannel:*;
            var msg:*;
            if (((this.sysApi.getOption("chatExpertMode", "chat")) && (this._tabsCache[this._nCurrentTab])))
            {
                this.texta_tchat.htmlText = this._tabsCache[this._nCurrentTab];
                if (pScrollToBottom)
                {
                    this.texta_tchat.scrollV = this.texta_tchat.maxScrollV;
                };
                return;
            };
            var messagesBuffer:Array = new Array();
            for each (channelToShow in this._aTabs[this._nCurrentTab])
            {
                for each (messageForThisChannel in this.texta_tchat.getTextForChannel(channelToShow))
                {
                    messagesBuffer.push(messageForThisChannel);
                };
            };
            for each (messageRed in this.texta_tchat.getTextForChannel(this.chatApi.getRedChannelId()))
            {
                messagesBuffer.push(messageRed);
            };
            messagesBuffer.sortOn("id", Array.NUMERIC);
            if (messagesBuffer.length > this.chatApi.getMessagesStoredMax())
            {
                messagesBuffer.splice(0, (messagesBuffer.length - this.chatApi.getMessagesStoredMax()));
            };
            if ((((this.texta_tchat.type == ChatComponentHandler.CHAT_NORMAL)) && ((this.texta_tchat.text == ""))))
            {
                return;
            };
            this.texta_tchat.clearText();
            if (this.texta_tchat.type == ChatComponentHandler.CHAT_ADVANCED)
            {
                this.texta_tchat.insertParagraphes(messagesBuffer);
            }
            else
            {
                this._numMessages = 0;
                this._refreshingChat = true;
                for each (msg in messagesBuffer)
                {
                    switch (Api.chat.getTypeOfChatSentence(msg))
                    {
                        case "basicSentence":
                            this.formatLine(msg.channel, msg.msg, msg.timestamp, msg.fingerprint);
                            break;
                        case "sourceSentence":
                            this.formatLine(msg.channel, msg.msg, msg.timestamp, msg.fingerprint, msg.senderId, msg.senderName, msg.objects, "", 0, false, msg.admin);
                            break;
                        case "recipientSentence":
                            this.formatLine(msg.channel, msg.msg, msg.timestamp, msg.fingerprint, msg.senderId, msg.senderName, msg.objects, msg.receiverName, msg.receiverId);
                            break;
                        case "informationSentence":
                            this.formatLine(msg.channel, msg.msg, msg.timestamp, msg.fingerprint);
                            break;
                    };
                };
                this._refreshingChat = false;
            };
            if (pScrollToBottom)
            {
                this.texta_tchat.scrollV = this.texta_tchat.maxScrollV;
            };
        }

        private function updateChanColor(channelId:int):void
        {
            var chanColor:int = this.sysApi.getOption(("channelColor" + channelId), "chat");
            var colorisation:ColorTransform = new ColorTransform();
            colorisation.color = chanColor;
            this.tx_arrow_btn_menu.transform.colorTransform = colorisation;
            if (channelId != 0)
            {
                this.tx_focus.transform.colorTransform = colorisation;
            }
            else
            {
                this.tx_focus.transform.colorTransform = new ColorTransform();
            };
            this.inp_tchatinput.setCssColor(("#" + chanColor.toString(16)), ("p" + channelId));
        }

        private function changeCurrentChannel(chan:String, auto:Boolean=true):void
        {
            var channelId:int;
            if (this._sChan != chan)
            {
                channelId = this.chatApi.searchChannel(chan);
                if (channelId != -1)
                {
                    this._sCssClass = ("p" + channelId);
                    this._sLastChan = this._sChan;
                    this._sChan = chan;
                    if (!(auto))
                    {
                        this._bCurrentChannelSelected = true;
                    };
                    if (this.inp_tchatinput.cssClass != this._sCssClass)
                    {
                        this.inp_tchatinput.cssClass = this._sCssClass;
                    };
                    this.updateChanColor(channelId);
                };
            };
        }

        private function changeDefaultChannel(chan:String):void
        {
            var channelId:int;
            if (this._sChanLocked != chan)
            {
                channelId = this.chatApi.searchChannel(chan);
                if (channelId != -1)
                {
                    this._sChanLocked = chan;
                };
                this.changeCurrentChannel(chan, false);
            };
        }

        private function changeDisplayChannel(channel:Object, tab:int):void
        {
            if (this._aTabs[tab].indexOf(channel.id) == -1)
            {
                if (this.howManyTimesIsThisChannelUsed(channel.id) == 0)
                {
                    this.sysApi.sendAction(new ChannelEnabling(channel.id, true));
                }
                else
                {
                    this._bChanCheckChange = false;
                };
                this._aTabs[tab].push(channel.id);
            }
            else
            {
                if (this.howManyTimesIsThisChannelUsed(channel.id) == 1)
                {
                    this.sysApi.sendAction(new ChannelEnabling(channel.id, false));
                }
                else
                {
                    this._bChanCheckChange = false;
                };
                this._aTabs[tab].splice(this._aTabs[tab].indexOf(channel.id), 1);
            };
            this.refreshChat();
            this.sysApi.sendAction(new TabsUpdate(this._aTabs));
        }

        private function howManyTimesIsThisChannelUsed(channelId:uint):uint
        {
            var tab:*;
            var chanId:*;
            var timesUsed:uint;
            for each (tab in this._aTabs)
            {
                for each (chanId in tab)
                {
                    if (chanId == channelId)
                    {
                        timesUsed++;
                    };
                };
            };
            return (timesUsed);
        }

        private function tabpicChange(pictoId:uint, tab:int):void
        {
            this.onTabPictoChange((tab + 1), pictoId.toString());
        }

        private function openOptions():void
        {
            this.modCommon.openOptionMenu(false, "ui");
        }

        private function openExternalChat():void
        {
            this.chatApi.launchExternalChat();
        }

        private function colorCheckBox():void
        {
            var id_color:*;
            var t:ColorTransform;
            for (id_color in this._aCheckColors)
            {
                t = new ColorTransform();
                t.color = this.configApi.getConfigProperty("chat", ("channelColor" + this._aCheckChans[id_color][0]));
                this._aCheckColors[id_color].transform.colorTransform = t;
            };
        }

        private function switchNoobyMode(activate:Boolean):void
        {
            var idChan:uint;
            var idCheck:*;
            if (activate)
            {
                this._aTabsViewStamp = new Array();
                this.tabs_ctr.visible = false;
                this.checks_ctr.visible = true;
                if (this._nCurrentTab != 0)
                {
                    this._nCurrentTab = 0;
                    this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                    this.refreshChat();
                };
                this.colorCheckBox();
                for (idCheck in this._aCheckChans)
                {
                    if (this._aTabs[0].indexOf(this._aCheckChans[idCheck][0]) != -1)
                    {
                        if (this._aCheckChans[idCheck].length > 1)
                        {
                            for each (idChan in this._aCheckChans[idCheck])
                            {
                                if (this._aTabs[0].indexOf(idChan) == -1)
                                {
                                    this.changeDisplayChannel(this.dataApi.getChatChannel(idChan), this._nCurrentTab);
                                    if (this._aTabsViewStamp.indexOf(idChan) == -1)
                                    {
                                        this._aTabsViewStamp.push(idChan);
                                    };
                                };
                            };
                        };
                        this._aChecks[idCheck].selected = true;
                    }
                    else
                    {
                        if (this._aCheckChans[idCheck].length > 1)
                        {
                            for each (idChan in this._aCheckChans[idCheck])
                            {
                                if (this._aTabs[0].indexOf(idChan) != -1)
                                {
                                    this.changeDisplayChannel(this.dataApi.getChatChannel(idChan), this._nCurrentTab);
                                    if (this._aTabsViewStamp.indexOf(idChan) == -1)
                                    {
                                        this._aTabsViewStamp.push(idChan);
                                    };
                                };
                            };
                        };
                        this._aChecks[idCheck].selected = false;
                    };
                };
            }
            else
            {
                if (this._aTabsViewStamp != null)
                {
                    for each (idChan in this._aTabsViewStamp)
                    {
                        this.changeDisplayChannel(this.dataApi.getChatChannel(idChan), this._nCurrentTab);
                    };
                    this._aTabsViewStamp = null;
                };
                this.checks_ctr.visible = false;
                this.tabs_ctr.visible = true;
            };
        }

        public function onRelease(target:Object):void
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:String;
            var _local_7:Boolean;
            var _local_8:uint;
            var _local_9:Array;
            var _local_10:Array;
            var iPic:uint;
            var chanAvailable:*;
            var selected:Boolean;
            var chanDisp:*;
            var chatChannel:Object;
            var shortcutKey:String;
            var chan:*;
            var chatChannelTab:Object;
            var idChan:uint;
            var channelCheck:Object;
            switch (target)
            {
                case this.btn_menu:
                    _local_2 = new Array();
                    _local_3 = new Array();
                    _local_4 = new Array();
                    _local_5 = new Array();
                    _local_3.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.small"), this.textResize, [SMALL_SIZE, SMALL_SIZE_LINE_HEIGHT], false, null, (this._nFontSize == SMALL_SIZE)));
                    _local_3.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.medium"), this.textResize, [MEDIUM_SIZE, MEDIUM_SIZE_LINE_HEIGHT], false, null, (this._nFontSize == MEDIUM_SIZE)));
                    _local_3.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.large"), this.textResize, [LARGE_SIZE, LARGE_SIZE_LINE_HEIGHT], false, null, (this._nFontSize == LARGE_SIZE)));
                    _local_6 = this.uiApi.me().getConstant("tabIcon_uri");
                    iPic = 0;
                    while (iPic < 12)
                    {
                        _local_4.push(this.modContextMenu.createContextMenuPictureItemObject(((_local_6 + "") + iPic), this.tabpicChange, [iPic, this._nCurrentTab], false, null, (iPic.toString() == this._aTabsPicto[this._nCurrentTab]), true));
                        iPic++;
                    };
                    for each (chanAvailable in this._aChannels)
                    {
                        selected = false;
                        for each (chanDisp in this._aTabs[this._nCurrentTab])
                        {
                            if (chanDisp == chanAvailable)
                            {
                                selected = true;
                            };
                        };
                        chatChannel = this.dataApi.getChatChannel(chanAvailable);
                        shortcutKey = null;
                        if (chatChannel.shortcutKey)
                        {
                            shortcutKey = this.bindsApi.getShortcutBindStr(chatChannel.shortcutKey).toString();
                        };
                        if (shortcutKey)
                        {
                            _local_5.push(this.modContextMenu.createContextMenuItemObject((((chatChannel.name + " (") + shortcutKey) + ")"), this.changeDisplayChannel, [chatChannel, this._nCurrentTab], false, null, selected, false));
                        }
                        else
                        {
                            _local_5.push(this.modContextMenu.createContextMenuItemObject(chatChannel.name, this.changeDisplayChannel, [chatChannel, this._nCurrentTab], false, null, selected, false));
                        };
                    };
                    _local_2.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.chat")));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject((this.uiApi.getText("ui.option.title.chat") + "..."), this.openOptions, null, false, null, false, true));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.externalChat.open"), this.openExternalChat, null, this._isStreaming, null, false, true));
                    _local_2.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.fontSize"), null, null, false, _local_3));
                    if (!(this.checks_ctr.visible))
                    {
                        _local_2.push(this.modContextMenu.createContextMenuSeparatorObject());
                        _local_2.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.chatTab")));
                        _local_2.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.tabPic"), null, null, false, _local_4));
                        _local_2.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.displayedChannels"), null, null, false, _local_5));
                    };
                    _local_2.push(this.modContextMenu.createContextMenuSeparatorObject());
                    _local_2.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.currentChannel")));
                    _local_8 = 0;
                    if (!(_shortcutColor))
                    {
                        _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                        _shortcutColor = _shortcutColor.replace("0x", "#");
                    };
                    for each (chan in this._aTabs[this._nCurrentTab])
                    {
                        chatChannelTab = this.dataApi.getChatChannel(chan);
                        if (((chatChannelTab.shortcut) && (!((chatChannelTab.shortcut == "null")))))
                        {
                            _local_8++;
                            if (this._sChanLocked == chatChannelTab.shortcut)
                            {
                                _local_7 = true;
                            }
                            else
                            {
                                _local_7 = false;
                            };
                            _local_2.push(this.modContextMenu.createContextMenuItemObject((((((chatChannelTab.name + " <font color='") + _shortcutColor) + "'>(") + chatChannelTab.shortcut) + ")</font>"), this.changeDefaultChannel, [chatChannelTab.shortcut], false, null, _local_7, true));
                        };
                    };
                    if (_local_8 == 0)
                    {
                        _local_2.pop();
                        _local_2.pop();
                    };
                    this.modContextMenu.createContextMenu(_local_2);
                    break;
                case this.btn_plus:
                    this.resize(1);
                    break;
                case this.btn_minus:
                    this.resize(-1);
                    break;
                case this.btn_smiley:
                    this.sysApi.sendAction(new OpenSmileys(0));
                    if (this._smileyOpened)
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
                    }
                    else
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_CLOSE;
                    };
                    this._smileyOpened = !(this._smileyOpened);
                    break;
                case this.btn_emote:
                    this.openEmoteUi();
                    break;
                case this.btn_tab0:
                    this._nCurrentTab = 0;
                    this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                    this.refreshChat();
                    break;
                case this.btn_tab1:
                    this._nCurrentTab = 1;
                    this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                    this.refreshChat();
                    break;
                case this.btn_tab2:
                    this._nCurrentTab = 2;
                    this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                    this.refreshChat();
                    break;
                case this.btn_tab3:
                    this._nCurrentTab = 3;
                    this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                    this.refreshChat();
                    break;
                case this.inp_tchatinput:
                    if (this.uiApi.useIME())
                    {
                        this.setImeMode(null);
                    };
                    break;
                case this.btn_check0:
                case this.btn_check1:
                case this.btn_check2:
                case this.btn_check3:
                case this.btn_check4:
                case this.btn_check5:
                case this.btn_check6:
                case this.btn_check7:
                    this._bChanCheckChange = true;
                    for each (idChan in this._aCheckChans[int(target.name.substr(9, 1))])
                    {
                        channelCheck = this.dataApi.getChatChannel(idChan);
                        if (!((this._aTabs[this._nCurrentTab].indexOf(channelCheck.id) == -1)) != target.selected)
                        {
                            this.changeDisplayChannel(channelCheck, this._nCurrentTab);
                        };
                        if (this._aTabsViewStamp.indexOf(channelCheck.id) != -1)
                        {
                            this._aTabsViewStamp.splice(this._aTabsViewStamp.indexOf(channelCheck.id), 1);
                        };
                    };
                    break;
                case this.btn_ime:
                    _local_9 = new Array();
                    _local_9.push(this.modContextMenu.createContextMenuItemObject("あ Hiragana", this.setImeMode, [IMEConversionMode.JAPANESE_HIRAGANA], false, null, (IME.conversionMode == IMEConversionMode.JAPANESE_HIRAGANA), true));
                    _local_9.push(this.modContextMenu.createContextMenuItemObject("カ Katakana", this.setImeMode, [IMEConversionMode.JAPANESE_KATAKANA_FULL], false, null, (IME.conversionMode == IMEConversionMode.JAPANESE_KATAKANA_FULL), true));
                    _local_9.push(this.modContextMenu.createContextMenuItemObject("_カ Half-width Katakana", this.setImeMode, [IMEConversionMode.JAPANESE_KATAKANA_HALF], false, null, (IME.conversionMode == IMEConversionMode.JAPANESE_KATAKANA_HALF), true));
                    _local_9.push(this.modContextMenu.createContextMenuItemObject("Ａ Full-width Alphanumeric", this.setImeMode, [IMEConversionMode.ALPHANUMERIC_FULL], false, null, (IME.conversionMode == IMEConversionMode.ALPHANUMERIC_FULL), true));
                    _local_9.push(this.modContextMenu.createContextMenuItemObject("_Ａ Half-width Alphanumeric", this.setImeMode, [IMEConversionMode.ALPHANUMERIC_HALF], false, null, (IME.conversionMode == IMEConversionMode.ALPHANUMERIC_HALF), true));
                    _local_9.push(this.modContextMenu.createContextMenuItemObject("D Direct input", this.setImeMode, [IMEConversionMode.UNKNOWN], false, null, (IME.conversionMode == IMEConversionMode.UNKNOWN), true));
                    this.modContextMenu.createContextMenu(_local_9);
                    break;
                case this.btn_status:
                    this.sysApi.dispatchHook(OpenStatusMenu);
                    _local_10 = new Array();
                    _local_10.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.chat.status.title")));
                    _local_10.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "|available")), this.uiApi.getText("ui.chat.status.availiable"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_AVAILABLE], false, null, (_currentStatus == -1), true, this.uiApi.getText("ui.chat.status.availiabletooltip")));
                    _local_10.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "|away")), this.uiApi.getText("ui.chat.status.away"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_AFK], false, null, (_currentStatus == 0), true, this.uiApi.getText("ui.chat.status.awaytooltip")));
                    _local_10.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "|away")), (this.uiApi.getText("ui.chat.status.away") + "..."), 13, false, this.onStatusChangeWithMessage, [PlayerStatusEnum.PLAYER_STATUS_AFK], false, null, (_currentStatus == 0), true, this.uiApi.getText("ui.chat.status.awaymessagetooltip")));
                    _local_10.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "|private")), this.uiApi.getText("ui.chat.status.private"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_PRIVATE], false, null, (_currentStatus == 1), true, this.uiApi.getText("ui.chat.status.privatetooltip")));
                    _local_10.push(this.modContextMenu.createContextMenuPictureLabelItemObject(this.uiApi.createUri((this._iconsPath + "|solo")), this.uiApi.getText("ui.chat.status.solo"), 13, false, this.onStatusChange, [PlayerStatusEnum.PLAYER_STATUS_SOLO], false, null, (_currentStatus == 1), true, this.uiApi.getText("ui.chat.status.solotooltip")));
                    this.modContextMenu.createContextMenu(_local_10);
                    break;
            };
        }

        private function setImeMode(mode:String):void
        {
            if (mode == IMEConversionMode.UNKNOWN)
            {
                IME.enabled = false;
            }
            else
            {
                try
                {
                    IME.enabled = true;
                    IME.conversionMode = mode;
                }
                catch(e:Error)
                {
                };
            };
            var modeName:String = "";
            switch (IME.conversionMode)
            {
                case IMEConversionMode.JAPANESE_HIRAGANA:
                    modeName = "あ";
                    break;
                case IMEConversionMode.JAPANESE_KATAKANA_FULL:
                    modeName = "カ";
                    break;
                case IMEConversionMode.JAPANESE_KATAKANA_HALF:
                    modeName = "_カ";
                    break;
                case IMEConversionMode.ALPHANUMERIC_FULL:
                    modeName = "Ａ";
                    break;
                case IMEConversionMode.ALPHANUMERIC_HALF:
                    modeName = "_Ａ";
                    break;
                default:
                    modeName = "D";
            };
            this.btn_lbl_btn_ime.text = modeName;
        }

        private function onDelaySendChatTimer(e:TimerEvent):void
        {
            this._delaySendChatTimer.reset();
            this._delaySendChat = false;
            if (this._delayWaitingMessage)
            {
                this._delayWaitingMessage = false;
                this.validUiShortcut();
            };
        }

        private function getHyperlinkFormatedText(text:String):String
        {
            var currentItem:Object;
            var itemName:String;
            var index:int;
            text = this.chatApi.escapeChatString(text);
            var numItem:int = this._aItemReplacement.length;
            var m:int;
            while (m < numItem)
            {
                currentItem = this._aItemReplacement[m];
                itemName = (("[" + currentItem.realName) + "]");
                index = text.indexOf(itemName);
                if (index == -1)
                {
                    this._aItemReplacement.splice(m, 1);
                    m--;
                    numItem--;
                }
                else
                {
                    text = ((text.substr(0, index) + ITEM_INDEX_CODE) + text.substr((index + itemName.length)));
                };
                m++;
            };
            var num:int = this._aMiscReplacement.length;
            var k:int;
            k = 0;
            while (k < num)
            {
                text = text.split(this._aMiscReplacement[k]).join(this._aMiscReplacement[(k + 1)]);
                k = (k + 2);
            };
            return (text);
        }

        private function processLinkedItem(text:String):String
        {
            var currentItem:Object;
            var itemName:String;
            var index:int;
            var numItem:int = this._aItemReplacement.length;
            var m:int;
            while (m < numItem)
            {
                currentItem = this._aItemReplacement[m];
                itemName = (("[" + currentItem.realName) + "]");
                index = text.indexOf(itemName);
                if (index == -1)
                {
                    this._aItemReplacement.splice(m, 1);
                    m--;
                    numItem--;
                }
                else
                {
                    text = ((((text.substr(0, index) + ITEM_INDEX_CODE) + currentItem.objectUID) + ITEM_INDEX_CODE) + text.substr((index + itemName.length)));
                };
                m++;
            };
            return (text);
        }

        private function addChannelsContextMenu(nTab:int):void
        {
            var chanAvailable:*;
            var selected:Boolean;
            var chanDisp:*;
            var chatChannel:Object;
            var shortcutKey:String;
            var name:String;
            var contextMenu:Array = new Array();
            var picMenu:Array = new Array();
            var displayedChannelsMenu:Array = new Array();
            var iconUri:String = this.uiApi.me().getConstant("tabIcon_uri");
            var iPic:uint;
            while (iPic < 12)
            {
                picMenu.push(this.modContextMenu.createContextMenuPictureItemObject(((iconUri + "") + iPic), this.tabpicChange, [iPic, nTab], false, null, (iPic.toString() == this._aTabsPicto[nTab]), true));
                iPic++;
            };
            for each (chanAvailable in this._aChannels)
            {
                selected = false;
                for each (chanDisp in this._aTabs[nTab])
                {
                    if (chanDisp == chanAvailable)
                    {
                        selected = true;
                    };
                };
                chatChannel = this.dataApi.getChatChannel(chanAvailable);
                shortcutKey = null;
                if (chatChannel.shortcutKey)
                {
                    shortcutKey = this.bindsApi.getShortcutBindStr(chatChannel.shortcutKey).toString();
                };
                if (shortcutKey)
                {
                    name = (((chatChannel.name + " (") + shortcutKey) + ")");
                }
                else
                {
                    name = chatChannel.name;
                };
                displayedChannelsMenu.push(this.modContextMenu.createContextMenuItemObject(name, this.changeDisplayChannel, [chatChannel, nTab], false, null, selected, false));
            };
            contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.chatTab")));
            contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.tabPic"), null, null, false, picMenu));
            contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.displayedChannels"), null, null, false, displayedChannelsMenu));
            this.modContextMenu.createContextMenu(contextMenu);
        }

        private function validUiShortcut():Boolean
        {
            var controler:Object;
            if (!(this.inp_tchatinput.haveFocus))
            {
                return (false);
            };
            if (this._delaySendChat)
            {
                this._delayWaitingMessage = true;
                return (true);
            };
            if (this.canSendMsg(this.inp_tchatinput.text))
            {
                controler = this.sysApi.getNewDynamicSecureObject();
                controler.cancel = false;
                this.sysApi.dispatchHook(ChatSendPreInit, this.inp_tchatinput.text, controler);
                return (true);
            };
            return (false);
        }

        private function canSendMsg(msg:String):Boolean
        {
            if (msg.charAt(0) != " ")
            {
                return (true);
            };
            if (msg.length == 0)
            {
                return (false);
            };
            while (msg.indexOf(" ") != -1)
            {
                msg = msg.replace(" ", "");
            };
            return ((msg.length > 0));
        }

        public function onShortcut(s:String):Boolean
        {
            var i:int;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:uint;
            var sShortcut:String;
            var finalText:String;
            var textInfos:Array;
            var numInfos:int;
            var objectUID:int;
            var item:Object;
            var c2:*;
            switch (s)
            {
                case "focusChat":
                    if (!(this.inp_tchatinput.haveFocus))
                    {
                        this._focusTimer.stop();
                        this._focusTimer.reset();
                        this._focusTimer.start();
                    };
                    return (true);
                case "validUi":
                    if (this.uiApi.useIME())
                    {
                        return (this.validUiShortcut());
                    };
                    return (true);
                case ShortcutHookListEnum.CLOSE_UI:
                    if (this.inp_tchatinput.haveFocus)
                    {
                        this.inp_tchatinput.blur();
                        return (true);
                    };
                    return (false);
                case "upArrow":
                case "downArrow":
                    if (!(this.inp_tchatinput.haveFocus)) break;
                    if (((!(this._aHistory[(this._aHistory.length - 1)])) && (!(this._aHistory[0])))) break;
                    this._bCurrentChannelSelected = false;
                    if ((((s == "upArrow")) && ((this._nHistoryIndex >= 0))))
                    {
                        this._nHistoryIndex--;
                    };
                    if ((((s == "downArrow")) && ((this._nHistoryIndex < this._aHistory.length))))
                    {
                        this._nHistoryIndex++;
                    };
                    _local_3 = this._aHistory[this._nHistoryIndex];
                    if (((!((_local_3 == null))) && (!((_local_3 == "")))))
                    {
                        this.chanSearch(_local_3);
                        sShortcut = this.dataApi.getChatChannel(0).shortcut;
                        if (_local_3.indexOf((sShortcut + " ")) == 0)
                        {
                            finalText = _local_3.slice((sShortcut.length + 1));
                        }
                        else
                        {
                            finalText = _local_3;
                        };
                        this._aItemReplacement = new Array();
                        textInfos = finalText.split(ITEM_INDEX_CODE);
                        numInfos = textInfos.length;
                        i = 1;
                        while (i < numInfos)
                        {
                            objectUID = int(textInfos[i]);
                            if (objectUID)
                            {
                                item = this._dItemIndex[objectUID];
                                if (item)
                                {
                                    textInfos[i] = (("[" + item.name) + "]");
                                    this._aItemReplacement.push(item);
                                }
                                else
                                {
                                    textInfos[i] = "";
                                };
                            };
                            i = (i + 2);
                        };
                        finalText = textInfos.join("");
                        this.inp_tchatinput.text = finalText;
                    }
                    else
                    {
                        this.inp_tchatinput.text = "";
                        this.init();
                    };
                    this.inp_tchatinput.setSelection(this.inp_tchatinput.length, this.inp_tchatinput.length);
                    return (true);
                case "shiftDown":
                case "shiftUp":
                    if (!(this.inp_tchatinput.haveFocus)) break;
                    if (this._privateHistory.length == 0)
                    {
                        break;
                    };
                    this._bCurrentChannelSelected = false;
                    if (s == "shiftUp")
                    {
                        _local_4 = this._privateHistory.previous();
                    }
                    else
                    {
                        if (s == "shiftDown")
                        {
                            _local_4 = this._privateHistory.next();
                        };
                    };
                    _local_5 = (("/w " + _local_4) + " ");
                    this.inp_tchatinput.text = _local_5;
                    this.chanSearch(_local_5);
                    this.inp_tchatinput.setSelection(this.inp_tchatinput.length, this.inp_tchatinput.length);
                    return (true);
                case "shiftValid":
                case "altValid":
                case "ctrlValid":
                    if (!(this.inp_tchatinput.haveFocus))
                    {
                        this._focusTimer.stop();
                        this._focusTimer.reset();
                        this._focusTimer.start();
                        return (false);
                    };
                    if ((((this.inp_tchatinput.text.charAt(0) == "/")) && ((this.inp_tchatinput.text.indexOf(this._sChan) == 0))))
                    {
                        this._sText = this.inp_tchatinput.text.substring((this.inp_tchatinput.text.indexOf(" ") + 1), this.inp_tchatinput.text.length);
                    }
                    else
                    {
                        this._sText = this.inp_tchatinput.text;
                    };
                    if (this._sText.length == 0)
                    {
                        return (true);
                    };
                    this._bCurrentChannelSelected = false;
                    _local_6 = this._sText;
                    this._sText = this.getHyperlinkFormatedText(this._sText);
                    _local_7 = "";
                    if (this._sDest)
                    {
                        _local_7 = (_local_7 + (this._sDest + " "));
                    }
                    else
                    {
                        _local_7 = (_local_7 + this._sDest);
                    };
                    _local_7 = (_local_7 + this._sText);
                    if (s == "altValid")
                    {
                        _local_8 = ChatActivableChannelsEnum.CHANNEL_GUILD;
                        if (this._aItemReplacement.length)
                        {
                            this.sysApi.sendAction(new ChatTextOutput(_local_7, _local_8, "", this._aItemReplacement));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ChatTextOutput(_local_7, _local_8));
                        };
                        this._sChan = this.dataApi.getChatChannel(_local_8).shortcut;
                    }
                    else
                    {
                        if (s == "shiftValid")
                        {
                            _local_8 = ChatActivableChannelsEnum.CHANNEL_PARTY;
                            this.sysApi.sendAction(new ChatTextOutput(_local_7, _local_8));
                            this._sChan = this.dataApi.getChatChannel(_local_8).shortcut;
                        }
                        else
                        {
                            if (s == "ctrlValid")
                            {
                                _local_8 = ChatActivableChannelsEnum.CHANNEL_TEAM;
                                this.sysApi.sendAction(new ChatTextOutput(_local_7, _local_8));
                                this._sChan = this.dataApi.getChatChannel(_local_8).shortcut;
                            };
                        };
                    };
                    _local_6 = this.processLinkedItem(_local_6);
                    this._sText = _local_6;
                    this.textOutput();
                    this.inp_tchatinput.text = "";
                    if (!(this.sysApi.getOption("channelLocked", "chat")))
                    {
                        this.init();
                    }
                    else
                    {
                        for each (c2 in this._aChannels)
                        {
                            if (((!((c2 == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG))) && ((this.dataApi.getChatChannel(c2).shortcut == this._sChan))))
                            {
                                if (this.dataApi.getChatChannel(c2).isPrivate)
                                {
                                    this.init();
                                };
                            };
                        };
                    };
                    return (true);
                case ShortcutHookListEnum.EXTEND_CHAT:
                case ShortcutHookListEnum.EXTEND_CHAT2:
                    if (!(this.inp_tchatinput.haveFocus))
                    {
                        this.resize(1);
                    };
                    return (true);
                case ShortcutHookListEnum.SHRINK_CHAT:
                    if (!(this.inp_tchatinput.haveFocus))
                    {
                        this.resize(-1);
                    };
                    return (true);
                case ShortcutHookListEnum.TOGGLE_EMOTES:
                    this.sysApi.sendAction(new OpenSmileys(0));
                    if (this._smileyOpened)
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
                    }
                    else
                    {
                        this.btn_smiley.soundId = SoundEnum.WINDOW_CLOSE;
                    };
                    this._smileyOpened = !(this._smileyOpened);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_ATTITUDES:
                    this.openEmoteUi();
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_0:
                    if (this.checks_ctr.visible)
                    {
                        return (true);
                    };
                    if (this._aTabs.length > 0)
                    {
                        this._nCurrentTab = 0;
                        this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                        this.refreshChat();
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_1:
                    if (this.checks_ctr.visible)
                    {
                        return (true);
                    };
                    if (this._aTabs.length > 1)
                    {
                        this._nCurrentTab = 1;
                        this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                        this.refreshChat();
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_2:
                    if (this.checks_ctr.visible)
                    {
                        return (true);
                    };
                    if (this._aTabs.length > 2)
                    {
                        this._nCurrentTab = 2;
                        this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                        this.refreshChat();
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_TAB_3:
                    if (this.checks_ctr.visible)
                    {
                        return (true);
                    };
                    if (this._aTabs.length > 3)
                    {
                        this._nCurrentTab = 3;
                        this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                        this._aBtnTabs[this._nCurrentTab].selected = true;
                        this.refreshChat();
                    };
                    return (true);
                case ShortcutHookListEnum.NEXT_CHAT_TAB:
                    if (this.checks_ctr.visible)
                    {
                        return (true);
                    };
                    this._nCurrentTab++;
                    this._nCurrentTab = (this._nCurrentTab % this._aTabs.length);
                    this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                    this._aBtnTabs[this._nCurrentTab].selected = true;
                    this.refreshChat();
                    return (true);
                case ShortcutHookListEnum.PREVIOUS_CHAT_TAB:
                    if (this.checks_ctr.visible)
                    {
                        return (true);
                    };
                    if (this._nCurrentTab > 0)
                    {
                        this._nCurrentTab--;
                    }
                    else
                    {
                        this._nCurrentTab = (this._aTabs.length - 1);
                    };
                    this.refreshChat();
                    this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                    this._aBtnTabs[this._nCurrentTab].selected = true;
                    this.refreshChat();
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_GLOBAL:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(0), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_TEAM:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(1), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_GUILD:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(2), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_ALLIANCE:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(3), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_PARTY:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(4), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_ARENA:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(13), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_SALES:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(5), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_SEEK:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(6), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.TOGGLE_CHANNEL_FIGHT:
                    this.changeDisplayChannel(this.dataApi.getChatChannel(11), this._nCurrentTab);
                    return (true);
                case ShortcutHookListEnum.SWITCH_TEXT_SIZE:
                    switch (this._nFontSize)
                    {
                        case SMALL_SIZE:
                            this.textResize(MEDIUM_SIZE, MEDIUM_SIZE_LINE_HEIGHT);
                            break;
                        case MEDIUM_SIZE:
                            this.textResize(LARGE_SIZE, LARGE_SIZE_LINE_HEIGHT);
                            break;
                        case LARGE_SIZE:
                            this.textResize(SMALL_SIZE, SMALL_SIZE_LINE_HEIGHT);
                            break;
                    };
                    return (true);
                case ShortcutHookListEnum.CHAT_AUTOCOMPLETE:
                    if (this.inp_tchatinput.haveFocus)
                    {
                        this.autocompleteChat();
                        return (true);
                    };
                    return (false);
            };
            return (false);
        }

        public function onKeyUp(event:KeyboardEvent):void
        {
            var input:String;
            if (this.tx_focus.currentFrame == 1)
            {
                this.inp_tchatinput.focus();
            };
            if (((((!((this.sysApi.getCurrentLanguage() == "ja"))) && (!(((((((((event.altKey) || (event.shiftKey))) || (((event.hasOwnProperty("controlKey")) && (Object(event).controlKey))))) || (event.ctrlKey))) || (((event.hasOwnProperty("commandKey")) && (Object(event).commandKey)))))))) && ((event.keyCode == Keyboard.ENTER))))
            {
                this.validUiShortcut();
            }
            else
            {
                if (this.uiApi.useIME())
                {
                    this.setImeMode(null);
                };
                input = this.inp_tchatinput.text;
                if (!(this.uiApi.useIME()))
                {
                    this.inp_tchatinput.text = input;
                    if (this.inp_tchatinput.text == "")
                    {
                        this.inp_tchatinput.cssClass = this._sCssClass;
                    };
                };
                this.chanSearch(input);
            };
        }

        public function onChatSendPreInit(content:String, controler:Object):void
        {
            var i:*;
            var japString:String;
            var ijc:uint;
            var japchar:Number;
            var l:int;
            var objectUid:uint;
            var s:String;
            var c:*;
            if (controler.cancel)
            {
                this.inp_tchatinput.text = "";
                return;
            };
            var textInp:String = content;
            if ((((textInp.charAt(0) == "/")) && ((textInp.toLowerCase().indexOf((this._sChan + " ")) == 0))))
            {
                this._sText = textInp.substring((textInp.indexOf(" ") + 1), textInp.length);
            }
            else
            {
                this._sText = textInp;
            };
            if (this._sText.length == 0)
            {
                return;
            };
            this._bCurrentChannelSelected = false;
            if (this._sText.charAt(0) == String.fromCharCode(65295))
            {
                japString = "";
                ijc = 0;
                while (ijc < this._sText.length)
                {
                    japchar = this._sText.charCodeAt(ijc);
                    if ((((japchar >= 65281)) && ((japchar <= 65374))))
                    {
                        japchar = (japchar - 65248);
                    };
                    japString = (japString + String.fromCharCode(japchar));
                    ijc++;
                };
                this._sText = japString;
            };
            if ((((((((((this._sText.charAt(0) == "/")) && ((this._sText.length == textInp.length)))) && (!((this._sText.substr(0, 3).toLowerCase() == "/me"))))) && (!((this._sText.substr(0, 6).toLowerCase() == "/think"))))) && (!((((this._sText.charAt(0) == "*")) && ((this._sText.charAt((this._sText.length - 1)) == "*")))))))
            {
                this.sysApi.sendAction(new ChatCommand(this._sText.substr(1)));
                this.inp_tchatinput.text = "";
                this.addToHistory(this._sText);
                return;
            };
            var destTmp:String = this._sText.substring(0, this._sText.indexOf(" "));
            if (destTmp == "")
            {
                destTmp = this._sText;
            };
            if (((!(this.dataApi.getChatChannel(i).isPrivate)) && (((((!((destTmp.charAt(0) == "["))) && (!((destTmp.indexOf("]") == -1))))) || (((((!((destTmp.indexOf("[") == -1))) && ((destTmp.indexOf("]") == -1)))) && (!((this._sText.indexOf("]") == -1)))))))))
            {
                this._sText = ((this._sText.substring(0, this._sText.indexOf("[")) + " ") + this._sText.substring(this._sText.indexOf("["), this._sText.length));
                this._sText = this.trim(this._sText);
            }
            else
            {
                if ((((destTmp.charAt(0) == "[")) && (!((destTmp.indexOf("]") == destTmp.lastIndexOf("]"))))))
                {
                    this._sText = ((this._sText.substring(0, this._sText.lastIndexOf("[")) + " ") + this._sText.substring(this._sText.lastIndexOf("["), this._sText.length));
                    this._sText = this.trim(this._sText);
                };
            };
            var links:Object = this.inp_tchatinput.getHyperLinkCodes();
            var numLinks:uint = ((links) ? links.length : 0);
            if (numLinks > 0)
            {
                this._aItemReplacement = [];
                l = 0;
                while (l < numLinks)
                {
                    s = links[l].split(",")[1];
                    objectUid = uint(s.substring(0, s.indexOf("}")));
                    if (this._dItemIndex[objectUid])
                    {
                        this._aItemReplacement.push(this._dItemIndex[objectUid]);
                    };
                    l++;
                };
            };
            var historyText:String = this._sText;
            this._sText = this.getHyperlinkFormatedText(this._sText);
            for each (i in this._aChannels)
            {
                if (this._sChan == this.dataApi.getChatChannel(i).shortcut)
                {
                    if (!(this.dataApi.getChatChannel(i).isPrivate))
                    {
                        if (this._aItemReplacement.length)
                        {
                            this.sysApi.sendAction(new ChatTextOutput(this._sText, i, this._sDest, this._aItemReplacement));
                        }
                        else
                        {
                            this.sysApi.sendAction(new ChatTextOutput(this._sText, i, this._sDest));
                        };
                    }
                    else
                    {
                        this._sDest = this._sText.substring(0, this._sText.indexOf(" "));
                        this._sText = this._sText.substring((this._sText.indexOf(" ") + 1), this._sText.length);
                        historyText = historyText.substring((historyText.indexOf(" ") + 1), historyText.length);
                        if (this._sDest.length != 0)
                        {
                            if (this._aItemReplacement.length)
                            {
                                this.sysApi.sendAction(new ChatTextOutput(this._sText, i, this._sDest, this._aItemReplacement));
                            }
                            else
                            {
                                this.sysApi.sendAction(new ChatTextOutput(this._sText, i, this._sDest));
                            };
                        };
                    };
                };
            };
            this._privateHistory.resetCursor();
            historyText = this.processLinkedItem(historyText);
            this._sText = historyText;
            this._aItemReplacement = new Array();
            this.textOutput();
            this.inp_tchatinput.text = "";
            if (!(this.sysApi.getOption("channelLocked", "chat")))
            {
                this.init();
            }
            else
            {
                for each (c in this._aChannels)
                {
                    if (((!((c == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG))) && ((this.dataApi.getChatChannel(c).shortcut == this._sChan))))
                    {
                        if (this.dataApi.getChatChannel(c).isPrivate)
                        {
                            this.init();
                        };
                    };
                };
            };
        }

        public function onChatServer(channel:uint=0, senderId:uint=0, senderName:String="", content:String="", timestamp:Number=0, fingerprint:String="", admin:Boolean=false):void
        {
            this.formatLine(channel, content, timestamp, fingerprint, senderId, senderName, null, "", 0, false, admin);
        }

        public function onChatServerWithObject(channel:uint=0, senderId:uint=0, senderName:String="", content:String="", timestamp:Number=0, fingerprint:String="", objects:Object=null):void
        {
            this.formatLine(channel, content, timestamp, fingerprint, senderId, senderName, objects);
        }

        public function onChatServerCopy(channel:uint=0, receiverName:String="", content:String="", timestamp:Number=0, fingerprint:String="", receiverId:uint=0):void
        {
            this.formatLine(channel, content, timestamp, fingerprint, 0, "", null, receiverName, receiverId);
        }

        public function onChatServerCopyWithObject(channel:uint=0, receiverName:String="", content:String="", timestamp:Number=0, fingerprint:String="", receiverId:uint=0, objects:Object=null):void
        {
            this.formatLine(channel, content, timestamp, fingerprint, 0, "", objects, receiverName, receiverId);
        }

        public function onChatSpeakingItem(channel:uint=0, item:Object=null, content:String="", timestamp:Number=0, fingerprint:String=""):void
        {
            this.sysApi.sendAction(new SaveMessage(((item.name + this.uiApi.getText("ui.common.colon")) + content), channel, timestamp));
            this.formatLine(channel, content, timestamp, fingerprint, 0, item.name, null, "", 0, true);
        }

        public function onLivingObjectMessage(owner:String="", text:String="", timestamp:Number=0):void
        {
            this.sysApi.sendAction(new SaveMessage(((owner + this.uiApi.getText("ui.common.colon")) + text), 0, timestamp));
            this.formatLine(0, text, timestamp, "", 0, owner, null, "", 0, true);
        }

        public function onTextInformation(content:String="", channel:int=0, timestamp:Number=0, saveMsg:Boolean=true, forceDisplay:Boolean=false):void
        {
            if (content == "")
            {
                this.sysApi.log(16, "Le message d'information est vide, il ne sera pas affiché.");
            }
            else
            {
                if (channel == 2)
                {
                    this.soundApi.playSoundById("16109");
                };
                if (saveMsg)
                {
                    this.sysApi.sendAction(new SaveMessage(content, channel, timestamp));
                };
                this.formatLine(channel, content, timestamp, "", 0, "", null, "", 0, false, false, forceDisplay);
            };
        }

        public function onTextActionInformation(textKey:uint=0, params:Array=null, channel:int=0, timestamp:Number=0):void
        {
            var content:String = this.uiApi.getTextFromKey(textKey, null, params);
            content = this.uiApi.processText(content, "n", false);
            this.formatLine(channel, content, timestamp);
        }

        public function onTabPictoChange(tab:uint, name:String=null):void
        {
            this._aTabsPicto[(tab - 1)] = name;
            this.uiApi.me().getElement(("bgTexture" + this._aBtnTabs[(tab - 1)].name)).uri = this.uiApi.createUri(((this.uiApi.me().getConstant("tab_uri") + "") + name));
            this.sysApi.sendAction(new TabsUpdate(null, this._aTabsPicto));
        }

        public function onChannelEnablingChange(channel:uint=0, enable:Boolean=false):void
        {
            if (this._bChanCheckChange)
            {
                this._bChanCheckChange = false;
            };
        }

        public function onEnabledChannels(channels:Object):void
        {
            var tabs:*;
            var tmpChanel:Object;
            var cc:*;
            var chans:Array;
            var c:*;
            var temp:Array;
            var chan:*;
            var defaultChan:Object;
            var currentChannels:Array;
            var tab:*;
            var i:*;
            var j:*;
            var chan2:*;
            var aTabs:Array = new Array();
            for each (tabs in this._aTabs)
            {
                temp = new Array();
                for each (chan in tabs)
                {
                    if (this.chatApi.getDisallowedChannelsId().indexOf(chan) == -1)
                    {
                        temp.push(chan);
                    };
                };
                aTabs.push(temp);
            };
            this._aTabs = aTabs;
            tmpChanel = this.chatApi.getChannelsId();
            this._aChannels = new Array();
            for each (cc in tmpChanel)
            {
                this._aChannels.push(cc);
            };
            chans = new Array();
            for each (c in channels)
            {
                chans.push(c);
            };
            if (chans.length)
            {
                currentChannels = new Array();
                if (this._aTabs.length == 0)
                {
                    this._aTabs = this.sysApi.getOption("channelTabs", "chat");
                };
                for each (tab in this._aTabs)
                {
                    for each (chan2 in tab)
                    {
                        if (currentChannels[chan2] == undefined)
                        {
                            currentChannels[chan2] = 1;
                        };
                    };
                };
                for each (i in chans)
                {
                    if (currentChannels[i] == undefined)
                    {
                        this.sysApi.sendAction(new ChannelEnabling(i, false));
                    }
                    else
                    {
                        currentChannels[i] = null;
                    };
                };
                for (j in currentChannels)
                {
                    if (((!((currentChannels[j] == null))) && (!((j == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)))))
                    {
                        if (chans.indexOf(j) == -1)
                        {
                            this.sysApi.sendAction(new ChannelEnabling(j, true));
                        };
                    };
                };
            };
        }

        public function onUpdateChatOptions():void
        {
            var canal:*;
            var expertMode:Boolean;
            var tab:*;
            for each (canal in this._aChannels)
            {
                if (canal != ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)
                {
                    this.texta_tchat.setCssColor(("#" + this.configApi.getConfigProperty("chat", ("channelColor" + canal)).toString(16)), ("p" + canal));
                };
                if (this.dataApi.getChatChannel(canal).shortcut == this._sChan)
                {
                    this.updateChanColor(canal);
                };
            };
            expertMode = this.sysApi.getOption("chatExpertMode", "chat");
            if (expertMode)
            {
                this.switchNoobyMode(false);
                this.setTabsChannels();
            };
            if (!(expertMode))
            {
                this.switchNoobyMode(true);
            };
            if (this.checks_ctr.visible)
            {
                this.colorCheckBox();
            };
            for (tab in this._aTabs)
            {
                delete this._tabsCache[tab];
            };
            this.refreshChat();
        }

        public function onChatSmiley(smileyId:uint, entityId:uint):void
        {
            if (((this.sysApi.getOption("smileysAutoclosed", "chat")) && ((entityId == this.playerApi.id()))))
            {
                this.btn_smiley.selected = false;
                this.btn_emote.selected = false;
            };
        }

        private function openEmoteUi():void
        {
            this.sysApi.sendAction(new OpenSmileys(1));
            if (this._emoteOpened)
            {
                this.btn_emote.soundId = SoundEnum.WINDOW_OPEN;
            }
            else
            {
                this.btn_emote.soundId = SoundEnum.WINDOW_CLOSE;
            };
            this._emoteOpened = !(this._emoteOpened);
        }

        private function onToggleChatLog(enable:Boolean=true):void
        {
        }

        private function onClearChat():void
        {
            this.texta_tchat.clearText();
            delete this._tabsCache[this._nCurrentTab];
            this.sysApi.sendAction(new ClearChat(this._aTabs[this._nCurrentTab]));
        }

        private function onChatRollOverLink(target:*, pHref:String):void
        {
            var data:Object = this.uiApi.textTooltipInfo(pHref, null, null, 400);
            this.uiApi.showTooltip(data, target, false, "standard", 0, 0, 3, null, null, null, "TextInfo");
        }

        public function onNewMessage(chanId:int, removedSentence:uint=0):void
        {
            var tab:*;
            for (tab in this._aTabs)
            {
                if (((((!((this._aTabs[tab].indexOf(chanId) == -1))) && (!((tab == this._nCurrentTab))))) && ((this._aTabs[this._nCurrentTab].indexOf(chanId) == -1))))
                {
                    this._aTxHighlights[tab].gotoAndStop = "highlight";
                };
            };
            if (this.texta_tchat.type == ChatComponentHandler.CHAT_NORMAL)
            {
                this.chatApi.removeLinesFromHistory(removedSentence, chanId);
            };
        }

        public function onChatFocus(name:String=""):void
        {
            var position:int;
            if (name)
            {
                this.inp_tchatinput.text = (("/w " + name) + " ");
                position = this.inp_tchatinput.text.length;
                this.inp_tchatinput.setSelection(position, position);
                this.chanSearch("/w ");
            };
            this.inp_tchatinput.focus();
            this.inp_tchatinput.caretIndex = -1;
        }

        public function onRightClick(target:Object):void
        {
            switch (target)
            {
                case this.btn_tab0:
                case this.btn_tab1:
                case this.btn_tab2:
                case this.btn_tab3:
                    if (!(this.checks_ctr.visible))
                    {
                        this.addChannelsContextMenu(int(target.name.substr(7, 1)));
                    };
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var point:uint;
            var relPoint:uint;
            var chatChannel:Object;
            var chan0:*;
            var chan1:*;
            var chan2:*;
            var chan3:*;
            var data:Object;
            var tooltipText:String = "";
            var shortcutKey:String;
            var maxWidth:int;
            point = 7;
            relPoint = 1;
            switch (target)
            {
                case this.btn_smiley:
                    tooltipText = this.uiApi.getText("ui.chat.smilies");
                    shortcutKey = this.bindsApi.getShortcutBindStr("toggleEmotes").toString();
                    break;
                case this.btn_emote:
                    tooltipText = this.uiApi.getText("ui.common.emotes");
                    shortcutKey = this.bindsApi.getShortcutBindStr("toggleAttitudes").toString();
                    break;
                case this.btn_plus:
                    tooltipText = this.uiApi.getText("ui.chat.resize.plus");
                    shortcutKey = this.bindsApi.getShortcutBindStr("extendChat").toString();
                    maxWidth = 240;
                    break;
                case this.btn_minus:
                    tooltipText = this.uiApi.getText("ui.chat.resize.minus");
                    shortcutKey = this.bindsApi.getShortcutBindStr("shrinkChat").toString();
                    maxWidth = 240;
                    break;
                case this.btn_menu:
                    tooltipText = this.uiApi.getText("ui.option.chat");
                    break;
                case this.btn_tab0:
                    for each (chan0 in this._aTabs[0])
                    {
                        chatChannel = this.dataApi.getChatChannel(chan0);
                        tooltipText = (tooltipText + (chatChannel.name + "\n"));
                    };
                    break;
                case this.btn_tab1:
                    for each (chan1 in this._aTabs[1])
                    {
                        chatChannel = this.dataApi.getChatChannel(chan1);
                        tooltipText = (tooltipText + (chatChannel.name + "\n"));
                    };
                    break;
                case this.btn_tab2:
                    for each (chan2 in this._aTabs[2])
                    {
                        chatChannel = this.dataApi.getChatChannel(chan2);
                        tooltipText = (tooltipText + (chatChannel.name + "\n"));
                    };
                    break;
                case this.btn_tab3:
                    for each (chan3 in this._aTabs[3])
                    {
                        chatChannel = this.dataApi.getChatChannel(chan3);
                        tooltipText = (tooltipText + (chatChannel.name + "\n"));
                    };
                    break;
                case this.btn_check0:
                    tooltipText = this.uiApi.getText("ui.chat.check0");
                    maxWidth = 400;
                    break;
                case this.btn_check1:
                    tooltipText = this.uiApi.getText("ui.chat.check941");
                    maxWidth = 400;
                    break;
                case this.btn_check2:
                    tooltipText = this.uiApi.getText("ui.chat.check1011");
                    maxWidth = 400;
                    break;
                case this.btn_check3:
                    tooltipText = this.uiApi.getText("ui.chat.check2");
                    maxWidth = 400;
                    break;
                case this.btn_check4:
                    tooltipText = this.uiApi.getText("ui.chat.check3");
                    maxWidth = 400;
                    break;
                case this.btn_check5:
                    tooltipText = this.uiApi.getText("ui.chat.check5");
                    maxWidth = 400;
                    break;
                case this.btn_check6:
                    tooltipText = this.uiApi.getText("ui.chat.check6");
                    maxWidth = 400;
                    break;
                case this.btn_check7:
                    tooltipText = this.uiApi.getText("ui.chat.check12");
                    maxWidth = 400;
                    break;
                case this.btn_status:
                    switch (_currentStatus)
                    {
                        case PlayerStatusEnum.PLAYER_STATUS_AFK:
                            if (this._awayMessage != "")
                            {
                                tooltipText = ((this.uiApi.getText("ui.chat.status.away") + this.uiApi.getText("ui.common.colon")) + this._awayMessage);
                            }
                            else
                            {
                                tooltipText = this.uiApi.getText("ui.chat.status.away");
                            };
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                            tooltipText = this.uiApi.getText("ui.chat.status.idle");
                        case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                            tooltipText = this.uiApi.getText("ui.chat.status.private");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                            tooltipText = this.uiApi.getText("ui.chat.status.solo");
                            break;
                        case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                            tooltipText = this.uiApi.getText("ui.chat.status.availiable");
                            break;
                    };
                    maxWidth = 400;
                    break;
            };
            if (tooltipText != "")
            {
                if (shortcutKey)
                {
                    if (!(_shortcutColor))
                    {
                        _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                        _shortcutColor = _shortcutColor.replace("0x", "#");
                    };
                    data = this.uiApi.textTooltipInfo((((((tooltipText + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"), null, null, maxWidth);
                }
                else
                {
                    data = this.uiApi.textTooltipInfo(tooltipText, null, null, maxWidth);
                };
                this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        private function onFocusTimer(e:Event):void
        {
            this.inp_tchatinput.focus();
            this._focusTimer.stop();
            this._focusTimer.reset();
        }

        private function onChatHyperlink(hyperLinkCode:String):void
        {
            var hyperlinkInfo:Array = hyperLinkCode.split(",");
            var staticHyperlink:String = this.chatApi.getStaticHyperlink(hyperLinkCode);
            if ((((((((((((hyperlinkInfo[0] == "{spell")) || ((hyperlinkInfo[0] == "{recipe")))) || ((hyperlinkInfo[0] == "{chatachievement")))) || ((hyperlinkInfo[0] == "{chatmonster")))) || ((hyperlinkInfo[0] == "{guild")))) || ((hyperlinkInfo[0] == "{alliance"))))
            {
                this._aMiscReplacement.push(staticHyperlink, hyperLinkCode);
            };
            this.inp_tchatinput.appendText((staticHyperlink + " "));
            this.inp_tchatinput.focus();
            this.inp_tchatinput.caretIndex = -1;
        }

        private function onChatWarning():void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.warningForbiddenLink"), [this.uiApi.getText("ui.common.ok")], [], null, null, null, true, true);
        }

        private function onChatLinkRelease(link:String, sender:uint, senderName:String):void
        {
            this.sysApi.goToCheckLink(link, sender, senderName);
        }

        private function onPopupWarning(author:String, content:String, duration:uint):void
        {
            var msg:String = ((author + this.uiApi.getText("ui.common.colon")) + content);
            this.modCommon.openLockedPopup(this.uiApi.getText("ui.common.informations"), msg, null, false, false, [duration.toString()], false, true);
        }

        private function onMouseShiftClick(target:Object):void
        {
            var data:Object = target.data;
            if (data)
            {
                if ((data is ShortcutWrapper))
                {
                    data = (data as ShortcutWrapper).realItem;
                };
                if (((data.hasOwnProperty("isPresetObject")) && (data.isPresetObject)))
                {
                    return;
                };
                if (((data.hasOwnProperty("objectUID")) && ((data.objectUID == 0))))
                {
                    return;
                };
                if ((((((data is SmileyWrapper)) || ((data is EmoteWrapper)))) || ((data is ButtonWrapper))))
                {
                    return;
                };
                this.onInsertHyperlink(data);
            };
        }

        private function onFocusChange(target:Object):void
        {
            if ((((target == this.inp_tchatinput)) || ((target == this.inp_tchatinput.textfield))))
            {
                this.tx_focus.gotoAndStop = 2;
            }
            else
            {
                this.tx_focus.gotoAndStop = 1;
            };
        }

        public function onEmoteUnabledListUpdated(emotesOk:Object):void
        {
            if (emotesOk.length == 0)
            {
                this.btn_emote.disabled = true;
                if (this.uiApi.getUi(UIEnum.SMILEY_UI))
                {
                    this.uiApi.unloadUi(UIEnum.SMILEY_UI);
                };
            }
            else
            {
                this.btn_emote.disabled = false;
            };
        }

        public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int):void
        {
            if (isSpectator)
            {
                if (this._sChanLocked == this._sChanLockedBeforeSpec)
                {
                    if (this.sysApi.getOption("channelLocked", "chat"))
                    {
                        this.changeDefaultChannel(this.dataApi.getChatChannel(1).shortcut);
                    };
                };
            };
        }

        public function onGameFightLeave(id:int):void
        {
            if ((((id == this.playerApi.id())) && ((this._sChanLocked == this.dataApi.getChatChannel(1).shortcut))))
            {
                if (this.sysApi.getOption("channelLocked", "chat"))
                {
                    this.changeDefaultChannel(this.dataApi.getChatChannel(0).shortcut);
                };
            };
        }

        private function onInsertRecipeHyperlink(id:uint):void
        {
            this.onInsertHyperlink(id, true);
        }

        private function onInsertHyperlink(data:Object, isRecipe:Boolean=false):void
        {
            var staticHyperlink:String;
            var hyperLinkCode:String;
            var linkInChat:String;
            if (data.hasOwnProperty("objectUID"))
            {
                if (this._aItemReplacement.length >= MAX_CHAT_ITEMS)
                {
                    return;
                };
                hyperLinkCode = (("{item," + data.objectGID) + "}");
                staticHyperlink = this.chatApi.getStaticHyperlink(hyperLinkCode);
                this._aItemReplacement.push(data);
                this._dItemIndex[data.objectUID] = data;
                this.inp_tchatinput.addHyperLinkCode((("{item," + data.objectUID) + "}"));
            }
            else
            {
                if (isRecipe)
                {
                    hyperLinkCode = (("{recipe," + data) + "}");
                }
                else
                {
                    if ((data is Achievement))
                    {
                        hyperLinkCode = (("{chatachievement," + data.id) + "}");
                    }
                    else
                    {
                        if ((data is Monster))
                        {
                            hyperLinkCode = (("{chatmonster," + data.id) + "}");
                        }
                        else
                        {
                            if ((data is AllianceWrapper))
                            {
                                hyperLinkCode = this.chatApi.getAllianceLink(data);
                            }
                            else
                            {
                                if ((data is GuildFactSheetWrapper))
                                {
                                    hyperLinkCode = this.chatApi.getGuildLink(data);
                                }
                                else
                                {
                                    if (data.hasOwnProperty("spellLevel"))
                                    {
                                        hyperLinkCode = (((("{spell," + data.id) + ",") + data.spellLevel) + "}");
                                    };
                                };
                            };
                        };
                    };
                };
                staticHyperlink = this.chatApi.getStaticHyperlink(hyperLinkCode);
                this._aMiscReplacement.push(staticHyperlink, hyperLinkCode);
            };
            this.inp_tchatinput.appendText((staticHyperlink + " "));
            this.inp_tchatinput.focus();
            this.inp_tchatinput.caretIndex = -1;
        }

        private function onActivateSmilies():void
        {
            this.texta_tchat.activeSmilies();
        }

        private function autocompleteChat():void
        {
            var subString:String;
            var text:String = this.inp_tchatinput.text;
            var i:int = (text.length - 1);
            while (i >= 0)
            {
                if (text.charAt(i) == " ")
                {
                    text = text.substr(0, i);
                }
                else
                {
                    break;
                };
                i--;
            };
            var lidx:int = text.lastIndexOf(" ");
            if ((((((lidx == -1)) || (!((text.substr(0, lidx).indexOf(" ") == -1))))) || (!((text.charAt(0) == "/")))))
            {
                return;
            };
            subString = text.substr((lidx + 1));
            if (subString.length == 0)
            {
                return;
            };
            if (((!(this._autocompletionLastCompletion)) || (!((this._autocompletionLastCompletion == subString)))))
            {
                this._autocompletionCount = 0;
                this._autocompletionSubString = subString;
            };
            var autocompletion:String = this.chatApi.getAutocompletion(this._autocompletionSubString, this._autocompletionCount);
            if ((((autocompletion == null)) && ((this._autocompletionCount > 0))))
            {
                this._autocompletionCount = 0;
                autocompletion = this.chatApi.getAutocompletion(this._autocompletionSubString, this._autocompletionCount);
            };
            if (autocompletion == null)
            {
                return;
            };
            this._autocompletionLastCompletion = autocompletion;
            this._autocompletionCount++;
            this.inp_tchatinput.text = ((text.substring(0, (lidx + 1)) + autocompletion) + " ");
            this.inp_tchatinput.caretIndex = -1;
        }

        private function onChatChange(e:Event):void
        {
            if (this._delayWaitingMessage)
            {
                e.target.text = this._lastText;
            }
            else
            {
                this._lastText = e.target.text;
            };
        }

        private function onStatusChange(status:uint, message:String=""):void
        {
            if (message == "")
            {
                Api.system.sendAction(new PlayerStatusUpdateRequest(status));
                this._awayMessage = "";
            }
            else
            {
                Api.system.sendAction(new PlayerStatusUpdateRequest(status, message));
                this.onNewAwayMessage(message);
            };
        }

        private function onStatusChangeWithMessage(status:uint):void
        {
            var oldMsg:Array = this.sysApi.getData("oldAwayMessage");
            this.modCommon.openInputComboBoxPopup(this.uiApi.getText("ui.popup.status.awaytitle"), this.uiApi.getText("ui.popup.status.awaymessage"), this.uiApi.getText("ui.popup.status.wipeAwayMessageHistory"), this.onSubmitAwayMessage, null, this.onResetAwayMessage, "", null, 360, oldMsg);
        }

        private function onSubmitAwayMessage(value:String):void
        {
            this.onStatusChange(PlayerStatusEnum.PLAYER_STATUS_AFK, value);
        }

        private function onResetAwayMessage():void
        {
            this.sysApi.setData("oldAwayMessage", [], false);
        }

        private function onPlayerStatusUpdate(accountId:uint, playerId:uint, status:uint):void
        {
            var statusName:String;
            if (playerId == this.playerApi.id())
            {
                switch (status)
                {
                    case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                        this.bgTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "|available"));
                        statusName = this.uiApi.getText("ui.chat.status.availiable");
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_AFK:
                    case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                        this.bgTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "|away"));
                        statusName = this.uiApi.getText("ui.chat.status.away");
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                        this.bgTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "|private"));
                        statusName = this.uiApi.getText("ui.chat.status.private");
                        break;
                    case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                        this.bgTexturebtn_status.uri = this.uiApi.createUri((this._iconsPath + "|solo"));
                        statusName = this.uiApi.getText("ui.chat.status.solo");
                        break;
                };
                if (status != PlayerStatusEnum.PLAYER_STATUS_IDLE)
                {
                    _currentStatus = status;
                };
                this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.chat.status.statuschange", [statusName]), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, this.timeApi.getTimestamp());
            };
        }

        private function onNewAwayMessage(message:String):void
        {
            var oldMsg:Array;
            var i:int;
            if (message != "")
            {
                oldMsg = this.sysApi.getData("oldAwayMessage");
                if (!(oldMsg))
                {
                    oldMsg = new Array();
                }
                else
                {
                    if (oldMsg.length > 10)
                    {
                        oldMsg.pop();
                    };
                };
                i = 0;
                while (i < oldMsg.length)
                {
                    if (oldMsg[i] == message)
                    {
                        oldMsg.splice(i, 1);
                        break;
                    };
                    i++;
                };
                oldMsg.unshift(message);
            };
            this.sysApi.setData("oldAwayMessage", oldMsg, false);
            this._awayMessage = message;
        }

        private function onInactivityNotification(inactive:Boolean):void
        {
            if (((((inactive) && (!((_currentStatus == PlayerStatusEnum.PLAYER_STATUS_AFK))))) && (!(this._idle))))
            {
                this._idle = true;
                this.onStatusChange(PlayerStatusEnum.PLAYER_STATUS_IDLE);
            }
            else
            {
                if (((!(inactive)) && (this._idle)))
                {
                    this._idle = false;
                    this.onStatusChange(_currentStatus, this._awayMessage);
                };
            };
        }

        private function trim(s:String):String
        {
            var start:int;
            while ((((start < s.length)) && ((((((((s.charAt(start) == " ")) || ((s.charAt(start) == "\n")))) || ((s.charAt(start) == "\t")))) || ((s.charAt(start) == "\r"))))))
            {
                start++;
            };
            var end:int = (s.length - 1);
            while ((((end >= 0)) && ((((((((s.charAt(end) == " ")) || ((s.charAt(end) == "\n")))) || ((s.charAt(end) == "\t")))) || ((s.charAt(end) == "\r"))))))
            {
                end--;
            };
            if ((end - start) == 0)
            {
                return ("");
            };
            return (s.substring(start, (end + 1)));
        }


    }
}//package ui

