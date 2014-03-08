package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.misc.utils.RpcServiceManager;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxEvent;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxMonth;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxZodiac;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.events.Event;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.types.events.RpcEvent;
   import com.ankamagames.jerakine.managers.LangManager;
   
   public class AlmanaxManager extends Object
   {
      
      public function AlmanaxManager() {
         this._ds = new DataStoreType("AlmanaxCache",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_COMPUTER);
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            _loc1_ = StoreDataManager.getInstance().getSetData(this._ds,"cacheDate",new Date(2000));
            _loc2_ = new Date();
            if(!(_loc1_.day == _loc2_.day) || _loc2_.time - _loc1_.time > 120000)
            {
               if(BuildInfos.BUILD_TYPE >= BuildTypeEnum.INTERNAL)
               {
                  this._rpcService = new RpcServiceManager("http://api.ankama.lan/krosmoz/event.json","json");
               }
               else
               {
                  this._rpcService = new RpcServiceManager("http://api.ankama.com/krosmoz/event.json","json");
               }
               this._rpcService.addEventListener(Event.COMPLETE,this.onData);
               this._rpcService.addEventListener(RpcEvent.EVENT_ERROR,this.onError);
               this._rpcService.callMethod("GetEvent",[LangManager.getInstance().getEntry("config.lang.current")]);
            }
            else
            {
               StoreDataManager.getInstance().registerClass(new AlmanaxEvent());
               this._currentEvent = StoreDataManager.getInstance().getData(this._ds,"currentEvent");
               this._currentMonth = StoreDataManager.getInstance().getData(this._ds,"currentMonth");
               this._currentZodiac = StoreDataManager.getInstance().getData(this._ds,"currentZodiac");
               this.checkData();
            }
            return;
         }
      }
      
      private static var _self:AlmanaxManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlmanaxManager));
      
      public static function getInstance() : AlmanaxManager {
         if(!_self)
         {
            _self = new AlmanaxManager();
         }
         return _self;
      }
      
      private var _rpcService:RpcServiceManager;
      
      private var _currentEvent:AlmanaxEvent;
      
      private var _currentMonth:AlmanaxMonth;
      
      private var _currentZodiac:AlmanaxZodiac;
      
      private var _ds:DataStoreType;
      
      public function get event() : AlmanaxEvent {
         return this._currentEvent;
      }
      
      public function get month() : AlmanaxMonth {
         return this._currentMonth;
      }
      
      public function get zodiac() : AlmanaxZodiac {
         return this._currentZodiac;
      }
      
      private function setDefaultData(param1:Object) : void {
         if(param1 is AlmanaxEvent)
         {
            if(!param1.bossText)
            {
               param1.bossText = "ui.almanax.default.boss";
            }
            if(!param1.ephemeris)
            {
               param1.ephemeris = "ui.almanax.default.ephemeris";
            }
            param1.festText = "";
            param1.name = "";
            param1.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/jour.jpg");
         }
         else
         {
            if(param1 is AlmanaxMonth)
            {
               if(!param1.protectorDescription)
               {
                  param1.protectorDescription = "ui.almanax.default.protector";
               }
               param1.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/protecteur.jpg");
            }
            else
            {
               if(param1 is AlmanaxZodiac)
               {
                  param1.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/constellation.jpg");
                  if(!param1.description)
                  {
                     param1.description = "ui.almanax.default.zodiac";
                  }
               }
            }
         }
      }
      
      private function checkData() : void {
         if(!this.isValidImageUrl(this._currentEvent.webImageUrl))
         {
            this.setDefaultData(this._currentEvent);
         }
         if(!this.isValidImageUrl(this._currentMonth.webImageUrl))
         {
            this.setDefaultData(this._currentMonth);
         }
         if(!this.isValidImageUrl(this._currentZodiac.webImageUrl))
         {
            this.setDefaultData(this._currentZodiac);
         }
      }
      
      private function isValidImageUrl(param1:String) : Boolean {
         return (param1) && !(param1 == "false");
      }
      
      private function onData(param1:Event) : void {
         var _loc2_:Object = this._rpcService.getResultData("event");
         var _loc3_:Object = this._rpcService.getResultData("month");
         var _loc4_:Object = this._rpcService.getResultData("zodiac");
         this._currentEvent = new AlmanaxEvent();
         this.event.bossText = _loc2_.bosstext;
         this.event.ephemeris = _loc2_.ephemeris;
         this.event.festText = _loc2_.festtext;
         this.event.id = _loc2_.id;
         this.event.name = _loc2_.name;
         this.event.rubrikabrax = _loc2_.rubrikabrax;
         this.event.webImageUrl = _loc2_.imageurl;
         this._currentMonth = new AlmanaxMonth();
         this.month.id = _loc3_.id;
         this.month.monthNum = _loc3_.month;
         this.month.protectorDescription = _loc3_.protectordesc;
         this.month.protectorName = _loc3_.protectorname;
         this.month.webImageUrl = _loc3_.protectorimageurl;
         this._currentZodiac = new AlmanaxZodiac();
         this.zodiac.id = _loc4_.id;
         this.zodiac.name = _loc4_.name;
         this.zodiac.webImageUrl = _loc4_.imageurl;
         this.zodiac.description = _loc4_.description;
         this.checkData();
         StoreDataManager.getInstance().setData(this._ds,"currentEvent",this._currentEvent);
         StoreDataManager.getInstance().setData(this._ds,"currentMonth",this._currentMonth);
         StoreDataManager.getInstance().setData(this._ds,"currentZodiac",this._currentZodiac);
         StoreDataManager.getInstance().setData(this._ds,"cacheDate",new Date());
      }
      
      private function onError(param1:Event) : void {
         this._currentEvent = new AlmanaxEvent();
         this.setDefaultData(this._currentEvent);
         this._currentMonth = new AlmanaxMonth();
         this.setDefaultData(this._currentMonth);
         this._currentZodiac = new AlmanaxZodiac();
         this.setDefaultData(this._currentZodiac);
         StoreDataManager.getInstance().setData(this._ds,"currentEvent",this._currentEvent);
         StoreDataManager.getInstance().setData(this._ds,"currentMonth",this._currentMonth);
         StoreDataManager.getInstance().setData(this._ds,"currentZodiac",this._currentZodiac);
         StoreDataManager.getInstance().setData(this._ds,"cacheDate",new Date());
      }
   }
}
