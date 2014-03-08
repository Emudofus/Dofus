package com.ankamagames.dofus.console.debug.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.updater.parts.PartsListMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.PartInfoMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadCurrentSpeedMessage;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   import com.ankamagames.dofus.network.messages.updater.parts.GetPartsListMessage;
   import com.ankamagames.dofus.kernel.updater.UpdaterConnexionHandler;
   import com.ankamagames.dofus.network.messages.updater.parts.GetPartInfoMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadSetSpeedRequestMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadGetCurrentSpeedRequestMessage;
   import com.ankamagames.dofus.network.messages.updater.parts.DownloadPartMessage;
   
   public class UpdaterDebugFrame extends Object implements Frame
   {
      
      public function UpdaterDebugFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UpdaterDebugFrame));
      
      private var _partInfoCallback:Function;
      
      private var _updaterSpeedCallback:Function;
      
      public function get priority() : int {
         return Priority.LOW;
      }
      
      public function pushed() : Boolean {
         this._partInfoCallback = null;
         this._updaterSpeedCallback = null;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:PartsListMessage = null;
         var _loc3_:PartInfoMessage = null;
         var _loc4_:DownloadCurrentSpeedMessage = null;
         var _loc5_:ContentPart = null;
         switch(true)
         {
            case param1 is PartsListMessage:
               _loc2_ = param1 as PartsListMessage;
               if(this._partInfoCallback != null)
               {
                  for each (_loc5_ in _loc2_.parts)
                  {
                     this._partInfoCallback(_loc5_);
                  }
                  this._partInfoCallback = null;
               }
               return false;
            case param1 is PartInfoMessage:
               _loc3_ = param1 as PartInfoMessage;
               if(this._partInfoCallback != null)
               {
                  this._partInfoCallback(_loc3_.part);
                  this._partInfoCallback = null;
               }
               return false;
            case param1 is DownloadCurrentSpeedMessage:
               _loc4_ = param1 as DownloadCurrentSpeedMessage;
               if(this._updaterSpeedCallback != null)
               {
                  this._updaterSpeedCallback(_loc4_.downloadSpeed);
                  this._updaterSpeedCallback = null;
               }
               return false;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function partListRequest(param1:Function) : void {
         _log.info("Send part list request");
         this._partInfoCallback = param1;
         var _loc2_:GetPartsListMessage = new GetPartsListMessage();
         _loc2_.initGetPartsListMessage();
         UpdaterConnexionHandler.getConnection().send(_loc2_);
      }
      
      public function partInfoRequest(param1:String, param2:Function) : void {
         _log.info("Send part info request");
         this._partInfoCallback = param2;
         var _loc3_:GetPartInfoMessage = new GetPartInfoMessage();
         _loc3_.initGetPartInfoMessage(param1);
         UpdaterConnexionHandler.getConnection().send(_loc3_);
      }
      
      public function setUpdaterSpeedRequest(param1:int, param2:Function) : void {
         _log.info("Send updater speed request");
         this._updaterSpeedCallback = param2;
         var _loc3_:DownloadSetSpeedRequestMessage = new DownloadSetSpeedRequestMessage();
         _loc3_.initDownloadSetSpeedRequestMessage(param1);
         UpdaterConnexionHandler.getConnection().send(_loc3_);
      }
      
      public function getUpdaterSpeedRequest(param1:Function) : void {
         _log.info("Send updater speed request");
         this._updaterSpeedCallback = param1;
         var _loc2_:DownloadGetCurrentSpeedRequestMessage = new DownloadGetCurrentSpeedRequestMessage();
         _loc2_.initDownloadGetCurrentSpeedRequestMessage();
         UpdaterConnexionHandler.getConnection().send(_loc2_);
      }
      
      public function downloadPartRequest(param1:String, param2:Function) : void {
         _log.info("Send download part request");
         this._partInfoCallback = param2;
         var _loc3_:DownloadPartMessage = new DownloadPartMessage();
         _loc3_.initDownloadPartMessage(param1);
         UpdaterConnexionHandler.getConnection().send(_loc3_);
      }
   }
}
