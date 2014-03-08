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
      
      public function set priority(p:int) : void {
         this._priority = p;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var zlmsg:ZaapListMessage = null;
         var destinationz:Array = null;
         var tdlmsg:TeleportDestinationsListMessage = null;
         var destinations:Array = null;
         var hints:Vector.<Hint> = null;
         var hint:Hint = null;
         var tra:TeleportRequestAction = null;
         var ldm:LeaveDialogMessage = null;
         var i:* = 0;
         var trmsg:TeleportRequestMessage = null;
         switch(true)
         {
            case msg is ZaapListMessage:
               zlmsg = msg as ZaapListMessage;
               destinationz = new Array();
               i = 0;
               while(i < zlmsg.mapIds.length)
               {
                  destinationz.push(new TeleportDestinationWrapper(zlmsg.teleporterType,zlmsg.mapIds[i],zlmsg.subAreaIds[i],zlmsg.destTeleporterType[i],zlmsg.costs[i],zlmsg.spawnMapId == zlmsg.mapIds[i]));
                  i++;
               }
               this._spawnMapId = zlmsg.spawnMapId;
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList,destinationz,TeleporterTypeEnum.TELEPORTER_ZAAP);
               return true;
            case msg is TeleportDestinationsListMessage:
               tdlmsg = msg as TeleportDestinationsListMessage;
               destinations = new Array();
               i = 0;
               while(i < tdlmsg.mapIds.length)
               {
                  if(tdlmsg.teleporterType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
                  {
                     hints = TeleportDestinationWrapper.getHintsFromMapId(tdlmsg.mapIds[i]);
                     for each (hint in hints)
                     {
                        destinations.push(new TeleportDestinationWrapper(tdlmsg.teleporterType,tdlmsg.mapIds[i],tdlmsg.subAreaIds[i],TeleporterTypeEnum.TELEPORTER_SUBWAY,tdlmsg.costs[i],false,hint));
                     }
                  }
                  else
                  {
                     destinations.push(new TeleportDestinationWrapper(tdlmsg.teleporterType,tdlmsg.mapIds[i],tdlmsg.subAreaIds[i],tdlmsg.destTeleporterType[i],tdlmsg.costs[i]));
                  }
                  i++;
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.TeleportDestinationList,destinations,tdlmsg.teleporterType);
               return true;
            case msg is TeleportRequestAction:
               tra = msg as TeleportRequestAction;
               if(tra.cost <= PlayedCharacterManager.getInstance().characteristics.kamas)
               {
                  trmsg = new TeleportRequestMessage();
                  trmsg.initTeleportRequestMessage(tra.teleportType,tra.mapId);
                  ConnectionsHandler.getConnection().send(trmsg);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.popup.not_enough_rich"),ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is LeaveDialogMessage:
               ldm = msg as LeaveDialogMessage;
               if(ldm.dialogType == DialogTypeEnum.DIALOG_TELEPORTER)
               {
                  Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
