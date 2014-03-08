package com.ankamagames.berilia.managers
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.text.Font;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.jerakine.resources.events.ResourceLoaderProgressEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class EmbedFontManager extends EventDispatcher
   {
      
      public function EmbedFontManager() {
         super();
         if(_self != null)
         {
            throw new SingletonError("EmbedFontManager constructor should not be called directly.");
         }
         else
         {
            _self = this;
            this._aFonts = new Array();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onComplete);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onError);
            this._loader.addEventListener(ResourceLoaderProgressEvent.LOADER_COMPLETE,this.onAllFontLoaded);
            return;
         }
      }
      
      private static var _self:EmbedFontManager;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmbedFontManager));
      
      public static function getInstance() : EmbedFontManager {
         if(_self == null)
         {
            _self = new EmbedFontManager();
         }
         return _self;
      }
      
      private var _aFonts:Array;
      
      private var _currentlyLoading:String;
      
      private var _loadingFonts:Array;
      
      private var _loader:IResourceLoader;
      
      public function initialize(fontList:Array) : void {
         if(this._loadingFonts == null)
         {
            this._loadingFonts = new Array();
         }
         this._loadingFonts = this._loadingFonts.concat(fontList);
         this.loadFonts();
      }
      
      public function isEmbed(fontName:String) : Boolean {
         return this._aFonts[fontName] == true;
      }
      
      public function getFont(fontName:String) : Font {
         var aFonts:Array = Font.enumerateFonts();
         var i:uint = 0;
         while(i < aFonts.length)
         {
            if(Font(aFonts[i]).fontName.toUpperCase() == fontName.toUpperCase())
            {
               return aFonts[i];
            }
            i++;
         }
         return null;
      }
      
      private function loadFonts() : void {
         var font:String = null;
         if(this._currentlyLoading != null)
         {
            return;
         }
         if(this._loadingFonts.length == 0)
         {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
         }
         var aQueue:Array = new Array();
         for each (font in this._loadingFonts)
         {
            aQueue.push(new Uri(font));
         }
         this._loadingFonts = null;
         this._loader.load(aQueue);
      }
      
      private function onComplete(e:ResourceLoadedEvent) : void {
         var fontsList:Array = null;
         var i:* = 0;
         var fontClass:Class = Swl(e.resource).getDefinition(FileUtils.getFileStartName(e.uri.uri)) as Class;
         this._aFonts[FileUtils.getFileStartName(e.uri.uri)] = true;
         if(fontClass["EMBED_FONT"])
         {
            Font.registerFont(fontClass["EMBED_FONT"]);
         }
         else
         {
            fontsList = fontClass["FONTS_LIST"];
            if(fontsList)
            {
               i = 0;
               while(i < fontsList.length)
               {
                  Font.registerFont(fontsList[i]);
                  i++;
               }
            }
         }
         this._currentlyLoading = null;
      }
      
      private function onAllFontLoaded(e:ResourceLoaderProgressEvent) : void {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onError(e:ResourceErrorEvent) : void {
         _log.error("Unabled to load a font : " + e.uri);
      }
   }
}
