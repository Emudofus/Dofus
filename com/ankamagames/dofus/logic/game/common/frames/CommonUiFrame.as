package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSmileysAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenTeamSearchAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenArenaAction;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.network.messages.game.script.CinematicMessage;
   import com.ankamagames.dofus.logic.connection.messages.DelayedSystemMessageDisplayMessage;
   import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
   import com.ankamagames.dofus.network.messages.game.ui.ClientUIOpenedByObjectMessage;
   import com.ankamagames.dofus.network.messages.game.ui.ClientUIOpenedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.EntityTalkMessage;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionLimitationMessage;
   import com.ankamagames.dofus.network.messages.game.subscriber.SubscriptionZoneMessage;
   import com.ankamagames.dofus.network.messages.game.guest.GuestLimitationMessage;
   import com.ankamagames.dofus.network.messages.game.guest.GuestModeMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionStateUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightOptionToggleMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
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
   import com.ankamagames.dofus.network.enums.GuestLimitationEnum;
   import com.ankamagames.dofus.kernel.Kernel;
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
   import com.ankamagames.dofus.misc.utils.ParamsDecoder;
   
   public class CommonUiFrame extends Object implements Frame
   {
      
      public function CommonUiFrame()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CommonUiFrame));
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:OpenSmileysAction = null;
         var _loc3_:OpenBookAction = null;
         var _loc4_:OpenTeamSearchAction = null;
         var _loc5_:OpenArenaAction = null;
         var _loc6_:IEntity = null;
         var _loc7_:OpenMapAction = null;
         var _loc8_:* = false;
         var _loc9_:OpenInventoryAction = null;
         var _loc10_:CinematicMessage = null;
         var _loc11_:DelayedSystemMessageDisplayMessage = null;
         var _loc12_:SystemMessageDisplayMessage = null;
         var _loc13_:ClientUIOpenedByObjectMessage = null;
         var _loc14_:ClientUIOpenedMessage = null;
         var _loc15_:EntityTalkMessage = null;
         var _loc16_:IDisplayable = null;
         var _loc17_:String = null;
         var _loc18_:uint = 0;
         var _loc19_:Array = null;
         var _loc20_:uint = 0;
         var _loc21_:Array = null;
         var _loc22_:ChatBubble = null;
         var _loc23_:SubscriptionLimitationMessage = null;
         var _loc24_:String = null;
         var _loc25_:SubscriptionZoneMessage = null;
         var _loc26_:GuestLimitationMessage = null;
         var _loc27_:String = null;
         var _loc28_:GuestModeMessage = null;
         var _loc29_:GameFightOptionStateUpdateMessage = null;
         var _loc30_:uint = 0;
         var _loc31_:GameFightOptionToggleMessage = null;
         var _loc32_:uint = 0;
         var _loc33_:GameFightOptionToggleMessage = null;
         var _loc34_:uint = 0;
         var _loc35_:GameFightOptionToggleMessage = null;
         var _loc36_:uint = 0;
         var _loc37_:GameFightOptionToggleMessage = null;
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
               _loc7_ = param1 as OpenMapAction;
               _loc8_ = OptionManager.getOptionManager("dofus")["lastMapUiWasPocket"];
               if(!_loc7_.ignoreSetting)
               {
                  _loc7_.pocket = _loc8_;
               }
               KernelEventsManager.getInstance().processCallback(HookList.OpenMap,_loc7_.ignoreSetting,_loc7_.pocket,_loc7_.conquest);
               return true;
            case param1 is OpenInventoryAction:
               _loc9_ = param1 as OpenInventoryAction;
               KernelEventsManager.getInstance().processCallback(HookList.OpenInventory,_loc9_.behavior);
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
               _loc10_ = param1 as CinematicMessage;
               KernelEventsManager.getInstance().processCallback(HookList.Cinematic,_loc10_.cinematicId);
               return true;
            case param1 is DelayedSystemMessageDisplayMessage:
               _loc11_ = param1 as DelayedSystemMessageDisplayMessage;
               this.systemMessageDisplay(_loc11_);
               return true;
            case param1 is SystemMessageDisplayMessage:
               _loc12_ = param1 as SystemMessageDisplayMessage;
               if(_loc12_.hangUp)
               {
                  _loc38_ = new DelayedSystemMessageDisplayMessage();
                  _loc38_.initDelayedSystemMessageDisplayMessage(_loc12_.hangUp,_loc12_.msgId,_loc12_.parameters);
                  DisconnectionHandlerFrame.messagesAfterReset.push(_loc38_);
               }
               this.systemMessageDisplay(_loc12_);
               return true;
            case param1 is ClientUIOpenedByObjectMessage:
               _loc13_ = param1 as ClientUIOpenedByObjectMessage;
               KernelEventsManager.getInstance().processCallback(CustomUiHookList.ClientUIOpened,_loc13_.type,_loc13_.uid);
               return true;
            case param1 is ClientUIOpenedMessage:
               _loc14_ = param1 as ClientUIOpenedMessage;
               KernelEventsManager.getInstance().processCallback(CustomUiHookList.ClientUIOpened,_loc14_.type,0);
               return true;
            case param1 is EntityTalkMessage:
               _loc15_ = param1 as EntityTalkMessage;
               _loc16_ = DofusEntities.getEntity(_loc15_.entityId) as IDisplayable;
               _loc19_ = new Array();
               _loc20_ = TextInformationTypeEnum.TEXT_ENTITY_TALK;
               if(_loc16_ == null)
               {
                  return true;
               }
               _loc21_ = new Array();
               for each(_loc39_ in _loc15_.parameters)
               {
                  _loc21_.push(_loc39_);
               }
               if(InfoMessage.getInfoMessageById(_loc20_ * 10000 + _loc15_.textId))
               {
                  _loc18_ = InfoMessage.getInfoMessageById(_loc20_ * 10000 + _loc15_.textId).textId;
                  if(_loc21_ != null)
                  {
                     if((_loc21_[0]) && !(_loc21_[0].indexOf("~") == -1))
                     {
                        _loc19_ = _loc21_[0].split("~");
                     }
                     else
                     {
                        _loc19_ = _loc21_;
                     }
                  }
               }
               else
               {
                  _log.error("Texte " + (_loc20_ * 10000 + _loc15_.textId) + " not found.");
                  _loc17_ = "" + _loc15_.textId;
               }
               if(!_loc17_)
               {
                  _loc17_ = I18n.getText(_loc18_,_loc19_);
               }
               _loc22_ = new ChatBubble(_loc17_);
               TooltipManager.show(_loc22_,_loc16_.absoluteBounds,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),true,"entityMsg" + _loc15_.entityId,LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,null,null);
               return true;
            case param1 is SubscriptionLimitationMessage:
               _loc23_ = param1 as SubscriptionLimitationMessage;
               _log.error("SubscriptionLimitationMessage reason " + _loc23_.reason);
               _loc24_ = "";
               switch(_loc23_.reason)
               {
                  case SubscriptionRequiredEnum.LIMIT_ON_JOB_XP:
                     _loc24_ = I18n.getUiText("ui.payzone.limitJobXp");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_JOB_USE:
                     _loc24_ = I18n.getUiText("ui.payzone.limitJobXp");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_MAP:
                     _loc24_ = I18n.getUiText("ui.payzone.limit");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_ITEM:
                     _loc24_ = I18n.getUiText("ui.payzone.limitItem");
                     break;
                  case SubscriptionRequiredEnum.LIMIT_ON_VENDOR:
                     _loc24_ = I18n.getUiText("ui.payzone.limitVendor");
                     break;
                  case SubscriptionRequiredEnum.LIMITED_TO_SUBSCRIBER:
                  default:
                     _loc24_ = I18n.getUiText("ui.payzone.limit");
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc24_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(HookList.NonSubscriberPopup);
               return true;
            case param1 is SubscriptionZoneMessage:
               _loc25_ = param1 as SubscriptionZoneMessage;
               _log.error("SubscriptionZoneMessage active " + _loc25_.active);
               KernelEventsManager.getInstance().processCallback(HookList.SubscriptionZone,_loc25_.active);
               return true;
            case param1 is GuestLimitationMessage:
               _loc26_ = param1 as GuestLimitationMessage;
               _log.error("GuestLimitationMessage reason " + _loc26_.reason);
               _loc27_ = "";
               switch(_loc26_.reason)
               {
                  case GuestLimitationEnum.GUEST_LIMIT_ON_JOB_XP:
                  case GuestLimitationEnum.GUEST_LIMIT_ON_JOB_USE:
                  case GuestLimitationEnum.GUEST_LIMIT_ON_MAP:
                  case GuestLimitationEnum.GUEST_LIMIT_ON_ITEM:
                  case GuestLimitationEnum.GUEST_LIMIT_ON_VENDOR:
                  case GuestLimitationEnum.GUEST_LIMIT_ON_GUILD:
                  case GuestLimitationEnum.GUEST_LIMIT_ON_CHAT:
                     break;
               }
               _loc27_ = I18n.getUiText("ui.fight.guestAccount");
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,_loc27_,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               KernelEventsManager.getInstance().processCallback(HookList.GuestLimitationPopup);
               return true;
            case param1 is GuestModeMessage:
               _loc28_ = param1 as GuestModeMessage;
               _log.error("GuestModeMessage active " + _loc28_.active);
               KernelEventsManager.getInstance().processCallback(HookList.GuestMode,_loc28_.active);
               return true;
            case param1 is GameFightOptionStateUpdateMessage:
               _loc29_ = param1 as GameFightOptionStateUpdateMessage;
               switch(_loc29_.option)
               {
                  case FightOptionsEnum.FIGHT_OPTION_SET_SECRET:
                     KernelEventsManager.getInstance().processCallback(HookList.OptionWitnessForbidden,_loc29_.state);
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY:
                     if(Kernel.getWorker().getFrame(FightContextFrame))
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.OptionLockParty,_loc29_.state);
                     }
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_SET_CLOSED:
                     if(PlayedCharacterManager.getInstance().teamId == _loc29_.teamId)
                     {
                        KernelEventsManager.getInstance().processCallback(HookList.OptionLockFight,_loc29_.state);
                     }
                     break;
                  case FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP:
                     KernelEventsManager.getInstance().processCallback(HookList.OptionHelpWanted,_loc29_.state);
                     break;
               }
               if(Kernel.getWorker().getFrame(RoleplayEntitiesFrame))
               {
                  return false;
               }
               return true;
            case param1 is ToggleWitnessForbiddenAction:
               _loc30_ = FightOptionsEnum.FIGHT_OPTION_SET_SECRET;
               _loc31_ = new GameFightOptionToggleMessage();
               _loc31_.initGameFightOptionToggleMessage(_loc30_);
               ConnectionsHandler.getConnection().send(_loc31_);
               return true;
            case param1 is ToggleLockPartyAction:
               _loc32_ = FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY;
               _loc33_ = new GameFightOptionToggleMessage();
               _loc33_.initGameFightOptionToggleMessage(_loc32_);
               ConnectionsHandler.getConnection().send(_loc33_);
               return true;
            case param1 is ToggleLockFightAction:
               _loc34_ = FightOptionsEnum.FIGHT_OPTION_SET_CLOSED;
               _loc35_ = new GameFightOptionToggleMessage();
               _loc35_.initGameFightOptionToggleMessage(_loc34_);
               ConnectionsHandler.getConnection().send(_loc35_);
               return true;
            case param1 is ToggleHelpWantedAction:
               _loc36_ = FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP;
               _loc37_ = new GameFightOptionToggleMessage();
               _loc37_.initGameFightOptionToggleMessage(_loc36_);
               ConnectionsHandler.getConnection().send(_loc37_);
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      private function systemMessageDisplay(param1:SystemMessageDisplayMessage) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:InfoMessage = null;
         var _loc7_:uint = 0;
         var _loc2_:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1.parameters)
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
