package managers
{
   import flash.display.Sprite;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.ExternalNotificationApi;
   import d2api.FightApi;
   import d2api.PlayedCharacterApi;
   import d2api.DataApi;
   import d2api.ChatApi;
   import d2api.UtilApi;
   import flash.utils.Dictionary;
   import d2data.ExternalNotification;
   import d2enums.ExternalNotificationTypeEnum;
   import d2enums.ChatActivableChannelsEnum;
   import d2enums.SocialContactCategoryEnum;
   import d2data.Quest;
   import d2enums.ExternalNotificationModeEnum;
   import d2enums.UISoundEnum;
   import d2data.Achievement;
   import d2enums.FightEventEnum;
   import com.ankamagames.dofusModuleLibrary.enum.ExchangeTypeEnum;
   import d2enums.ExchangeReplayStopReasonEnum;
   import d2enums.PvpArenaStepEnum;
   import d2enums.FightTypeEnum;
   import d2data.ItemWrapper;
   import d2hooks.ExternalNotification;
   import d2hooks.InactivityNotification;
   import d2hooks.MailStatus;
   import d2hooks.ExchangeMultiCraftRequest;
   import d2hooks.ExchangeItemAutoCraftStoped;
   import d2hooks.ArenaRegistrationStatusUpdate;
   import d2hooks.GameFightStarting;
   import d2hooks.GameFightStart;
   import d2hooks.GameFightEnd;
   import d2hooks.FightText;
   import d2hooks.GameFightTurnStartPlaying;
   import d2hooks.PlayerFightFriendlyRequested;
   import d2hooks.ExchangeRequestCharacterToMe;
   import d2hooks.ChatServer;
   import d2hooks.ChatServerWithObject;
   import d2hooks.TextInformation;
   import d2hooks.GuildInvited;
   import d2hooks.AchievementFinished;
   import d2hooks.QuestValidated;
   
   public class ExternalNotificationManager extends Sprite
   {
      
      public function ExternalNotificationManager(pc:PrivateClass) {
         super();
         this.iconsIds = new Dictionary();
         this.iconsBgColorsIds = new Dictionary();
         this.messages = new Dictionary();
         this.sysApi = Api.system as SystemApi;
         this.uiApi = Api.ui as UiApi;
         this.socialApi = Api.social as SocialApi;
         this.extNotifApi = Api.extNotif as ExternalNotificationApi;
         this.fightApi = Api.fight as FightApi;
         this.playerApi = Api.player as PlayedCharacterApi;
         this.dataApi = Api.data as DataApi;
         this.chatApi = Api.chat as ChatApi;
         this.utilApi = Api.util as UtilApi;
         this.initData();
         this.sysApi.addHook(d2hooks.ExternalNotification,this.onExternalNotification);
         this.sysApi.addHook(InactivityNotification,this.onInactivityNotification);
         this.sysApi.addHook(MailStatus,this.onMailStatus);
         this.sysApi.addHook(ExchangeMultiCraftRequest,this.onMultiCraftRequest);
         this.sysApi.addHook(ExchangeItemAutoCraftStoped,this.onCraftStopped);
         this.sysApi.addHook(ArenaRegistrationStatusUpdate,this.onArenaRegistrationUpdate);
         this.sysApi.addHook(GameFightStarting,this.onGameFightStarting);
         this.sysApi.addHook(GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(FightText,this.onFightText);
         this.sysApi.addHook(GameFightTurnStartPlaying,this.onFightTurnStartPlaying);
         this.sysApi.addHook(PlayerFightFriendlyRequested,this.onPlayerFight);
         this.sysApi.addHook(ExchangeRequestCharacterToMe,this.onExchange);
         this.sysApi.addHook(ChatServer,this.onChatServer);
         this.sysApi.addHook(ChatServerWithObject,this.onChatServerWithObject);
         this.sysApi.addHook(TextInformation,this.onTextInformation);
         this.sysApi.addHook(GuildInvited,this.onGuildInvitation);
         this.sysApi.addHook(AchievementFinished,this.onAchievementFinished);
         this.sysApi.addHook(QuestValidated,this.onQuestValidated);
      }
      
      private static var _instance:ExternalNotificationManager;
      
      private static const DEBUG:Boolean = false;
      
      private static const ENABLE_AVATARS:Boolean = true;
      
      private static var notifCount:int = 0;
      
      private static const ITEM_INDEX_CODE:String;
      
      private static function log(pMsg:*) : void {
         if(DEBUG)
         {
            Api.system.log(2,pMsg);
         }
      }
      
      public static function getInstance() : ExternalNotificationManager {
         if(!_instance)
         {
            _instance = new ExternalNotificationManager(new PrivateClass());
         }
         return _instance;
      }
      
      private var sysApi:SystemApi;
      
      private var uiApi:UiApi;
      
      private var socialApi:SocialApi;
      
      private var extNotifApi:ExternalNotificationApi;
      
      private var fightApi:FightApi;
      
      private var playerApi:PlayedCharacterApi;
      
      private var dataApi:DataApi;
      
      private var chatApi:ChatApi;
      
      private var utilApi:UtilApi;
      
      private var iconsIds:Dictionary;
      
      private var iconsBgColorsIds:Dictionary;
      
      private var messages:Dictionary;
      
      private var _arenaRegistered:Boolean;
      
      private function initData() : void {
         var extNotif:ExternalNotification = null;
         var extNotifType:* = 0;
         var extNotifs:Object = this.dataApi.getExternalNotifications();
         var colorsIds:Vector.<String> = new <String>["green","blue","yellow","red"];
         for each(extNotif in extNotifs)
         {
            extNotifType = ExternalNotificationTypeEnum[extNotif.name];
            this.messages[extNotifType] = this.uiApi.getTextFromKey(extNotif.messageId);
            this.iconsIds[extNotifType] = extNotif.iconId;
            this.iconsBgColorsIds[extNotifType] = colorsIds[extNotif.colorId - 1];
         }
      }
      
      private function getIconId(pNotifType:int) : int {
         return this.iconsIds[pNotifType];
      }
      
      private function getIconBgColorId(pNotifType:int) : String {
         return this.iconsBgColorsIds[pNotifType];
      }
      
      private function getChatMessage(pChannel:uint, pContent:String) : Object {
         var chatMessage:Object = new Object();
         chatMessage.text = pContent;
         if((!(chatMessage.text.indexOf("{") == -1)) && (!(chatMessage.text.indexOf("}") == -1)))
         {
            chatMessage.text = this.chatApi.getStaticHyperlink(chatMessage.text);
         }
         chatMessage.css = "chat_input";
         switch(pChannel)
         {
            case ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_INFO;
               chatMessage.cssClass = "p10";
               break;
            case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
               chatMessage.notifType = ExternalNotificationTypeEnum.PRIVATE_MSG;
               chatMessage.cssClass = "p9";
               break;
            case ChatActivableChannelsEnum.CHANNEL_GUILD:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_GUILD;
               chatMessage.cssClass = "p2";
               break;
            case ChatActivableChannelsEnum.CHANNEL_PARTY:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_GROUP;
               chatMessage.cssClass = "p4";
               break;
            case ChatActivableChannelsEnum.CHANNEL_TEAM:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_TEAM;
               chatMessage.cssClass = "p1";
               break;
            case ChatActivableChannelsEnum.CHANNEL_GLOBAL:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_GENERAL;
               chatMessage.cssClass = "p0";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ADMIN:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_ADMIN;
               chatMessage.cssClass = "p8";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ALLIANCE:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_ALIGNMENT;
               chatMessage.cssClass = "p3";
               break;
            case ChatActivableChannelsEnum.CHANNEL_SALES:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_TRADE;
               chatMessage.cssClass = "p5";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ADS:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_PROMO;
               chatMessage.cssClass = "p12";
               break;
            case ChatActivableChannelsEnum.CHANNEL_ARENA:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_KOLO;
               chatMessage.cssClass = "p13";
               break;
            case ChatActivableChannelsEnum.CHANNEL_SEEK:
               chatMessage.notifType = ExternalNotificationTypeEnum.CHAT_MSG_RECRUIT;
               chatMessage.cssClass = "p6";
               break;
         }
         return chatMessage;
      }
      
      private function addExternalNotification(pExtNotifType:int, pMessage:String, pCss:String = "normal", pCssClass:String = "p", pEntityContactData:Object = null) : void {
         notifCount++;
         this.extNotifApi.addExternalNotification(pExtNotifType,"extNotif" + notifCount,"externalnotification","Dofus 2 - " + this.playerApi.getPlayedCharacterInfo().name,pMessage,this.sysApi.getConfigEntry("config.gfx.path") + "notifications/",!pEntityContactData?this.getIconId(pExtNotifType):-1,!pEntityContactData?this.getIconBgColorId(pExtNotifType):null,pCss,pCssClass,pEntityContactData);
      }
      
      private function addExternalNotificationFromChatMessage(pChannel:uint, pSenderId:int, pSenderName:String, pContent:String) : void {
         var sender:String = null;
         var contactData:Object = null;
         var chatmessage:Object = this.getChatMessage(pChannel,this.chatApi.unEscapeChatString(pContent));
         if((chatmessage.notifType > 0) && (this.extNotifApi.canAddExternalNotification(chatmessage.notifType)))
         {
            sender = pSenderName?pSenderName + this.uiApi.getText("ui.common.colon"):"";
            if(ENABLE_AVATARS)
            {
               switch(pChannel)
               {
                  case ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE:
                     contactData = 
                        {
                           "id":pSenderId,
                           "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_INTERLOCUTOR
                        };
                     break;
                  case ChatActivableChannelsEnum.CHANNEL_GUILD:
                     contactData = 
                        {
                           "id":pSenderId,
                           "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_GUILD
                        };
                     break;
               }
            }
            this.addExternalNotification(chatmessage.notifType,sender + chatmessage.text,chatmessage.css,chatmessage.cssClass,contactData);
         }
      }
      
      private function onQuestValidated(pQuestId:uint) : void {
         var quest:Quest = null;
         var msg:String = null;
         if((!(this.extNotifApi.getShowMode() == ExternalNotificationModeEnum.DISABLED)) && (!this.extNotifApi.isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.QUEST_VALIDATED)))
         {
            notifCount++;
            quest = this.dataApi.getQuest(pQuestId);
            msg = "<b>" + this.uiApi.getText("ui.almanax.questDone") + "</b><br/>" + quest.name;
            this.extNotifApi.addExternalNotification(ExternalNotificationTypeEnum.QUEST_VALIDATED,"extNotif" + notifCount,"questNotification",null,msg,null,-1,null,"normal","left",null,UISoundEnum.ACHIEVEMENT_UNLOCKED,true);
         }
      }
      
      private function onAchievementFinished(pAchievementId:uint) : void {
         var achievement:Achievement = null;
         if((!(this.extNotifApi.getShowMode() == ExternalNotificationModeEnum.DISABLED)) && (!this.extNotifApi.isExternalNotificationTypeIgnored(ExternalNotificationTypeEnum.ACHIEVEMENT_UNLOCKED)))
         {
            notifCount++;
            achievement = this.dataApi.getAchievement(pAchievementId);
            this.extNotifApi.addExternalNotification(ExternalNotificationTypeEnum.ACHIEVEMENT_UNLOCKED,"extNotif" + notifCount,"achievementNotification",null,"<b>" + this.uiApi.getText("ui.achievement.achievementUnlock") + "</b><br/>" + achievement.name,this.sysApi.getConfigEntry("config.gfx.path") + "achievements/",achievement.iconId,null,"normal","darkleft",null,UISoundEnum.ACHIEVEMENT_UNLOCKED,true,"OpenBook",["achievementTab",
               {
                  "forceOpen":true,
                  "achievementId":pAchievementId
               }]);
         }
      }
      
      private function onExternalNotification(... pArgs) : void {
         var contactData:Object = null;
         var type:int = pArgs[0];
         var params:Object = pArgs[1];
         if(ENABLE_AVATARS)
         {
            switch(type)
            {
               case ExternalNotificationTypeEnum.FRIEND_CONNECTION:
                  contactData = 
                     {
                        "id":params[params.length - 1],
                        "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_FRIEND
                     };
                  break;
               case ExternalNotificationTypeEnum.MEMBER_CONNECTION:
                  contactData = 
                     {
                        "id":params[params.length - 1],
                        "contactCategory":SocialContactCategoryEnum.SOCIAL_CONTACT_GUILD
                     };
                  break;
            }
         }
         var text:String = !params?this.messages[type]:this.utilApi.applyTextParams(this.messages[type],params);
         if((!(text.indexOf("{") == -1)) && (!(text.indexOf("}") == -1)))
         {
            text = this.chatApi.getStaticHyperlink(text);
         }
         this.addExternalNotification(type,text,"normal","p",contactData);
      }
      
      private function onFightText(pEvtName:String, pParams:Object, pTargets:Object, pTargetsTeam:String = "") : void {
         var gender:String = null;
         var playerId:int = pParams[0] as int;
         var playerName:String = this.playerApi.getPlayedCharacterInfo().name;
         var dead:Boolean = (pEvtName == FightEventEnum.FIGHTER_DEATH) || (pEvtName == FightEventEnum.FIGHTER_LIFE_LOSS_AND_DEATH);
         if((dead) && (playerId == this.playerApi.id()) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_DEATH)))
         {
            gender = this.playerApi.getPlayedCharacterInfo().sex == 0?"m":"f";
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_DEATH,this.uiApi.processText(this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.FIGHT_DEATH],[playerName]),gender));
         }
      }
      
      private function onInactivityNotification(pIsAFK:Boolean) : void {
         if((pIsAFK) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.INACTIVITY_WARNING)))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.INACTIVITY_WARNING,this.messages[ExternalNotificationTypeEnum.INACTIVITY_WARNING]);
         }
      }
      
      private function onMailStatus(pHasNewMail:Boolean, pNbUnread:uint, pNbTotal:uint) : void {
         if((pHasNewMail) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.ANKABOX_MSG)))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.ANKABOX_MSG,this.messages[ExternalNotificationTypeEnum.ANKABOX_MSG]);
         }
      }
      
      private function onMultiCraftRequest(pRole:int, pOtherName:String, pAskerId:uint) : void {
         if((pRole == ExchangeTypeEnum.MULTICRAFT_CUSTOMER) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.CRAFT_INVITATION)))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.CRAFT_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.CRAFT_INVITATION],[pOtherName]));
         }
      }
      
      private function onCraftStopped(pReason:int) : void {
         if((pReason == ExchangeReplayStopReasonEnum.STOPPED_REASON_OK) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.MULTI_CRAFT_END)))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.MULTI_CRAFT_END,this.messages[ExternalNotificationTypeEnum.MULTI_CRAFT_END]);
         }
      }
      
      private function onArenaRegistrationUpdate(pRegistered:Boolean, pStatus:int) : void {
         if(pRegistered != this._arenaRegistered)
         {
            if((pRegistered) && (pStatus == PvpArenaStepEnum.ARENA_STEP_REGISTRED) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH)))
            {
               this.addExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH,this.messages[ExternalNotificationTypeEnum.KOLO_SEARCH]);
            }
            else if((!pRegistered) && (!(pStatus == PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT)) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH_END)))
            {
               this.addExternalNotification(ExternalNotificationTypeEnum.KOLO_SEARCH_END,this.messages[ExternalNotificationTypeEnum.KOLO_SEARCH_END]);
            }
            
            this._arenaRegistered = pRegistered;
         }
      }
      
      private function onGameFightStarting(pFightType:uint) : void {
         if((pFightType == FightTypeEnum.FIGHT_TYPE_PvM) && (this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_JOIN)))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_JOIN,this.messages[ExternalNotificationTypeEnum.FIGHT_JOIN]);
         }
      }
      
      private function onGameFightStart() : void {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_START))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_START,this.messages[ExternalNotificationTypeEnum.FIGHT_START]);
         }
      }
      
      private function onGameFightEnd(pResultsRecap:Object) : void {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_END))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_END,this.messages[ExternalNotificationTypeEnum.FIGHT_END]);
         }
      }
      
      private function onFightTurnStartPlaying() : void {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.FIGHT_TURN_START))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.FIGHT_TURN_START,this.messages[ExternalNotificationTypeEnum.FIGHT_TURN_START]);
         }
      }
      
      private function onPlayerFight(pTargetName:String) : void {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.CHALLENGE_INVITATION))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.CHALLENGE_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.CHALLENGE_INVITATION],[pTargetName]));
         }
      }
      
      private function onExchange(pMyName:String, pSourceName:String) : void {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.EXCHANGE_INVITATION))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.EXCHANGE_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.EXCHANGE_INVITATION],[pSourceName]));
         }
      }
      
      private function onChatServer(pChannel:uint = 0, pSenderId:uint = 0, pSenderName:String = "", pContent:String = "", pTimestamp:Number = 0, pFingerprint:String = "", pAdmin:Boolean = false) : void {
         this.addExternalNotificationFromChatMessage(pChannel,pSenderId,pSenderName,pContent);
      }
      
      private function onChatServerWithObject(pChannel:uint = 0, pSenderId:uint = 0, pSenderName:String = "", pContent:String = "", pTimestamp:Number = 0, pFingerprint:String = "", pObjects:Object = null) : void {
         var numItem:* = 0;
         var i:* = 0;
         var item:ItemWrapper = null;
         var index:* = 0;
         var content:String = pContent;
         if(pObjects)
         {
            numItem = pObjects.length;
            i = 0;
            while(i < numItem)
            {
               item = pObjects[i];
               index = content.indexOf(ITEM_INDEX_CODE);
               if(index == -1)
               {
                  break;
               }
               content = content.substr(0,index) + this.chatApi.newChatItem(item) + content.substr(index + 1);
               i++;
            }
         }
         this.addExternalNotificationFromChatMessage(pChannel,pSenderId,pSenderName,content);
      }
      
      private function onTextInformation(pText:String = "", pChannel:uint = 0, pTimestamp:Number = 0, pSaveMessage:Boolean = true) : void {
         if(pChannel == ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO)
         {
            this.addExternalNotificationFromChatMessage(pChannel,-1,null,pText);
         }
      }
      
      private function onGuildInvitation(pGuildName:String, pRecruitedId:uint, pRecruterName:String) : void {
         if(this.extNotifApi.canAddExternalNotification(ExternalNotificationTypeEnum.GUILD_INVITATION))
         {
            this.addExternalNotification(ExternalNotificationTypeEnum.GUILD_INVITATION,this.uiApi.replaceParams(this.messages[ExternalNotificationTypeEnum.GUILD_INVITATION],[pRecruterName,pGuildName]));
         }
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
