package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.ByteArray;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   
   public class CustomLoadingScreen extends Object
   {
      
      public function CustomLoadingScreen() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomLoadingScreen));
      
      public static function recover(param1:DataStoreType, param2:String) : CustomLoadingScreen {
         var _loc3_:CustomLoadingScreen = StoreDataManager.getInstance().getData(param1,"loading_" + param2) as CustomLoadingScreen;
         return _loc3_;
      }
      
      public static function loadFromXml(param1:XML) : CustomLoadingScreen {
         var _loc2_:CustomLoadingScreen = new CustomLoadingScreen();
         _loc2_.name = param1.@name;
         if(!_loc2_.name && param1.child("name").length() > 0)
         {
            _loc2_.name = param1.name;
         }
         if(param1.child("img").length() > 0)
         {
            _loc2_.backgroundUrl = param1.img;
         }
         if(param1.child("background").length() > 0)
         {
            _loc2_.backgroundUrl = param1.background;
         }
         if(param1.child("foreground").length() > 0)
         {
            _loc2_.foregroundUrl = param1.foreground;
         }
         if(param1.child("url").length() > 0)
         {
            _loc2_.linkUrl = param1.url;
         }
         if(param1.child("begin").length() > 0)
         {
            _loc2_.begin = new Date(param1.begin.@year,param1.begin.@month-1,param1.begin.@day,param1.begin.@hour,param1.begin.@minute);
         }
         if(param1.child("end").length() > 0)
         {
            _loc2_.end = new Date(param1.end.@year,param1.end.@month-1,param1.end.@day,param1.end.@hour,param1.end.@minute);
         }
         if(param1.child("count").length() > 0)
         {
            _loc2_.countMax = param1.count;
         }
         if(param1.child("screen").length() > 0)
         {
            _loc2_.screen = param1.screen;
         }
         _loc2_.count = 0;
         var _loc3_:String = XmlConfig.getInstance().getEntry("config.lang.current");
         _loc2_.lang = _loc3_;
         return _loc2_;
      }
      
      public var name:String;
      
      public var backgroundImg:ByteArray;
      
      public var foregroundImg:ByteArray;
      
      public var backgroundUrl:String;
      
      public var foregroundUrl:String;
      
      public var linkUrl:String;
      
      public var begin:Date;
      
      public var end:Date;
      
      public var countMax:int = 0;
      
      public var count:int;
      
      public var screen:int = 1;
      
      public var lang:String;
      
      private var _backgroundUrlLoader:URLLoader;
      
      private var _foregroundUrlLoader:URLLoader;
      
      public var dataStore:DataStoreType;
      
      public function loadData() : void {
         if(this.backgroundUrl)
         {
            this._backgroundUrlLoader = new URLLoader();
            this._backgroundUrlLoader.addEventListener(Event.COMPLETE,this.onComplete);
            this._backgroundUrlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._backgroundUrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            _log.info("load custom background : " + this.backgroundUrl);
            this._backgroundUrlLoader.load(new URLRequest(this.backgroundUrl));
         }
         if(this.foregroundUrl)
         {
            this._foregroundUrlLoader = new URLLoader();
            this._foregroundUrlLoader.addEventListener(Event.COMPLETE,this.onComplete);
            this._foregroundUrlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this._foregroundUrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            _log.info("load custom foreground : " + this.foregroundUrl);
            this._foregroundUrlLoader.load(new URLRequest(this.foregroundUrl));
         }
      }
      
      public function store(param1:Boolean=false) : void {
         if(this.dataStore)
         {
            StoreDataManager.getInstance().setData(this.dataStore,"loading_" + this.name,this);
            if(param1)
            {
               StoreDataManager.getInstance().setData(this.dataStore,"currentLoadingScreen",this.name);
            }
         }
         else
         {
            _log.error("Can\'t store loading screen without dataStore");
         }
      }
      
      public function isViewing() : void {
         if(this.count < this.countMax)
         {
            this.count++;
            this.store();
         }
      }
      
      public function canBeRead() : Boolean {
         var _loc1_:Date = new Date();
         if((!this.begin || this.begin.time < _loc1_.time) && (!this.end || this.end.time > _loc1_.time) && (this.countMax == -1 || this.countMax == 0 || this.count < this.countMax))
         {
            return true;
         }
         return false;
      }
      
      public function canBeReadOnScreen(param1:Boolean) : Boolean {
         return (this.canBeRead()) && (this.screen == 3 || (param1) && this.screen == 1 || !param1 && this.screen == 2);
      }
      
      private function onComplete(param1:Event) : void {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.onComplete);
         switch(param1.target)
         {
            case this._backgroundUrlLoader:
               this.backgroundImg = _loc2_.data;
               this.store();
               break;
            case this._foregroundUrlLoader:
               this.foregroundImg = _loc2_.data;
               this.store();
               break;
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
         _log.error("invalid bitmap : " + param1);
      }
   }
}
