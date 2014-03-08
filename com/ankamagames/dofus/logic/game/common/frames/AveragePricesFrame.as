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
   import __AS3__.vec.Vector;
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
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AveragePricesFrame));
      
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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:GameContextCreateMessage = null;
         var _loc3_:ObjectAveragePricesMessage = null;
         var _loc4_:ObjectAveragePricesErrorMessage = null;
         switch(true)
         {
            case param1 is GameContextCreateMessage:
               _loc2_ = param1 as GameContextCreateMessage;
               if(_loc2_.context == GameContextEnum.ROLE_PLAY && (this.updateAllowed()))
               {
                  this.askPricesData();
               }
               return false;
            case param1 is ObjectAveragePricesMessage:
               _loc3_ = param1 as ObjectAveragePricesMessage;
               this.updatePricesData(_loc3_.ids,_loc3_.avgPrices);
               return true;
            case param1 is ObjectAveragePricesErrorMessage:
               _loc4_ = param1 as ObjectAveragePricesErrorMessage;
               return true;
            default:
               return false;
         }
      }
      
      private function updatePricesData(param1:Vector.<uint>, param2:Vector.<uint>) : void {
         var _loc3_:int = param1.length;
         this._pricesData = 
            {
               "lastUpdate":new Date(),
               "items":{}
            };
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            this._pricesData.items["item" + param1[_loc4_]] = param2[_loc4_];
            _loc4_++;
         }
         StoreDataManager.getInstance().setData(_dataStoreType,this._serverName,this._pricesData);
      }
      
      private function updateAllowed() : Boolean {
         var _loc3_:Date = null;
         var _loc4_:String = null;
         var _loc1_:MiscFrame = Kernel.getWorker().getFrame(MiscFrame) as MiscFrame;
         var _loc2_:OptionalFeature = OptionalFeature.getOptionalFeatureByKeyword("biz.prices");
         if(!_loc1_.isOptionalFeatureActive(_loc2_.id))
         {
            return false;
         }
         if(this.dataAvailable)
         {
            _loc3_ = new Date();
            _loc4_ = TimeManager.getInstance().formatClock(this._pricesData.lastUpdate.getTime());
            if(_loc3_.getFullYear() == this._pricesData.lastUpdate.getFullYear() && _loc3_.getMonth() == this._pricesData.lastUpdate.getMonth() && _loc3_.getDate() == this._pricesData.lastUpdate.getDate())
            {
               return false;
            }
         }
         return true;
      }
      
      private function askPricesData() : void {
         var _loc1_:ObjectAveragePricesGetMessage = new ObjectAveragePricesGetMessage();
         _loc1_.initObjectAveragePricesGetMessage();
         ConnectionsHandler.getConnection().send(_loc1_);
      }
   }
}
