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
            cacheDate = StoreDataManager.getInstance().getSetData(this._ds,"cacheDate",new Date(2000));
            currentDate = new Date();
            if((!(cacheDate.day == currentDate.day)) || (currentDate.time - cacheDate.time > 120000))
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
      
      private function setDefaultData(pAlmanaxElement:Object) : void {
         if(pAlmanaxElement is AlmanaxEvent)
         {
            if(!pAlmanaxElement.bossText)
            {
               pAlmanaxElement.bossText = "ui.almanax.default.boss";
            }
            if(!pAlmanaxElement.ephemeris)
            {
               pAlmanaxElement.ephemeris = "ui.almanax.default.ephemeris";
            }
            pAlmanaxElement.festText = "";
            pAlmanaxElement.name = "";
            pAlmanaxElement.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/jour.jpg");
         }
         else
         {
            if(pAlmanaxElement is AlmanaxMonth)
            {
               if(!pAlmanaxElement.protectorDescription)
               {
                  pAlmanaxElement.protectorDescription = "ui.almanax.default.protector";
               }
               pAlmanaxElement.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/protecteur.jpg");
            }
            else
            {
               if(pAlmanaxElement is AlmanaxZodiac)
               {
                  pAlmanaxElement.webImageUrl = XmlConfig.getInstance().getEntry("config.gfx.path").concat("almanax/constellation.jpg");
                  if(!pAlmanaxElement.description)
                  {
                     pAlmanaxElement.description = "ui.almanax.default.zodiac";
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
      
      private function isValidImageUrl(pUrl:String) : Boolean {
         return (pUrl) && (!(pUrl == "false"));
      }
      
      private function onData(e:Event) : void {
         var eventRawData:Object = this._rpcService.getResultData("event");
         var monthRawData:Object = this._rpcService.getResultData("month");
         var zodiacRawData:Object = this._rpcService.getResultData("zodiac");
         this._currentEvent = new AlmanaxEvent();
         this.event.bossText = eventRawData.bosstext;
         this.event.ephemeris = eventRawData.ephemeris;
         this.event.festText = eventRawData.festtext;
         this.event.id = eventRawData.id;
         this.event.name = eventRawData.name;
         this.event.rubrikabrax = eventRawData.rubrikabrax;
         this.event.webImageUrl = eventRawData.imageurl;
         this._currentMonth = new AlmanaxMonth();
         this.month.id = monthRawData.id;
         this.month.monthNum = monthRawData.month;
         this.month.protectorDescription = monthRawData.protectordesc;
         this.month.protectorName = monthRawData.protectorname;
         this.month.webImageUrl = monthRawData.protectorimageurl;
         this._currentZodiac = new AlmanaxZodiac();
         this.zodiac.id = zodiacRawData.id;
         this.zodiac.name = zodiacRawData.name;
         this.zodiac.webImageUrl = zodiacRawData.imageurl;
         this.zodiac.description = zodiacRawData.description;
         this.checkData();
         StoreDataManager.getInstance().setData(this._ds,"currentEvent",this._currentEvent);
         StoreDataManager.getInstance().setData(this._ds,"currentMonth",this._currentMonth);
         StoreDataManager.getInstance().setData(this._ds,"currentZodiac",this._currentZodiac);
         StoreDataManager.getInstance().setData(this._ds,"cacheDate",new Date());
      }
      
      private function onError(e:Event) : void {
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
