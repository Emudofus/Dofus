package ui
{
   import flash.filters.ColorMatrixFilter;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.SoundApi;
   import d2api.DataApi;
   import d2api.HighlightApi;
   import d2api.QuestApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.Label;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.NotificationTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import flash.utils.getDefinitionByName;
   import flash.display.Shape;
   import flash.utils.getTimer;
   import flash.system.ApplicationDomain;
   
   public class TipsUi extends Object
   {
      
      public function TipsUi() {
         this._tipsList = new Array();
         this._timerSlide = new Timer(200,1);
         this._btnListDisplay = new Array();
         this._imgListDisplay = new Array();
         this._noCheatTimer = new Timer(1000,1);
         super();
      }
      
      private static const MAX_VISIBLE_NOTIFICATION:uint = 3;
      
      private static const PADDING_BOTTOM:uint = 15;
      
      private static const NOTIFICATION_HEIGHT:uint = 55;
      
      private static const LUMINOSITY_EFFECTS:Array;
      
      private static const CTR_TEXT_MARGIN_TOP:uint = 19;
      
      private static var QUIET_MODE:Boolean = true;
      
      private var _include_action_PartyAction:PartyInvitationDetailsRequest;
      
      private var _include_action_PartyAcceptInvitation:PartyAcceptInvitation;
      
      private var _include_action_ArenaFightAnswer:ArenaFightAnswer;
      
      private var _include_action_TeleportToBuddyAnswer:TeleportToBuddyAnswer;
      
      private var _include_action_OpenSmileys:d2actions.OpenSmileys;
      
      private var _include_action_OpenBook:d2actions.OpenBook;
      
      private var _include_action_PartyRefuseInvitation:PartyRefuseInvitation;
      
      private var _include_action_NotificationUpdateFlag:NotificationUpdateFlag;
      
      private var _include_action_JoinFightRequest:JoinFightRequest;
      
      private var _include_hook_MapWithMonsters:MapWithMonsters;
      
      private var _include_hook_FightResultVictory:FightResultVictory;
      
      private var _include_hook_GameStart:GameStart;
      
      private var _include_hook_NpcDialogCreation:NpcDialogCreation;
      
      private var _include_hook_PlayerMove:PlayerMove;
      
      private var _include_hook_GameFightStart:GameFightStart;
      
      private var _include_hook_GameFightStarting:GameFightStarting;
      
      private var _include_hook_PlayerFightMove:PlayerFightMove;
      
      private var _include_hook_FightSpellCast:FightSpellCast;
      
      private var _include_hook_CharacterLevelUp:CharacterLevelUp;
      
      private var _include_hook_PlayerNewSpell:PlayerNewSpell;
      
      private var _include_hook_PlayerIsDead:PlayerIsDead;
      
      private var _include_hook_GameRolePlayPlayerLifeStatus:GameRolePlayPlayerLifeStatus;
      
      private var _include_hook_OpenInventory:OpenInventory;
      
      private var _include_hook_OpenStats:OpenStats;
      
      private var _include_hook_OpenBook:d2hooks.OpenBook;
      
      private var _include_hook_OpenGrimoireSpellTab:OpenGrimoireSpellTab;
      
      private var _include_hook_OpenGrimoireQuestTab:OpenGrimoireQuestTab;
      
      private var _include_hook_OpenGrimoireAlignmentTab:OpenGrimoireAlignmentTab;
      
      private var _include_hook_OpenGrimoireJobTab:OpenGrimoireJobTab;
      
      private var _include_hook_OpenGrimoireCalendarTab:OpenGrimoireCalendarTab;
      
      private var _include_hook_CreaturesMode:CreaturesMode;
      
      private var _include_hook_OpenSmileys:d2hooks.OpenSmileys;
      
      private var _include_hook_LifePointsRegenBegin:LifePointsRegenBegin;
      
      private var _include_hook_AddMapFlag:AddMapFlag;
      
      private var _include_hook_OpenSocial:OpenSocial;
      
      private var _enabled:Boolean = true;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var soundApi:SoundApi;
      
      public var dataApi:DataApi;
      
      public var highlightApi:HighlightApi;
      
      public var questApi:QuestApi;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_visible:GraphicContainer;
      
      public var ctr_tips:GraphicContainer;
      
      public var ctr_text:GraphicContainer;
      
      public var ctr_down:GraphicContainer;
      
      public var ctr_nocheat:GraphicContainer;
      
      public var ctr_effect:GraphicContainer;
      
      public var mask_tips:GraphicContainer;
      
      public var btn_hide:ButtonContainer;
      
      public var btn_show:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var tx_background_message:Texture;
      
      public var tx_background:Texture;
      
      public var lbl_message:Label;
      
      public var lbl_title_message:Label;
      
      public var lbl_down:Label;
      
      public var tx_effect1:Texture;
      
      public var tx_effect2:Texture;
      
      private var _tipsList:Array;
      
      private var _currentTips:NotificationWrapper;
      
      private var _timerSlide:Timer;
      
      private var _btnListDisplay:Array;
      
      private var _imgListDisplay:Array;
      
      private var _noCheatTimer:Timer;
      
      private var _notificationsDisabled:Object;
      
      private var _contextualTipsList:Object;
      
      private var _triggersInit:Boolean = false;
      
      private var _tmpTimer:int = 0;
      
      public function main(param:Object) : void {
         this.sysApi.addHook(FoldAll,this.onFoldAll);
         this.sysApi.addHook(Notification,this.onNewNotification);
         this.sysApi.addHook(CloseNotification,this.onCloseNotification);
         this.sysApi.addHook(HideNotification,this.onHideNotification);
         this.uiApi.addComponentHook(this.lbl_message,"onTextClick");
         this.uiApi.addComponentHook(this.ctr_nocheat,"onRelease");
         this.uiApi.addComponentHook(this.ctr_visible,"onRollOver");
         this.uiApi.addComponentHook(this.ctr_visible,"onRollOut");
         this.ctr_tips.mask = this.mask_tips;
         this.checkQuietMode();
         this._timerSlide.addEventListener(TimerEvent.TIMER,this.showMessage);
         this._noCheatTimer.addEventListener(TimerEvent.TIMER,this.closeNoCheatContainer);
         if((param) && (param[0]))
         {
            this.forceNewNotification(param[0]);
         }
      }
      
      public function checkQuietMode() : void {
         var activated:Boolean = !this.sysApi.getOption("showNotifications","dofus");
         if(activated == QUIET_MODE)
         {
            return;
         }
         QUIET_MODE = activated;
         this._contextualTipsList = this.dataApi.getNotifications();
         this._notificationsDisabled = this.questApi.getNotificationList();
         if(this._notificationsDisabled)
         {
            this._triggersInit = false;
         }
         if(activated)
         {
            this.clearAllNotification(NotificationTypeEnum.TUTORIAL);
         }
         else if(!this._triggersInit)
         {
            this.initContextualHelpTriggers();
         }
         
      }
      
      public function resetTips(notifs:Object) : void {
         this._notificationsDisabled = notifs;
         this.clearAllNotification(NotificationTypeEnum.TUTORIAL);
         this.initContextualHelpTriggers();
      }
      
      private function addNewNotification(pNotification:NotificationWrapper) : void {
         if((QUIET_MODE) && (pNotification.type == NotificationTypeEnum.TUTORIAL))
         {
            return;
         }
         if(!this._enabled)
         {
            this.sendCallback(pNotification);
            return;
         }
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         if(!this.ctr_effect)
         {
            return;
         }
         this.ctr_effect.visible = true;
         this.btn_hide.visible = true;
         var oldNotif:NotificationWrapper = this.getNotificationByName(pNotification.name);
         if(oldNotif != null)
         {
            this.removeNotification(oldNotif);
         }
         this._tipsList = this.sortByPriority(this._tipsList,pNotification);
         this.updateVisibleNotification();
      }
      
      private function sortByPriority(data:Array, pushValue:NotificationWrapper = null) : Array {
         var t:Object = null;
         var sortArray:Array = null;
         var type:uint = 0;
         var priorityArray:Array = new Array();
         for each(t in data)
         {
            if(priorityArray[t.type] == null)
            {
               priorityArray[t.type] = new Array();
            }
            priorityArray[t.type].push(t);
         }
         sortArray = new Array();
         for each(type in NotificationTypeEnum.NOTIFICATION_PRIORITY)
         {
            if(priorityArray[type])
            {
               if((!(pushValue == null)) && (pushValue.type == type))
               {
                  sortArray.push(pushValue);
               }
               sortArray = sortArray.concat(priorityArray[type]);
            }
            else if(type == pushValue.type)
            {
               sortArray.push(pushValue);
            }
            
         }
         priorityArray = null;
         var data:Array = null;
         return sortArray.concat();
      }
      
      private function removeNotification(pNotification:NotificationWrapper, pBlockCallback:Boolean = false) : void {
         if(pNotification == null)
         {
            return;
         }
         if(!pBlockCallback)
         {
            this.sendCallback(pNotification);
         }
         if(pNotification.maskTimer)
         {
            pNotification.texture.removeChild(pNotification.maskTimer);
         }
         if(pNotification.tutorialId > 0)
         {
            this.sysApi.sendAction(new NotificationUpdateFlag(pNotification.tutorialId));
         }
         if(pNotification == this._currentTips)
         {
            this.ctr_text.visible = false;
            this._currentTips = null;
            this.clearContainer();
         }
         this.ctr_tips.removeChild(pNotification.texture);
         this._tipsList.splice(this._tipsList.indexOf(pNotification),1);
         pNotification.texture = null;
         var pNotification:NotificationWrapper = null;
         if(this._tipsList.length <= 0)
         {
            this.ctr_effect.visible = false;
            this.ctr_visible.visible = false;
         }
         this.uiApi.hideTooltip();
         this._tmpTimer = 0;
         this.updateVisibleNotification();
         this.updateUi();
      }
      
      private function sendCallback(pNotification:NotificationWrapper) : Boolean {
         var hook:Class = null;
         var action:Object = null;
         if(pNotification.callback)
         {
            if(pNotification.callbackType == "hook")
            {
               hook = getDefinitionByName("d2hook." + pNotification.callback) as Class;
               this.sysApi.dispatchHook(hook,pNotification.callbackParams);
            }
            else if(pNotification.callbackType == "action")
            {
               action = this.utilApi.callConstructorWithParameters(getDefinitionByName("d2actions." + pNotification.callback) as Class,pNotification.callbackParams);
               this.sysApi.sendAction(action);
            }
            
            return true;
         }
         return false;
      }
      
      private function updateVisibleNotification() : void {
         var i:uint = 0;
         var notif:NotificationWrapper = null;
         var timerInit:* = false;
         var openFirst:Boolean = true;
         i = 0;
         while(i < this._tipsList.length)
         {
            notif = this._tipsList[i];
            if(i < MAX_VISIBLE_NOTIFICATION)
            {
               if(notif.texture == null)
               {
                  this.createNotificationTexture(notif);
                  timerInit = this.initTimer(notif);
                  if(timerInit)
                  {
                     openFirst = true;
                  }
               }
               else
               {
                  notif.texture.visible = true;
                  this.ctr_tips.addChild(notif.texture);
                  this.slide(notif.texture,0,i * NOTIFICATION_HEIGHT,500);
                  if(notif == this._currentTips)
                  {
                     this.slide(this.ctr_text,this.ctr_text.x,CTR_TEXT_MARGIN_TOP + i * NOTIFICATION_HEIGHT,500);
                  }
               }
            }
            else if(notif == this._currentTips)
            {
               this.ctr_text.visible = false;
               notif.texture.filters = null;
               notif.texture.visible = false;
               this._currentTips = null;
               openFirst = true;
            }
            
            i++;
         }
         if((this._currentTips == null) && (openFirst))
         {
            this._currentTips = this._tipsList[0];
            this.showMessage();
         }
      }
      
      private function initTimer(pNotification:NotificationWrapper) : Boolean {
         var mask:Shape = null;
         if((pNotification.hasTimer) && (!pNotification.startTime))
         {
            if(pNotification.texture)
            {
               mask = new Shape();
               mask.graphics.beginFill(0,0.6);
               mask.graphics.drawRect(0,0,pNotification.texture.width,pNotification.texture.height);
               mask.graphics.endFill();
               pNotification.maskTimer = mask;
               pNotification.texture.addChild(mask);
            }
            pNotification.startTime = getTimer();
            this.sysApi.addEventListener(this.updateTimer,"timerComplete");
            return true;
         }
         return false;
      }
      
      private function openNotification(pNotificationId:uint) : void {
         if(pNotificationId != this._tipsList.indexOf(this._currentTips))
         {
            this.hideNotification(this._currentTips);
         }
      }
      
      private function hideNotification(pNotification:Object) : void {
         if((pNotification == null) || (pNotification.texture == null))
         {
            return;
         }
         pNotification.texture.filters = null;
         if(pNotification == this._currentTips)
         {
            this._currentTips = null;
         }
         if(this.ctr_text.visible)
         {
            this.ctr_text.visible = false;
         }
      }
      
      private function getNotificationByName(pName:String) : NotificationWrapper {
         var i:uint = 0;
         var len:uint = this._tipsList.length;
         i = 0;
         while(i < len)
         {
            if(this._tipsList[i].name == pName)
            {
               return this._tipsList[i];
            }
            i = i + 1;
         }
         return null;
      }
      
      private function getNotificationData(tx:Texture) : NotificationWrapper {
         var i:uint = 0;
         var len:uint = this._tipsList.length;
         i = 0;
         while(i < len)
         {
            if((!(this._tipsList[i].texture == null)) && (this._tipsList[i].texture == tx))
            {
               return this._tipsList[i];
            }
            i = i + 1;
         }
         return null;
      }
      
      private function hideAll() : void {
         this.ctr_visible.visible = false;
         this.btn_hide.visible = false;
         this.btn_show.visible = true;
      }
      
      private function showAll() : void {
         this.ctr_visible.visible = true;
         this.btn_hide.visible = true;
         this.btn_show.visible = false;
      }
      
      private function showMessage(pEvt:TimerEvent = null) : void {
         var i:* = 0;
         var len:* = 0;
         if((this._currentTips == null) || (this.ctr_text == null))
         {
            return;
         }
         this.clearContainer();
         this.ctr_text.visible = true;
         this.ctr_effect.visible = true;
         this.lbl_message.height = 0;
         this.lbl_title_message.height = 0;
         this.tx_background_message.height = 0;
         this.lbl_title_message.text = this._currentTips.title;
         this.lbl_message.text = this._currentTips.contentText;
         this.lbl_title_message.selectable = this._currentTips.type == NotificationTypeEnum.ERROR;
         this.lbl_message.selectable = this._currentTips.type == NotificationTypeEnum.ERROR;
         this.lbl_title_message.fullSize(300);
         this.lbl_message.fullSize(300);
         this.tx_background_message.height = this.lbl_message.textHeight + this.lbl_title_message.y + this.lbl_title_message.textHeight + PADDING_BOTTOM;
         this.slide(this.ctr_text,this.ctr_text.x,CTR_TEXT_MARGIN_TOP + this._tipsList.indexOf(this._currentTips) * NOTIFICATION_HEIGHT,0);
         this._currentTips.texture.filters = LUMINOSITY_EFFECTS;
         if((this._currentTips.imageList) && (this._currentTips.imageList.length > 0))
         {
            len = this._currentTips.imageList.length;
            i = 0;
            while(i < len)
            {
               this.addImageToContainer(this._currentTips.imageList[i]);
               i++;
            }
         }
         if((this._currentTips.buttonList) && (this._currentTips.buttonList.length > 0))
         {
            len = this._currentTips.buttonList.length;
            i = 0;
            while(i < len)
            {
               this.addBtnToContainer(this._currentTips.buttonList[i],i);
               i++;
            }
            this.tx_background_message.height = this.tx_background_message.height + (this._currentTips.buttonList[0].height + 10);
         }
         this.updateUi();
      }
      
      private function startAnim(tips:NotificationWrapper) : void {
         this._timerSlide.reset();
         var tipsIndex:uint = this._tipsList.indexOf(tips);
         this.slide(tips.texture,0,tipsIndex * NOTIFICATION_HEIGHT,500);
         if(tipsIndex + 1 >= MAX_VISIBLE_NOTIFICATION)
         {
            tips.texture.visible = false;
            if(tips == this._currentTips)
            {
               this._currentTips = null;
               this.ctr_visible.visible = false;
            }
         }
         else if(tips == this._currentTips)
         {
            this._timerSlide.start();
         }
         else
         {
            this.updateUi();
         }
         
      }
      
      private function clearAllNotification(pType:int = -1) : void {
         var notif:NotificationWrapper = null;
         var tmp:Array = this._tipsList.concat();
         for each(notif in tmp)
         {
            if((notif.type == pType) || (pType == -1))
            {
               if(notif == this._currentTips)
               {
                  this.ctr_text.visible = false;
               }
               this.removeNotification(notif);
            }
         }
         if(pType == NotificationTypeEnum.TUTORIAL)
         {
            this.clearTutorialTriggers();
         }
      }
      
      private function getVisibleNotificationNumber() : uint {
         return this._tipsList.length > MAX_VISIBLE_NOTIFICATION?MAX_VISIBLE_NOTIFICATION:this._tipsList.length;
      }
      
      private function slide(tx:GraphicContainer, posX:Number, posY:Number, time:uint = 500) : void {
         tx.y = posY;
         tx.x = posX;
      }
      
      private function onFoldAll(folded:Boolean) : void {
         if(this._tipsList.length == 0)
         {
            return;
         }
         if(folded)
         {
            this.hideAll();
         }
         else
         {
            this.showAll();
         }
      }
      
      private function onNewNotification(pNotification:Object) : void {
         this.addNewNotification(NotificationWrapper.create(pNotification));
      }
      
      private function onCloseNotification(pName:String, pBlockCallback:Boolean = false) : void {
         var notif:NotificationWrapper = this.getNotificationByName(pName);
         if(notif != null)
         {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
            this.removeNotification(notif,pBlockCallback);
         }
      }
      
      private function onHideNotification(pName:String) : void {
         this.hideNotification(this.getNotificationByName(pName));
      }
      
      private function updateTimer() : void {
         var tips:NotificationWrapper = null;
         var currentTime:* = 0;
         var totalTime:* = 0;
         var perc:* = NaN;
         for each(tips in this._tipsList)
         {
            if(tips.duration > 0)
            {
               if(!((this._currentTips == tips) && (this._tmpTimer > 0)))
               {
                  currentTime = getTimer();
                  totalTime = tips.startTime + tips.duration;
                  if(currentTime > totalTime)
                  {
                     this.removeNotification(tips,tips.blockCallbackOnTimerEnds);
                  }
                  else
                  {
                     perc = (currentTime - tips.startTime) / (totalTime - tips.startTime);
                     tips.maskTimer.height = tips.texture.height * perc;
                     tips.maskTimer.y = tips.texture.height - tips.maskTimer.height;
                  }
               }
            }
         }
         if(this._tipsList.length == 0)
         {
            this.sysApi.removeEventListener(this.updateTimer);
         }
      }
      
      private function closeNoCheatContainer(pEvt:TimerEvent) : void {
         this.ctr_nocheat.visible = false;
      }
      
      public function onRelease(target:Object) : void {
         var notif:NotificationWrapper = null;
         var btn:Object = null;
         var action:Object = null;
         var hook:Class = null;
         switch(target)
         {
            case this.btn_close:
               this.ctr_nocheat.visible = true;
               this._noCheatTimer.reset();
               this._noCheatTimer.start();
               this.removeNotification(this._currentTips);
               break;
            case this.btn_hide:
               this.hideAll();
               break;
            case this.btn_show:
               this.showAll();
               break;
            case this.ctr_nocheat:
               return;
            default:
               if(this._btnListDisplay.indexOf(target) != -1)
               {
                  btn = this._currentTips.buttonList[this._btnListDisplay.indexOf(target)];
                  if(btn.actionType == "action")
                  {
                     action = this.utilApi.callConstructorWithParameters(getDefinitionByName("d2actions." + btn.action) as Class,btn.params);
                     this.sysApi.sendAction(action);
                  }
                  else if(btn.actionType == "hook")
                  {
                     hook = getDefinitionByName("d2hooks." + btn.action) as Class;
                     switch(btn.params.length)
                     {
                        case 1:
                           this.sysApi.dispatchHook(hook,btn.params[0]);
                           break;
                        case 2:
                           this.sysApi.dispatchHook(hook,btn.params[0],btn.params[1]);
                           break;
                        case 3:
                           this.sysApi.dispatchHook(hook,btn.params[0],btn.params[1],btn.params[2]);
                           break;
                        case 4:
                           this.sysApi.dispatchHook(hook,btn.params[0],btn.params[1],btn.params[2],btn.params[3]);
                           break;
                        case 5:
                           this.sysApi.dispatchHook(hook,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4]);
                           break;
                        case 6:
                           this.sysApi.dispatchHook(hook,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4],btn.params[5]);
                           break;
                        case 7:
                           this.sysApi.dispatchHook(hook,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4],btn.params[5],btn.params[6]);
                           break;
                        case 8:
                           this.sysApi.dispatchHook(hook,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4],btn.params[5],btn.params[6],btn.params[7]);
                           break;
                     }
                  }
                  
                  if(btn.forceClose)
                  {
                     this.removeNotification(this._currentTips,true);
                  }
                  return;
               }
               notif = this.getNotificationData(target as Texture);
               if(notif)
               {
                  if(notif != this._currentTips)
                  {
                     this.uiApi.hideTooltip();
                     if(this._currentTips != null)
                     {
                        this.hideNotification(this._currentTips);
                     }
                     this._currentTips = notif;
                     this.showMessage();
                  }
                  else
                  {
                     this.hideNotification(notif);
                  }
                  return;
               }
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var notif:NotificationWrapper = null;
         var img:Object = null;
         if(target == this.ctr_visible)
         {
            if((!(this._currentTips == null)) && (this._currentTips.duration > 0) && (this._currentTips.pauseOnOver) && (this._tmpTimer == 0))
            {
               this._tmpTimer = getTimer();
            }
         }
         else
         {
            notif = this.getNotificationData(target as Texture);
            if(notif)
            {
               if(notif != this._currentTips)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(notif.title),target,false,"standard",3,5,3,null,null,null,"TextInfo");
               }
            }
            else if((this._currentTips) && (!(this._imgListDisplay.indexOf(target) == -1)))
            {
               img = this._currentTips.imageList[this._imgListDisplay.indexOf(target)];
               if(img)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(img.tips),target,false,"standard",3,5,3,null,null,null,"TextInfo");
               }
            }
            
         }
      }
      
      public function onRollOut(target:Object) : void {
         switch(target)
         {
            case this.ctr_visible:
               if((!(this._currentTips == null)) && (this._currentTips.duration > 0) && (this._currentTips.pauseOnOver))
               {
                  this._currentTips.startTime = this._currentTips.startTime + (getTimer() - this._tmpTimer);
                  this._tmpTimer = 0;
               }
               break;
            default:
               this.uiApi.hideTooltip();
         }
      }
      
      public function onMiddleClick(target:Object) : void {
         var notif:NotificationWrapper = this.getNotificationData(target as Texture);
         if(notif)
         {
            this.removeNotification(notif);
         }
      }
      
      public function onTextClick(target:Object, textEvent:String) : void {
         var infos:Array = null;
         var action:Object = null;
         if(target == this.lbl_message)
         {
            if(textEvent.indexOf("sendaction") == 0)
            {
               infos = textEvent.split(",");
               infos.splice(0,2);
               action = this.utilApi.callConstructorWithParameters(getDefinitionByName("d2actions." + infos[1]) as Class,infos);
               this.sysApi.sendAction(action);
            }
         }
      }
      
      public function forceNewNotification(pNotification:Object) : void {
         this.onNewNotification(pNotification);
      }
      
      private function createNotificationTexture(pNotification:NotificationWrapper) : void {
         this.ctr_main.visible = true;
         this.ctr_visible.visible = true;
         this.ctr_tips.visible = true;
         this.btn_show.visible = false;
         this.btn_hide.visible = true;
         var tx:Texture = this.uiApi.createComponent("Texture") as Texture;
         tx.name = "tips" + this._tipsList.indexOf(pNotification);
         tx.mouseEnabled = true;
         tx.cacheAsBitmap = true;
         tx.buttonMode = true;
         tx.useHandCursor = true;
         var typeIcon:int = pNotification.type;
         if(typeIcon == NotificationTypeEnum.SERVER_INFORMATION)
         {
            typeIcon = NotificationTypeEnum.TUTORIAL;
         }
         tx.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tips_icon" + typeIcon);
         this.uiApi.addComponentHook(tx,"onRelease");
         this.uiApi.addComponentHook(tx,"onRollOver");
         this.uiApi.addComponentHook(tx,"onRollOut");
         this.uiApi.addComponentHook(tx,"onMiddleClick");
         tx.finalize();
         pNotification.texture = tx;
         this.ctr_tips.addChild(tx);
         tx.visible = true;
         tx.y = 25 + this.getVisibleNotificationNumber() * NOTIFICATION_HEIGHT + 10;
         tx.x = 0;
         if(this._tipsList.length == 1)
         {
            this._currentTips = pNotification;
         }
         this.startAnim(pNotification);
      }
      
      private function addBtnToContainer(pData:Object, pPos:int) : void {
         var btn:ButtonContainer = null;
         var btnTx:Texture = null;
         var btnLbl:Label = null;
         var padding:uint = 20;
         var marginTop:uint = 10;
         var numberButton:int = this._currentTips.buttonList.length;
         btn = this.uiApi.createContainer("ButtonContainer") as ButtonContainer;
         btn.width = pData.width;
         btn.height = pData.height;
         btn.x = (this.tx_background_message.width - pData.width * numberButton - padding * numberButton) / 2 + (pData.width + padding) * pPos;
         btn.y = this.tx_background_message.height;
         btn.name = pData.name;
         btn.finalize();
         btnTx = this.uiApi.createComponent("Texture") as Texture;
         btnTx.width = pData.width;
         btnTx.height = pData.height;
         btnTx.uri = this.uiApi.createUri(this.uiApi.me().getConstant("btn.file"));
         btnTx.autoGrid = true;
         btnTx.name = btn.name + "_tx";
         btnTx.finalize();
         btnLbl = this.uiApi.createComponent("Label") as Label;
         btnLbl.width = pData.width;
         btnLbl.height = pData.height;
         btnLbl.verticalAlign = "center";
         btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("btn.css"));
         btnLbl.text = this.uiApi.replaceKey(pData.label);
         var stateChangingProperties:Array = new Array();
         stateChangingProperties[1] = new Array();
         stateChangingProperties[1][btnTx.name] = new Array();
         stateChangingProperties[1][btnTx.name]["gotoAndStop"] = "over";
         stateChangingProperties[2] = new Array();
         stateChangingProperties[2][btnTx.name] = new Array();
         stateChangingProperties[2][btnTx.name]["gotoAndStop"] = "pressed";
         btn.changingStateData = stateChangingProperties;
         btn.addChild(btnTx);
         btn.addChild(btnLbl);
         this.uiApi.addComponentHook(btn,"onRelease");
         this._btnListDisplay.push(btn);
         this.ctr_text.addChild(btn);
      }
      
      private function addImageToContainer(pData:Object) : void {
         var marginTop:* = 0;
         var dataIndex:* = 0;
         var lbl:Label = null;
         var img:Texture = this.uiApi.createComponent("Texture") as Texture;
         img.uri = pData.uri;
         if(pData.width > 0)
         {
            img.width = pData.width;
         }
         if(pData.height > 0)
         {
            img.height = pData.height;
         }
         if(pData.horizontalAlign)
         {
            img.x = (this.tx_background_message.width - img.width) / 2;
         }
         else
         {
            img.x = img.width / 2 + 5;
         }
         if(pData.verticalAlign)
         {
            marginTop = 10;
            dataIndex = this._imgListDisplay.indexOf(pData);
            img.y = this.lbl_message.height + this.lbl_message.y + (dataIndex > 0?this._imgListDisplay[this._imgListDisplay.indexOf(pData) - 1].y + this._imgListDisplay[this._imgListDisplay.indexOf(pData) - 1].height + marginTop:1);
         }
         else
         {
            img.y = pData.y;
         }
         if(pData.tips != "")
         {
            img.buttonMode = true;
            this.uiApi.addComponentHook(img,"onRollOver");
            this.uiApi.addComponentHook(img,"onRollOut");
         }
         img.finalize();
         this.tx_background_message.height = this.tx_background_message.height + (img.height + marginTop);
         if(pData.label != "")
         {
            lbl = this.uiApi.createComponent("Label") as Label;
            lbl.text = pData.label;
            lbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "normal.css");
            lbl.x = img.x + img.contentWidth / 2;
            lbl.y = (img.contentHeight - lbl.textHeight) / 2;
            img.addChild(lbl);
         }
         this._imgListDisplay.push(img);
         this.ctr_text.addChild(img);
      }
      
      private function clearContainer() : void {
         var btn:Object = null;
         var img:Object = null;
         for each(btn in this._btnListDisplay)
         {
            this.ctr_text.removeChild(btn);
         }
         this._btnListDisplay = new Array();
         for each(img in this._imgListDisplay)
         {
            this.ctr_text.removeChild(img);
         }
         this._imgListDisplay = new Array();
      }
      
      private function updateUi() : void {
         var h:uint = 0;
         if(this._tipsList.length > 0)
         {
            h = 25 + this.getVisibleNotificationNumber() * NOTIFICATION_HEIGHT;
            this.tx_background.height = h;
            this.ctr_down.y = h;
            this.mask_tips.height = h;
         }
         this.lbl_down.text = this._tipsList.length.toString();
         this.uiApi.me().render();
      }
      
      private function initContextualHelpTriggers() : void {
         var hookFunction:Function = null;
         var n:Object = null;
         var hookName:String = null;
         for each(n in this._contextualTipsList)
         {
            if((n.trigger) && (!this._notificationsDisabled[n.id]))
            {
               hookName = this.getHookName(n.trigger);
               if(ApplicationDomain.currentDomain.hasDefinition(hookName))
               {
                  hookFunction = this.createHook(n.title,n.message,"contextualHelp_" + n.id,hookName,n.id);
                  this.sysApi.addHook(getDefinitionByName(hookName) as Class,hookFunction);
                  if(hookName == "d2hooks.GameStart")
                  {
                     hookFunction();
                  }
               }
               else
               {
                  this.sysApi.log(1,"Impossible d\'écouter le hook " + hookName + " pour l\'interface de tips (hook non existant)");
               }
            }
         }
         this._triggersInit = true;
      }
      
      private function getHookName(trigger:String) : String {
         var hookInfo:Array = trigger.split(",");
         return "d2hooks." + hookInfo[0];
      }
      
      private function createHook(pTitle:String, pMessage:String, pName:String, pHookName:String, pId:int) : Function {
         return function(... args):void
         {
            var tutoNotif:* = new Object();
            tutoNotif.title = pTitle;
            tutoNotif.contentText = pMessage;
            tutoNotif.name = pName;
            tutoNotif.type = NotificationTypeEnum.TUTORIAL;
            tutoNotif.tutorialId = pId;
            forceNewNotification(tutoNotif);
            sysApi.removeHook(getDefinitionByName(pHookName) as Class);
         };
      }
      
      private function clearTutorialTriggers() : void {
         var n:Object = null;
         var hookName:String = null;
         for each(n in this._contextualTipsList)
         {
            if(n.trigger)
            {
               hookName = this.getHookName(n.trigger);
               if(ApplicationDomain.currentDomain.hasDefinition(hookName))
               {
                  this.sysApi.removeHook(getDefinitionByName(hookName) as Class);
               }
            }
         }
         this._triggersInit = false;
      }
      
      public function activate() : void {
         this._enabled = true;
      }
      
      public function deactivate() : void {
         this.clearAllNotification();
         this._enabled = false;
      }
   }
}
import d2components.Texture;
import flash.display.Shape;

class NotificationWrapper extends Object
{
   
   function NotificationWrapper() {
      super();
   }
   
   public static function create(data:Object) : NotificationWrapper {
      var b:Object = null;
      var i:Object = null;
      var notif:NotificationWrapper = new NotificationWrapper();
      notif.callback = data.callback;
      notif.callbackType = data.callbackType;
      notif.callbackParams = data.callbackParams;
      notif.texture = data.texture;
      notif.duration = data.duration;
      notif.startTime = data.startTime;
      notif.pauseOnOver = data.pauseOnOver;
      notif.title = data.title;
      notif.contentText = data.contentText;
      notif.name = data.name;
      notif.tutorialId = data.tutorialId;
      notif.buttonList = new Array();
      for each(b in data.buttonList)
      {
         notif.buttonList.push(b);
      }
      notif.imageList = new Array();
      for each(i in data.imageList)
      {
         notif.imageList.push(i);
      }
      notif.type = data.type;
      notif.blockCallbackOnTimerEnds = data.blockCallbackOnTimerEnds;
      return notif;
   }
   
   public var callback:String;
   
   public var callbackType:String;
   
   public var callbackParams:Object;
   
   public var texture:Texture;
   
   public var maskTimer:Shape;
   
   public var duration:int;
   
   public var startTime:int;
   
   public var pauseOnOver:Boolean;
   
   public var title:String;
   
   public var contentText:String;
   
   public var type:int;
   
   public var name:String;
   
   public var buttonList:Array;
   
   public var imageList:Array;
   
   public var tutorialId:int;
   
   public var blockCallbackOnTimerEnds:Boolean;
   
   public function get hasTimer() : Boolean {
      return (this.duration) && (this.duration > 0);
   }
}
