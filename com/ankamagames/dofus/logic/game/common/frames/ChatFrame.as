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
   import __AS3__.vec.*;
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
         var i:Object = null;
         var smiley:Smiley = null;
         var lang:String = null;
         var censoreds:Array = null;
         var wordCount:uint = 0;
         var word:* = undefined;
         var chatOpt:OptionManager = null;
         var id:* = 0;
         var smileyW:SmileyWrapper = null;
         var date:Date = null;
         var arrayMood:Array = null;
         var action:MoodSmileyRequestAction = null;
         this._options = new ChatOptions();
         this.setDisplayOptions(this._options);
         this._aChannels = ChatChannel.getChannels();
         this._aDisallowedChannels = new Array();
         this._aMessagesByChannel = new Array();
         this._aParagraphesByChannel = new Array();
         this._aSmilies = new Array();
         this._aCensoredWords = new Dictionary();
         for (i in this._aChannels)
         {
            this._aMessagesByChannel[this._aChannels[i].id] = new Array();
            this._aParagraphesByChannel[this._aChannels[i].id] = new Array();
         }
         this._aMessagesByChannel[RED_CHANNEL_ID] = new Array();
         this._aParagraphesByChannel[RED_CHANNEL_ID] = new Array();
         ConsolesManager.registerConsole("chat",new ConsoleHandler(Kernel.getWorker(),false,true),new ChatConsoleInstructionRegistrar());
         for each (smiley in Smiley.getSmileys())
         {
            if(smiley.forPlayers)
            {
               smileyW = SmileyWrapper.create(smiley.id,smiley.gfxId,smiley.order);
               this._aSmilies.push(smileyW);
            }
         }
         this._aSmilies.sortOn("order",Array.NUMERIC);
         lang = XmlConfig.getInstance().getEntry("config.lang.current");
         censoreds = CensoredWord.getCensoredWords();
         wordCount = 0;
         for each (word in censoreds)
         {
            if(word)
            {
               if(word.language == lang)
               {
                  wordCount++;
                  if(word.deepLooking)
                  {
                     this._aCensoredWords[word.word] = 2;
                  }
                  else
                  {
                     this._aCensoredWords[word.word] = 1;
                  }
               }
            }
         }
         chatOpt = OptionManager.getOptionManager("chat");
         id = PlayedCharacterManager.getInstance().id;
         if(!chatOpt["moodSmiley_" + id])
         {
            chatOpt.add("moodSmiley_" + id,"");
         }
         var moodSmileyId:String = chatOpt["moodSmiley_" + id];
         if((moodSmileyId) && (!(moodSmileyId == "")))
         {
            date = new Date();
            arrayMood = moodSmileyId.split("_");
            if((int(arrayMood[0]) > 0) && (Number(arrayMood[1]) < date.time + 604800000))
            {
               action = new MoodSmileyRequestAction();
               action.smileyId = int(arrayMood[0]);
               this.process(action);
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
      
      public function set maxMessagesStored(val:int) : void {
         this._maxMessagesStored = val;
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
      
      public function process(msg:Message) : Boolean {
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
         switch(true)
         {
            case msg is BasicWhoIsRequestAction:
               bwira = msg as BasicWhoIsRequestAction;
               search = bwira.playerName;
               if((search.length >= 1) && (search.length <= ProtocolConstantsEnum.MAX_PLAYER_OR_ACCOUNT_NAME_LEN))
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
                  if((!isNaN(posX)) && (!isNaN(posY)) && (!isNaN(worldMapId)))
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
                  if((ctoa.receiverName.length < 2) || (ctoa.receiverName.length > 31))
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
               if((!(scwomsg.channel == RED_CHANNEL_ID)) && (!(scwomsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)) && ((this.socialFrame.isIgnored(scwomsg.senderName,scwomsg.senderAccountId)) || (this.socialFrame.isEnemy(scwomsg.senderName))))
               {
                  return true;
               }
               if(scwomsg.senderId != PlayedCharacterManager.getInstance().id)
               {
                  if(scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                  {
                     this.playAlertSound(GUILD_SOUND);
                  }
                  if((scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY) || (scwomsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA))
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
                  if((casmsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY) || (casmsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA))
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
               if((!(csmsg.channel == RED_CHANNEL_ID)) && (!(csmsg.channel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE)) && ((this.socialFrame.isIgnored(csmsg.senderName,csmsg.senderAccountId)) || (this.socialFrame.isEnemy(csmsg.senderName))))
               {
                  return true;
               }
               if(csmsg.senderId != PlayedCharacterManager.getInstance().id)
               {
                  if(csmsg.channel == ChatActivableChannelsEnum.CHANNEL_GUILD)
                  {
                     this.playAlertSound(GUILD_SOUND);
                  }
                  if((csmsg.channel == ChatActivableChannelsEnum.CHANNEL_PARTY) || (csmsg.channel == ChatActivableChannelsEnum.CHANNEL_ARENA))
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
                  if((content.charAt(0) == "*") && (content.charAt(content.length - 1) == "*"))
                  {
                     thinking = true;
                     bubbleContent = newContent[1].substr(1,content.length - 2);
                  }
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.ChatServer,csmsg.channel,csmsg.senderId,csmsg.senderName,content,this.getRealTimestamp(csmsg.timestamp),csmsg.fingerprint,false);
               this.saveMessage(csmsg.channel,csmsg.content,content,this.getRealTimestamp(csmsg.timestamp),csmsg.fingerprint,csmsg.senderId,csmsg.senderName);
               if((Kernel.getWorker().contains(FightBattleFrame)) || (content.substr(0,3).toLowerCase() == "/me"))
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
                     if((rider) && (!isCreatureMode))
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
                     if((param[0]) && (!(param[0].indexOf("~") == -1)))
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
                     contentErr = I18n.getUiText("ui.chat.error.0");
                     break;
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
      
      public function setDisplayOptions(opt:ChatOptions) : void {
         this._options = opt;
      }
      
      private function onCssLoaded() : void {
         var styleObj:Object = null;
         var _ssSheet:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         var i:int = 0;
         while(i < 13)
         {
            styleObj = _ssSheet.getStyle("p" + i);
            this._aChatColors[i] = uint(this.color0x(styleObj["color"]));
            i++;
         }
         styleObj = _ssSheet.getStyle("p");
         this._aChatColors.push(uint(this.color0x(styleObj["color"])));
      }
      
      private function color0x(color:String) : String {
         return color.replace("#","0x");
      }
      
      private function displayCarac(pCarac:CharacterBaseCharacteristic) : String {
         var bonuses:int = pCarac.alignGiftBonus + pCarac.contextModif + pCarac.objectsAndMountBonus;
         var signe:String = "+";
         if(bonuses < 0)
         {
            signe = "";
         }
         return pCarac.base + " (" + signe + bonuses + ")";
      }
      
      private function playAlertSound(pType:uint) : void {
         if(Kernel.getWorker().getFrame(LoadingModuleFrame) as LoadingModuleFrame)
         {
            return;
         }
         var sapi:SoundApi = new SoundApi();
         switch(pType)
         {
            case GUILD_SOUND:
               if(sapi.playSoundForGuildMessage())
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.GUILD_CHAT_MESSAGE);
               }
               break;
            case PARTY_SOUND:
               if(sapi.playSoundForGuildMessage())
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.PARTY_CHAT_MESSAGE);
               }
               break;
            case PRIVATE_SOUND:
               if(sapi.playSoundForGuildMessage())
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.PRIVATE_CHAT_MESSAGE);
               }
               break;
            case ALERT_SOUND:
               SoundManager.getInstance().manager.playUISound(UISoundEnum.RED_CHAT_MESSAGE);
               break;
         }
      }
      
      private function saveMessage(channel:int=0, baseContent:String="", content:String="", timestamp:Number=0, fingerprint:String="", senderId:uint=0, senderName:String="", objects:Vector.<ItemWrapper>=null, receiverName:String="", receiverId:uint=0, textKey:uint=0, params:Array=null, admin:Boolean=false) : void {
         var sentence:Object = null;
         var max:uint = 0;
         var i:uint = 0;
         if(receiverName != "")
         {
            sentence = new ChatSentenceWithRecipient(this._msgUId,baseContent,content,channel,timestamp,fingerprint,senderId,senderName,receiverName,receiverId,objects);
         }
         else
         {
            if(senderName != "")
            {
               sentence = new ChatSentenceWithSource(this._msgUId,baseContent,content,channel,timestamp,fingerprint,senderId,senderName,objects,admin);
            }
            else
            {
               if(textKey != 0)
               {
                  sentence = new ChatInformationSentence(this._msgUId,baseContent,content,channel,timestamp,fingerprint,textKey,params);
               }
               else
               {
                  sentence = new BasicChatSentence(this._msgUId,baseContent,content,channel,timestamp,fingerprint);
               }
            }
         }
         this._aMessagesByChannel[channel].push(sentence);
         var removedSentences:uint = 0;
         if(this._aMessagesByChannel[channel].length > this._maxMessagesStored)
         {
            max = this._aMessagesByChannel[channel].length - this._maxMessagesStored;
            i = 0;
            while(i < max)
            {
               removedSentences++;
               i++;
            }
         }
         this._msgUId++;
         KernelEventsManager.getInstance().processCallback(ChatHookList.NewMessage,channel,removedSentences);
      }
      
      public function addParagraphToHistory(channel:int, p:Object) : void {
         if(p != null)
         {
            p.id = this._msgUId;
            this._aParagraphesByChannel[channel].push(p);
         }
      }
      
      public function removeLinesFromHistory(value:int, channel:int) : void {
         var i:* = 0;
         i = 0;
         while(i < value)
         {
            this._aMessagesByChannel[channel].shift();
            this._aParagraphesByChannel[channel].shift();
            i++;
         }
      }
      
      private function getTimestamp() : Number {
         return TimeManager.getInstance().getTimestamp();
      }
      
      private function getRealTimestamp(time:Number) : Number {
         return time * 1000 + TimeManager.getInstance().timezoneOffset;
      }
      
      public function getTimestampServerByRealTimestamp(realTimeStamp:Number) : Number {
         return (realTimeStamp - TimeManager.getInstance().timezoneOffset) / 1000;
      }
      
      public function checkCensored(word:String, channel:uint, senderId:uint, senderName:String) : Array {
         var wordl:String = null;
         var nAddWarning:uint = 0;
         var newContent:Array = null;
         var lang:String = null;
         var finalText:String = null;
         var safeChars:Array = null;
         var indexOfMethod:* = false;
         var wordsToCheck:Array = null;
         var wordi:String = null;
         var testword:String = null;
         var finalWord:String = null;
         var ichar:* = 0;
         var forbiddenWord:String = null;
         var iichar:* = 0;
         var safeReplace:String = null;
         var upperContent:String = null;
         var searchedWord:String = null;
         var pos:* = 0;
         var finalWordl:String = null;
         var result:Object = null;
         var warning:String = null;
         var content:String = word;
         if((((OptionManager.getOptionManager("chat").filterInsult) && (!(channel == 8))) && (!(channel == 10))) && (!(channel == 11)) && (!(channel == 666)))
         {
            lang = XmlConfig.getInstance().getEntry("config.lang.current");
            finalText = "";
            safeChars = ["&","%","?","#","§","!"];
            indexOfMethod = lang == "ja";
            if(!indexOfMethod)
            {
               wordsToCheck = content.split(" ");
               for each (wordi in wordsToCheck)
               {
                  testword = wordi.toLowerCase();
                  finalWord = "";
                  if(this._aCensoredWords)
                  {
                     if(this._aCensoredWords[testword])
                     {
                        ichar = 0;
                        while(ichar < testword.length)
                        {
                           finalWord = finalWord + safeChars[testword.charCodeAt(ichar) % 5];
                           ichar++;
                        }
                     }
                     else
                     {
                        for (forbiddenWord in this._aCensoredWords)
                        {
                           if(this._aCensoredWords[forbiddenWord] == 2)
                           {
                              if(testword.indexOf(forbiddenWord) != -1)
                              {
                                 iichar = 0;
                                 while(iichar < testword.length)
                                 {
                                    finalWord = finalWord + safeChars[testword.charCodeAt(iichar) % 5];
                                    iichar++;
                                 }
                              }
                           }
                        }
                     }
                  }
                  if(finalWord == "")
                  {
                     finalWord = wordi;
                  }
                  finalText = finalText + (finalWord + " ");
               }
               content = finalText.slice(0,finalText.length - 1);
            }
            else
            {
               safeReplace = "&%?§!&?&%§!&%!&%?#§!";
               upperContent = content.toUpperCase();
               for (searchedWord in this._aCensoredWords)
               {
                  pos = 0;
                  while(pos != -1)
                  {
                     pos = upperContent.indexOf(searchedWord);
                     if(pos != -1)
                     {
                        content = content.substr(0,pos) + safeReplace.substr(0,searchedWord.length) + content.substr(pos + searchedWord.length);
                        upperContent = content.toUpperCase();
                     }
                  }
               }
            }
         }
         var aText:Array = content.split(" ");
         var finalText2:String = "";
         var isLink:Boolean = false;
         var wordBeginning:String = "";
         var wordEnd:String = "";
         var wordLink:String = "";
         for each (wordl in aText)
         {
            finalWordl = "";
            result = this.needToFormateUrl(wordl);
            if(result.formate)
            {
               finalWordl = finalWordl + HtmlManager.addLink("[" + result.url + "]","event:chatLinkRelease," + result.url + "," + senderId + "," + senderName,{"bold":true});
               isLink = true;
            }
            if(finalWordl == "")
            {
               finalWordl = wordl;
            }
            finalText2 = finalText2 + (finalWordl + " ");
         }
         content = finalText2.slice(0,finalText2.length - 1);
         nAddWarning = 0;
         newContent = new Array();
         if(nAddWarning > 0)
         {
            warning = I18n.getUiText("ui.popup.warning");
            newContent[0] = content + " [" + HtmlManager.addLink(I18n.getUiText("ui.popup.warning"),"event:chatWarning",{"color":XmlConfig.getInstance().getEntry("colors.hyperlink.warning")}) + "]";
            newContent[1] = content + " [" + warning + "]";
         }
         else
         {
            newContent[0] = content;
            newContent[1] = content;
         }
         return newContent;
      }
      
      public function needToFormateUrl(inStr:String) : Object {
         var str:String = inStr.replace("&amp;amp;","&");
         var needReplaceAmp:Boolean = !(str == inStr);
         var myPattern:RegExp = new RegExp(URL_MATCHER);
         var result:Object = myPattern.exec(str);
         var objResult:Object = new Object();
         objResult.formate = false;
         if(result)
         {
            if(needReplaceAmp)
            {
               objResult.url = result[0].replace("&","&amp;amp;");
            }
            else
            {
               objResult.url = result[0];
            }
            objResult.index = result.index;
            if((result[2] == undefined) && (result[8] == undefined) && (result[7].split(".").length >= 2) && (LINK_TLDS.indexOf(result[11]) == -1))
            {
               objResult.formate = false;
            }
            else
            {
               objResult.formate = true;
            }
         }
         return objResult;
      }
   }
}
