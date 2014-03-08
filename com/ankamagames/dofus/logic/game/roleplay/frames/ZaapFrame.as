package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.ZaapListMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportDestinationsListMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.logic.game.roleplay.actions.TeleportRequestAction;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.zaap.TeleportRequestMessage;
   import com.ankamagames.dofus.internalDatacenter.taxi.TeleportDestinationWrapper;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.TeleporterTypeEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class ZaapFrame extends Object implements Frame
   {
      
      public function ZaapFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));
      
      private var _priority:int = 0;
      
      private var _spawnMapId:uint;
      
      public function get spawnMapId() : uint {
         return this._spawnMapId;
      }
      
      public function get priority() : int {
         return this._priority;
      }
      
      public function set priority(param1:int) : void {
         this._priority = param1;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:ZaapListMessage = null;
         var _loc3_:Array = null;
         var _loc4_:TeleportDestinationsListMessage = null;
         var _loc5_:Array = null;
         var _loc6_:Vector.<Hint> = null;
         var _loc7_:Hint = null;
         var _loc8_:TeleportRequestAction = null;
         var _loc9_:LeaveDialogMessage = null;
         var _loc10_:* = 0;
         var _loc11_:TeleportRequestMessage = null;
         switch(true)
         {
            case param1 is ZaapListMessage:
               _loc2_ = param1 as ZaapListMessage;
               _loc3_ = new Array();
               _loc10_ = 0;
               while(_loc10_ < _loc2_.mapIds.length)
               {
                  _loc3_.push(new TeleportDestinationWrapper(_loc2_.teleporterType,_loc2_.mapIds[_loc10_],_loc2_.subAreaIds[_loc10_],_loc2_.destTeleporterType[_loc10_],_loc2_.costs[_loc10_],_loc2_.spawnMapId == _loc2_.mapIds[_loc10_]));
                  _loc10_++;
               }
               this._spawnMapId = _loc2_.spawnMapId;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList,_loc3_,TeleporterTypeEnum.TELEPORTER_ZAAP);
               return true;
            case param1 is TeleportDestinationsListMessage:
               _loc4_ = param1 as TeleportDestinationsListMessage;
               _loc5_ = new Array();
               _loc10_ = 0;
               while(_loc10_ < _loc4_.mapIds.length)
               {
                  if(_loc4_.teleporterType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
                  {
                     _loc6_ = TeleportDestinationWrapper.getHintsFromMapId(_loc4_.mapIds[_loc10_]);
                     for each (_loc7_ in _loc6_)
                     {
                        _loc5_.push(new TeleportDestinationWrapper(_loc4_.teleporterType,_loc4_.mapIds[_loc10_],_loc4_.subAreaIds[_loc10_],TeleporterTypeEnum.TELEPORTER_SUBWAY,_loc4_.costs[_loc10_],false,_loc7_));
                     }
                  }
                  else
                  {
                     _loc5_.push(new TeleportDestinationWrapper(_loc4_.teleporterType,_loc4_.mapIds[_loc10_],_loc4_.subAreaIds[_loc10_],_loc4_.destTeleporterType[_loc10_],_loc4_.costs[_loc10_]));
                  }
                  _loc10_++;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList,_loc5_,_loc4_.teleporterType);
               return true;
            case param1 is TeleportRequestAction:
               _loc8_ = param1 as TeleportRequestAction;
               if(_loc8_.cost <= PlayedCharacterManager.getInstance().characteristics.kamas)
               {
                  _loc11_ = new TeleportRequestMessage();
                  _loc11_.initTeleportRequestMessage(_loc8_.teleportType,_loc8_.mapId);
                  ConnectionsHandler.getConnection().send(_loc11_);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.popup.not_enough_rich"),ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case param1 is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case param1 is LeaveDialogMessage:
               _loc9_ = param1 as LeaveDialogMessage;
               if(_loc9_.dialogType == DialogTypeEnum.DIALOG_TELEPORTER)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
