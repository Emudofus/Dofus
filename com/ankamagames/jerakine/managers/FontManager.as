package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.jerakine.utils.errors.FileTypeError;
   import com.ankamagames.jerakine.types.Uri;
   import flash.text.AntiAliasType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.messages.LangFileLoadedMessage;
   import com.ankamagames.jerakine.messages.LangAllFilesLoadedMessage;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class FontManager extends Object
   {
      
      public function FontManager() {
         this._log = Log.getLogger(getQualifiedClassName(FontManager));
         super();
         if(_self != null)
         {
            throw new SingletonError("FontManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onFileLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
            return;
         }
      }
      
      private static var _self:FontManager;
      
      public static var initialized:Boolean = false;
      
      public static function getInstance() : FontManager {
         if(_self == null)
         {
            _self = new FontManager();
         }
         return _self;
      }
      
      private var _log:Logger;
      
      private var _handler:MessageHandler;
      
      private var _loader:IResourceLoader;
      
      private var _data:XML;
      
      private var _lang:String;
      
      private var _fonts:Dictionary;
      
      public function set handler(param1:MessageHandler) : void {
         this._handler = param1;
      }
      
      public function loadFile(param1:String) : void {
         var _loc2_:String = FileUtils.getExtension(param1);
         this._lang = LangManager.getInstance().getEntry("config.lang.current");
         if(_loc2_ == null)
         {
            throw new FileTypeError(param1 + " have no type (no extension found).");
         }
         else
         {
            _loc3_ = new Uri(param1);
            _loc3_.tag = param1;
            this._loader.load(_loc3_);
            return;
         }
      }
      
      public function getRealFontName(param1:String) : String {
         if(this._fonts[param1])
         {
            return this._fonts[param1].realname;
         }
         return "";
      }
      
      public function getFontsList() : Array {
         var _loc2_:Object = null;
         var _loc1_:Array = new Array();
         for each (_loc2_ in this._fonts)
         {
            _loc1_.push(_loc2_.url);
         }
         return _loc1_;
      }
      
      public function getSizeMultipicator(param1:String) : Number {
         if(this._fonts[param1])
         {
            return Number(this._fonts[param1].sizemultiplicator);
         }
         return 1;
      }
      
      public function getFontClassName(param1:String) : String {
         return this._fonts[param1].classname;
      }
      
      public function getFontClassRenderingMode(param1:String) : String {
         if(this._fonts[param1].embedAsCff)
         {
            return AntiAliasType.ADVANCED;
         }
         return AntiAliasType.NORMAL;
      }
      
      private function onFileLoaded(param1:ResourceLoadedEvent) : void {
         var xml:XMLList = null;
         var length:int = 0;
         var i:int = 0;
         var name:String = null;
         var o:Object = null;
         var e:ResourceLoadedEvent = param1;
         this._data = new XML(e.resource);
         this._fonts = new Dictionary();
         xml = this._data.Fonts.(@lang == _lang);
         if(xml.length() == 0)
         {
            xml = this._data.Fonts.(@lang == "");
         }
         length = xml.font.length();
         i = 0;
         while(i < length)
         {
            name = xml.font[i].@name;
            o = 
               {
                  "realname":xml.font[i].@realName,
                  "classname":xml.font[i].@classname,
                  "sizemultiplicator":xml.font[i].@sizemultiplicator,
                  "url":LangManager.getInstance().replaceKey(xml.font[i]),
                  "embedAsCff":xml.font[i].@embedAsCff == "true"
               };
            this._fonts[name] = o;
            i++;
         }
         if(this._handler)
         {
            this._handler.process(new LangFileLoadedMessage(e.uri.uri,true,e.uri.uri));
            this._handler.process(new LangAllFilesLoadedMessage(e.uri.uri,true));
         }
         initialized = true;
      }
      
      private function onLoadError(param1:ResourceErrorEvent) : void {
         this._handler.process(new LangFileLoadedMessage(param1.uri.uri,false,param1.uri.uri));
         this._log.warn("can\'t load " + param1.uri.uri);
      }
   }
}
