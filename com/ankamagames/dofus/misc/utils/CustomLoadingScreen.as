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
      
      public static function recover(dataStore:DataStoreType, name:String) : CustomLoadingScreen {
         var storedCustomLoadingScreen:CustomLoadingScreen = StoreDataManager.getInstance().getData(dataStore,"loading_" + name) as CustomLoadingScreen;
         return storedCustomLoadingScreen;
      }
      
      public static function loadFromXml(xml:XML) : CustomLoadingScreen {
         var cls:CustomLoadingScreen = new CustomLoadingScreen();
         cls.name = xml.@name;
         if((!cls.name) && (xml.child("name").length() > 0))
         {
            cls.name = xml.name;
         }
         if(xml.child("img").length() > 0)
         {
            cls.backgroundUrl = xml.img;
         }
         if(xml.child("background").length() > 0)
         {
            cls.backgroundUrl = xml.background;
         }
         if(xml.child("foreground").length() > 0)
         {
            cls.foregroundUrl = xml.foreground;
         }
         if(xml.child("url").length() > 0)
         {
            cls.linkUrl = xml.url;
         }
         if(xml.child("begin").length() > 0)
         {
            cls.begin = new Date(xml.begin.@year,xml.begin.@month - 1,xml.begin.@day,xml.begin.@hour,xml.begin.@minute);
         }
         if(xml.child("end").length() > 0)
         {
            cls.end = new Date(xml.end.@year,xml.end.@month - 1,xml.end.@day,xml.end.@hour,xml.end.@minute);
         }
         if(xml.child("count").length() > 0)
         {
            cls.countMax = xml.count;
         }
         if(xml.child("screen").length() > 0)
         {
            cls.screen = xml.screen;
         }
         cls.count = 0;
         var lang:String = XmlConfig.getInstance().getEntry("config.lang.current");
         cls.lang = lang;
         return cls;
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
      
      public function store(storeAsCurrent:Boolean=false) : void {
         if(this.dataStore)
         {
            StoreDataManager.getInstance().setData(this.dataStore,"loading_" + this.name,this);
            if(storeAsCurrent)
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
         var currentDate:Date = new Date();
         if(((!this.begin) || (this.begin.time < currentDate.time)) && ((!this.end) || (this.end.time > currentDate.time)) && ((this.countMax == -1) || (this.countMax == 0) || (this.count < this.countMax)))
         {
            return true;
         }
         return false;
      }
      
      public function canBeReadOnScreen(beforeLogin:Boolean) : Boolean {
         return (this.canBeRead()) && ((this.screen == 3) || (beforeLogin) && (this.screen == 1) || (!beforeLogin) && (this.screen == 2));
      }
      
      private function onComplete(e:Event) : void {
         var urlLoader:URLLoader = e.target as URLLoader;
         urlLoader.removeEventListener(Event.COMPLETE,this.onComplete);
         switch(e.target)
         {
            case this._backgroundUrlLoader:
               this.backgroundImg = urlLoader.data;
               this.store();
               break;
            case this._foregroundUrlLoader:
               this.foregroundImg = urlLoader.data;
               this.store();
               break;
         }
      }
      
      private function onIOError(e:IOErrorEvent) : void {
         _log.error("invalid bitmap : " + e);
      }
   }
}
