package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.pools.PoolableLoader;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.resources.ResourceType;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.errors.EOFError;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.net.URLLoaderDataFormat;
   import flash.system.ApplicationDomain;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.ErrorEvent;
   
   public class SwlAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      public function SwlAdapter() {
         super();
      }
      
      private var _ldr:PoolableLoader;
      
      private var _onInit:Function;
      
      private var _swl:Swl;
      
      override protected function getResource(param1:String, param2:*) : * {
         return this._swl;
      }
      
      override public function getResourceType() : uint {
         return ResourceType.RESOURCE_SWL;
      }
      
      override protected function process(param1:String, param2:*) : void {
         var file:uint = 0;
         var version:uint = 0;
         var frameRate:uint = 0;
         var classesCount:uint = 0;
         var classesList:Array = null;
         var i:uint = 0;
         var swfData:ByteArray = null;
         var dataFormat:String = param1;
         var data:* = param2;
         try
         {
            file = (data as ByteArray).readByte();
            if(file != 76)
            {
               dispatchFailure("Malformated library file (wrong header).",ResourceErrorCode.SWL_MALFORMED_LIBRARY);
               return;
            }
            version = (data as ByteArray).readByte();
            frameRate = (data as ByteArray).readUnsignedInt();
            classesCount = (data as ByteArray).readInt();
            classesList = new Array();
            i = 0;
            while(i < classesCount)
            {
               classesList.push((data as ByteArray).readUTF());
               i++;
            }
            swfData = new ByteArray();
            (data as ByteArray).readBytes(swfData);
         }
         catch(eof:EOFError)
         {
            dispatchFailure("Malformated library file (end of file).",ResourceErrorCode.SWL_MALFORMED_LIBRARY);
            return;
         }
         this._ldr = PoolsManager.getInstance().getLoadersPool().checkOut() as PoolableLoader;
         this._ldr.contentLoaderInfo.addEventListener(Event.INIT,this._onInit = this.onLibraryInit(frameRate,classesList));
         this._ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLibraryError);
         var loaderContext:LoaderContext = getUri().loaderContext;
         if(!loaderContext)
         {
            loaderContext = new LoaderContext();
         }
         AirScanner.allowByteCodeExecution(loaderContext,true);
         this._ldr.loadBytes(swfData,loaderContext);
      }
      
      override protected function getDataFormat() : String {
         return URLLoaderDataFormat.BINARY;
      }
      
      private function createResource(param1:uint, param2:Array, param3:ApplicationDomain) : void {
         this._swl = new Swl(param1,param2,param3);
         dispatchSuccess(null,null);
      }
      
      private function releaseLoader() : void {
         this._ldr.contentLoaderInfo.removeEventListener(Event.INIT,this._onInit);
         this._ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onLibraryError);
         PoolsManager.getInstance().getLoadersPool().checkIn(this._ldr);
         this._ldr = null;
         this._onInit = null;
      }
      
      private function onLibraryInit(param1:uint, param2:Array) : Function {
         var frameRate:uint = param1;
         var classesList:Array = param2;
         return function(param1:Event):void
         {
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc2_:* = param1.target as LoaderInfo;
            var _loc3_:* = _loc2_.applicationDomain;
            var _loc4_:* = _loc2_.content as MovieClip;
            if(_loc4_)
            {
               _loc5_ = _loc4_.numChildren;
               _loc6_ = -1;
               while(++_loc6_ < _loc5_)
               {
                  _loc4_.removeChildAt(0);
               }
            }
            createResource(frameRate,classesList,_loc3_);
            releaseLoader();
         };
      }
      
      private function onLibraryError(param1:ErrorEvent) : void {
         dispatchFailure("Library loading from binaries failed: " + param1.text,ResourceErrorCode.SWL_MALFORMED_BINARY);
         this.releaseLoader();
      }
   }
}
