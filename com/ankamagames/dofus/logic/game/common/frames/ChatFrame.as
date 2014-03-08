package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.misc.options.ChatOptions;
   import com.ankamagames.dofus.datacenter.communication.Smiley;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.chat.MoodSmileyRequestAction;
   import com.ankamagames.dofus.datacenter.communication.ChatChannel;
   import com.ankamagames.jerakine.console.ConsolesManager;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.console.ChatConsoleInstructionRegistrar;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.dofus.datacenter.communication.CensoredWord;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.BasicWhoIsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.NumericWhoIsRequestAction;
   import com.ankamagames.dofus.network.messages.game.basic.NumericWhoIsRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatTextOutputAction;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.messages.game.chat.ChatServerWithObjectMessage;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.messages.game.chat.ChatAdminServerMessage;
   import com.ankamagames.dofus.network.messages.game.moderation.PopupWarningMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatServerMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatServerCopyWithObjectMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatServerCopyMessage;
   import com.ankamagames.dofus.network.messages.game.basic.TextInformationMessage;
   import com.ankamagames.jerakine.console.ConsoleOutputMessage;
   import com.ankamagames.dofus.logic.game.fight.messages.TextActionInformationMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatErrorMessage;
   import com.ankamagames.dofus.logic.game.common.actions.chat.SaveMessageAction;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.ChatSmileyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.LocalizedChatSmileyMessage;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.ChatSmileyMessage;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.MoodSmileyRequestMessage;
   import com.ankamagames.dofus.network.messages.game.chat.smiley.MoodSmileyResultMessage;
   import com.ankamagames.dofus.network.messages.game.chat.channel.ChannelEnablingChangeMessage;
   import com.ankamagames.dofus.network.messages.game.chat.channel.ChannelEnablingMessage;
   import com.ankamagames.dofus.logic.game.common.actions.chat.TabsUpdateAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatCommandAction;
   import com.ankamagames.dofus.network.messages.game.chat.channel.EnabledChannelsMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicTimeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectErrorMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicWhoIsMessage;
   import com.ankamagames.dofus.network.messages.game.basic.NumericWhoIsMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicWhoIsNoMatchMessage;
   import com.ankamagames.dofus.logic.game.common.actions.chat.LivingObjectMessageRequestAction;
   import com.ankamagames.dofus.network.messages.game.inventory.items.LivingObjectMessageRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.LivingObjectMessageMessage;
   import com.ankamagames.dofus.datacenter.livingObjects.SpeakingItemText;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatLoadedAction;
   import com.ankamagames.dofus.network.messages.game.context.notification.NotificationByServerMessage;
   import com.ankamagames.dofus.datacenter.notifications.Notification;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeGuildTaxCollectorGetMessage;
   import com.ankamagames.dofus.network.messages.web.ankabox.MailStatusMessage;
   import com.ankamagames.dofus.network.messages.game.basic.BasicWhoIsRequestMessage;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.messages.game.chat.ChatClientMultiWithObjectMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatClientMultiMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatClientPrivateWithObjectMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatClientPrivateMessage;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.dofus.internalDatacenter.communication.ThinkBubble;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
   import com.ankamagames.jerakine.console.UnhandledConsoleInstructionError;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.common.managers.AccountManager;
   import com.ankamagames.dofus.network.enums.ChatChannelsMultiEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.datacenter.communication.InfoMessage;
   import com.ankamagames.dofus.network.enums.TextInformationTypeEnum;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   import com.ankamagames.dofus.logic.game.common.actions.chat.FightOutputAction;
   import com.ankamagames.dofus.network.enums.ChatErrorEnum;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatSmileyRequestAction;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChannelEnablingAction;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.enums.ObjectErrorEnum;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.network.enums.GameHierarchyEnum;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.dofus.network.enums.PlayerStateEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.network.messages.web.ankabox.NewMailMessage;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ClearChatAction;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   import com.ankamagames.dofus.logic.common.frames.LoadingModuleFrame;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatSentenceWithRecipient;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatSentenceWithSource;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatInformationSentence;
   import com.ankamagames.dofus.internalDatacenter.communication.BasicChatSentence;
   import com.ankamagames.jerakine.types.Callback;
   
   public class ChatFrame extends Object implements Frame
   {
      
      public function ChatFrame() {
         this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/chat.css";
         this._aChatColors = new Array();
         super();
         CssManager.getInstance().askCss(this._cssUri,new Callback(this.onCssLoaded));
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatFrame));
      
      public static const GUILD_SOUND:uint = 0;
      
      public static const PARTY_SOUND:uint = 1;
      
      public static const PRIVATE_SOUND:uint = 2;
      
      public static const ALERT_SOUND:uint = 3;
      
      public static const RED_CHANNEL_ID:uint = 666;
      
      public static const URL_MATCHER:RegExp = new RegExp("\\b((http|https|ftp):\\/\\/)?(([^:@ ]*)(:([^@ ]*))?@)?((www\\.)?(([a-z0-9\\-\\.]{2,})(\\.[a-z0-9\\-]{2,})))(:([0-9]+))?(\\/[^\\s`!()\\[\\]{};:\'\",<>?«»“”‘’#]*)?(\\?([^\\s`!()\\[\\]{};:\'\".,<>?«»“”‘’]*))?(#(.*))?","gi");
      
      public static const LINK_TLDS:Array = new Array(".com",".edu",".org",".fr",".info",".net",".de",".ja",".uk",".us",".it",".nl",".ru",".es",".pt",".br");
      
      private var _aChannels:Array;
      
      private var _aDisallowedChannels:Array;
      
      private var _aMessagesByChannel:Array;
      
      private var _aParagraphesByChannel:Array;
      
      private var _msgUId:uint = 0;
      
      private var _maxMessagesStored:uint = 40;
      
      private var _aCensoredWords:Dictionary;
      
      private var _smileyMood:int = -1;
      
      private var _options:ChatOptions;
      
      private var _cssUri:String;
      
      private var _aChatColors:Array;
      
      private var _ankaboxEnabled:Boolean = false;
      
      private var _aSmilies:Array;
      
      public function pushed() : Boolean {
         var _loc1_:Object = null;
         var _loc2_:Smiley = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:OptionManager = null;
         var _loc8_:* = 0;
         var _loc10_:SmileyWrapper = null;
         var _loc11_:Date = null;
         var _loc12_:Array = null;
         var _loc13_:MoodSmileyRequestAction = null;
         this._options = new ChatOptions();
         this.setDisplayOptions(this._options);
         this._aChannels = ChatChannel.getChannels();
         this._aDisallowedChannels = new Array();
         this._aMessagesByChannel = new Array();
         this._aParagraphesByChannel = new Array();
         this._aSmilies = new Array();
         this._aCensoredWords = new Dictionary();
         for (_loc1_ in this._aChannels)
         {
            this._aMessagesByChannel[this._aChannels[_loc1_].id] = new Array();
            this._aParagraphesByChannel[this._aChannels[_loc1_].id] = new Array();
         }
         this._aMessagesByChannel[RED_CHANNEL_ID] = new Array();
         this._aParagraphesByChannel[RED_CHANNEL_ID] = new Array();
         ConsolesManager.registerConsole("chat",new ConsoleHandler(Kernel.getWorker(),false,true),new ChatConsoleInstructionRegistrar());
         for each (_loc2_ in Smiley.getSmileys())
         {
            if(_loc2_.forPlayers)
            {
               _loc10_ = SmileyWrapper.create(_loc2_.id,_loc2_.gfxId,_loc2_.order);
               this._aSmilies.push(_loc10_);
            }
         }
         this._aSmilies.sortOn("order",Array.NUMERIC);
         _loc3_ = XmlConfig.getInstance().getEntry("config.lang.current");
         _loc4_ = CensoredWord.getCensoredWords();
         _loc5_ = 0;
         for each (_loc6_ in _loc4_)
         {
            if(_loc6_)
            {
               if(_loc6_.language == _loc3_)
               {
                  _loc5_++;
                  if(_loc6_.deepLooking)
                  {
                     this._aCensoredWords[_loc6_.word] = 2;
                  }
                  else
                  {
                     this._aCensoredWords[_loc6_.word] = 1;
                  }
               }
            }
         }
         _loc7_ = OptionManager.getOptionManager("chat");
         _loc8_ = PlayedCharacterManager.getInstance().id;
         if(!_loc7_["moodSmiley_" + _loc8_])
         {
            _loc7_.add("moodSmiley_" + _loc8_,"");
         }
         var _loc9_:String = _loc7_["moodSmiley_" + _loc8_];
         if((_loc9_) && !(_loc9_ == ""))
         {
            _loc11_ = new Date();
            _loc12_ = _loc9_.split("_");
            if(int(_loc12_[0]) > 0 && Number(_loc12_[1]) < _loc11_.time + 604800000)
            {
               _loc13_ = new MoodSmileyRequestAction();
               _loc13_.smileyId = int(_loc12_[0]);
               this.process(_loc13_);
            }
         }
         return true;
      }
      
      public function get entitiesFrame() : RoleplayEntitiesFrame {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      public function get socialFrame() : SocialFrame {
         return Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
      }
      
      public function get priority() : int {
         return 0;
      }
      
      public function get disallowedChannels() : Array {
         return this._aDisallowedChannels;
      }
      
      public function get chatColors() : Array {
         return this._aChatColors;
      }
      
      public function get censoredWords() : Dictionary {
         return this._aCensoredWords;
      }
      
      public function get smilies() : Array {
         return this._aSmilies;
      }
      
      public function set maxMessagesStored(param1:int) : void {
         this._maxMessagesStored = param1;
      }
      
      public function get maxMessagesStored() : int {
         return this._maxMessagesStored;
      }
      
      public function get smileyMood() : int {
         return this._smileyMood;
      }
      
      public function get ankaboxEnabled() : Boolean {
         return this._ankaboxEnabled;
      }
      
      public function process(param1:Message) : Boolean {
         var content:String = null;
         var bwira:BasicWhoIsRequestAction = null;
         var search:String = null;
         var nwira:NumericWhoIsRequestAction = null;
         var nwirmsg:NumericWhoIsRequestMessage = null;
         var ch:uint = 0;
         var ctoa:ChatTextOutputAction = null;
         var pattern:RegExp = null;
         var charTempL:String = null;
         var charTempR:String = null;
         var objects:Vector.<ObjectItem> = null;
         var scwomsg:ChatServerWithObjectMessage = null;
         var numItem:int = 0;
         var listItem:Vector.<ItemWrapper> = null;
         var casmsg:ChatAdminServerMessage = null;
         var pwmsg:PopupWarningMessage = null;
         var csmsg:ChatServerMessage = null;
         var bubbleContent:String = null;
         var newContent:Array = null;
         var thinking:Boolean = false;
         var cscwomsg:ChatServerCopyWithObjectMessage = null;
         var numItemc:int = 0;
         var listItemc:Vector.<ItemWrapper> = null;
         var cscmsg:ChatServerCopyMessage = null;
         var timsg:TextInformationMessage = null;
         var param:Array = null;
         var msgContent:String = null;
         var textId:uint = 0;
         var params:Array = null;
         var timestampf:Number = NaN;
         var comsg:ConsoleOutputMessage = null;
         var consoleTimestamp:Number = NaN;
         var taimsg:TextActionInformationMessage = null;
         var paramTaimsg:Array = null;
         var channel2:uint = 0;
         var timestamp2:Number = NaN;
         var cemsg:ChatErrorMessage = null;
         var timestampErr:Number = NaN;
         var contentErr:String = null;
         var sma:SaveMessageAction = null;
         var csrmsg:ChatSmileyRequestMessage = null;
         var lcsmsg:LocalizedChatSmileyMessage = null;
         var smileyItemLocalized:SmileyWrapper = null;
         var cell:GraphicCell = null;
         var gctr:GraphicContainer = null;
         var scmsg:ChatSmileyMessage = null;
         var smileyItem:SmileyWrapper = null;
         var smileyEntity:IDisplayable = null;
         var sysApi:SystemApi = null;
         var msrmsg:MoodSmileyRequestMessage = null;
         var msrtmsg:MoodSmileyResultMessage = null;
         var date:Date = null;
         var id:int = 0;
         var chatOpt:OptionManager = null;
         var cecmsg:ChannelEnablingChangeMessage = null;
         var cebmsg:ChannelEnablingMessage = null;
         var tua:TabsUpdateAction = null;
         var cca:ChatCommandAction = null;
         var ecmsg:EnabledChannelsMessage = null;
         var btmsg:BasicTimeMessage = null;
         var date2:Date = null;
         var oemsg:ObjectErrorMessage = null;
         var objectErrorText:String = null;
         var bwimsg:BasicWhoIsMessage = null;
         var areaName:String = null;
         var notice:String = null;
         var text:String = null;
         var nwimsg:NumericWhoIsMessage = null;
         var bwnmmsg:BasicWhoIsNoMatchMessage = null;
         var lomra:LivingObjectMessageRequestAction = null;
         var lomrmsg:LivingObjectMessageRequestMessage = null;
         var lommsg:LivingObjectMessageMessage = null;
         var speakingItemText:SpeakingItemText = null;
         var cla:ChatLoadedAction = null;
         var nbsmsg:NotificationByServerMessage = null;
         var a:Array = null;
         var notification:Notification = null;
         var title:String = null;
         var egtcgmsg:ExchangeGuildTaxCollectorGetMessage = null;
         var idFName:Number = NaN;
         var idName:Number = NaN;
         var taxCollectorName:String = null;
         var textObjects:String = null;
         var objectsAndExp:String = null;
         var nmmsg:MailStatusMessage = null;
         var msmsg:MailStatusMessage = null;
         var chans:Array = null;
         var indTabChan:int = 0;
         var bwirmsg:BasicWhoIsRequestMessage = null;
         var charas:CharacterCharacteristicsInformations = null;
         var infos:CharacterBaseInformations = null;
         var variables:Array = null;
         var variable:String = null;
         var guilde:String = null;
         var leftIndex:int = 0;
         var rightIndex:int = 0;
         var leftBlock:String = null;
         var rightBlock:String = null;
         var middleBlock:String = null;
         var replace:Boolean = false;
         var mapInfo:Array = null;
         var posX:Number = NaN;
         var posY:Number = NaN;
         var worldMapId:Number = NaN;
         var nb:int = 0;
         var o:int = 0;
         var ccmwomsg:ChatClientMultiWithObjectMessage = null;
         var itemWrapper:ItemWrapper = null;
         var objectItem:ObjectItem = null;
         var ccmmsg:ChatClientMultiMessage = null;
         var nb2:int = 0;
         var jo:int = 0;
         var ccpwomsg:ChatClientPrivateWithObjectMessage = null;
         var itemWrapper2:ItemWrapper = null;
         var objectItem2:ObjectItem = null;
         var ccpmsg:ChatClientPrivateMessage = null;
         var i:int = 0;
         var oi:ObjectItem = null;
         var speakerEntity:IDisplayable = null;
         var targetBounds:IRectangle = null;
         var tooltipContent:String = null;
         var tooltipTarget:TiphonSprite = null;
         var rider:TiphonSprite = null;
         var isCreatureMode:Boolean = false;
         var head:DisplayObject = null;
         var r1:Rectangle = null;
         var r2:Rectangle2 = null;
         var thinkBubble:ThinkBubble = null;
         var bubble:ChatBubble = null;
         var oic:ObjectItem = null;
         var iTimsg:* = undefined;
         var channel:uint = 0;
         var timestamp:Number = NaN;
         var iTaimsg:* = undefined;
         var entityInfo:GameContextActorInformations = null;
         var chanId:* = undefined;
         var socGroup:AbstractSocialGroupInfos = null;
         var parameter:String = null;
         var nbsmsgNid:uint = 0;
         var object:ObjectItemQuantity = null;
         var msg:Message = param1;
         switch(true)
         {
            case msg is BasicWhoIsRequestAction:
               bwira = msg as BasicWhoIsRequestAction;
               search = bwira.playerName;
               if(search.length >= 1 && search.length <= ProtocolConstantsEnum.MAX_PLAYER_OR_ACCOUNT_NAME_LEN)
               {
                  bwirmsg = new BasicWhoIsRequestMessage();
                  bwirmsg.initBasicWhoIsRequestMessage(bwira.verbose,bwira.playerName);
                  ConnectionsHandler.getConnection().send(bwirmsg);
               }
               return true;
            case msg is NumericWhoIsRequestAction:
               nwira = msg as NumericWhoIsRequestAction;
               nwirmsg = new NumericWhoIsRequestMessage();
               nwirmsg.initNumericWhoIsRequestMessage(nwira.playerId);
               ConnectionsHandler.getConnection().send(bwirmsg);
               return true;
            case msg is ChatTextOutputAction:
               ch = ChatTextOutputAction(msg).channel;
               ctoa = msg as ChatTextOutputAction;
               content = ctoa.content;
               content = StringUtils.concatSameString(content," ");
               content = content.split("\r").join(" ");
               if(content.length > 256)
               {
                  _log.error("Too long message has been truncated before sending.");
                  content = content.substr(0,255);
               }
               pattern = new RegExp("%[a-z]+%");
               if(content.match(pattern) != null)
               {
                  charas = PlayedCharacterManager.getInstance().characteristics;
                  infos = PlayedCharacterManager.getInstance().infos;
                  variables = I18n.getUiText("ui.chat.variable.experience").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),int((charas.experience - charas.experienceLevelFloor) / (charas.experienceNextLevelFloor - charas.experienceLevelFloor) * 100) + "%");
                  }
                  variables = I18n.getUiText("ui.chat.variable.level").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),infos.level);
                  }
                  variables = I18n.getUiText("ui.chat.variable.life").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),charas.lifePoints);
                  }
                  variables = I18n.getUiText("ui.chat.variable.maxlife").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),charas.maxLifePoints);
                  }
                  variables = I18n.getUiText("ui.chat.variable.lifepercent").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),int(charas.lifePoints / charas.maxLifePoints * 100) + "%");
                  }
                  variables = I18n.getUiText("ui.chat.variable.myself").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),infos.name);
                  }
                  variables = I18n.getUiText("ui.chat.variable.stats").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),I18n.getUiText("ui.chat.variable.statsresult",new Array(this.displayCarac(charas.vitality),this.displayCarac(charas.wisdom),this.displayCarac(charas.strength),this.displayCarac(charas.intelligence),this.displayCarac(charas.chance),this.displayCarac(charas.agility),this.displayCarac(charas.initiative),this.displayCarac(charas.actionPoints),this.displayCarac(charas.movementPoints))));
                  }
                  variables = I18n.getUiText("ui.chat.variable.area").split(",");
                  for each (variable in variables)
                  {
                     if(PlayedCharacterManager.getInstance().currentSubArea != null)
                     {
                        content = content.replace(new RegExp(variable,"g"),PlayedCharacterManager.getInstance().currentSubArea.area.name);
                     }
                  }
                  variables = I18n.getUiText("ui.chat.variable.subarea").split(",");
                  for each (variable in variables)
                  {
                     if(PlayedCharacterManager.getInstance().currentSubArea != null)
                     {
                        content = content.replace(new RegExp(variable,"g"),"{subArea," + PlayedCharacterManager.getInstance().currentSubArea.id + "}");
                     }
                  }
                  variables = I18n.getUiText("ui.chat.variable.position").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),"[" + PlayedCharacterManager.getInstance().currentMap.outdoorX + "," + PlayedCharacterManager.getInstance().currentMap.outdoorY + "," + PlayedCharacterManager.getInstance().currentWorldMap.id + "]");
                  }
                  variables = I18n.getUiText("ui.chat.variable.guild").split(",");
                  guilde = this.socialFrame.guild == null?I18n.getUiText("ui.chat.variable.guilderror"):this.socialFrame.guild.guildName;
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),guilde);
                  }
                  variables = I18n.getUiText("ui.chat.variable.achievement").split(",");
                  for each (variable in variables)
                  {
                     content = content.replace(new RegExp(variable,"g"),I18n.getUiText("ui.chat.variable.achievementResult",[PlayedCharacterManager.getInstance().achievementPoints,PlayedCharacterManager.getInstance().achievementPercent]));
                  }
               }
               charTempL = String.fromCharCode(2);
               charTempR = String.fromCharCode(3);
               while(true)
               {
                  leftIndex = content.indexOf("[");
                  if(leftIndex == -1)
                  {
                     break;
                  }
                  rightIndex = content.indexOf("]");
                  if(rightIndex == -1)
                  {
                     break;
                  }
                  if(leftIndex > rightIndex)
                  {
                     break;
                  }
                  leftBlock = content.substring(0,leftIndex);
                  rightBlock = content.substring(rightIndex + 1);
                  middleBlock = content.substring(leftIndex + 1,rightIndex);
                  replace = true;
                  mapInfo = middleBlock.split(",");
                  posX = NaN;
                  posY = NaN;
                  worldMapId = NaN;
                  if(mapInfo.length >= 2)
                  {
                     posX = Number(mapInfo[0]);
                     posY = Number(mapInfo[1]);
                  }
                  if(mapInfo.length == 3)
                  {
                     worldMapId = int(mapInfo[2]);
                  }
                  else
                  {
                     if(mapInfo.length == 2)
                     {
                        worldMapId = PlayedCharacterManager.getInstance().currentWorldMap.id;
                     }
                  }
                  if(!isNaN(posX) && !isNaN(posY) && !isNaN(worldMapId))
                  {
                     replace = false;
                     content = leftBlock + "{map," + int(posX) + "," + int(posY) + "," + worldMapId + "}" + rightBlock;
                  }
                  if(replace)
                  {
                     content = leftBlock + charTempL + middleBlock + charTempR + rightBlock;
                  }
               }
               content = content.split(charTempL).join("[").split(charTempR).join("]");
               if(content.length > 256)
               {
                  content = content.substr(0,253) + "...";
               }
               objects = new Vector.<ObjectItem>();
               if(!this._aChannels[ch].isPrivate)
               {
                  if(ctoa.objects)
                  {
                     nb = ctoa.objects.length;
                     o = 0;
                     while(o < nb)
                     {
                        itemWrapper = SecureCenter.unsecure(ctoa.objects[o]);
                        objectItem = new ObjectItem();
                        objectItem.initObjectItem(itemWrapper.position,itemWrapper.objectGID,itemWrapper.effectsList == null?new Vector.<ObjectEffect>():itemWrapper.effectsList,itemWrapper.objectUID,itemWrapper.quantity);
                        objects.push(objectItem);
                        o++;
                     }
                     ccmwomsg = new ChatClientMultiWithObjectMessage();
                     ccmwomsg.initChatClientMultiWithObjectMessage(content,ch,objects);
                     ConnectionsHandler.getConnection().send(ccmwomsg);
                  }
                  else
                  {
                     ccmmsg = new ChatClientMultiMessage();
                     ccmmsg.initChatClientMultiMessage(content,ch);
                     ConnectionsHandler.getConnection().send(ccmmsg);
                  }
               }
               else
               {
                  if(ctoa.receiverName.length < 2 || ctoa.receiverName.length > 31)
                  {
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.chat.error.1"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.getTimestamp());
                     return true;
                  }
                  if(ctoa.objects)
                  {
                     objects = new Vector.<ObjectItem>();
                     nb2 = ctoa.objects.length;
                     jo = 0;
                     while(jo < nb2)
                     {
                        itemWrapper2 = SecureCenter.unsecure(ctoa.objects[jo]);
                        objectItem2 = new ObjectItem();
                        objectItem2.initObjectItem(itemWrapper2.position,itemWrapper2.objectGID,itemWrapper2.effectsList == null?new Vector.<ObjectEffect>():itemWrapper2.effectsList,itemWrapper2.objectUID,itemWrapper2.quantity);
                        objects.push(objectItem2);
                        jo++;
                     }
                     ccpwomsg = new ChatClientPrivateWithObjectMessage();
                     ccpwomsg.initChatClientPrivateWithObjectMessage(content,ctoa.receiverName,objects);
                     ConnectionsHandler.getConnection().send(ccpwomsg);
                  }
                  else
                  {
                     ccpmsg = new ChatClientPrivateMessage();
                     ccpmsg.initChatClientPrivateMessage(content,ctoa.receiverName);
                     ConnectionsHandler.getConnection().send(ccpmsg);
                  }
               }
               return true;
            case msg is ChatServerWithObjectMessage:
               scwomsg = msg as ChatServerWithObjectMessage;
               AccountManager.getInstance().setAccount(scwomsg.senderName,scwomsg.senderAccountId);
               if(!(scwomsg.channel == RED_CHANNEL_ID) && !(scwomsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE) && ((this.socialFrame.isIgnored(scwomsg.senderName,scwomsg.senderAccountId)) || (this.socialFrame.isEnemy(scwomsg.senderName))))
               {
                  return true;
               }
               if(scwomsg.senderId != PlayedCharacterManager.getInstance().id)
               {
                  if(scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                  {
                     this.playAlertSound(GUILD_SOUND);
                  }
                  if(scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY || scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA)
                  {
                     this.playAlertSound(PARTY_SOUND);
                  }
                  if(scwomsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)
                  {
                     this.playAlertSound(PRIVATE_SOUND);
                  }
               }
               numItem = scwomsg.objects.length;
               listItem = new Vector.<ItemWrapper>(numItem);
               i = 0;
               while(i < numItem)
               {
                  oi = scwomsg.objects[i];
                  listItem[i] = ItemWrapper.create(oi.position,oi.objectUID,oi.objectGID,oi.quantity,oi.effects,false);
                  i++;
               }
               content = this.checkCensored(scwomsg.content,scwomsg.channel,scwomsg.senderAccountId,scwomsg.senderName)[0];
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServerWithObject,scwomsg.channel,scwomsg.senderId,scwomsg.senderName,content,this.getRealTimestamp(scwomsg.timestamp),scwomsg.fingerprint,listItem);
               this.saveMessage(scwomsg.channel,scwomsg.content,content,this.getRealTimestamp(scwomsg.timestamp),scwomsg.fingerprint,scwomsg.senderId,scwomsg.senderName,listItem);
               return true;
            case msg is ChatAdminServerMessage:
               casmsg = msg as ChatAdminServerMessage;
               AccountManager.getInstance().setAccount(casmsg.senderName,casmsg.senderAccountId);
               if(casmsg.senderId != PlayedCharacterManager.getInstance().id)
               {
                  if(casmsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                  {
                     this.playAlertSound(GUILD_SOUND);
                  }
                  if(casmsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY || casmsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA)
                  {
                     this.playAlertSound(PARTY_SOUND);
                  }
                  if(casmsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)
                  {
                     this.playAlertSound(PRIVATE_SOUND);
                  }
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServer,casmsg.channel,casmsg.senderId,casmsg.senderName,casmsg.content,this.getRealTimestamp(casmsg.timestamp),casmsg.fingerprint,true);
               this.saveMessage(casmsg.channel,casmsg.content,casmsg.content,this.getRealTimestamp(casmsg.timestamp),casmsg.fingerprint,casmsg.senderId,casmsg.senderName,null,"",0,0,null,true);
               return true;
            case msg is PopupWarningMessage:
               pwmsg = msg as PopupWarningMessage;
               KernelEventsManager.getInstance().processCallback(ChatHookList.PopupWarning,pwmsg.author,pwmsg.content,pwmsg.lockDuration);
               return true;
            case msg is ChatServerMessage:
               csmsg = msg as ChatServerMessage;
               AccountManager.getInstance().setAccount(csmsg.senderName,csmsg.senderAccountId);
               if(!(csmsg.channel == RED_CHANNEL_ID) && !(csmsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE) && ((this.socialFrame.isIgnored(csmsg.senderName,csmsg.senderAccountId)) || (this.socialFrame.isEnemy(csmsg.senderName))))
               {
                  return true;
               }
               if(csmsg.senderId != PlayedCharacterManager.getInstance().id)
               {
                  if(csmsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                  {
                     this.playAlertSound(GUILD_SOUND);
                  }
                  if(csmsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY || csmsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA)
                  {
                     this.playAlertSound(PARTY_SOUND);
                  }
                  if(csmsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)
                  {
                     this.playAlertSound(PRIVATE_SOUND);
                  }
               }
               newContent = this.checkCensored(csmsg.content,csmsg.channel,csmsg.senderAccountId,csmsg.senderName);
               content = newContent[0];
               if(csmsg.channel == ChatChannelsMultiEnum.CHANNEL_ADS)
               {
                  content = csmsg.content;
               }
               if(content.substr(0,6).toLowerCase() == "/think")
               {
                  thinking = true;
                  bubbleContent = newContent[1].substr(7);
               }
               else
               {
                  if(content.charAt(0) == "*" && content.charAt(content.length-1) == "*")
                  {
                     thinking = true;
                     bubbleContent = newContent[1].substr(1,content.length - 2);
                  }
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServer,csmsg.channel,csmsg.senderId,csmsg.senderName,content,this.getRealTimestamp(csmsg.timestamp),csmsg.fingerprint,false);
               this.saveMessage(csmsg.channel,csmsg.content,content,this.getRealTimestamp(csmsg.timestamp),csmsg.fingerprint,csmsg.senderId,csmsg.senderName);
               if((Kernel.getWorker().contains(FightBattleFrame)) || content.substr(0,3).toLowerCase() == "/me")
               {
                  return true;
               }
               if(csmsg.channel == ChatActivableChannelsEnum.CHANNEL_GLOBAL)
               {
                  speakerEntity = DofusEntities.getEntity(csmsg.senderId) as IDisplayable;
                  if(speakerEntity == null)
                  {
                     return true;
                  }
                  if(speakerEntity is AnimatedCharacter)
                  {
                     if((speakerEntity as AnimatedCharacter).isMoving)
                     {
                        return true;
                     }
                  }
                  if(speakerEntity is TiphonSprite)
                  {
                     tooltipTarget = speakerEntity as TiphonSprite;
                     rider = (speakerEntity as TiphonSprite).getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER,0) as TiphonSprite;
                     isCreatureMode = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame)) && (RoleplayEntitiesFrame(Kernel.getWorker().getFrame(RoleplayEntitiesFrame)).isCreatureMode);
                     if((rider) && !isCreatureMode)
                     {
                        tooltipTarget = rider;
                     }
                     head = tooltipTarget.getSlot("Tete");
                     if(head)
                     {
                        r1 = head.getBounds(StageShareManager.stage);
                        r2 = new Rectangle2(r1.x,r1.y,r1.width,r1.height);
                        targetBounds = r2;
                     }
                  }
                  if(!targetBounds)
                  {
                     targetBounds = (speakerEntity as IDisplayable).absoluteBounds;
                  }
                  tooltipContent = newContent[1];
                  if(thinking)
                  {
                     thinkBubble = new ThinkBubble(bubbleContent);
                  }
                  else
                  {
                     bubble = new ChatBubble(tooltipContent);
                  }
                  TooltipManager.show(thinking?thinkBubble:bubble,targetBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"msg" + csmsg.senderId,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,null,null,null,null,false,StrataEnum.STRATA_WORLD);
               }
               return true;
            case msg is ChatServerCopyWithObjectMessage:
               cscwomsg = msg as ChatServerCopyWithObjectMessage;
               numItemc = cscwomsg.objects.length;
               listItemc = new Vector.<ItemWrapper>(numItemc);
               i = 0;
               while(i < numItemc)
               {
                  oic = cscwomsg.objects[i];
                  listItemc[i] = ItemWrapper.create(oic.position,oic.objectUID,oic.objectGID,oic.quantity,oic.effects,false);
                  i++;
               }
               content = this.checkCensored(cscwomsg.content,cscwomsg.channel,PlayerManager.getInstance().accountId,PlayedCharacterManager.getInstance().infos.name)[0];
               this.saveMessage(cscwomsg.channel,cscwomsg.content,content,this.getRealTimestamp(cscwomsg.timestamp),cscwomsg.fingerprint,0,"",listItemc,cscwomsg.receiverName,cscwomsg.receiverId);
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServerCopyWithObject,cscwomsg.channel,cscwomsg.receiverName,content,this.getRealTimestamp(cscwomsg.timestamp),cscwomsg.fingerprint,cscwomsg.receiverId,listItemc);
               return true;
            case msg is ChatServerCopyMessage:
               cscmsg = msg as ChatServerCopyMessage;
               content = this.checkCensored(cscmsg.content,cscmsg.channel,PlayerManager.getInstance().accountId,PlayedCharacterManager.getInstance().infos.name)[0];
               this.saveMessage(cscmsg.channel,cscmsg.content,content,this.getRealTimestamp(cscmsg.timestamp),cscmsg.fingerprint,0,"",null,cscmsg.receiverName,cscmsg.receiverId);
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServerCopy,cscmsg.channel,cscmsg.receiverName,content,this.getRealTimestamp(cscmsg.timestamp),cscmsg.fingerprint,cscmsg.receiverId);
               return true;
            case msg is TextInformationMessage:
               timsg = msg as TextInformationMessage;
               param = new Array();
               for each (iTimsg in timsg.parameters)
               {
                  param.push(iTimsg);
               }
               params = new Array();
               if(InfoMessage.getInfoMessageById(timsg.msgType * 10000 + timsg.msgId))
               {
                  textId = InfoMessage.getInfoMessageById(timsg.msgType * 10000 + timsg.msgId).textId;
                  if(param != null)
                  {
                     if((param[0]) && !(param[0].indexOf("~") == -1))
                     {
                        params = param[0].split("~");
                     }
                     else
                     {
                        params = param;
                     }
                  }
               }
               else
               {
                  _log.error("Information message " + (timsg.msgType * 10000 + timsg.msgId) + " cannot be found.");
                  if(timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_ERROR)
                  {
                     textId = InfoMessage.getInfoMessageById(10231).textId;
                  }
                  else
                  {
                     textId = InfoMessage.getInfoMessageById(207).textId;
                  }
                  params.push(timsg.msgId);
               }
               msgContent = I18n.getText(textId);
               if(msgContent)
               {
                  msgContent = ParamsDecoder.applyParams(msgContent,params);
                  timestamp = this.getTimestamp();
                  if(timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_ERROR)
                  {
                     channel = RED_CHANNEL_ID;
                     this.playAlertSound(ALERT_SOUND);
                  }
                  else
                  {
                     if(timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_MESSAGE)
                     {
                        channel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO;
                     }
                     else
                     {
                        if(timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_PVP)
                        {
                           channel = ChatActivableChannelsEnum.CHANNEL_ALLIANCE;
                        }
                        else
                        {
                           if(timsg.msgType == TextInformationTypeEnum.TEXT_INFORMATION_FIGHT)
                           {
                              channel = ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG;
                           }
                        }
                     }
                  }
                  this.saveMessage(channel,null,msgContent,timestamp);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,msgContent,channel,timestamp,false);
               }
               else
               {
                  _log.error("There\'s no message for id " + (timsg.msgType * 10000 + timsg.msgId));
               }
               return true;
            case msg is FightOutputAction:
               timestampf = this.getTimestamp();
               this.saveMessage(FightOutputAction(msg).channel,null,FightOutputAction(msg).content,timestampf);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,FightOutputAction(msg).content,FightOutputAction(msg).channel,timestampf,false);
               return true;
            case msg is ConsoleOutputMessage:
               comsg = msg as ConsoleOutputMessage;
               if(comsg.consoleId != "chat")
               {
                  return false;
               }
               consoleTimestamp = this.getTimestamp();
               this.saveMessage(ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,null,comsg.text,consoleTimestamp);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,comsg.text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,consoleTimestamp,false);
               return true;
            case msg is TextActionInformationMessage:
               taimsg = msg as TextActionInformationMessage;
               paramTaimsg = new Array();
               for each (iTaimsg in taimsg.params)
               {
                  paramTaimsg.push(iTaimsg);
               }
               channel2 = ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG;
               timestamp2 = this.getTimestamp();
               this.saveMessage(channel2,null,"",timestamp2,"",0,"",null,"",0,taimsg.textKey,paramTaimsg);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextActionInformation,taimsg.textKey,params,channel2,timestamp2,false);
               return true;
            case msg is ChatErrorMessage:
               cemsg = msg as ChatErrorMessage;
               timestampErr = this.getTimestamp();
               switch(cemsg.reason)
               {
                  case ChatErrorEnum.CHAT_ERROR_INTERIOR_MONOLOGUE:
                  case ChatErrorEnum.CHAT_ERROR_INVALID_MAP:
                  case ChatErrorEnum.CHAT_ERROR_NO_GUILD:
                  case ChatErrorEnum.CHAT_ERROR_NO_PARTY:
                  case ChatErrorEnum.CHAT_ERROR_RECEIVER_NOT_FOUND:
                  case ChatErrorEnum.CHAT_ERROR_NO_PARTY_ARENA:
                  case ChatErrorEnum.CHAT_ERROR_NO_TEAM:
                     contentErr = I18n.getUiText("ui.chat.error." + cemsg.reason);
                     break;
                  case ChatErrorEnum.CHAT_ERROR_ALLIANCE:
                  default:
                     contentErr = I18n.getUiText("ui.chat.error.0");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,contentErr,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,timestampErr);
               return true;
            case msg is SaveMessageAction:
               sma = SaveMessageAction(msg);
               this.saveMessage(sma.channel,sma.content,sma.content,sma.timestamp);
               return true;
            case msg is ChatSmileyRequestAction:
               csrmsg = new ChatSmileyRequestMessage();
               csrmsg.initChatSmileyRequestMessage(ChatSmileyRequestAction(msg).smileyId);
               ConnectionsHandler.getConnection().send(csrmsg);
               return true;
            case msg is LocalizedChatSmileyMessage:
               lcsmsg = msg as LocalizedChatSmileyMessage;
               smileyItemLocalized = new SmileyWrapper();
               smileyItemLocalized.id = lcsmsg.smileyId;
               cell = InteractiveCellManager.getInstance().getCell(lcsmsg.cellId);
               gctr = new GraphicContainer();
               gctr.x = cell.x;
               gctr.y = cell.y;
               gctr.width = cell.width;
               gctr.height = cell.height;
               gctr.x = gctr.x + 14;
               gctr.y = gctr.y - 35;
               if(cell)
               {
                  TooltipManager.show(smileyItemLocalized,gctr,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"smiley_" + lcsmsg.entityId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,StrataEnum.STRATA_WORLD);
               }
               return true;
            case msg is ChatSmileyMessage:
               scmsg = msg as ChatSmileyMessage;
               AccountManager.getInstance().setAccountFromId(scmsg.entityId,scmsg.accountId);
               if(this.entitiesFrame)
               {
                  entityInfo = this.entitiesFrame.getEntityInfos(scmsg.entityId);
                  if((entityInfo) && (entityInfo is GameRolePlayCharacterInformations) && (this.socialFrame.isIgnored(GameRolePlayCharacterInformations(entityInfo).name,scmsg.accountId)))
                  {
                     return true;
                  }
               }
               smileyItem = new SmileyWrapper();
               smileyItem.id = scmsg.smileyId;
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatSmiley,scmsg.smileyId,scmsg.entityId);
               smileyEntity = DofusEntities.getEntity(scmsg.entityId) as IDisplayable;
               if(smileyEntity == null)
               {
                  return true;
               }
               if(smileyEntity is AnimatedCharacter)
               {
                  if((smileyEntity as AnimatedCharacter).isMoving)
                  {
                     return true;
                  }
               }
               sysApi = new SystemApi();
               TooltipManager.show(smileyItem,smileyEntity.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"smiley" + scmsg.entityId,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,null,null,null,null,false,StrataEnum.STRATA_WORLD,sysApi.getCurrentZoom());
               return true;
            case msg is MoodSmileyRequestAction:
               msrmsg = new MoodSmileyRequestMessage();
               msrmsg.initMoodSmileyRequestMessage(MoodSmileyRequestAction(msg).smileyId);
               ConnectionsHandler.getConnection().send(msrmsg);
               return true;
            case msg is MoodSmileyResultMessage:
               msrtmsg = msg as MoodSmileyResultMessage;
               this._smileyMood = msrtmsg.smileyId;
               date = new Date();
               id = PlayedCharacterManager.getInstance().id;
               chatOpt = OptionManager.getOptionManager("chat");
               if(!chatOpt["moodSmiley_" + id])
               {
                  chatOpt.add("moodSmiley_" + id,"");
               }
               chatOpt["moodSmiley_" + id] = this._smileyMood + "_" + date.time;
               KernelEventsManager.getInstance().processCallback(ChatHookList.MoodResult,msrtmsg.resultCode,msrtmsg.smileyId);
               return true;
            case msg is ChannelEnablingChangeMessage:
               cecmsg = msg as ChannelEnablingChangeMessage;
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChannelEnablingChange,cecmsg.channel,cecmsg.enable);
               return true;
            case msg is ChannelEnablingAction:
               cebmsg = new ChannelEnablingMessage();
               cebmsg.initChannelEnablingMessage(ChannelEnablingAction(msg).channel,ChannelEnablingAction(msg).enable);
               ConnectionsHandler.getConnection().send(cebmsg);
               return true;
            case msg is TabsUpdateAction:
               tua = msg as TabsUpdateAction;
               if(tua.tabs)
               {
                  OptionManager.getOptionManager("chat").channelTabs = tua.tabs;
               }
               if(tua.tabsNames)
               {
                  OptionManager.getOptionManager("chat").tabsNames = tua.tabsNames;
               }
               return true;
            case msg is ChatCommandAction:
               cca = msg as ChatCommandAction;
               try
               {
                  ConsolesManager.getConsole("chat").process(ConsolesManager.getMessage(cca.command));
               }
               catch(ucie:UnhandledConsoleInstructionError)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,ucie.message,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,getTimestamp());
               }
               return true;
            case msg is EnabledChannelsMessage:
               ecmsg = msg as EnabledChannelsMessage;
               for each (chanId in ecmsg.disallowed)
               {
                  this._aDisallowedChannels.push(chanId);
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.EnabledChannels,ecmsg.channels);
               return true;
            case msg is BasicTimeMessage:
               btmsg = msg as BasicTimeMessage;
               date2 = new Date();
               TimeManager.getInstance().serverTimeLag = (btmsg.timestamp + btmsg.timezoneOffset * 60) * 1000 - date2.getTime();
               TimeManager.getInstance().timezoneOffset = btmsg.timezoneOffset * 60 * 1000;
               TimeManager.getInstance().dofusTimeYearLag = -1370;
               return true;
            case msg is ObjectErrorMessage:
               oemsg = msg as ObjectErrorMessage;
               if(oemsg.reason == ObjectErrorEnum.MIMICRY_OBJECT_ERROR)
               {
                  return false;
               }
               switch(oemsg.reason)
               {
                  case ObjectErrorEnum.INVENTORY_FULL:
                     objectErrorText = I18n.getUiText("ui.objectError.InventoryFull");
                     break;
                  case ObjectErrorEnum.CANNOT_EQUIP_TWICE:
                     objectErrorText = I18n.getUiText("ui.objectError.CannotEquipTwice");
                     break;
                  case ObjectErrorEnum.NOT_TRADABLE:
                     break;
                  case ObjectErrorEnum.CANNOT_DROP:
                     objectErrorText = I18n.getUiText("ui.objectError.CannotDrop");
                     break;
                  case ObjectErrorEnum.CANNOT_DROP_NO_PLACE:
                     objectErrorText = I18n.getUiText("ui.objectError.CannotDropNoPlace");
                     break;
                  case ObjectErrorEnum.CANNOT_DESTROY:
                     objectErrorText = I18n.getUiText("ui.objectError.CannotDelete");
                     break;
                  case ObjectErrorEnum.LEVEL_TOO_LOW:
                     objectErrorText = I18n.getUiText("ui.objectError.levelTooLow");
                     break;
                  case ObjectErrorEnum.LIVING_OBJECT_REFUSED_FOOD:
                     objectErrorText = I18n.getUiText("ui.objectError.LivingObjectRefusedFood");
                     break;
               }
               this.playAlertSound(ALERT_SOUND);
               if(objectErrorText)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,objectErrorText,RED_CHANNEL_ID,this.getTimestamp());
               }
               else
               {
                  _log.error("Texte d\'erreur objet " + oemsg.reason + " manquant");
               }
               return false;
            case msg is BasicWhoIsMessage:
               bwimsg = msg as BasicWhoIsMessage;
               if(!bwimsg.verbose)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.SilentWhoIs,bwimsg.accountId,bwimsg.accountNickname,bwimsg.areaId,bwimsg.playerId,bwimsg.playerName,bwimsg.position,bwimsg.socialGroups);
                  return true;
               }
               if(bwimsg.areaId != -1)
               {
                  areaName = Area.getAreaById(bwimsg.areaId).name;
               }
               else
               {
                  areaName = I18n.getUiText("ui.common.unknowArea");
               }
               notice = "{player," + bwimsg.playerName + "," + bwimsg.playerId + "}";
               if(bwimsg.position == GameHierarchyEnum.MODERATOR)
               {
                  notice = notice + (" (" + HtmlManager.addTag(I18n.getUiText("ui.common.moderator"),HtmlManager.SPAN,
                     {
                        "color":XmlConfig.getInstance().getEntry("colors.hierarchy.moderator"),
                        "bold":true
                     }) + ")");
               }
               else
               {
                  if(bwimsg.position == GameHierarchyEnum.GAMEMASTER_PADAWAN)
                  {
                     notice = notice + (" (" + HtmlManager.addTag(I18n.getUiText("ui.common.gameMasterAssistant"),HtmlManager.SPAN,
                        {
                           "color":XmlConfig.getInstance().getEntry("colors.hierarchy.gamemaster_padawan"),
                           "bold":true
                        }) + ")");
                  }
                  else
                  {
                     if(bwimsg.position == GameHierarchyEnum.GAMEMASTER)
                     {
                        notice = notice + (" (" + HtmlManager.addTag(I18n.getUiText("ui.common.gameMaster"),HtmlManager.SPAN,
                           {
                              "color":XmlConfig.getInstance().getEntry("colors.hierarchy.gamemaster"),
                              "bold":true
                           }) + ")");
                     }
                     else
                     {
                        if(bwimsg.position == GameHierarchyEnum.ADMIN)
                        {
                           notice = notice + " (";
                           notice = notice + HtmlManager.addTag(I18n.getUiText("ui.common.administrator"),HtmlManager.SPAN,
                              {
                                 "color":XmlConfig.getInstance().getEntry("colors.hierarchy.administrator"),
                                 "bold":true
                              });
                           notice = notice + ")";
                        }
                     }
                  }
               }
               if(bwimsg.playerState == PlayerStateEnum.NOT_CONNECTED)
               {
                  text = I18n.getUiText("ui.common.disconnected",[bwimsg.accountNickname,notice]);
               }
               else
               {
                  text = I18n.getUiText("ui.common.whois",[bwimsg.accountNickname,notice,areaName]);
               }
               if(bwimsg.socialGroups.length > 0)
               {
                  for each (socGroup in bwimsg.socialGroups)
                  {
                     if(socGroup is BasicGuildInformations)
                     {
                        text = text + (" " + I18n.getUiText("ui.common.guild") + " {guild," + (socGroup as BasicGuildInformations).guildId + "::" + (socGroup as BasicGuildInformations).guildName + "}");
                     }
                     else
                     {
                        if(socGroup is BasicAllianceInformations)
                        {
                           text = text + (", " + I18n.getUiText("ui.common.alliance").toLowerCase() + " {alliance," + (socGroup as BasicAllianceInformations).allianceId + "::[" + (socGroup as BasicAllianceInformations).allianceTag + "]}");
                        }
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.getTimestamp());
               return true;
            case msg is NumericWhoIsMessage:
               nwimsg = msg as NumericWhoIsMessage;
               AccountManager.getInstance().setAccountFromId(nwimsg.playerId,nwimsg.accountId);
               KernelEventsManager.getInstance().processCallback(ChatHookList.NumericWhoIs,nwimsg.playerId,nwimsg.accountId);
               return true;
            case msg is BasicWhoIsNoMatchMessage:
               bwnmmsg = msg as BasicWhoIsNoMatchMessage;
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.common.playerNotFound",[bwnmmsg.search]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.getTimestamp());
               return true;
            case msg is LivingObjectMessageRequestAction:
               lomra = msg as LivingObjectMessageRequestAction;
               lomrmsg = new LivingObjectMessageRequestMessage();
               lomrmsg.initLivingObjectMessageRequestMessage(lomra.msgId,null,lomra.livingObjectUID);
               ConnectionsHandler.getConnection().send(lomrmsg);
               return true;
            case msg is LivingObjectMessageMessage:
               lommsg = msg as LivingObjectMessageMessage;
               speakingItemText = SpeakingItemText.getSpeakingItemTextById(lommsg.msgId);
               KernelEventsManager.getInstance().processCallback(ChatHookList.LivingObjectMessage,lommsg.owner,speakingItemText.textString,this.getRealTimestamp(lommsg.timeStamp));
               return true;
            case msg is ChatLoadedAction:
               cla = msg as ChatLoadedAction;
               SpeakingItemManager.getInstance().triggerEvent(SpeakingItemManager.SPEAK_TRIGGER_ON_CONNECT);
               return true;
            case msg is NotificationByServerMessage:
               nbsmsg = msg as NotificationByServerMessage;
               a = new Array();
               for each (parameter in nbsmsg.parameters)
               {
                  a.push(parameter);
               }
               notification = Notification.getNotificationById(nbsmsg.id);
               title = I18n.getText(notification.titleId);
               text = I18n.getText(notification.messageId,a);
               if(notification.id)
               {
                  nbsmsgNid = NotificationManager.getInstance().prepareNotification(title,text,notification.iconId,"serverMsg_" + notification.id);
                  NotificationManager.getInstance().addCallbackToNotification(nbsmsgNid,"NotificationUpdateFlag",[notification.id]);
                  NotificationManager.getInstance().sendNotification(nbsmsgNid);
               }
               return true;
            case msg is ExchangeGuildTaxCollectorGetMessage:
               egtcgmsg = msg as ExchangeGuildTaxCollectorGetMessage;
               idFName = parseInt(egtcgmsg.collectorName.split(",")[0],36);
               idName = parseInt(egtcgmsg.collectorName.split(",")[1],36);
               taxCollectorName = TaxCollectorFirstname.getTaxCollectorFirstnameById(idFName).firstname + " " + TaxCollectorName.getTaxCollectorNameById(idName).name;
               textObjects = "";
               for each (object in egtcgmsg.objectsInfos)
               {
                  if(textObjects != "")
                  {
                     textObjects = textObjects + ", ";
                  }
                  textObjects = textObjects + (object.quantity + "x" + Item.getItemById(object.objectUID).name);
               }
               if(textObjects != "")
               {
                  objectsAndExp = I18n.getUiText("ui.social.thingsTaxCollectorGet",[textObjects,egtcgmsg.experience]);
               }
               else
               {
                  objectsAndExp = I18n.getUiText("ui.social.xpTaxCollectorGet",[egtcgmsg.experience]);
               }
               text = I18n.getUiText("ui.social.taxcollectorRecolted",[taxCollectorName,"(" + egtcgmsg.worldX + ", " + egtcgmsg.worldY + ")",egtcgmsg.userName,objectsAndExp]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.CHANNEL_GUILD,this.getTimestamp());
               return true;
            case msg is NewMailMessage:
               nmmsg = msg as NewMailMessage;
               this._ankaboxEnabled = true;
               KernelEventsManager.getInstance().processCallback(ChatHookList.MailStatus,true,nmmsg.unread,nmmsg.total);
               return true;
            case msg is MailStatusMessage:
               msmsg = msg as MailStatusMessage;
               this._ankaboxEnabled = true;
               KernelEventsManager.getInstance().processCallback(ChatHookList.MailStatus,false,msmsg.unread,msmsg.total);
               return true;
            case msg is ClearChatAction:
               chans = (msg as ClearChatAction).channel;
               for each (indTabChan in chans)
               {
                  this._aMessagesByChannel[indTabChan] = new Array();
                  this._aParagraphesByChannel[indTabChan] = new Array();
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function getRedId() : uint {
         return RED_CHANNEL_ID;
      }
      
      public function getMessages() : Array {
         return this._aMessagesByChannel;
      }
      
      public function getParagraphes() : Array {
         return this._aParagraphesByChannel;
      }
      
      public function get options() : ChatOptions {
         return this._options;
      }
      
      public function setDisplayOptions(param1:ChatOptions) : void {
         this._options = param1;
      }
      
      private function onCssLoaded() : void {
         var _loc2_:Object = null;
         var _loc1_:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         var _loc3_:* = 0;
         while(_loc3_ < 13)
         {
            _loc2_ = _loc1_.getStyle("p" + _loc3_);
            this._aChatColors[_loc3_] = uint(this.color0x(_loc2_["color"]));
            _loc3_++;
         }
         _loc2_ = _loc1_.getStyle("p");
         this._aChatColors.push(uint(this.color0x(_loc2_["color"])));
      }
      
      private function color0x(param1:String) : String {
         return param1.replace("#","0x");
      }
      
      private function displayCarac(param1:CharacterBaseCharacteristic) : String {
         var _loc2_:int = param1.alignGiftBonus + param1.contextModif + param1.objectsAndMountBonus;
         var _loc3_:* = "+";
         if(_loc2_ < 0)
         {
            _loc3_ = "";
         }
         return param1.base + " (" + _loc3_ + _loc2_ + ")";
      }
      
      private function playAlertSound(param1:uint) : void {
         if(Kernel.getWorker().getFrame(LoadingModuleFrame) as LoadingModuleFrame)
         {
            return;
         }
         var _loc2_:SoundApi = new SoundApi();
         switch(param1)
         {
            case GUILD_SOUND:
               if(_loc2_.playSoundForGuildMessage())
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.GUILD_CHAT_MESSAGE);
               }
               break;
            case PARTY_SOUND:
               if(_loc2_.playSoundForGuildMessage())
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.PARTY_CHAT_MESSAGE);
               }
               break;
            case PRIVATE_SOUND:
               if(_loc2_.playSoundForGuildMessage())
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.PRIVATE_CHAT_MESSAGE);
               }
               break;
            case ALERT_SOUND:
               SoundManager.getInstance().manager.playUISound(UISoundEnum.RED_CHAT_MESSAGE);
               break;
         }
      }
      
      private function saveMessage(param1:int=0, param2:String="", param3:String="", param4:Number=0, param5:String="", param6:uint=0, param7:String="", param8:Vector.<ItemWrapper>=null, param9:String="", param10:uint=0, param11:uint=0, param12:Array=null, param13:Boolean=false) : void {
         var _loc14_:Object = null;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         if(param9 != "")
         {
            _loc14_ = new ChatSentenceWithRecipient(this._msgUId,param2,param3,param1,param4,param5,param6,param7,param9,param10,param8);
         }
         else
         {
            if(param7 != "")
            {
               _loc14_ = new ChatSentenceWithSource(this._msgUId,param2,param3,param1,param4,param5,param6,param7,param8,param13);
            }
            else
            {
               if(param11 != 0)
               {
                  _loc14_ = new ChatInformationSentence(this._msgUId,param2,param3,param1,param4,param5,param11,param12);
               }
               else
               {
                  _loc14_ = new BasicChatSentence(this._msgUId,param2,param3,param1,param4,param5);
               }
            }
         }
         this._aMessagesByChannel[param1].push(_loc14_);
         var _loc15_:uint = 0;
         if(this._aMessagesByChannel[param1].length > this._maxMessagesStored)
         {
            _loc16_ = this._aMessagesByChannel[param1].length - this._maxMessagesStored;
            _loc17_ = 0;
            while(_loc17_ < _loc16_)
            {
               _loc15_++;
               _loc17_++;
            }
         }
         this._msgUId++;
         KernelEventsManager.getInstance().processCallback(ChatHookList.NewMessage,param1,_loc15_);
      }
      
      public function addParagraphToHistory(param1:int, param2:Object) : void {
         if(param2 != null)
         {
            param2.id = this._msgUId;
            this._aParagraphesByChannel[param1].push(param2);
         }
      }
      
      public function removeLinesFromHistory(param1:int, param2:int) : void {
         var _loc3_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            this._aMessagesByChannel[param2].shift();
            this._aParagraphesByChannel[param2].shift();
            _loc3_++;
         }
      }
      
      private function getTimestamp() : Number {
         return TimeManager.getInstance().getTimestamp();
      }
      
      private function getRealTimestamp(param1:Number) : Number {
         return param1 * 1000 + TimeManager.getInstance().timezoneOffset;
      }
      
      public function getTimestampServerByRealTimestamp(param1:Number) : Number {
         return (param1 - TimeManager.getInstance().timezoneOffset) / 1000;
      }
      
      public function checkCensored(param1:String, param2:uint, param3:uint, param4:String) : Array {
         var _loc12_:String = null;
         var _loc13_:uint = 0;
         var _loc14_:Array = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:Array = null;
         var _loc18_:* = false;
         var _loc19_:Array = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:* = 0;
         var _loc24_:String = null;
         var _loc25_:* = 0;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:* = 0;
         var _loc30_:String = null;
         var _loc31_:Object = null;
         var _loc32_:String = null;
         var _loc5_:String = param1;
         if((((OptionManager.getOptionManager("chat").filterInsult) && (!(param2 == 8))) && (!(param2 == 10))) && (!(param2 == 11)) && !(param2 == 666))
         {
            _loc15_ = XmlConfig.getInstance().getEntry("config.lang.current");
            _loc16_ = "";
            _loc17_ = ["&","%","?","#","§","!"];
            _loc18_ = _loc15_ == "ja";
            if(!_loc18_)
            {
               _loc19_ = _loc5_.split(" ");
               for each (_loc20_ in _loc19_)
               {
                  _loc21_ = _loc20_.toLowerCase();
                  _loc22_ = "";
                  if(this._aCensoredWords)
                  {
                     if(this._aCensoredWords[_loc21_])
                     {
                        _loc23_ = 0;
                        while(_loc23_ < _loc21_.length)
                        {
                           _loc22_ = _loc22_ + _loc17_[_loc21_.charCodeAt(_loc23_) % 5];
                           _loc23_++;
                        }
                     }
                     else
                     {
                        for (_loc24_ in this._aCensoredWords)
                        {
                           if(this._aCensoredWords[_loc24_] == 2)
                           {
                              if(_loc21_.indexOf(_loc24_) != -1)
                              {
                                 _loc25_ = 0;
                                 while(_loc25_ < _loc21_.length)
                                 {
                                    _loc22_ = _loc22_ + _loc17_[_loc21_.charCodeAt(_loc25_) % 5];
                                    _loc25_++;
                                 }
                              }
                              continue;
                           }
                        }
                     }
                  }
                  if(_loc22_ == "")
                  {
                     _loc22_ = _loc20_;
                  }
                  _loc16_ = _loc16_ + (_loc22_ + " ");
               }
               _loc5_ = _loc16_.slice(0,_loc16_.length-1);
            }
            else
            {
               _loc26_ = "&%?§!&?&%§!&%!&%?#§!";
               _loc27_ = _loc5_.toUpperCase();
               for (_loc28_ in this._aCensoredWords)
               {
                  _loc29_ = 0;
                  while(_loc29_ != -1)
                  {
                     _loc29_ = _loc27_.indexOf(_loc28_);
                     if(_loc29_ != -1)
                     {
                        _loc5_ = _loc5_.substr(0,_loc29_) + _loc26_.substr(0,_loc28_.length) + _loc5_.substr(_loc29_ + _loc28_.length);
                        _loc27_ = _loc5_.toUpperCase();
                     }
                  }
               }
            }
         }
         var _loc6_:Array = _loc5_.split(" ");
         var _loc7_:* = "";
         var _loc8_:* = false;
         var _loc9_:* = "";
         var _loc10_:* = "";
         var _loc11_:* = "";
         for each (_loc12_ in _loc6_)
         {
            _loc30_ = "";
            _loc31_ = this.needToFormateUrl(_loc12_);
            if(_loc31_.formate)
            {
               _loc30_ = _loc30_ + HtmlManager.addLink("[" + _loc31_.url + "]","event:chatLinkRelease," + _loc31_.url + "," + param3 + "," + param4,{"bold":true});
               _loc8_ = true;
            }
            if(_loc30_ == "")
            {
               _loc30_ = _loc12_;
            }
            _loc7_ = _loc7_ + (_loc30_ + " ");
         }
         _loc5_ = _loc7_.slice(0,_loc7_.length-1);
         _loc13_ = 0;
         _loc14_ = new Array();
         if(_loc13_ > 0)
         {
            _loc32_ = I18n.getUiText("ui.popup.warning");
            _loc14_[0] = _loc5_ + " [" + HtmlManager.addLink(I18n.getUiText("ui.popup.warning"),"event:chatWarning",{"color":XmlConfig.getInstance().getEntry("colors.hyperlink.warning")}) + "]";
            _loc14_[1] = _loc5_ + " [" + _loc32_ + "]";
         }
         else
         {
            _loc14_[0] = _loc5_;
            _loc14_[1] = _loc5_;
         }
         return _loc14_;
      }
      
      public function needToFormateUrl(param1:String) : Object {
         var _loc2_:String = param1.replace("&amp;amp;","&");
         var _loc3_:* = !(_loc2_ == param1);
         var _loc4_:RegExp = new RegExp(URL_MATCHER);
         var _loc5_:Object = _loc4_.exec(_loc2_);
         var _loc6_:Object = new Object();
         _loc6_.formate = false;
         if(_loc5_)
         {
            if(_loc3_)
            {
               _loc6_.url = _loc5_[0].replace("&","&amp;amp;");
            }
            else
            {
               _loc6_.url = _loc5_[0];
            }
            _loc6_.index = _loc5_.index;
            if(_loc5_[2] == undefined && _loc5_[8] == undefined && _loc5_[7].split(".").length >= 2 && LINK_TLDS.indexOf(_loc5_[11]) == -1)
            {
               _loc6_.formate = false;
            }
            else
            {
               _loc6_.formate = true;
            }
         }
         return _loc6_;
      }
   }
}
