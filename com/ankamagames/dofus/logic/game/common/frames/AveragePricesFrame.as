package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.GameContextCreateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.ObjectAveragePricesMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.ObjectAveragePricesErrorMessage;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.frames.MiscFrame;
   import com.ankamagames.dofus.datacenter.misc.OptionalFeature;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.network.messages.game.inventory.ObjectAveragePricesGetMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class AveragePricesFrame extends Object implements Frame
   {
      
      public function AveragePricesFrame() {
         super();
         this._serverName = PlayerManager.getInstance().server.name;
         if(!_dataStoreType)
         {
            _dataStoreType = new DataStoreType("averagePrices",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         }
      }
      
      protected static const _log:Logger;
      
      private static var _dataStoreType:DataStoreType;
      
      private var _serverName:String;
      
      private var _pricesData:Object;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function get dataAvailable() : Boolean {
         return this._pricesData;
      }
      
      public function get pricesData() : Object {
         return this._pricesData;
      }
      
      public function pushed() : Boolean {
         this._pricesData = StoreDataManager.getInstance().getData(_dataStoreType,this._serverName);
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      public function process(pMsg:Message) : Boolean {
         var gccm:GameContextCreateMessage = null;
         var oapm:ObjectAveragePricesMessage = null;
         var oapem:ObjectAveragePricesErrorMessage = null;
         switch(true)
         {
            case pMsg is GameContextCreateMessage:
               gccm = pMsg as GameContextCreateMessage;
               if((gccm.context == GameContextEnum.ROLE_PLAY) && (this.updateAllowed()))
               {
                  this.askPricesData();
               }
               return false;
            case pMsg is ObjectAveragePricesMessage:
               oapm = pMsg as ObjectAveragePricesMessage;
               this.updatePricesData(oapm.ids,oapm.avgPrices);
               return true;
            case pMsg is ObjectAveragePricesErrorMessage:
               oapem = pMsg as ObjectAveragePricesErrorMessage;
               return true;
            default:
               return false;
         }
      }
      
      private function updatePricesData(pItemsIds:Vector.<uint>, pItemsAvgPrices:Vector.<uint>) : void {
         var nbItems:int = pItemsIds.length;
         this._pricesData = 
            {
               "lastUpdate":new Date(),
               "items":{}
            };
         var i:int = 0;
         while(i < nbItems)
         {
            this._pricesData.items["item" + pItemsIds[i]] = pItemsAvgPrices[i];
            i++;
         }
         StoreDataManager.getInstance().setData(_dataStoreType,this._serverName,this._pricesData);
      }
      
      private function updateAllowed() : Boolean {
         var now:Date = null;
         var lastUpdateHour:String = null;
         var misc:MiscFrame = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
         var feature:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword("biz.prices");
         if(!misc.isOptionalFeatureActive(feature.id))
         {
            return false;
         }
         if(this.dataAvailable)
         {
            now = new Date();
            lastUpdateHour = TimeManager.getInstance().formatClock(this._pricesData.lastUpdate.getTime());
            if((now.getFullYear() == this._pricesData.lastUpdate.getFullYear()) && (now.getMonth() == this._pricesData.lastUpdate.getMonth()) && (now.getDate() == this._pricesData.lastUpdate.getDate()))
            {
               return false;
            }
         }
         return true;
      }
      
      private function askPricesData() : void {
         var oapgm:ObjectAveragePricesGetMessage = new ObjectAveragePricesGetMessage();
         oapgm.initObjectAveragePricesGetMessage();
         ConnectionsHandler.getConnection().send(oapgm);
      }
   }
}
