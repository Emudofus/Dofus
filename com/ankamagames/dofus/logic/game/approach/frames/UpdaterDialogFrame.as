package com.ankamagames.dofus.logic.game.approach.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.approach.actions.GetPartsListAction;
   import com.ankamagames.dofus.network.messages.updater.parts.GetPartsListMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.PartsListMessage;
   import com.ankamagames.dofus.logic.game.approach.actions.DownloadPartAction;
   import com.ankamagames.dofus.logic.game.approach.actions.GetPartInfoAction;
   import com.ankamagames.dofus.network.messages.updater.parts.GetPartInfoMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.PartInfoMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadCurrentSpeedMessage;
   import com.ankamagames.dofus.network.messages.game.packs.PackRestrictedSubAreaMessage;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.misc.Pack;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadErrorMessage;
   import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
   import com.ankamagames.dofus.logic.game.approach.managers.PartManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.common.managers.InactivityManager;
   import com.ankamagames.dofus.logic.game.approach.utils.DownloadMonitoring;
   
   public class UpdaterDialogFrame extends Object implements Frame
   {
      
      public function UpdaterDialogFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterDialogFrame));
      
      public function get priority() : int {
         return Priority.LOWEST;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GetPartsListAction = null;
         var _loc3_:GetPartsListMessage = null;
         var _loc4_:PartsListMessage = null;
         var _loc5_:DownloadPartAction = null;
         var _loc6_:GetPartInfoAction = null;
         var _loc7_:GetPartInfoMessage = null;
         var _loc8_:PartInfoMessage = null;
         var _loc9_:* = 0;
         var _loc10_:DownloadCurrentSpeedMessage = null;
         var _loc11_:PackRestrictedSubAreaMessage = null;
         var _loc12_:SubArea = null;
         var _loc13_:Pack = null;
         var _loc14_:DownloadErrorMessage = null;
         switch(true)
         {
            case param1 is GetPartsListAction:
               _loc2_ = param1 as GetPartsListAction;
               _loc3_ = new GetPartsListMessage();
               _loc3_.initGetPartsListMessage();
               UpdaterConnexionHandler.getConnection().send(_loc3_);
               return true;
            case param1 is PartsListMessage:
               _loc4_ = param1 as PartsListMessage;
               PartManager.getInstance().receiveParts(_loc4_.parts);
               KernelEventsManager.getInstance().processCallback(HookList.PartsList,_loc4_.parts);
               return true;
            case param1 is DownloadPartAction:
               _loc5_ = param1 as DownloadPartAction;
               PartManager.getInstance().checkAndDownload(_loc5_.id);
               return true;
            case param1 is GetPartInfoAction:
               _loc6_ = param1 as GetPartInfoAction;
               _loc7_ = new GetPartInfoMessage();
               _loc7_.initGetPartInfoMessage(_loc6_.id);
               UpdaterConnexionHandler.getConnection().send(_loc7_);
               return true;
            case param1 is PartInfoMessage:
               _loc8_ = param1 as PartInfoMessage;
               InactivityManager.getInstance().activity();
               PartManager.getInstance().updatePart(_loc8_.part);
               _loc9_ = PartManager.getInstance().getDownloadPercent(_loc8_.installationPercent);
               KernelEventsManager.getInstance().processCallback(HookList.PartInfo,_loc8_.part,_loc9_);
               return true;
            case param1 is DownloadCurrentSpeedMessage:
               _loc10_ = param1 as DownloadCurrentSpeedMessage;
               DownloadMonitoring.getInstance().downloadSpeed = _loc10_.downloadSpeed;
               KernelEventsManager.getInstance().processCallback(HookList.DownloadSpeed,_loc10_.downloadSpeed);
               return true;
            case param1 is PackRestrictedSubAreaMessage:
               _loc11_ = param1 as PackRestrictedSubAreaMessage;
               _loc12_ = SubArea.getSubAreaById(_loc11_.subAreaId);
               _loc13_ = Pack.getPackById(_loc12_.packId);
               if(_loc13_.name == "subscribed")
               {
                  PartManager.getInstance().checkAndDownload("all");
               }
               PartManager.getInstance().checkAndDownload(_loc13_.name);
               KernelEventsManager.getInstance().processCallback(HookList.PackRestrictedSubArea,_loc11_.subAreaId);
               return true;
            case param1 is DownloadErrorMessage:
               _loc14_ = param1 as DownloadErrorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.DownloadError,_loc14_.errorId,_loc14_.message.length > 0?_loc14_.message:null,_loc14_.helpUrl.length > 0?_loc14_.helpUrl:null);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
