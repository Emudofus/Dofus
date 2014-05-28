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
      
      public function set handler(value:MessageHandler) : void {
         this._handler = value;
      }
      
      public function loadFile(sUrl:String) : void {
         var sExtension:String = FileUtils.getExtension(sUrl);
         this._lang = LangManager.getInstance().getEntry("config.lang.current");
         if(sExtension == null)
         {
            throw new FileTypeError(sUrl + " have no type (no extension found).");
         }
         else
         {
            uri = new Uri(sUrl);
            uri.tag = sUrl;
            this._loader.load(uri);
            return;
         }
      }
      
      public function getRealFontName(font:String) : String {
         if(this._fonts[font])
         {
            return this._fonts[font].realname;
         }
         return "";
      }
      
      public function getFontsList() : Array {
         var o:Object = null;
         var fontList:Array = new Array();
         for each(o in this._fonts)
         {
            fontList.push(o.url);
         }
         return fontList;
      }
      
      public function getSizeMultipicator(fontName:String) : Number {
         if(this._fonts[fontName])
         {
            return Number(this._fonts[fontName].sizemultiplicator);
         }
         return 1;
      }
      
      public function getFontClassName(cssName:String) : String {
         return this._fonts[cssName].classname;
      }
      
      public function getFontClassRenderingMode(fontName:String) : String {
         if(this._fonts[fontName].embedAsCff)
         {
            return AntiAliasType.ADVANCED;
         }
         return AntiAliasType.NORMAL;
      }
      
      private function onFileLoaded(e:ResourceLoadedEvent) : void {
         var xml:XMLList = null;
         var length:int = 0;
         var i:int = 0;
         var name:String = null;
         var o:Object = null;
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
      
      private function onLoadError(e:ResourceErrorEvent) : void {
         this._handler.process(new LangFileLoadedMessage(e.uri.uri,false,e.uri.uri));
         this._log.warn("can\'t load " + e.uri.uri);
      }
   }
}
