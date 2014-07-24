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
   import d2enums.EventEnums;
   import d2enums.ShortcutHookListEnum;
   import d2enums.BuildTypeEnum;
   import flash.events.Event;
   import d2hooks.*;
   import d2actions.*;
   import flash.events.TimerEvent;
   import flash.text.AntiAliasType;
   import flash.events.KeyboardEvent;
   import d2enums.ChatActivableChannelsEnum;
   import d2data.ItemWrapper;
   import flash.geom.ColorTransform;
   import flash.system.IMEConversionMode;
   import flash.system.IME;
   import flash.ui.Keyboard;
   import d2data.ShortcutWrapper;
   import d2data.SmileyWrapper;
   import d2data.EmoteWrapper;
   import d2data.ButtonWrapper;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import d2data.Achievement;
   import d2data.Monster;
   import d2data.AllianceWrapper;
   import d2data.GuildFactSheetWrapper;
   
   public class Chat extends Object
   {
      
      public function Chat() {
         this._aMiscReplacement = new Array();
         this._aItemReplacement = new Array();
         this._dItemIndex = new Dictionary();
         this._focusTimer = new Timer(1,1);
         this._timerLowQuality = new Timer(100,1);
         super();
      }
      
      private static var _shortcutColor:String;
      
      private static const SMALL_SIZE:uint = 14;
      
      private static const SMALL_SIZE_LINE_HEIGHT:uint = 15.0;
      
      private static const MEDIUM_SIZE:uint = 16;
      
      private static const MEDIUM_SIZE_LINE_HEIGHT:uint = 18.0;
      
      private static const LARGE_SIZE:uint = 19;
      
      private static const LARGE_SIZE_LINE_HEIGHT:uint = 22.0;
      
      private static const ITEM_INDEX_CODE:String;
      
      private static const MAX_CHAT_ITEMS:int = 16;
      
      private static var _currentStatus:int = 10;
      
      public var output:Object;
      
      public var bindsApi:BindsApi;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var timeApi:TimeApi;
      
      public var dataApi:DataApi;
      
      public var chatApi:ChatApi;
      
      public var configApi:ConfigApi;
      
      public var tooltipApi:TooltipApi;
      
      public var modCommon:Object;
      
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
      
      public var btn_shop:ButtonContainer;
      
      public function main(args:Array) : void {
         var c:* = undefined;
         var iTab:* = 0;
         var name:* = undefined;
         var canal:* = undefined;
         var tabs:* = undefined;
         var temp:Array = null;
         var chan:* = undefined;
         var obj:* = undefined;
         var lh:uint = 0;
         this.btn_plus.soundId = SoundEnum.WINDOW_OPEN;
         this.btn_minus.soundId = SoundEnum.WINDOW_OPEN;
         this.btn_menu.soundId = SoundEnum.WINDOW_OPEN;
         this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
         this.btn_emote.soundId = SoundEnum.WINDOW_OPEN;
         this.sysApi.createHook("InsertHyperlink");
         this.sysApi.addHook(ChatServer,this.onChatServer);
         this.sysApi.addHook(NewMessage,this.onNewMessage);
         this.sysApi.addHook(ChatSendPreInit,this.onChatSendPreInit);
         this.sysApi.addHook(ChatServerWithObject,this.onChatServerWithObject);
         this.sysApi.addHook(ChatServerCopy,this.onChatServerCopy);
         this.sysApi.addHook(ChatServerCopyWithObject,this.onChatServerCopyWithObject);
         this.sysApi.addHook(ChatSpeakingItem,this.onChatSpeakingItem);
         this.sysApi.addHook(TextActionInformation,this.onTextActionInformation);
         this.sysApi.addHook(TextInformation,this.onTextInformation);
         this.sysApi.addHook(ChannelEnablingChange,this.onChannelEnablingChange);
         this.sysApi.addHook(EnabledChannels,this.onEnabledChannels);
         this.sysApi.addHook(UpdateChatOptions,this.onUpdateChatOptions);
         this.sysApi.addHook(ChatSmiley,this.onChatSmiley);
         this.sysApi.addHook(ChatFocus,this.onChatFocus);
         this.sysApi.addHook(MouseShiftClick,this.onMouseShiftClick);
         this.sysApi.addHook(FocusChange,this.onFocusChange);
         this.sysApi.addHook(InsertHyperlink,this.onInsertHyperlink);
         this.sysApi.addHook(InsertRecipeHyperlink,this.onInsertRecipeHyperlink);
         this.sysApi.addHook(ChatHyperlink,this.onChatHyperlink);
         this.sysApi.addHook(AddItemHyperlink,this.onInsertHyperlink);
         this.sysApi.addHook(LivingObjectMessage,this.onLivingObjectMessage);
         this.sysApi.addHook(ChatWarning,this.onChatWarning);
         this.sysApi.addHook(PopupWarning,this.onPopupWarning);
         this.sysApi.addHook(ChatLinkRelease,this.onChatLinkRelease);
         this.sysApi.addHook(EmoteUnabledListUpdated,this.onEmoteUnabledListUpdated);
         this.sysApi.addHook(GameFightLeave,this.onGameFightLeave);
         this.sysApi.addHook(GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(ToggleChatLog,this.onToggleChatLog);
         this.sysApi.addHook(d2hooks.ClearChat,this.onClearChat);
         this.sysApi.addHook(ChatRollOverLink,this.onChatRollOverLink);
         this.sysApi.addHook(ShowSmilies,this.onActivateSmilies);
         this.sysApi.addHook(PlayerStatusUpdate,this.onPlayerStatusUpdate);
         this.sysApi.addHook(InactivityNotification,this.onInactivityNotification);
         this.sysApi.addHook(NewAwayMessage,this.onNewAwayMessage);
         this.uiApi.addComponentHook(this.btn_tab0,EventEnums.EVENT_ONROLLOVER);
         this.uiApi.addComponentHook(this.btn_tab0,EventEnums.EVENT_ONROLLOUT);
         this.uiApi.addComponentHook(this.btn_tab0,EventEnums.EVENT_ONRIGHTCLICK);
         this.uiApi.addComponentHook(this.btn_tab1,EventEnums.EVENT_ONROLLOVER);
         this.uiApi.addComponentHook(this.btn_tab1,EventEnums.EVENT_ONROLLOUT);
         this.uiApi.addComponentHook(this.btn_tab1,EventEnums.EVENT_ONRIGHTCLICK);
         this.uiApi.addComponentHook(this.btn_tab2,EventEnums.EVENT_ONROLLOVER);
         this.uiApi.addComponentHook(this.btn_tab2,EventEnums.EVENT_ONROLLOUT);
         this.uiApi.addComponentHook(this.btn_tab2,EventEnums.EVENT_ONRIGHTCLICK);
         this.uiApi.addComponentHook(this.btn_tab3,EventEnums.EVENT_ONROLLOVER);
         this.uiApi.addComponentHook(this.btn_tab3,EventEnums.EVENT_ONROLLOUT);
         this.uiApi.addComponentHook(this.btn_tab3,EventEnums.EVENT_ONRIGHTCLICK);
         this.uiApi.addComponentHook(this.btn_status,EventEnums.EVENT_ONROLLOVER);
         this.uiApi.addComponentHook(this.btn_status,EventEnums.EVENT_ONROLLOUT);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.HISTORY_UP,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.HISTORY_DOWN,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_UP,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_DOWN,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHIFT_VALID,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.ALT_VALID,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CTRL_VALID,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.EXTEND_CHAT2,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SHRINK_CHAT,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_EMOTES,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_ATTITUDES,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_0,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_1,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_2,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_TAB_3,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.NEXT_CHAT_TAB,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.PREVIOUS_CHAT_TAB,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CHAT_AUTOCOMPLETE,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_GLOBAL,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_TEAM,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_GUILD,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_ALLIANCE,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_PARTY,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_ARENA,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_SALES,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_SEEK,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_CHANNEL_FIGHT,this.onShortcut,true);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.SWITCH_TEXT_SIZE,this.onShortcut,true);
         this.uiApi.addShortcutHook("focusChat",this.onShortcut);
         if(this.sysApi.getBuildType() < BuildTypeEnum.TESTING)
         {
            this.btn_shop.visible = false;
         }
         if(this.sysApi.getCurrentLanguage() == "ja")
         {
            this.inp_tchatinput.useEmbedFonts = false;
         }
         this.inp_tchatinput.textfield.addEventListener(Event.CHANGE,this.onChatChange);
         this._focusTimer.addEventListener(TimerEvent.TIMER,this.onFocusTimer);
         this._aCheckChans = new Array([0],[9,1,4,13],[10,11],[2],[3],[5],[6],[12]);
         this._aCheckColors = new Array(this.tx_checkColor0,this.tx_checkColor1,this.tx_checkColor2,this.tx_checkColor3,this.tx_checkColor4,this.tx_checkColor5,this.tx_checkColor6,this.tx_checkColor7);
         this._aChecks = new Array(this.btn_check0,this.btn_check1,this.btn_check2,this.btn_check3,this.btn_check4,this.btn_check5,this.btn_check6,this.btn_check7);
         if(this.uiApi.useIME())
         {
            this.btn_ime.visible = true;
            this.uiApi.addComponentHook(this.btn_ime,EventEnums.EVENT_ONRELEASE);
            this.setImeMode(null);
            this.inp_tchatinput.width = this.inp_tchatinput.width - this.btn_ime.width;
            this.btn_status.x = this.btn_ime.x - 25;
         }
         else
         {
            this.btn_ime.visible = false;
         }
         this.texta_tchat = new ChatComponentHandler(ChatComponentHandler.CHAT_NORMAL,this.realTchatCtr);
         this.tx_focus.mouseEnabled = false;
         this.tx_focus.mouseChildren = false;
         this._sFrom = this.uiApi.getText("ui.chat.from");
         this._sTo = this.uiApi.getText("ui.chat.to");
         this._aHistory = this.sysApi.getData("aTchatHistory");
         if(this._aHistory == null)
         {
            this._aHistory = new Array();
         }
         this._nHistoryIndex = this._aHistory.length;
         this._privateHistory = new PrivateHistory(this._maxCmdHistoryIndex);
         this.inp_tchatinput.html = false;
         this.inp_tchatinput.maxChars = 256;
         this.inp_tchatinput.antialias = AntiAliasType.ADVANCED;
         this.inp_tchatinput.textfield.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this._aTxHighlights = [this.tx_tab0,this.tx_tab1,this.tx_tab2,this.tx_tab3];
         this._aBtnTabs = [this.btn_tab0,this.btn_tab1,this.btn_tab2,this.btn_tab3];
         var tmpChanel:Object = this.chatApi.getChannelsId();
         this._aChannels = new Array();
         for each(c in tmpChanel)
         {
            this._aChannels.push(c);
         }
         this._aTabs = new Array();
         iTab = 0;
         while(iTab < 4)
         {
            tabs = this.sysApi.getOption("channelTabs","chat")[iTab];
            temp = new Array();
            if(tabs)
            {
               for each(chan in tabs)
               {
                  if((this.chatApi.getDisallowedChannelsId()) && (this.chatApi.getDisallowedChannelsId().indexOf(chan) == -1))
                  {
                     temp.push(chan);
                  }
               }
            }
            this._aTabs.push(temp);
            iTab++;
         }
         this._aTabsPicto = new Array();
         var iPicto:uint = 0;
         var modifiedNames:Boolean = false;
         for each(name in this.sysApi.getOption("tabsNames","chat"))
         {
            if(!Number(name))
            {
               name = iPicto;
               modifiedNames = true;
            }
            this._aTabsPicto.push(name);
            this.uiApi.me().getElement("bgTexture" + this._aBtnTabs[iPicto].name).uri = this.uiApi.createUri(this.uiApi.me().getConstant("tab_uri") + "" + name);
            iPicto++;
         }
         if(modifiedNames)
         {
            this.sysApi.sendAction(new TabsUpdate(null,this._aTabsPicto));
         }
         this.uiApi.setRadioGroupSelectedItem("tabChatGroup",this.btn_tab0,this.uiApi.me());
         this.init();
         this.onUpdateChatOptions();
         this.sysApi.sendAction(new ChatLoaded());
         for each(canal in this._aChannels)
         {
            if(canal != ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)
            {
               this.texta_tchat.setCssColor("#" + this.sysApi.getOption("channelColor" + canal,"chat").toString(16),"p" + canal);
            }
         }
         if(args)
         {
            this.onEnabledChannels(args[0]);
            if((args[1]) && (!(args[1].length == 0)))
            {
               for each(obj in args[1])
               {
                  this.onTextInformation(obj.content,obj.channel,obj.timestamp,obj.saveMsg);
               }
            }
         }
         this._nFontSize = this.configApi.getConfigProperty("chat","chatFontSize");
         if((this._nFontSize) && ((this._nFontSize == SMALL_SIZE) || (this._nFontSize == MEDIUM_SIZE) || (this._nFontSize == LARGE_SIZE)))
         {
            switch(this._nFontSize)
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
            }
            this.textResize(this._nFontSize,lh);
         }
         else
         {
            this.configApi.setConfigProperty("chat","chatFontSize",MEDIUM_SIZE);
         }
         this._delaySendChat = false;
         this._delayWaitingMessage = false;
         this._delaySendChatTimer = new Timer(500,1);
         this._delaySendChatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onDelaySendChatTimer);
         this.resizeToPos(3);
         this.texta_tchat.initSmileyTab(this.uiApi.me().getConstant("smilies_uri"),this.dataApi.getAllSmiley());
         this._iconsPath = this.uiApi.me().getConstant("icons_uri");
         this.bgTexturebtn_status.uri = this.uiApi.createUri(this._iconsPath + "|available");
      }
      
      public function unload() : void {
         this._delaySendChatTimer.stop();
         this._delaySendChatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onDelaySendChatTimer);
         this._focusTimer.removeEventListener(TimerEvent.TIMER,this.onFocusTimer);
         this.inp_tchatinput.textfield.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }
      
      public function resize(way:int = 1) : void {
         if((way == -1) && (this._bNormalSize == 0))
         {
            this.resizeToPos(2);
         }
         else
         {
            this.resizeToPos((this._bNormalSize + way) % 3);
         }
      }
      
      public function resizeToPos(pos:int = -1) : void {
         if(pos < 0)
         {
            pos = (this._bNormalSize + 1) % 3;
         }
         this.tx_background.autoGrid = true;
         if(!this.tx_backgroundMinHeight)
         {
            this.tx_backgroundMinHeight = this.tx_background.height;
         }
         if(!this.ctrMinHeight)
         {
            this.ctrMinHeight = this.tchatCtr.height;
         }
         if(!this.texta_tchatMinHeight)
         {
            this.texta_tchatMinHeight = this.texta_tchat.height;
         }
         if(pos == 1)
         {
            this.tx_background.height = this.tx_backgroundMinHeight + this._nOffsetYSmallResize;
            this.texta_tchat.height = this.texta_tchatMinHeight + this._nOffsetYSmallResize;
            this.tchatCtr.height = this.ctrMinHeight + this._nOffsetYSmallResize;
            this._bNormalSize = 1;
            this.btn_plus.selected = false;
         }
         else if(pos == 2)
         {
            this.tx_background.height = this.tx_backgroundMinHeight + this._nOffsetYSmallResize + this._nOffsetYResize;
            this.texta_tchat.height = this.texta_tchatMinHeight + this._nOffsetYSmallResize + this._nOffsetYResize;
            this.tchatCtr.height = this.ctrMinHeight + this._nOffsetYSmallResize + this._nOffsetYResize;
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
         }
         
         this.uiApi.me().render();
         this.texta_tchat.scrollV = this.texta_tchat.maxScrollV;
      }
      
      public function sendMessage(txt:String) : void {
         this.inp_tchatinput.text = txt;
         this.chanSearch(txt);
         this.inp_tchatinput.focus();
         this.validUiShortcut();
      }
      
      private function textOutput() : void {
         var dest:String = "";
         if(this._sDest.length > 0)
         {
            dest = this._sDest + " ";
         }
         var textToSave:String = this._sChan + " " + dest + this._sText;
         this.addToHistory(textToSave);
         if(this._sDest.length > 0)
         {
            this._privateHistory.addName(this._sDest);
         }
      }
      
      private function addToHistory(msg:String) : void {
         var msg:String = this.trim(msg);
         var hisLength:uint = this._aHistory.length;
         if((!hisLength) || (!(msg == this._aHistory[hisLength - 1])))
         {
            this._aHistory.push(msg);
            if(hisLength + 1 > this._maxCmdHistoryIndex)
            {
               this._aHistory = this._aHistory.slice(hisLength + 10 - this._maxCmdHistoryIndex,hisLength + 1);
            }
            this._nHistoryIndex = this._aHistory.length - 1;
            this.sysApi.setData("_nHistoryIndex ",this._nHistoryIndex);
            this.sysApi.setData("aTchatHistory",this._aHistory,false);
         }
         this._nHistoryIndex++;
      }
      
      private function chanSearch(input:String) : void {
         var chan:String = null;
         if(input.toLocaleLowerCase().indexOf(this._sChan) != 0)
         {
            if(input.charAt(0) == "/")
            {
               chan = input.toLocaleLowerCase().substring(0,input.indexOf(" "));
            }
            else
            {
               chan = this._sChanLocked;
            }
            if(this.sysApi.getOption("channelLocked","chat"))
            {
               this.changeDefaultChannel(chan);
            }
            else
            {
               this.changeCurrentChannel(chan);
            }
         }
      }
      
      private function init() : void {
         this._sDest = "";
         this._sText = "";
         this.changeCurrentChannel(this._sChanLocked);
      }
      
      private function appendFakeLine(s:String, cssClass:String, time:Number = 0) : Object {
         return this.texta_tchat.appendText(this.addTimeToText(s,time),cssClass,false);
      }
      
      private function appendLine(s:String, cssClass:String, time:Number = 0, scrollv:Boolean = true, channel:int = 0) : Object {
         var val:* = 0;
         var scrollNeed:Boolean = this.texta_tchat.scrollNeeded();
         var scrollTemp:int = this.texta_tchat.scrollV;
         if(this.sysApi.getOption("chatoutput","chat"))
         {
            this.chatApi.logChat(this.chatApi.getStaticHyperlink(s));
         }
         var paragraph:Object = this.texta_tchat.appendText(this.addTimeToText(s,time),cssClass,true);
         if((scrollv) && (scrollNeed))
         {
            this.texta_tchat.scrollV = this.texta_tchat.maxScrollV;
         }
         if(this.texta_tchat.maxScrollV > this.chatApi.getMaxMessagesStored())
         {
            val = this.texta_tchat.maxScrollV - this.chatApi.getMaxMessagesStored();
            this.texta_tchat.removeLines(val);
         }
         return paragraph;
      }
      
      private function addTimeToText(inValue:String, inTime:Number) : String {
         if(this.sysApi.getOption("showTime","chat"))
         {
            inValue = "[" + this.timeApi.getClock(inTime,true) + "] " + inValue;
         }
         return inValue;
      }
      
      private function textResize(size:uint, lineHeight:uint) : void {
         this.texta_tchat.setCssSize(size,lineHeight);
         if(this._nFontSize != size)
         {
            this._nFontSize = size;
            this.configApi.setConfigProperty("chat","chatFontSize",size);
         }
         this.refreshChat(false);
      }
      
      private function formatLine(channel:uint = 0, content:String = "", timestamp:Number = 0, fingerprint:String = "", senderId:uint = 0, senderName:String = "", objects:Object = null, receiverName:String = "", receiverId:uint = 0, livingObject:Boolean = false, admin:Boolean = false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function refreshChat(pScrollToBottom:Boolean = true) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function updateChanColor(channelId:int) : void {
         var chanColor:int = this.sysApi.getOption("channelColor" + channelId,"chat");
         var colorisation:ColorTransform = new ColorTransform();
         colorisation.color = chanColor;
         this.tx_arrow_btn_menu.transform.colorTransform = colorisation;
         if(channelId != 0)
         {
            this.tx_focus.transform.colorTransform = colorisation;
         }
         else
         {
            this.tx_focus.transform.colorTransform = new ColorTransform();
         }
         this.inp_tchatinput.setCssColor("#" + chanColor.toString(16),"p" + channelId);
      }
      
      private function changeCurrentChannel(chan:String, auto:Boolean = true) : void {
         var channelId:* = 0;
         if(this._sChan != chan)
         {
            channelId = this.chatApi.searchChannel(chan);
            if(channelId != -1)
            {
               this._sCssClass = "p" + channelId;
               this._sLastChan = this._sChan;
               this._sChan = chan;
               if(!auto)
               {
                  this._bCurrentChannelSelected = true;
               }
               if(this.inp_tchatinput.cssClass != this._sCssClass)
               {
                  this.inp_tchatinput.cssClass = this._sCssClass;
               }
               this.updateChanColor(channelId);
            }
         }
      }
      
      private function changeDefaultChannel(chan:String) : void {
         var channelId:* = 0;
         if(this._sChanLocked != chan)
         {
            channelId = this.chatApi.searchChannel(chan);
            if(channelId != -1)
            {
               this._sChanLocked = chan;
            }
            this.changeCurrentChannel(chan,false);
         }
      }
      
      private function changeDisplayChannel(channel:Object, tab:int) : void {
         if(this._aTabs[tab].indexOf(channel.id) == -1)
         {
            if(this.howManyTimesIsThisChannelUsed(channel.id) == 0)
            {
               this.sysApi.sendAction(new ChannelEnabling(channel.id,true));
            }
            else
            {
               this._bChanCheckChange = false;
            }
            this._aTabs[tab].push(channel.id);
         }
         else
         {
            if(this.howManyTimesIsThisChannelUsed(channel.id) == 1)
            {
               this.sysApi.sendAction(new ChannelEnabling(channel.id,false));
            }
            else
            {
               this._bChanCheckChange = false;
            }
            this._aTabs[tab].splice(this._aTabs[tab].indexOf(channel.id),1);
         }
         this.refreshChat();
         this.sysApi.sendAction(new TabsUpdate(this._aTabs));
      }
      
      private function howManyTimesIsThisChannelUsed(channelId:uint) : uint {
         var tab:* = undefined;
         var chanId:* = undefined;
         var timesUsed:uint = 0;
         for each(tab in this._aTabs)
         {
            for each(chanId in tab)
            {
               if(chanId == channelId)
               {
                  timesUsed++;
               }
            }
         }
         return timesUsed;
      }
      
      private function tabpicChange(pictoId:uint, tab:int) : void {
         this.onTabPictoChange(tab + 1,pictoId.toString());
      }
      
      private function openOptions() : void {
         this.modCommon.openOptionMenu(false,"ui");
      }
      
      private function colorCheckBox() : void {
         var id_color:* = undefined;
         var t:ColorTransform = null;
         for(id_color in this._aCheckColors)
         {
            t = new ColorTransform();
            t.color = this.configApi.getConfigProperty("chat","channelColor" + this._aCheckChans[id_color][0]);
            this._aCheckColors[id_color].transform.colorTransform = t;
         }
      }
      
      private function switchNoobyMode(activate:Boolean) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function onRelease(target:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function setImeMode(mode:String) : void {
         if(mode == IMEConversionMode.UNKNOWN)
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
            }
         }
         var modeName:String = "";
         switch(IME.conversionMode)
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
         }
         this.btn_lbl_btn_ime.text = modeName;
      }
      
      private function onDelaySendChatTimer(e:TimerEvent) : void {
         this._delaySendChatTimer.reset();
         this._delaySendChat = false;
         if(this._delayWaitingMessage)
         {
            this._delayWaitingMessage = false;
            this.validUiShortcut();
         }
      }
      
      private function getHyperlinkFormatedText(text:String) : String {
         var currentItem:Object = null;
         var itemName:String = null;
         var index:* = 0;
         var text:String = this.chatApi.escapeChatString(text);
         var numItem:int = this._aItemReplacement.length;
         var m:int = 0;
         while(m < numItem)
         {
            currentItem = this._aItemReplacement[m];
            itemName = "[" + currentItem.realName + "]";
            index = text.indexOf(itemName);
            if(index == -1)
            {
               this._aItemReplacement.splice(m,1);
               m--;
               numItem--;
            }
            else
            {
               text = text.substr(0,index) + ITEM_INDEX_CODE + text.substr(index + itemName.length);
            }
            m++;
         }
         var num:int = this._aMiscReplacement.length;
         var k:int = 0;
         k = 0;
         while(k < num)
         {
            text = text.split(this._aMiscReplacement[k]).join(this._aMiscReplacement[k + 1]);
            k = k + 2;
         }
         return text;
      }
      
      private function processLinkedItem(text:String) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function addChannelsContextMenu(nTab:int) : void {
         var chanAvailable:* = undefined;
         var selected:* = false;
         var chanDisp:* = undefined;
         var chatChannel:Object = null;
         var shortcutKey:String = null;
         var name:String = null;
         var contextMenu:Array = new Array();
         var picMenu:Array = new Array();
         var displayedChannelsMenu:Array = new Array();
         var iconUri:String = this.uiApi.me().getConstant("tabIcon_uri");
         var iPic:uint = 0;
         while(iPic < 12)
         {
            picMenu.push(this.modContextMenu.createContextMenuPictureItemObject(iconUri + "" + iPic,this.tabpicChange,[iPic,nTab],false,null,iPic.toString() == this._aTabsPicto[nTab],true));
            iPic++;
         }
         for each(chanAvailable in this._aChannels)
         {
            selected = false;
            for each(chanDisp in this._aTabs[nTab])
            {
               if(chanDisp == chanAvailable)
               {
                  selected = true;
               }
            }
            chatChannel = this.dataApi.getChatChannel(chanAvailable);
            shortcutKey = null;
            if(chatChannel.shortcutKey)
            {
               shortcutKey = this.bindsApi.getShortcutBindStr(chatChannel.shortcutKey).toString();
            }
            if(shortcutKey)
            {
               name = chatChannel.name + " (" + shortcutKey + ")";
            }
            else
            {
               name = chatChannel.name;
            }
            displayedChannelsMenu.push(this.modContextMenu.createContextMenuItemObject(name,this.changeDisplayChannel,[chatChannel,nTab],false,null,selected,false));
         }
         contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.option.chatTab")));
         contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.tabPic"),null,null,false,picMenu));
         contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.option.displayedChannels"),null,null,false,displayedChannelsMenu));
         this.modContextMenu.createContextMenu(contextMenu);
      }
      
      private function validUiShortcut() : Boolean {
         var controler:Object = null;
         if(!this.inp_tchatinput.haveFocus)
         {
            return false;
         }
         if(this._delaySendChat)
         {
            this._delayWaitingMessage = true;
            return true;
         }
         if(this.canSendMsg(this.inp_tchatinput.text))
         {
            controler = this.sysApi.getNewDynamicSecureObject();
            controler.cancel = false;
            this.sysApi.dispatchHook(ChatSendPreInit,this.inp_tchatinput.text,controler);
            return true;
         }
         return false;
      }
      
      private function canSendMsg(msg:String) : Boolean {
         if(msg.charAt(0) != " ")
         {
            return true;
         }
         if(msg.length == 0)
         {
            return false;
         }
         while(msg.indexOf(" ") != -1)
         {
            msg = msg.replace(" ","");
         }
         return msg.length > 0;
      }
      
      public function onShortcut(s:String) : Boolean {
         var i:* = 0;
         var historyString:String = null;
         var name:String = null;
         var command:String = null;
         var historyText2:String = null;
         var text:String = null;
         var chan:uint = 0;
         var sShortcut:String = null;
         var finalText:String = null;
         var textInfos:Array = null;
         var numInfos:* = 0;
         var objectUID:* = 0;
         var item:Object = null;
         var c2:* = undefined;
         switch(s)
         {
            case "focusChat":
               if(!this.inp_tchatinput.haveFocus)
               {
                  this._focusTimer.stop();
                  this._focusTimer.reset();
                  this._focusTimer.start();
               }
               return true;
            case "validUi":
               if(this.uiApi.useIME())
               {
                  return this.validUiShortcut();
               }
               return true;
            case ShortcutHookListEnum.CLOSE_UI:
               if(this.inp_tchatinput.haveFocus)
               {
                  this.inp_tchatinput.blur();
                  return true;
               }
               return false;
            case "upArrow":
            case "downArrow":
               if(!this.inp_tchatinput.haveFocus)
               {
                  break;
               }
               if((!this._aHistory[this._aHistory.length - 1]) && (!this._aHistory[0]))
               {
                  break;
               }
               this._bCurrentChannelSelected = false;
               if((s == "upArrow") && (this._nHistoryIndex >= 0))
               {
                  this._nHistoryIndex--;
               }
               if((s == "downArrow") && (this._nHistoryIndex < this._aHistory.length))
               {
                  this._nHistoryIndex++;
               }
               historyString = this._aHistory[this._nHistoryIndex];
               if((!(historyString == null)) && (!(historyString == "")))
               {
                  this.chanSearch(historyString);
                  sShortcut = this.dataApi.getChatChannel(0).shortcut;
                  if(historyString.indexOf(sShortcut + " ") == 0)
                  {
                     finalText = historyString.slice(sShortcut.length + 1);
                  }
                  else
                  {
                     finalText = historyString;
                  }
                  this._aItemReplacement = new Array();
                  textInfos = finalText.split(ITEM_INDEX_CODE);
                  numInfos = textInfos.length;
                  i = 1;
                  while(i < numInfos)
                  {
                     objectUID = int(textInfos[i]);
                     if(objectUID)
                     {
                        item = this._dItemIndex[objectUID];
                        if(item)
                        {
                           textInfos[i] = "[" + item.name + "]";
                           this._aItemReplacement.push(item);
                        }
                        else
                        {
                           textInfos[i] = "";
                        }
                     }
                     i = i + 2;
                  }
                  finalText = textInfos.join("");
                  this.inp_tchatinput.text = finalText;
               }
               else
               {
                  this.inp_tchatinput.text = "";
                  this.init();
               }
               this.inp_tchatinput.setSelection(this.inp_tchatinput.length,this.inp_tchatinput.length);
               return true;
            case "shiftDown":
            case "shiftUp":
               if(!this.inp_tchatinput.haveFocus)
               {
                  break;
               }
               if(this._privateHistory.length == 0)
               {
                  break;
               }
               this._bCurrentChannelSelected = false;
               if(s == "shiftUp")
               {
                  name = this._privateHistory.previous();
               }
               else if(s == "shiftDown")
               {
                  name = this._privateHistory.next();
               }
               
               command = "/w " + name + " ";
               this.inp_tchatinput.text = command;
               this.chanSearch(command);
               this.inp_tchatinput.setSelection(this.inp_tchatinput.length,this.inp_tchatinput.length);
               return true;
            case "shiftValid":
            case "altValid":
            case "ctrlValid":
               if(!this.inp_tchatinput.haveFocus)
               {
                  this._focusTimer.stop();
                  this._focusTimer.reset();
                  this._focusTimer.start();
                  return false;
               }
               if((this.inp_tchatinput.text.charAt(0) == "/") && (this.inp_tchatinput.text.indexOf(this._sChan) == 0))
               {
                  this._sText = this.inp_tchatinput.text.substring(this.inp_tchatinput.text.indexOf(" ") + 1,this.inp_tchatinput.text.length);
               }
               else
               {
                  this._sText = this.inp_tchatinput.text;
               }
               if(this._sText.length == 0)
               {
                  return true;
               }
               this._bCurrentChannelSelected = false;
               historyText2 = this._sText;
               this._sText = this.getHyperlinkFormatedText(this._sText);
               text = "";
               if(this._sDest)
               {
                  text = text + (this._sDest + " ");
               }
               else
               {
                  text = text + this._sDest;
               }
               text = text + this._sText;
               if(s == "altValid")
               {
                  chan = ChatActivableChannelsEnum.CHANNEL_GUILD;
                  if(this._aItemReplacement.length)
                  {
                     this.sysApi.sendAction(new ChatTextOutput(text,chan,"",this._aItemReplacement));
                  }
                  else
                  {
                     this.sysApi.sendAction(new ChatTextOutput(text,chan));
                  }
                  this._sChan = this.dataApi.getChatChannel(chan).shortcut;
               }
               else if(s == "shiftValid")
               {
                  chan = ChatActivableChannelsEnum.CHANNEL_PARTY;
                  this.sysApi.sendAction(new ChatTextOutput(text,chan));
                  this._sChan = this.dataApi.getChatChannel(chan).shortcut;
               }
               else if(s == "ctrlValid")
               {
                  chan = ChatActivableChannelsEnum.CHANNEL_TEAM;
                  this.sysApi.sendAction(new ChatTextOutput(text,chan));
                  this._sChan = this.dataApi.getChatChannel(chan).shortcut;
               }
               
               
               historyText2 = this.processLinkedItem(historyText2);
               this._sText = historyText2;
               this.textOutput();
               this.inp_tchatinput.text = "";
               if(!this.sysApi.getOption("channelLocked","chat"))
               {
                  this.init();
               }
               else
               {
                  for each(c2 in this._aChannels)
                  {
                     if((!(c2 == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)) && (this.dataApi.getChatChannel(c2).shortcut == this._sChan))
                     {
                        if(this.dataApi.getChatChannel(c2).isPrivate)
                        {
                           this.init();
                        }
                     }
                  }
               }
               return true;
            case ShortcutHookListEnum.EXTEND_CHAT:
            case ShortcutHookListEnum.EXTEND_CHAT2:
               if(!this.inp_tchatinput.haveFocus)
               {
                  this.resize(1);
               }
               return true;
            case ShortcutHookListEnum.SHRINK_CHAT:
               if(!this.inp_tchatinput.haveFocus)
               {
                  this.resize(-1);
               }
               return true;
            case ShortcutHookListEnum.TOGGLE_EMOTES:
               this.sysApi.sendAction(new OpenSmileys(0));
               if(this._smileyOpened)
               {
                  this.btn_smiley.soundId = SoundEnum.WINDOW_OPEN;
               }
               else
               {
                  this.btn_smiley.soundId = SoundEnum.WINDOW_CLOSE;
               }
               this._smileyOpened = !this._smileyOpened;
               return true;
            case ShortcutHookListEnum.TOGGLE_ATTITUDES:
               this.openEmoteUi();
               return true;
            case ShortcutHookListEnum.CHAT_TAB_0:
               if(this.checks_ctr.visible)
               {
                  return true;
               }
               if(this._aTabs.length > 0)
               {
                  this._nCurrentTab = 0;
                  this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                  this._aBtnTabs[this._nCurrentTab].selected = true;
                  this.refreshChat();
               }
               return true;
            case ShortcutHookListEnum.CHAT_TAB_1:
               if(this.checks_ctr.visible)
               {
                  return true;
               }
               if(this._aTabs.length > 1)
               {
                  this._nCurrentTab = 1;
                  this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                  this._aBtnTabs[this._nCurrentTab].selected = true;
                  this.refreshChat();
               }
               return true;
            case ShortcutHookListEnum.CHAT_TAB_2:
               if(this.checks_ctr.visible)
               {
                  return true;
               }
               if(this._aTabs.length > 2)
               {
                  this._nCurrentTab = 2;
                  this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                  this._aBtnTabs[this._nCurrentTab].selected = true;
                  this.refreshChat();
               }
               return true;
            case ShortcutHookListEnum.CHAT_TAB_3:
               if(this.checks_ctr.visible)
               {
                  return true;
               }
               if(this._aTabs.length > 3)
               {
                  this._nCurrentTab = 3;
                  this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
                  this._aBtnTabs[this._nCurrentTab].selected = true;
                  this.refreshChat();
               }
               return true;
            case ShortcutHookListEnum.NEXT_CHAT_TAB:
               if(this.checks_ctr.visible)
               {
                  return true;
               }
               this._nCurrentTab++;
               this._nCurrentTab = this._nCurrentTab % this._aTabs.length;
               this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
               this._aBtnTabs[this._nCurrentTab].selected = true;
               this.refreshChat();
               return true;
            case ShortcutHookListEnum.PREVIOUS_CHAT_TAB:
               if(this.checks_ctr.visible)
               {
                  return true;
               }
               if(this._nCurrentTab > 0)
               {
                  this._nCurrentTab--;
               }
               else
               {
                  this._nCurrentTab = this._aTabs.length - 1;
               }
               this.refreshChat();
               this._aTxHighlights[this._nCurrentTab].gotoAndStop = "normal";
               this._aBtnTabs[this._nCurrentTab].selected = true;
               this.refreshChat();
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_GLOBAL:
               this.changeDisplayChannel(this.dataApi.getChatChannel(0),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_TEAM:
               this.changeDisplayChannel(this.dataApi.getChatChannel(1),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_GUILD:
               this.changeDisplayChannel(this.dataApi.getChatChannel(2),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_ALLIANCE:
               this.changeDisplayChannel(this.dataApi.getChatChannel(3),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_PARTY:
               this.changeDisplayChannel(this.dataApi.getChatChannel(4),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_ARENA:
               this.changeDisplayChannel(this.dataApi.getChatChannel(13),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_SALES:
               this.changeDisplayChannel(this.dataApi.getChatChannel(5),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_SEEK:
               this.changeDisplayChannel(this.dataApi.getChatChannel(6),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.TOGGLE_CHANNEL_FIGHT:
               this.changeDisplayChannel(this.dataApi.getChatChannel(11),this._nCurrentTab);
               return true;
            case ShortcutHookListEnum.SWITCH_TEXT_SIZE:
               switch(this._nFontSize)
               {
                  case SMALL_SIZE:
                     this.textResize(MEDIUM_SIZE,MEDIUM_SIZE_LINE_HEIGHT);
                     break;
                  case MEDIUM_SIZE:
                     this.textResize(LARGE_SIZE,LARGE_SIZE_LINE_HEIGHT);
                     break;
                  case LARGE_SIZE:
                     this.textResize(SMALL_SIZE,SMALL_SIZE_LINE_HEIGHT);
                     break;
               }
               return true;
            case ShortcutHookListEnum.CHAT_AUTOCOMPLETE:
               if(this.inp_tchatinput.haveFocus)
               {
                  this.autocompleteChat();
                  return true;
               }
               return false;
         }
         return false;
      }
      
      public function onKeyUp(event:KeyboardEvent) : void {
         var input:String = null;
         if((!(this.sysApi.getCurrentLanguage() == "ja")) && (!((event.altKey || event.shiftKey || event.hasOwnProperty("controlKey") && Object(event).controlKey) || (event.ctrlKey) || (event.hasOwnProperty("commandKey")) && (Object(event).commandKey))) && (event.keyCode == Keyboard.ENTER))
         {
            this.validUiShortcut();
         }
         else
         {
            if(this.uiApi.useIME())
            {
               this.setImeMode(null);
            }
            input = this.inp_tchatinput.text;
            if(!this.uiApi.useIME())
            {
               this.inp_tchatinput.text = input;
               if(this.inp_tchatinput.text == "")
               {
                  this.inp_tchatinput.cssClass = this._sCssClass;
               }
            }
            this.chanSearch(input);
         }
      }
      
      public function onChatSendPreInit(content:String, controler:Object) : void {
         var i:* = undefined;
         var japString:String = null;
         var ijc:uint = 0;
         var japchar:* = NaN;
         var c:* = undefined;
         if(controler.cancel)
         {
            this.inp_tchatinput.text = "";
            return;
         }
         var textInp:String = content;
         if((textInp.charAt(0) == "/") && (textInp.toLowerCase().indexOf(this._sChan + " ") == 0))
         {
            this._sText = textInp.substring(textInp.indexOf(" ") + 1,textInp.length);
         }
         else
         {
            this._sText = textInp;
         }
         if(this._sText.length == 0)
         {
            return;
         }
         this._bCurrentChannelSelected = false;
         if(this._sText.charAt(0) == String.fromCharCode(65295))
         {
            japString = "";
            ijc = 0;
            while(ijc < this._sText.length)
            {
               japchar = this._sText.charCodeAt(ijc);
               if((japchar >= 65281) && (japchar <= 65374))
               {
                  japchar = japchar - 65248;
               }
               japString = japString + String.fromCharCode(japchar);
               ijc++;
            }
            this._sText = japString;
         }
         if((this._sText.charAt(0) == "/") && (this._sText.length == textInp.length) && (!(this._sText.substr(0,3).toLowerCase() == "/me")) && (!(this._sText.substr(0,6).toLowerCase() == "/think")) && (!((this._sText.charAt(0) == "*") && (this._sText.charAt(this._sText.length - 1) == "*"))))
         {
            this.sysApi.sendAction(new ChatCommand(this._sText.substr(1)));
            this.inp_tchatinput.text = "";
            this.addToHistory(this._sText);
            return;
         }
         var destTmp:String = this._sText.substring(0,this._sText.indexOf(" "));
         if(destTmp == "")
         {
            destTmp = this._sText;
         }
         if((!this.dataApi.getChatChannel(i).isPrivate) && ((!(destTmp.charAt(0) == "[")) && (!(destTmp.indexOf("]") == -1)) || (!(destTmp.indexOf("[") == -1)) && (destTmp.indexOf("]") == -1) && (!(this._sText.indexOf("]") == -1))))
         {
            this._sText = this._sText.substring(0,this._sText.indexOf("[")) + " " + this._sText.substring(this._sText.indexOf("["),this._sText.length);
            this._sText = this.trim(this._sText);
         }
         else if((destTmp.charAt(0) == "[") && (!(destTmp.indexOf("]") == destTmp.lastIndexOf("]"))))
         {
            this._sText = this._sText.substring(0,this._sText.lastIndexOf("[")) + " " + this._sText.substring(this._sText.lastIndexOf("["),this._sText.length);
            this._sText = this.trim(this._sText);
         }
         
         var historyText:String = this._sText;
         this._sText = this.getHyperlinkFormatedText(this._sText);
         for each(i in this._aChannels)
         {
            if(this._sChan == this.dataApi.getChatChannel(i).shortcut)
            {
               if(!this.dataApi.getChatChannel(i).isPrivate)
               {
                  if(this._aItemReplacement.length)
                  {
                     this.sysApi.sendAction(new ChatTextOutput(this._sText,i,this._sDest,this._aItemReplacement));
                  }
                  else
                  {
                     this.sysApi.sendAction(new ChatTextOutput(this._sText,i,this._sDest));
                  }
               }
               else
               {
                  this._sDest = this._sText.substring(0,this._sText.indexOf(" "));
                  this._sText = this._sText.substring(this._sText.indexOf(" ") + 1,this._sText.length);
                  historyText = historyText.substring(historyText.indexOf(" ") + 1,historyText.length);
                  if(this._sDest.length != 0)
                  {
                     if(this._aItemReplacement.length)
                     {
                        this.sysApi.sendAction(new ChatTextOutput(this._sText,i,this._sDest,this._aItemReplacement));
                     }
                     else
                     {
                        this.sysApi.sendAction(new ChatTextOutput(this._sText,i,this._sDest));
                     }
                  }
               }
            }
         }
         this._privateHistory.resetCursor();
         historyText = this.processLinkedItem(historyText);
         this._sText = historyText;
         this._aItemReplacement = new Array();
         this.textOutput();
         this.inp_tchatinput.text = "";
         if(!this.sysApi.getOption("channelLocked","chat"))
         {
            this.init();
         }
         else
         {
            for each(c in this._aChannels)
            {
               if((!(c == ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)) && (this.dataApi.getChatChannel(c).shortcut == this._sChan))
               {
                  if(this.dataApi.getChatChannel(c).isPrivate)
                  {
                     this.init();
                  }
               }
            }
         }
      }
      
      public function onChatServer(channel:uint = 0, senderId:uint = 0, senderName:String = "", content:String = "", timestamp:Number = 0, fingerprint:String = "", admin:Boolean = false) : void {
         this.formatLine(channel,content,timestamp,fingerprint,senderId,senderName,null,"",0,false,admin);
      }
      
      public function onChatServerWithObject(channel:uint = 0, senderId:uint = 0, senderName:String = "", content:String = "", timestamp:Number = 0, fingerprint:String = "", objects:Object = null) : void {
         this.formatLine(channel,content,timestamp,fingerprint,senderId,senderName,objects);
      }
      
      public function onChatServerCopy(channel:uint = 0, receiverName:String = "", content:String = "", timestamp:Number = 0, fingerprint:String = "", receiverId:uint = 0) : void {
         this.formatLine(channel,content,timestamp,fingerprint,0,"",null,receiverName,receiverId);
      }
      
      public function onChatServerCopyWithObject(channel:uint = 0, receiverName:String = "", content:String = "", timestamp:Number = 0, fingerprint:String = "", receiverId:uint = 0, objects:Object = null) : void {
         this.formatLine(channel,content,timestamp,fingerprint,0,"",objects,receiverName,receiverId);
      }
      
      public function onChatSpeakingItem(channel:uint = 0, item:Object = null, content:String = "", timestamp:Number = 0, fingerprint:String = "") : void {
         this.sysApi.sendAction(new SaveMessage(item.name + this.uiApi.getText("ui.common.colon") + content,channel,timestamp));
         this.formatLine(channel,content,timestamp,fingerprint,0,item.name,null,"",0,true);
      }
      
      public function onLivingObjectMessage(owner:String = "", text:String = "", timestamp:Number = 0) : void {
         this.sysApi.sendAction(new SaveMessage(owner + this.uiApi.getText("ui.common.colon") + text,0,timestamp));
         this.formatLine(0,text,timestamp,"",0,owner,null,"",0,true);
      }
      
      public function onTextInformation(content:String = "", channel:int = 0, timestamp:Number = 0, saveMsg:Boolean = true) : void {
         if(content == "")
         {
            this.sysApi.log(16,"Le message d\'information est vide, il ne sera pas affiché.");
         }
         else
         {
            if(channel == 2)
            {
               this.soundApi.playSoundById("16109");
            }
            if(saveMsg)
            {
               this.sysApi.sendAction(new SaveMessage(content,channel,timestamp));
            }
            this.formatLine(channel,content,timestamp);
         }
      }
      
      public function onTextActionInformation(textKey:uint = 0, params:Array = null, channel:int = 0, timestamp:Number = 0) : void {
         var content:String = this.uiApi.getTextFromKey(textKey,null,params);
         content = this.uiApi.processText(content,"n",false);
         this.formatLine(channel,content,timestamp);
      }
      
      public function onTabPictoChange(tab:uint, name:String = null) : void {
         this._aTabsPicto[tab - 1] = name;
         this.uiApi.me().getElement("bgTexture" + this._aBtnTabs[tab - 1].name).uri = this.uiApi.createUri(this.uiApi.me().getConstant("tab_uri") + "" + name);
         this.sysApi.sendAction(new TabsUpdate(null,this._aTabsPicto));
      }
      
      public function onChannelEnablingChange(channel:uint = 0, enable:Boolean = false) : void {
         if(this._bChanCheckChange)
         {
            this._bChanCheckChange = false;
         }
      }
      
      public function onEnabledChannels(channels:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function onUpdateChatOptions() : void {
         var canal:* = undefined;
         var expertMode:* = false;
         for each(canal in this._aChannels)
         {
            if(canal != ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG)
            {
               this.texta_tchat.setCssColor("#" + this.configApi.getConfigProperty("chat","channelColor" + canal).toString(16),"p" + canal);
            }
            if(this.dataApi.getChatChannel(canal).shortcut == this._sChan)
            {
               this.updateChanColor(canal);
            }
         }
         expertMode = this.sysApi.getOption("chatExpertMode","chat");
         if(expertMode)
         {
            this.switchNoobyMode(false);
         }
         if(!expertMode)
         {
            this.switchNoobyMode(true);
         }
         if(this.checks_ctr.visible)
         {
            this.colorCheckBox();
         }
         this.refreshChat();
      }
      
      public function onChatSmiley(smileyId:uint, entityId:uint) : void {
         if((this.sysApi.getOption("smileysAutoclosed","chat")) && (entityId == this.playerApi.id()))
         {
            this.btn_smiley.selected = false;
            this.btn_emote.selected = false;
         }
      }
      
      private function openEmoteUi() : void {
         this.sysApi.sendAction(new OpenSmileys(1));
         if(this._emoteOpened)
         {
            this.btn_emote.soundId = SoundEnum.WINDOW_OPEN;
         }
         else
         {
            this.btn_emote.soundId = SoundEnum.WINDOW_CLOSE;
         }
         this._emoteOpened = !this._emoteOpened;
      }
      
      private function onToggleChatLog(enable:Boolean = true) : void {
      }
      
      private function onClearChat() : void {
         this.texta_tchat.clearText();
         this.sysApi.sendAction(new d2actions.ClearChat(this._aTabs[this._nCurrentTab]));
      }
      
      private function onChatRollOverLink(target:*, pHref:String) : void {
         var data:Object = this.uiApi.textTooltipInfo(pHref,null,null,400);
         this.uiApi.showTooltip(data,target,false,"standard",0,0,3,null,null,null,"TextInfo");
      }
      
      public function onNewMessage(chanId:int, removedSentence:uint = 0) : void {
         var tab:* = undefined;
         for(tab in this._aTabs)
         {
            if((!(this._aTabs[tab].indexOf(chanId) == -1)) && (!(tab == this._nCurrentTab)) && (this._aTabs[this._nCurrentTab].indexOf(chanId) == -1))
            {
               this._aTxHighlights[tab].gotoAndStop = "highlight";
            }
         }
         if(this.texta_tchat.type == ChatComponentHandler.CHAT_NORMAL)
         {
            this.chatApi.removeLinesFromHistory(removedSentence,chanId);
         }
      }
      
      public function onChatFocus(name:String = "") : void {
         var position:* = 0;
         if(name)
         {
            this.inp_tchatinput.text = "/w " + name + " ";
            position = this.inp_tchatinput.text.length;
            this.inp_tchatinput.setSelection(position,position);
            this.chanSearch("/w ");
         }
         this.inp_tchatinput.focus();
         this.inp_tchatinput.caretIndex = -1;
      }
      
      public function onRightClick(target:Object) : void {
         switch(target)
         {
            case this.btn_tab0:
            case this.btn_tab1:
            case this.btn_tab2:
            case this.btn_tab3:
               if(!this.checks_ctr.visible)
               {
                  this.addChannelsContextMenu(int(target.name.substr(7,1)));
               }
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var point:uint = 0;
         var relPoint:uint = 0;
         var chatChannel:Object = null;
         var chan0:* = undefined;
         var chan1:* = undefined;
         var chan2:* = undefined;
         var chan3:* = undefined;
         var data:Object = null;
         var tooltipText:String = "";
         var shortcutKey:String = null;
         var maxWidth:int = 0;
         point = 7;
         relPoint = 1;
         switch(target)
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
               for each(chan0 in this._aTabs[0])
               {
                  chatChannel = this.dataApi.getChatChannel(chan0);
                  tooltipText = tooltipText + (chatChannel.name + "\n");
               }
               break;
            case this.btn_tab1:
               for each(chan1 in this._aTabs[1])
               {
                  chatChannel = this.dataApi.getChatChannel(chan1);
                  tooltipText = tooltipText + (chatChannel.name + "\n");
               }
               break;
            case this.btn_tab2:
               for each(chan2 in this._aTabs[2])
               {
                  chatChannel = this.dataApi.getChatChannel(chan2);
                  tooltipText = tooltipText + (chatChannel.name + "\n");
               }
               break;
            case this.btn_tab3:
               for each(chan3 in this._aTabs[3])
               {
                  chatChannel = this.dataApi.getChatChannel(chan3);
                  tooltipText = tooltipText + (chatChannel.name + "\n");
               }
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
               switch(_currentStatus)
               {
                  case PlayerStatusEnum.PLAYER_STATUS_AFK:
                     if(this._awayMessage != "")
                     {
                        tooltipText = this.uiApi.getText("ui.chat.status.away") + this.uiApi.getText("ui.common.colon") + this._awayMessage;
                     }
                     else
                     {
                        tooltipText = this.uiApi.getText("ui.chat.status.away");
                     }
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
               }
               maxWidth = 400;
               break;
         }
         if(tooltipText != "")
         {
            if(shortcutKey)
            {
               if(!_shortcutColor)
               {
                  _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                  _shortcutColor = _shortcutColor.replace("0x","#");
               }
               data = this.uiApi.textTooltipInfo(tooltipText + " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>",null,null,maxWidth);
            }
            else
            {
               data = this.uiApi.textTooltipInfo(tooltipText,null,null,maxWidth);
            }
            this.uiApi.showTooltip(data,target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onFocusTimer(e:Event) : void {
         this.inp_tchatinput.focus();
         this._focusTimer.stop();
         this._focusTimer.reset();
      }
      
      private function onChatHyperlink(hyperLinkCode:String) : void {
         var hyperlinkInfo:Array = hyperLinkCode.split(",");
         var staticHyperlink:String = this.chatApi.getStaticHyperlink(hyperLinkCode);
         if((hyperlinkInfo[0] == "{spell") || (hyperlinkInfo[0] == "{recipe") || (hyperlinkInfo[0] == "{chatachievement") || (hyperlinkInfo[0] == "{chatmonster") || (hyperlinkInfo[0] == "{guild") || (hyperlinkInfo[0] == "{alliance"))
         {
            this._aMiscReplacement.push(staticHyperlink,hyperLinkCode);
         }
         this.inp_tchatinput.appendText(staticHyperlink + " ");
         this.inp_tchatinput.focus();
         this.inp_tchatinput.caretIndex = -1;
      }
      
      private function onChatWarning() : void {
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.warningForbiddenLink"),[this.uiApi.getText("ui.common.ok")],[],null,null,null,true,true);
      }
      
      private function onChatLinkRelease(link:String, sender:uint, senderName:String) : void {
         this.sysApi.goToCheckLink(link,sender,senderName);
      }
      
      private function onPopupWarning(author:String, content:String, duration:uint) : void {
         var msg:String = author + this.uiApi.getText("ui.common.colon") + content;
         this.modCommon.openLockedPopup(this.uiApi.getText("ui.common.informations"),msg,null,false,false,[duration.toString()],false,true);
      }
      
      private function onMouseShiftClick(target:Object) : void {
         var data:Object = target.data;
         if(data)
         {
            if(data is ShortcutWrapper)
            {
               data = (data as ShortcutWrapper).realItem;
            }
            if((data.hasOwnProperty("isPresetObject")) && (data.isPresetObject))
            {
               return;
            }
            if((data.hasOwnProperty("objectUID")) && (data.objectUID == 0))
            {
               return;
            }
            if((data is SmileyWrapper) || (data is EmoteWrapper) || (data is ButtonWrapper))
            {
               return;
            }
            this.onInsertHyperlink(data);
         }
      }
      
      private function onFocusChange(target:Object) : void {
         if((target == this.inp_tchatinput) || (target == this.inp_tchatinput.textfield))
         {
            this.tx_focus.gotoAndStop = 2;
         }
         else
         {
            this.tx_focus.gotoAndStop = 1;
         }
      }
      
      public function onEmoteUnabledListUpdated(emotesOk:Object) : void {
         if(emotesOk.length == 0)
         {
            this.btn_emote.disabled = true;
            if(this.uiApi.getUi(UIEnum.SMILEY_UI))
            {
               this.uiApi.unloadUi(UIEnum.SMILEY_UI);
            }
         }
         else
         {
            this.btn_emote.disabled = false;
         }
      }
      
      public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int) : void {
         if(isSpectator)
         {
            if(this._sChanLocked == this._sChanLockedBeforeSpec)
            {
               if(this.sysApi.getOption("channelLocked","chat"))
               {
                  this.changeDefaultChannel(this.dataApi.getChatChannel(1).shortcut);
               }
            }
         }
      }
      
      public function onGameFightLeave(id:int) : void {
         if((id == this.playerApi.id()) && (this._sChanLocked == this.dataApi.getChatChannel(1).shortcut))
         {
            if(this.sysApi.getOption("channelLocked","chat"))
            {
               this.changeDefaultChannel(this.dataApi.getChatChannel(0).shortcut);
            }
         }
      }
      
      private function onInsertRecipeHyperlink(id:uint) : void {
         this.onInsertHyperlink(id,true);
      }
      
      private function onInsertHyperlink(data:Object, isRecipe:Boolean = false) : void {
         var staticHyperlink:String = null;
         var hyperLinkCode:String = null;
         var linkInChat:String = null;
         if((data.hasOwnProperty("objectUID")) && (this._aItemReplacement.length < MAX_CHAT_ITEMS))
         {
            hyperLinkCode = "{item," + data.objectGID + "}";
            staticHyperlink = this.chatApi.getStaticHyperlink(hyperLinkCode);
            this._aItemReplacement.push(data);
            this._dItemIndex[data.objectUID] = data;
         }
         else
         {
            if(isRecipe)
            {
               hyperLinkCode = "{recipe," + data + "}";
            }
            else if(data is Achievement)
            {
               hyperLinkCode = "{chatachievement," + data.id + "}";
            }
            else if(data is Monster)
            {
               hyperLinkCode = "{chatmonster," + data.id + "}";
            }
            else if(data is AllianceWrapper)
            {
               hyperLinkCode = this.chatApi.getAllianceLink(data);
            }
            else if(data is GuildFactSheetWrapper)
            {
               hyperLinkCode = this.chatApi.getGuildLink(data);
            }
            else if(data.hasOwnProperty("spellLevel"))
            {
               hyperLinkCode = "{spell," + data.id + "," + data.spellLevel + "}";
            }
            
            
            
            
            
            staticHyperlink = this.chatApi.getStaticHyperlink(hyperLinkCode);
            this._aMiscReplacement.push(staticHyperlink,hyperLinkCode);
         }
         this.inp_tchatinput.appendText(staticHyperlink + " ");
         this.inp_tchatinput.focus();
         this.inp_tchatinput.caretIndex = -1;
      }
      
      private function onActivateSmilies() : void {
         this.texta_tchat.activeSmilies();
      }
      
      private function autocompleteChat() : void {
         var subString:String = null;
         var text:String = this.inp_tchatinput.text;
         var i:int = text.length - 1;
         while(i >= 0)
         {
            if(text.charAt(i) == " ")
            {
               text = text.substr(0,i);
               i--;
               continue;
            }
            break;
         }
         var lidx:int = text.lastIndexOf(" ");
         if((lidx == -1) || (!(text.substr(0,lidx).indexOf(" ") == -1)) || (!(text.charAt(0) == "/")))
         {
            return;
         }
         subString = text.substr(lidx + 1);
         if(subString.length == 0)
         {
            return;
         }
         if((!this._autocompletionLastCompletion) || (!(this._autocompletionLastCompletion == subString)))
         {
            this._autocompletionCount = 0;
            this._autocompletionSubString = subString;
         }
         var autocompletion:String = this.chatApi.getAutocompletion(this._autocompletionSubString,this._autocompletionCount);
         if((autocompletion == null) && (this._autocompletionCount > 0))
         {
            this._autocompletionCount = 0;
            autocompletion = this.chatApi.getAutocompletion(this._autocompletionSubString,this._autocompletionCount);
         }
         if(autocompletion == null)
         {
            return;
         }
         this._autocompletionLastCompletion = autocompletion;
         this._autocompletionCount++;
         this.inp_tchatinput.text = text.substring(0,lidx + 1) + autocompletion + " ";
         this.inp_tchatinput.caretIndex = -1;
      }
      
      private function onChatChange(e:Event) : void {
         if(this._delayWaitingMessage)
         {
            e.target.text = this._lastText;
         }
         else
         {
            this._lastText = e.target.text;
         }
      }
      
      private function onStatusChange(status:uint, message:String = "") : void {
         if(message == "")
         {
            Api.system.sendAction(new PlayerStatusUpdateRequest(status));
            this._awayMessage = "";
         }
         else
         {
            Api.system.sendAction(new PlayerStatusUpdateRequest(status,message));
            this.onNewAwayMessage(message);
         }
      }
      
      private function onStatusChangeWithMessage(status:uint) : void {
         var oldMsg:Array = this.sysApi.getData("oldAwayMessage");
         this.modCommon.openInputComboBoxPopup(this.uiApi.getText("ui.popup.status.awaytitle"),this.uiApi.getText("ui.popup.status.awaymessage"),this.uiApi.getText("ui.popup.status.wipeAwayMessageHistory"),this.onSubmitAwayMessage,null,this.onResetAwayMessage,"",null,360,oldMsg);
      }
      
      private function onSubmitAwayMessage(value:String) : void {
         this.onStatusChange(PlayerStatusEnum.PLAYER_STATUS_AFK,value);
      }
      
      private function onResetAwayMessage() : void {
         this.sysApi.setData("oldAwayMessage",[],false);
      }
      
      private function onPlayerStatusUpdate(accountId:uint, playerId:uint, status:uint) : void {
         var statusName:String = null;
         if(playerId == this.playerApi.id())
         {
            switch(status)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  this.bgTexturebtn_status.uri = this.uiApi.createUri(this._iconsPath + "|available");
                  statusName = this.uiApi.getText("ui.chat.status.availiable");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  this.bgTexturebtn_status.uri = this.uiApi.createUri(this._iconsPath + "|away");
                  statusName = this.uiApi.getText("ui.chat.status.away");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  this.bgTexturebtn_status.uri = this.uiApi.createUri(this._iconsPath + "|private");
                  statusName = this.uiApi.getText("ui.chat.status.private");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  this.bgTexturebtn_status.uri = this.uiApi.createUri(this._iconsPath + "|solo");
                  statusName = this.uiApi.getText("ui.chat.status.solo");
                  break;
            }
            if(status != PlayerStatusEnum.PLAYER_STATUS_IDLE)
            {
               _currentStatus = status;
            }
            this.sysApi.dispatchHook(TextInformation,this.uiApi.getText("ui.chat.status.statuschange",[statusName]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
         }
      }
      
      private function onNewAwayMessage(message:String) : void {
         var oldMsg:Array = null;
         var i:* = 0;
         if(message != "")
         {
            oldMsg = this.sysApi.getData("oldAwayMessage");
            if(!oldMsg)
            {
               oldMsg = new Array();
            }
            else if(oldMsg.length > 10)
            {
               oldMsg.pop();
            }
            
            i = 0;
            while(i < oldMsg.length)
            {
               if(oldMsg[i] == message)
               {
                  oldMsg.splice(i,1);
                  break;
               }
               i++;
            }
            oldMsg.unshift(message);
         }
         this.sysApi.setData("oldAwayMessage",oldMsg,false);
         this._awayMessage = message;
      }
      
      private function onInactivityNotification(inactive:Boolean) : void {
         if((inactive) && (!(_currentStatus == PlayerStatusEnum.PLAYER_STATUS_AFK)) && (!this._idle))
         {
            this._idle = true;
            this.onStatusChange(PlayerStatusEnum.PLAYER_STATUS_IDLE);
         }
         else if((!inactive) && (this._idle))
         {
            this._idle = false;
            this.onStatusChange(_currentStatus,this._awayMessage);
         }
         
      }
      
      private function trim(s:String) : String {
         var start:int = 0;
         while((start < s.length) && ((s.charAt(start) == " ") || (s.charAt(start) == "\n") || (s.charAt(start) == "\t") || (s.charAt(start) == "\r")))
         {
            start++;
         }
         var end:int = s.length - 1;
         while((end >= 0) && ((s.charAt(end) == " ") || (s.charAt(end) == "\n") || (s.charAt(end) == "\t") || (s.charAt(end) == "\r")))
         {
            end--;
         }
         if(end - start == 0)
         {
            return "";
         }
         return s.substring(start,end + 1);
      }
   }
}
