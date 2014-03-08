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
   import com.ankamagames.dofus.network.messages.game.script.CinematicMessage;
   import com.ankamagames.dofus.network.messages.game.context.display.DisplayNumericalValueMessage;
   import flash.utils.Timer;
   import com.ankamagames.dofus.logic.connection.messages.DelayedSystemMessageDisplayMessage;
   import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
   import com.ankamagames.dofus.network.messages.game.ui.ClientUIOpenedByObjectMessage;
   import com.ankamagames.dofus.network.messages.game.ui.ClientUIOpenedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.EntityTalkMessage;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionLimitationMessage;
   import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionZoneMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionToggleMessage;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayInteractivesFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.network.enums.NumericalValueTypeEnum;
   import flash.events.TimerEvent;
   import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.network.enums.TextInformationTypeEnum;
   import com.ankamagames.dofus.datacenter.communication.InfoMessage;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.network.enums.SubscriptionRequiredEnum;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.enums.FightOptionsEnum;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:OpenSmileysAction = null;
         var _loc3_:OpenBookAction = null;
         var _loc4_:OpenTeamSearchAction = null;
         var _loc5_:OpenArenaAction = null;
         var _loc6_:IEntity = null;
         var _loc7_:OpenInventoryAction = null;
         var _loc8_:CinematicMessage = null;
         var _loc9_:DisplayNumericalValueMessage = null;
         var _loc10_:IEntity = null;
         var _loc11_:uint = 0;
         var _loc12_:Timer = null;
         var _loc13_:DelayedSystemMessageDisplayMessage = null;
         var _loc14_:SystemMessageDisplayMessage = null;
         var _loc15_:ClientUIOpenedByObjectMessage = null;
         var _loc16_:ClientUIOpenedMessage = null;
         var _loc17_:EntityTalkMessage = null;
         var _loc18_:IDisplayable = null;
         var _loc19_:String = null;
         var _loc20_:uint = 0;
         var _loc21_:Array = null;
         var _loc22_:uint = 0;
         var _loc23_:Array = null;
         var _loc24_:ChatBubble = null;
         var _loc25_:SubscriptionLimitationMessage = null;
         var _loc26_:String = null;
         var _loc27_:SubscriptionZoneMessage = null;
         var _loc28_:GameFightOptionStateUpdateMessage = null;
         var _loc29_:uint = 0;
         var _loc30_:GameFightOptionToggleMessage = null;
         var _loc31_:uint = 0;
         var _loc32_:GameFightOptionToggleMessage = null;
         var _loc33_:uint = 0;
         var _loc34_:GameFightOptionToggleMessage = null;
         var _loc35_:uint = 0;
         var _loc36_:GameFightOptionToggleMessage = null;
         var _loc37_:RoleplayInteractivesFrame = null;
         var _loc38_:DelayedSystemMessageDisplayMessage = null;
         var _loc39_:* = undefined;
         switch(true)
         {
            case param1 is OpenSmileysAction:
               _loc2_ = param1 as OpenSmileysAction;
               KernelEventsManager.getInstance().processCallback(HookList.SmileysStart,_loc2_.type,_loc2_.forceOpen);
               return true;
            case param1 is OpenBookAction:
               _loc3_ = param1 as OpenBookAction;
               KernelEventsManager.getInstance().processCallback(HookList.OpenBook,_loc3_.value,_loc3_.param);
               return true;
            case param1 is OpenTeamSearchAction:
               _loc4_ = param1 as OpenTeamSearchAction;
               KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenTeamSearch);
               return true;
            case param1 is OpenArenaAction:
               _loc5_ = param1 as OpenArenaAction;
               KernelEventsManager.getInstance().processCallback(TriggerHookList.OpenArena);
               return true;
            case param1 is OpenMapAction:
               _loc6_ = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
               if(!_loc6_)
               {
                  return true;
               }
               TooltipManager.hideAll();
               KernelEventsManager.getInstance().processCallback(HookList.OpenMap,(param1 as OpenMapAction).conquest);
               return true;
            case param1 is OpenInventoryAction:
               _loc7_ = param1 as OpenInventoryAction;
               KernelEventsManager.getInstance().processCallback(HookList.OpenInventory,_loc7_.behavior);
               return true;
            case param1 is CloseInventoryAction:
               KernelEventsManager.getInstance().processCallback(HookList.CloseInventory);
               return true;
            case param1 is OpenMountAction:
               KernelEventsManager.getInstance().processCallback(HookList.OpenMount);
               return true;
            case param1 is OpenMainMenuAction:
               KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
               return true;
            case param1 is OpenStatsAction:
               KernelEventsManager.getInstance().processCallback(HookList.OpenStats,InventoryManager.getInstance().inventory.getView("equipment").content);
               return true;
            case param1 is CinematicMessage:
               _loc8_ = param1 as CinematicMessage;
               KernelEventsManager.getInstance().processCallback(HookList.Cinematic,_loc8_.cinematicId);
               return true;
            case param1 is DisplayNumericalValueMessage:
               _loc9_ = param1 as DisplayNumericalValueMessage;
               _loc10_ = DofusEntities.getEntity(_loc9_.entityId);
               _loc11_ = 0;
               switch(_loc9_.type)
               {
                  case NumericalValueTypeEnum.NUMERICAL_VALUE_COLLECT:
                     _loc11_ = 7615756;
                     _loc37_ = Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame;
                     if((_loc37_) && (_loc10_) && !((_loc10_ as IAnimated).getAnimation() == AnimationEnum.ANIM_STATIQUE))
                     {
                        _loc12_ = _loc37_.getInteractiveActionTimer(_loc10_);
                     }
                     if((_loc12_) && (_loc12_.running))
                     {
                        this._dnvmsgs[_loc12_] = _loc9_;
                        _loc12_.addEventListener(TimerEvent.TIMER,this.onAnimEnd);
                     }
                     else
                     {
                        this.displayNumericalValue(_loc10_,_loc9_,_loc11_);
                     }
                     return true;
                  default:
                     _log.warn("DisplayNumericalValueMessage with unsupported type : " + _loc9_.type);
                     return false;
               }
            case param1 is DelayedSystemMessageDisplayMessage:
               _loc13_ = param1 as DelayedSystemMessageDisplayMessage;
               this.systemMessageDisplay(_loc13_);
               return true;
            case param1 is SystemMessageDisplayMessage:
               _loc14_ = param1 as SystemMessageDisplayMessage;
               if(_loc14_.hangUp)
               {
                  _loc38_ = new DelayedSystemMessageDisplayMessage();
                  _loc38_.initDelayedSystemMessageDisplayMessage(_loc14_.hangUp,_loc14_.msgId,_loc14_.parameters);
                  DisconnectionHandlerFrame.messagesAfterReset.push(_loc38_);
               }
               this.systemMessageDisplay(_loc14_);
               return true;
            case param1 is ClientUIOpenedByObjectMessage:
               _loc15_ = param1 as ClientUIOpenedByObjectMessage;
               KernelEventsManager.getInstance().processCallback(CustomUiHookList.ClientUIOpened,_loc15_.type,_loc15_.uid);
               return true;
            case param1 is ClientUIOpenedMessage:
               _loc16_ = param1 as ClientUIOpenedMessage;
               KernelEventsManager.getInstance().processCallback(CustomUiHookList.ClientUIOpened,_loc16_.type,0);
               return true;
            case param1 is EntityTalkMessage:
               _loc17_ = param1 as EntityTalkMessage;
               _loc18_ = DofusEntities.getEntity(_loc17_.entityId) as IDisplayable;
               _loc21_ = new Array();
               _loc22_ = TextInformationTypeEnum.TEXT_ENTITY_TALK;
               if(_loc18_ == null)
               {
                  return true;
               }
               _loc23_ = new Array();
               for each (_loc39_ in _loc17_.parameters)
               {
                  _loc23_.push(_loc39_);
               }
               if(InfoMessage.getInfoMessageById(_loc22_ * 10000 + _loc17_.textId))
               {
                  _loc20_ = InfoMessage.getInfoMessageById(_loc22_ * 10000 + _loc17_.textId).textId;
                  if(_loc23_ != null)
                  {
                     if((_loc23_[0]) && !(_loc23_[0].indexOf("~") == -1))
                     {
                        _loc21_ = _loc23_[0].split("~");
                     }
                     else
                     {
                        _loc21_ = _loc23_;
                     }
                  }
               }
               else
               {
                  _log.error("Texte " + (_loc22_ * 10000 + _loc17_.textId) + " not found.");
                  _loc19_ = "" + _loc17_.textId;
               }
               if(!_loc19_)
               {
                  _loc19_ = I18n.getText(_loc20_,_loc21_);
               }
               _loc24_ = new ChatBubble(_loc19_);
               TooltipManager.show(_loc24_,_loc18_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"entityMsg" + _loc17_.entityId,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,null,null);
               return true;
            case param1 is SubscriptionLimitationMessage:
               _loc25_ = param1 as SubscriptionLimitationMessage;
               _log.error("SubscriptionLimitationMessage reason " + _loc25_.reason);
               _loc26_ = "";
               switch(_loc25_.reason)
               {
                  case SubscriptionRequiredEnum.LIMIT_ON_JOB_XP:
                     _loc26_ = I18n.getUiText("ui.payzone.limitJobXp");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_JOB_USE:
                     _loc26_ = I18n.getUiText("ui.payzone.limitJobXp");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_MAP:
                     _loc26_ = I18n.getUiText("ui.payzone.limit");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_ITEM:
                     _loc26_ = I18n.getUiText("ui.payzone.limitItem");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_VENDOR:
                     _loc26_ = I18n.getUiText("ui.payzone.limitVendor");
                     break;
                  case SubscriptionRequiredEnum.LIMITED_TO_SUBSCRIBER:
                  default:
                     _loc26_ = I18n.getUiText("ui.payzone.limit");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc26_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(HookList.NonSubscriberPopup);
               return true;
            case param1 is SubscriptionZoneMessage:
               _loc27_ = param1 as SubscriptionZoneMessage;
               _log.error("SubscriptionZoneMessage active " + _loc27_.active);
               KernelEventsManager.getInstance().processCallback(HookList.SubscriptionZone,_loc27_.active);
               return true;
            case param1 is GameFightOptionStateUpdateMessage:
               _loc28_ = param1 as GameFightOptionStateUpdateMessage;
               switch(_loc28_.option)
               {
                  case FightOptionsEnum.FIGHT_OPTION_SET_SECRET:
                     KernelEventsManager.getInstance().processCallback(HookList.OptionWitnessForbidden,_loc28_.state);
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY:
                     if(Kernel.getWorker().getFrame(FightContextFrame))
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty,_loc28_.state);
                     }
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_SET_CLOSED:
                     if(PlayedCharacterManager.getInstance().teamId == _loc28_.teamId)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.OptionLockFight,_loc28_.state);
                     }
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP:
                     KernelEventsManager.getInstance().processCallback(HookList.OptionHelpWanted,_loc28_.state);
                     break;
               }
               if(Kernel.getWorker().getFrame(RoleplayEntitiesFrame))
               {
                  return false;
               }
               return true;
            case param1 is ToggleWitnessForbiddenAction:
               _loc29_ = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
               _loc30_ = new GameFightOptionToggleMessage();
               _loc30_.initGameFightOptionToggleMessage(_loc29_);
               ConnectionsHandler.getConnection().send(_loc30_);
               return true;
            case param1 is ToggleLockPartyAction:
               _loc31_ = FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY;
               _loc32_ = new GameFightOptionToggleMessage();
               _loc32_.initGameFightOptionToggleMessage(_loc31_);
               ConnectionsHandler.getConnection().send(_loc32_);
               return true;
            case param1 is ToggleLockFightAction:
               _loc33_ = FightOptionsEnum.FIGHT_OPTION_SET_CLOSED;
               _loc34_ = new GameFightOptionToggleMessage();
               _loc34_.initGameFightOptionToggleMessage(_loc33_);
               ConnectionsHandler.getConnection().send(_loc34_);
               return true;
            case param1 is ToggleHelpWantedAction:
               _loc35_ = FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP;
               _loc36_ = new GameFightOptionToggleMessage();
               _loc36_.initGameFightOptionToggleMessage(_loc35_);
               ConnectionsHandler.getConnection().send(_loc36_);
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean {
         this._dnvmsgs = new Dictionary(true);
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      private function onAnimEnd(param1:TimerEvent) : void {
         param1.currentTarget.removeEventListener(TimerEvent.TIMER,this.onAnimEnd);
         var _loc2_:DisplayNumericalValueMessage = this._dnvmsgs[param1.currentTarget];
         this.displayNumericalValue(DofusEntities.getEntity(_loc2_.entityId),_loc2_,7615756,1,1500);
         delete this._dnvmsgs[[param1.currentTarget]];
      }
      
      private function displayNumericalValue(param1:IEntity, param2:DisplayNumericalValueMessage, param3:uint, param4:Number=1, param5:uint=2500) : void {
         this.displayValue(param1,param2.value.toString(),param3,param4,param5);
         var _loc6_:DisplayNumericalValueWithAgeBonusMessage = param2 as DisplayNumericalValueWithAgeBonusMessage;
         if(_loc6_)
         {
            this.displayValue(param1,_loc6_.valueOfBonus.toString(),16733440,param4,param5);
         }
      }
      
      private function displayValue(param1:IEntity, param2:String, param3:uint, param4:Number, param5:uint) : void {
         if(!param1)
         {
            return;
         }
         CharacteristicContextualManager.getInstance().addStatContextual(param2,param1,new TextFormat("Verdana",24,param3,true),1,param4,param5);
      }
      
      private function systemMessageDisplay(param1:SystemMessageDisplayMessage) : void {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:InfoMessage = null;
         var _loc7_:uint = 0;
         var _loc2_:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         var _loc3_:Array = new Array();
         for each (_loc4_ in param1.parameters)
         {
            _loc3_.push(_loc4_);
         }
         _loc6_ = InfoMessage.getInfoMessageById(40000 + param1.msgId);
         if(_loc6_)
         {
            _loc7_ = _loc6_.textId;
            _loc5_ = I18n.getText(_loc7_);
            if(_loc5_)
            {
               _loc5_ = ParamsDecoder.applyParams(_loc5_,_loc3_);
            }
         }
         else
         {
            _log.error("Information message " + (40000 + param1.msgId) + " cannot be found.");
            _loc5_ = "Information message " + (40000 + param1.msgId) + " cannot be found.";
         }
         _loc2_.openPopup(I18n.getUiText("ui.popup.warning"),_loc5_,[I18n.getUiText("ui.common.ok")],null,null,null,null,false,true);
      }
   }
}
