package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DataStoreType;
   import flash.net.URLRequest;
   import flash.net.URLLoader;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.BuildInfos;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class StatisticReportingManager extends Object
   {
      
      public function StatisticReportingManager() {
         this._log = Log.getLogger(getQualifiedClassName(StatisticReportingManager));
         this._dt = new DataStoreType("StatisticReportingManager",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static var _self:StatisticReportingManager;
      
      private static var WEB_SERVICE:String = "http://www.ankama.com/stats/dofus";
      
      public static function getInstance() : StatisticReportingManager {
         if(!_self)
         {
            _self = new StatisticReportingManager();
         }
         return _self;
      }
      
      protected var _log:Logger;
      
      private var _dt:DataStoreType;
      
      public function report(param1:String, param2:String) : Boolean {
         var _loc3_:String = null;
         var _loc4_:URLRequest = null;
         var _loc5_:URLLoader = null;
         if(!param1)
         {
            return false;
         }
         try
         {
            _loc3_ = StoreDataManager.getInstance().getData(this._dt,param1);
            if((_loc3_) && _loc3_ == param2)
            {
               return false;
            }
            _loc4_ = new URLRequest(WEB_SERVICE);
            _loc4_.method = URLRequestMethod.POST;
            _loc4_.data = new URLVariables();
            _loc4_.data.guid = MD5.hash(PlayerManager.getInstance().nickname);
            _loc4_.data.version = BuildInfos.BUILD_TYPE;
            _loc4_.data.key = param1;
            _loc4_.data.value = param2;
            _loc5_ = new URLLoader();
            _loc5_.addEventListener(Event.COMPLETE,this.onSended);
            _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.onSendError);
            _loc5_.load(_loc4_);
            StoreDataManager.getInstance().setData(this._dt,param1,param2);
            return true;
         }
         catch(e:Error)
         {
         }
         return false;
         if((_loc3_) && _loc3_ == param2)
         {
            return false;
         }
         _loc4_ = new URLRequest(WEB_SERVICE);
         _loc4_.method = URLRequestMethod.POST;
         _loc4_.data = new URLVariables();
         _loc4_.data.guid = MD5.hash(PlayerManager.getInstance().nickname);
         _loc4_.data.version = BuildInfos.BUILD_TYPE;
         _loc4_.data.key = param1;
         _loc4_.data.value = param2;
         _loc5_ = new URLLoader();
         _loc5_.addEventListener(Event.COMPLETE,this.onSended);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.onSendError);
         _loc5_.load(_loc4_);
         StoreDataManager.getInstance().setData(this._dt,param1,param2);
         return true;
      }
      
      public function isReported(param1:String) : Boolean {
         var _loc2_:String = StoreDataManager.getInstance().getData(this._dt,param1);
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      private function onSended(param1:Event) : void {
      }
      
      private function onSendError(param1:Event) : void {
      }
   }
}
