package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.resources.ResourceType;
   import flash.system.LoaderContext;
   import flash.display.Loader;
   import flash.errors.EOFError;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.ApplicationDomain;
   import com.ankamagames.jerakine.utils.misc.ApplicationDomainShareManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoaderDataFormat;
   import flash.display.LoaderInfo;
   import flash.events.ErrorEvent;
   import flash.events.SecurityErrorEvent;
   
   public class DxAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      public function DxAdapter() {
         super();
      }
      
      private static function decipherSwf(param1:ByteArray, param2:ByteArray, param3:ByteArray) : void {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         while(param2.bytesAvailable > 0)
         {
            _loc5_ = param2.readByte();
            _loc6_ = _loc5_ ^ param3[_loc4_ % param3.length];
            param1.writeByte(_loc6_);
            _loc4_++;
         }
      }
      
      private var _scriptClass:Class;
      
      override protected function getResource(param1:String, param2:*) : * {
         return this._scriptClass;
      }
      
      override public function getResourceType() : uint {
         return ResourceType.RESOURCE_DX;
      }
      
      override protected function process(param1:String, param2:*) : void {
         var file:uint = 0;
         var version:uint = 0;
         var keyLen:int = 0;
         var key:ByteArray = null;
         var swfData:ByteArray = null;
         var dataFormat:String = param1;
         var data:* = param2;
         try
         {
            file = data.readByte();
            if(file != 83)
            {
               dispatchFailure("Malformated script file (wrong header).",ResourceErrorCode.DX_MALFORMED_SCRIPT);
               return;
            }
            version = data.readByte();
            keyLen = data.readShort();
            key = new ByteArray();
            data.readBytes(key,0,keyLen);
            swfData = new ByteArray();
            data.readBytes(swfData);
         }
         catch(eof:EOFError)
         {
            dispatchFailure("Malformated script file (end of file).",ResourceErrorCode.DX_MALFORMED_SCRIPT);
            return;
         }
         var swf:ByteArray = new ByteArray();
         decipherSwf(swf,swfData,key);
         var loaderContext:LoaderContext = getUri().loaderContext;
         if(!loaderContext)
         {
            loaderContext = new LoaderContext();
         }
         AirScanner.allowByteCodeExecution(loaderContext,true);
         loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomainShareManager.currentApplicationDomain);
         var ldr:Loader = new Loader();
         ldr.contentLoaderInfo.addEventListener(Event.INIT,this.onScriptInit);
         ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onScriptError);
         ldr.loadBytes(swf,loaderContext);
      }
      
      override protected function getDataFormat() : String {
         return URLLoaderDataFormat.BINARY;
      }
      
      private function onScriptInit(param1:Event) : void {
         var _loc2_:ApplicationDomain = (param1.target as LoaderInfo).applicationDomain;
         if(_loc2_.hasDefinition("Script"))
         {
            this._scriptClass = _loc2_.getDefinition("Script") as Class;
            dispatchSuccess(null,null);
         }
         else
         {
            dispatchFailure("There wasn\'t any script class inside of the script binaries.",ResourceErrorCode.DX_NO_SCRIPT_INSIDE);
         }
      }
      
      private function onScriptError(param1:ErrorEvent) : void {
         var _loc2_:uint = ResourceErrorCode.UNKNOWN_ERROR;
         if(param1 is IOErrorEvent)
         {
            _loc2_ = ResourceErrorCode.DX_MALFORMED_BINARY;
         }
         else
         {
            if(param1 is SecurityErrorEvent)
            {
               _loc2_ = ResourceErrorCode.DX_SECURITY_ERROR;
            }
         }
         dispatchFailure("Script loading from binaries failed: " + param1.text,_loc2_);
      }
   }
}
