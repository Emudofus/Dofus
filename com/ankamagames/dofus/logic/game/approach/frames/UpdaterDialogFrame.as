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
      
      public function process(msg:Message) : Boolean {
         var gpla:GetPartsListAction = null;
         var gplmsg:GetPartsListMessage = null;
         var plmsg:PartsListMessage = null;
         var dpa:DownloadPartAction = null;
         var gpia:GetPartInfoAction = null;
         var gpimsg:GetPartInfoMessage = null;
         var pimsg:PartInfoMessage = null;
         var percent:* = 0;
         var dcsmsg:DownloadCurrentSpeedMessage = null;
         var prsamsg:PackRestrictedSubAreaMessage = null;
         var subArea:SubArea = null;
         var pack:Pack = null;
         var demsg:DownloadErrorMessage = null;
         switch(true)
         {
            case msg is GetPartsListAction:
               gpla = msg as GetPartsListAction;
               gplmsg = new GetPartsListMessage();
               gplmsg.initGetPartsListMessage();
               UpdaterConnexionHandler.getConnection().send(gplmsg);
               return true;
            case msg is PartsListMessage:
               plmsg = msg as PartsListMessage;
               PartManager.getInstance().receiveParts(plmsg.parts);
               KernelEventsManager.getInstance().processCallback(HookList.PartsList,plmsg.parts);
               return true;
            case msg is DownloadPartAction:
               dpa = msg as DownloadPartAction;
               PartManager.getInstance().checkAndDownload(dpa.id);
               return true;
            case msg is GetPartInfoAction:
               gpia = msg as GetPartInfoAction;
               gpimsg = new GetPartInfoMessage();
               gpimsg.initGetPartInfoMessage(gpia.id);
               UpdaterConnexionHandler.getConnection().send(gpimsg);
               return true;
            case msg is PartInfoMessage:
               pimsg = msg as PartInfoMessage;
               InactivityManager.getInstance().activity();
               PartManager.getInstance().updatePart(pimsg.part);
               percent = PartManager.getInstance().getDownloadPercent(pimsg.installationPercent);
               KernelEventsManager.getInstance().processCallback(HookList.PartInfo,pimsg.part,percent);
               return true;
            case msg is DownloadCurrentSpeedMessage:
               dcsmsg = msg as DownloadCurrentSpeedMessage;
               DownloadMonitoring.getInstance().downloadSpeed = dcsmsg.downloadSpeed;
               KernelEventsManager.getInstance().processCallback(HookList.DownloadSpeed,dcsmsg.downloadSpeed);
               return true;
            case msg is PackRestrictedSubAreaMessage:
               prsamsg = msg as PackRestrictedSubAreaMessage;
               subArea = SubArea.getSubAreaById(prsamsg.subAreaId);
               pack = Pack.getPackById(subArea.packId);
               if(pack.name == "subscribed")
               {
                  PartManager.getInstance().checkAndDownload("all");
               }
               PartManager.getInstance().checkAndDownload(pack.name);
               KernelEventsManager.getInstance().processCallback(HookList.PackRestrictedSubArea,prsamsg.subAreaId);
               return true;
            case msg is DownloadErrorMessage:
               demsg = msg as DownloadErrorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.DownloadError,demsg.errorId,demsg.message.length > 0?demsg.message:null,demsg.helpUrl.length > 0?demsg.helpUrl:null);
               return true;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
   }
}
