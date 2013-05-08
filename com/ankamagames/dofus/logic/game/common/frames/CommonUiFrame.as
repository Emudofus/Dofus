package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSmileysAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenTeamSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenArenaAction;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.network.messages.game.context.display.DisplayNumericalValueMessage;
   import flash.utils.Timer;
   import com.ankamagames.dofus.logic.connection.messages.DelayedSystemMessageDisplayMessage;
   import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.EntityTalkMessage;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionLimitationMessage;
   import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionZoneMessage;
   import com.ankamagames.dofus.network.messages.game.atlas.AtlasPointInformationsMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionToggleMessage;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import com.ankamagames.dofus.network.types.game.context.MapCoordinatesExtended;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.network.enums.NumericalValueTypeEnum;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
   import com.ankamagames.dofus.network.enums.TextInformationTypeEnum;
   import com.ankamagames.dofus.datacenter.communication.InfoMessage;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.network.enums.SubscriptionRequiredEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.managers.FlagManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.enums.FightOptionsEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMainMenuAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenStatsAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleWitnessForbiddenAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockPartyAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockFightAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleHelpWantedAction;
   import com.ankamagames.dofus.network.messages.game.context.display.DisplayNumericalValueWithAgeBonusMessage;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
   import flash.text.TextFormat;
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;


   public class CommonUiFrame extends Object implements Frame
   {
         

      public function CommonUiFrame() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonUiFrame));

      private var _dnvmsgs:Dictionary;

      public function get priority() : int {
         return 0;
      }

      public function process(msg:Message) : Boolean {
         var osa:OpenSmileysAction = null;
         var oba:OpenBookAction = null;
         var tsa:OpenTeamSearchAction = null;
         var oaa:OpenArenaAction = null;
         var playerEntity:IEntity = null;
         var oia:OpenInventoryAction = null;
         var dnvmsg:DisplayNumericalValueMessage = null;
         var entity:IEntity = null;
         var color:uint = 0;
         var animTimer:Timer = null;
         var dsmdmsg:DelayedSystemMessageDisplayMessage = null;
         var smdmsg:SystemMessageDisplayMessage = null;
         var etmsg:EntityTalkMessage = null;
         var speakerEntity:IDisplayable = null;
         var msgContent2:String = null;
         var textId2:uint = 0;
         var params:Array = null;
         var type:uint = 0;
         var param:Array = null;
         var bubble:ChatBubble = null;
         var slmsg:SubscriptionLimitationMessage = null;
         var text:String = null;
         var szmsg:SubscriptionZoneMessage = null;
         var apimsg:AtlasPointInformationsMessage = null;
         var gfosumsg:GameFightOptionStateUpdateMessage = null;
         var option:uint = 0;
         var gfotmsg:GameFightOptionToggleMessage = null;
         var option2:uint = 0;
         var gfotmsg2:GameFightOptionToggleMessage = null;
         var option3:uint = 0;
         var gfotmsg3:GameFightOptionToggleMessage = null;
         var option4:uint = 0;
         var gfotmsg4:GameFightOptionToggleMessage = null;
         var interactiveFrame:RoleplayInteractivesFrame = null;
         var dsmdmsg2:DelayedSystemMessageDisplayMessage = null;
         var prm:* = undefined;
         var pList:Array = null;
         var coord:MapCoordinatesExtended = null;
         switch(true)
         {
            case msg is OpenSmileysAction:
               osa=msg as OpenSmileysAction;
               KernelEventsManager.getInstance().processCallback(HookList.SmileysStart,osa.type,osa.forceOpen);
               return true;
            case msg is OpenBookAction:
               oba=msg as OpenBookAction;
               KernelEventsManager.getInstance().processCallback(HookList.OpenBook,oba.value,oba.param);
               return true;
            case msg is OpenTeamSearchAction:
               tsa=msg as OpenTeamSearchAction;
               KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenTeamSearch);
               return true;
            case msg is OpenArenaAction:
               oaa=msg as OpenArenaAction;
               KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenArena);
               return true;
            case msg is OpenMapAction:
               playerEntity=DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if(!playerEntity)
               {
                  return true;
               }
               TooltipManager.hideAll();
               KernelEventsManager.getInstance().processCallback(HookList.OpenMap,(msg as OpenMapAction).conquest);
               if((playerEntity as IMovable).isMoving)
               {
                  (playerEntity as IMovable).stop();
               }
               return true;
            case msg is OpenInventoryAction:
               oia=msg as OpenInventoryAction;
               KernelEventsManager.getInstance().processCallback(HookList.OpenInventory,oia.behavior);
               return true;
            case msg is CloseInventoryAction:
               KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               return true;
            case msg is OpenMountAction:
               KernelEventsManager.getInstance().processCallback(HookList.OpenMount);
               return true;
            case msg is OpenMainMenuAction:
               KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
               return true;
            case msg is OpenStatsAction:
               KernelEventsManager.getInstance().processCallback(HookList.OpenStats,InventoryManager.getInstance().inventory.getView("equipment").content);
               return true;
            case msg is DisplayNumericalValueMessage:
               dnvmsg=msg as DisplayNumericalValueMessage;
               entity=DofusEntities.getEntity(dnvmsg.entityId);
               color=0;
               switch(dnvmsg.type)
               {
                  case NumericalValueTypeEnum.NUMERICAL_VALUE_COLLECT:
                     color=7615756;
                     interactiveFrame=Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
                     if((interactiveFrame)&&(!((entity as IAnimated).getAnimation()==AnimationEnum.ANIM_STATIQUE)))
                     {
                        animTimer=interactiveFrame.getInteractiveActionTimer(entity);
                     }
                     if((animTimer)&&(animTimer.running))
                     {
                        this._dnvmsgs[animTimer]=dnvmsg;
                        animTimer.addEventListener(TimerEvent.TIMER,this.onAnimEnd);
                     }
                     else
                     {
                        this.displayNumericalValue(entity,dnvmsg,color);
                     }
                     return true;
                  default:
                     _log.warn("DisplayNumericalValueMessage with unsupported type : "+dnvmsg.type);
                     return false;
               }
            case msg is DelayedSystemMessageDisplayMessage:
               dsmdmsg=msg as DelayedSystemMessageDisplayMessage;
               this.systemMessageDisplay(dsmdmsg);
               return true;
            case msg is SystemMessageDisplayMessage:
               smdmsg=msg as SystemMessageDisplayMessage;
               if(smdmsg.hangUp)
               {
                  dsmdmsg2=new DelayedSystemMessageDisplayMessage();
                  dsmdmsg2.initDelayedSystemMessageDisplayMessage(smdmsg.hangUp,smdmsg.msgId,smdmsg.parameters);
                  DisconnectionHandlerFrame.messagesAfterReset.push(dsmdmsg2);
               }
               this.systemMessageDisplay(smdmsg);
               return true;
            case msg is EntityTalkMessage:
               etmsg=msg as EntityTalkMessage;
               speakerEntity=DofusEntities.getEntity(etmsg.entityId) as IDisplayable;
               params=new Array();
               type=TextInformationTypeEnum.TEXT_ENTITY_TALK;
               if(speakerEntity==null)
               {
                  return true;
               }
               param=new Array();
               for each (prm in etmsg.parameters)
               {
                  param.push(prm);
               }
               if(InfoMessage.getInfoMessageById(type*10000+etmsg.textId))
               {
                  textId2=InfoMessage.getInfoMessageById(type*10000+etmsg.textId).textId;
                  if(param!=null)
                  {
                     if((param[0])&&(!(param[0].indexOf("~")==-1)))
                     {
                        params=param[0].split("~");
                     }
                     else
                     {
                        params=param;
                     }
                  }
               }
               else
               {
                  _log.error("Texte "+(type*10000+etmsg.textId)+" not found.");
                  msgContent2=""+etmsg.textId;
               }
               if(!msgContent2)
               {
                  msgContent2=I18n.getText(textId2,params);
               }
               bubble=new ChatBubble(msgContent2);
               TooltipManager.show(bubble,speakerEntity.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"entityMsg"+etmsg.entityId,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,null,null);
               return true;
            case msg is SubscriptionLimitationMessage:
               slmsg=msg as SubscriptionLimitationMessage;
               _log.error("SubscriptionLimitationMessage reason "+slmsg.reason);
               text="";
               switch(slmsg.reason)
               {
                  case SubscriptionRequiredEnum.LIMIT_ON_JOB_XP:
                     text=I18n.getUiText("ui.payzone.limitJobXp");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_JOB_USE:
                     text=I18n.getUiText("ui.payzone.limitJobXp");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_MAP:
                     text=I18n.getUiText("ui.payzone.limit");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_ITEM:
                     text=I18n.getUiText("ui.payzone.limitItem");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_VENDOR:
                     text=I18n.getUiText("ui.payzone.limitVendor");
                     break;
                  case SubscriptionRequiredEnum.LIMITED_TO_SUBSCRIBER:
               }
               text=I18n.getUiText("ui.payzone.limit");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,text,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(HookList.NonSubscriberPopup);
               return true;
            case msg is SubscriptionZoneMessage:
               szmsg=msg as SubscriptionZoneMessage;
               _log.error("SubscriptionZoneMessage active "+szmsg.active);
               KernelEventsManager.getInstance().processCallback(HookList.SubscriptionZone,szmsg.active);
               return true;
            case msg is AtlasPointInformationsMessage:
               apimsg=AtlasPointInformationsMessage(msg);
               if(apimsg.type.type==3)
               {
                  pList=new Array();
                  for each (coord in apimsg.type.coords)
                  {
                     pList.push(coord.mapId);
                  }
                  FlagManager.getInstance().phoenixs=pList;
                  KernelEventsManager.getInstance().processCallback(HookList.phoenixUpdate);
               }
               return true;
            case msg is GameFightOptionStateUpdateMessage:
               gfosumsg=msg as GameFightOptionStateUpdateMessage;
               switch(gfosumsg.option)
               {
                  case FightOptionsEnum.FIGHT_OPTION_SET_SECRET:
                     KernelEventsManager.getInstance().processCallback(HookList.OptionWitnessForbidden,gfosumsg.state);
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY:
                     if(Kernel.getWorker().getFrame(FightContextFrame))
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty,gfosumsg.state);
                     }
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_SET_CLOSED:
                     if(PlayedCharacterManager.getInstance().teamId==gfosumsg.teamId)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.OptionLockFight,gfosumsg.state);
                     }
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP:
                     KernelEventsManager.getInstance().processCallback(HookList.OptionHelpWanted,gfosumsg.state);
                     break;
               }
               return false;
            case msg is ToggleWitnessForbiddenAction:
               option=FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
               gfotmsg=new GameFightOptionToggleMessage();
               gfotmsg.initGameFightOptionToggleMessage(option);
               ConnectionsHandler.getConnection().send(gfotmsg);
               return true;
            case msg is ToggleLockPartyAction:
               option2=FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY;
               gfotmsg2=new GameFightOptionToggleMessage();
               gfotmsg2.initGameFightOptionToggleMessage(option2);
               ConnectionsHandler.getConnection().send(gfotmsg2);
               return true;
            case msg is ToggleLockFightAction:
               option3=FightOptionsEnum.FIGHT_OPTION_SET_CLOSED;
               gfotmsg3=new GameFightOptionToggleMessage();
               gfotmsg3.initGameFightOptionToggleMessage(option3);
               ConnectionsHandler.getConnection().send(gfotmsg3);
               return true;
            case msg is ToggleHelpWantedAction:
               option4=FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP;
               gfotmsg4=new GameFightOptionToggleMessage();
               gfotmsg4.initGameFightOptionToggleMessage(option4);
               ConnectionsHandler.getConnection().send(gfotmsg4);
               return true;
            default:
               return false;
         }
      }

      public function pushed() : Boolean {
         this._dnvmsgs=new Dictionary(true);
         return true;
      }

      public function pulled() : Boolean {
         return true;
      }

      private function onAnimEnd(pTimerEvent:TimerEvent) : void {
         pTimerEvent.currentTarget.removeEventListener(TimerEvent.TIMER,this.onAnimEnd);
         var dnvmsg:DisplayNumericalValueMessage = this._dnvmsgs[pTimerEvent.currentTarget];
         this.displayNumericalValue(DofusEntities.getEntity(dnvmsg.entityId),dnvmsg,7615756,1,1500);
         delete this._dnvmsgs[[pTimerEvent.currentTarget]];
      }

      private function displayNumericalValue(pEntity:IEntity, pMsg:DisplayNumericalValueMessage, pColor:uint, pScrollSpeed:Number=1, pScrollDuration:uint=2500) : void {
         this.displayValue(pEntity,pMsg.value.toString(),pColor,pScrollSpeed,pScrollDuration);
         var dnvwabmsg:DisplayNumericalValueWithAgeBonusMessage = pMsg as DisplayNumericalValueWithAgeBonusMessage;
         if(dnvwabmsg)
         {
            this.displayValue(pEntity,dnvwabmsg.valueOfBonus.toString(),16733440,pScrollSpeed,pScrollDuration);
         }
      }

      private function displayValue(pEntity:IEntity, pValue:String, pColor:uint, pScrollSpeed:Number, pScrollDuration:uint) : void {
         CharacteristicContextualManager.getInstance().addStatContextual(pValue,pEntity,new TextFormat("Verdana",24,pColor,true),1,pScrollSpeed,pScrollDuration);
      }

      private function systemMessageDisplay(msg:SystemMessageDisplayMessage) : void {
         var i:* = undefined;
         var msgContent:String = null;
         var message:InfoMessage = null;
         var textId:uint = 0;
         var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         var a:Array = new Array();
         for each (i in msg.parameters)
         {
            a.push(i);
         }
         message=InfoMessage.getInfoMessageById(40000+msg.msgId);
         if(message)
         {
            textId=message.textId;
            msgContent=I18n.getText(textId);
            if(msgContent)
            {
               msgContent=ParamsDecoder.applyParams(msgContent,a);
            }
         }
         else
         {
            _log.error("Information message "+(40000+msg.msgId)+" cannot be found.");
            msgContent="Information message "+(40000+msg.msgId)+" cannot be found.";
         }
         commonMod.openPopup(I18n.getUiText("ui.popup.warning"),msgContent,[I18n.getUiText("ui.common.ok")]);
      }
   }

}