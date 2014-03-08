package com.ankamagames.atouin.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.atouin.data.map.Map;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.display.Bitmap;
   import com.ankamagames.atouin.enums.GroundCache;
   import com.ankamagames.atouin.AtouinConstants;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.filesystem.FileMode;
   
   public class GroundMapLoader extends Object
   {
      
      public function GroundMapLoader(param1:Map, param2:File, param3:Function, param4:Function) {
         var fileStream:FileStream = null;
         var rawJPG:ByteArray = null;
         var map:Map = param1;
         var file:File = param2;
         var callBack:Function = param3;
         var errorCallBack:Function = param4;
         super();
         try
         {
            this._map = map;
            this._callBack = callBack;
            this._errorCallBack = errorCallBack;
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onJPGReady);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
            fileStream = new FileStream();
            fileStream.open(file,FileMode.READ);
            rawJPG = new ByteArray();
            fileStream.readInt();
            fileStream.readByte();
            fileStream.readInt();
            fileStream.readBytes(rawJPG);
            fileStream.close();
            this._loader.loadBytes(rawJPG);
         }
         catch(e:Error)
         {
            if(e)
            {
               _log.fatal(e.getStackTrace());
            }
            onError(null);
         }
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(GroundMapLoader));
      
      public static function loadGroundMap(param1:Map, param2:File, param3:Function, param4:Function) : void {
      }
      
      private var _callBack:Function;
      
      private var _errorCallBack:Function;
      
      private var _loader:Loader;
      
      private var _map:Map;
      
      private var _groundIsLoaded:Boolean = false;
      
      private var _time:int = 0;
      
      private function onJPGReady(param1:Event) : void {
         var bitmap:Bitmap = null;
         var e:Event = param1;
         try
         {
            this._groundIsLoaded = true;
            bitmap = this._loader.content as Bitmap;
            if(this._map.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_LOW_QUALITY || this._map.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_MEDIUM_QUALITY)
            {
               bitmap.width = AtouinConstants.RESOLUTION_HIGH_QUALITY.x;
               bitmap.height = AtouinConstants.RESOLUTION_HIGH_QUALITY.y;
            }
            this._loader.contentLoaderInfo.removeEventListener(Event.INIT,this.onJPGReady);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._callBack(bitmap);
         }
         catch(e:Error)
         {
            if(e)
            {
               _log.fatal(e.getStackTrace());
            }
            onError(null);
         }
         return;
         if(this._map.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_LOW_QUALITY || this._map.groundCacheCurrentlyUsed == GroundCache.GROUND_CACHE_MEDIUM_QUALITY)
         {
            bitmap.width = AtouinConstants.RESOLUTION_HIGH_QUALITY.x;
            bitmap.height = AtouinConstants.RESOLUTION_HIGH_QUALITY.y;
         }
         this._loader.contentLoaderInfo.removeEventListener(Event.INIT,this.onJPGReady);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         this._callBack(bitmap);
      }
      
      private function onError(param1:Event) : void {
         _log.info("On a pas pu charger la map :/");
         this._errorCallBack(this._map.id);
         this._loader.contentLoaderInfo.removeEventListener(Event.INIT,this.onJPGReady);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
      }
      
      private function onProgress(param1:ProgressEvent) : void {
         if(param1.bytesLoaded == param1.bytesTotal)
         {
            EnterFrameDispatcher.addEventListener(this.check,"GroundMapLoader");
         }
      }
      
      private function check(param1:Event) : void {
         if(this._time > 5)
         {
            if(!this._groundIsLoaded)
            {
               this._groundIsLoaded = true;
               this.onError(null);
            }
            EnterFrameDispatcher.removeEventListener(this.check);
         }
         else
         {
            this._time++;
         }
      }
   }
}
