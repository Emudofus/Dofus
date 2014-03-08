package com.ankamagames.jerakine.network
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.resources.adapters.impl.BinaryAdapter;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import flash.utils.IDataInput;
   import flash.utils.ByteArray;
   
   public class HttpServerConnection extends Object
   {
      
      public function HttpServerConnection() {
         super();
         this.init();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HttpServerConnection));
      
      private var _loader:IResourceLoader;
      
      private var _requestTimestamp:Dictionary;
      
      private var _errorCallback:Dictionary;
      
      private var _whiteList:Dictionary;
      
      private var _whiteListCount:uint;
      
      public var rawParser:RawDataParser;
      
      public var handler:MessageHandler;
      
      public function resetTime(param1:Uri) : void {
         delete this._requestTimestamp[[param1.toString()]];
      }
      
      public function request(param1:Uri, param2:Function=null, param3:uint=0) : Boolean {
         var _loc4_:Number = this._requestTimestamp[param1.toString()];
         if((_loc4_) && getTimer() - _loc4_ < param3)
         {
            return false;
         }
         if(param2 == null)
         {
            this._errorCallback[param1] = param2;
         }
         this._requestTimestamp[param1.toString()] = getTimer();
         this._loader.load(param1,null,BinaryAdapter);
         return true;
      }
      
      public function reset() : void {
         this._loader.cancel();
      }
      
      public function addToWhiteList(param1:Class) : void {
         if(!this._whiteList[param1])
         {
            this._whiteList[param1] = true;
            this._whiteListCount++;
         }
      }
      
      public function removeFromWhiteList(param1:Class) : void {
         if(this._whiteList[param1])
         {
            delete this._whiteList[[param1]];
            this._whiteListCount--;
         }
      }
      
      public function get whiteListCount() : uint {
         return this._whiteListCount;
      }
      
      private function init() : void {
         this._whiteList = new Dictionary();
         this._errorCallback = new Dictionary(true);
         this._requestTimestamp = new Dictionary();
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onError);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onReceive);
      }
      
      private function getMessageId(param1:uint) : uint {
         return param1 >> NetworkMessage.BIT_RIGHT_SHIFT_LEN_PACKET_ID;
      }
      
      private function readMessageLength(param1:uint, param2:IDataInput) : uint {
         var _loc3_:uint = param1 & NetworkMessage.BIT_MASK;
         var _loc4_:uint = 0;
         switch(_loc3_)
         {
            case 0:
               break;
            case 1:
               _loc4_ = param2.readUnsignedByte();
               break;
            case 2:
               _loc4_ = param2.readUnsignedShort();
               break;
            case 3:
               _loc4_ = ((param2.readByte() & 255) << 16) + ((param2.readByte() & 255) << 8) + (param2.readByte() & 255);
               break;
         }
         return _loc4_;
      }
      
      protected function lowReceive(param1:IDataInput) : INetworkMessage {
         var _loc4_:uint = 0;
         if(param1.bytesAvailable < 2)
         {
            return null;
         }
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = this.getMessageId(_loc2_);
         if(param1.bytesAvailable >= (_loc2_ & NetworkMessage.BIT_MASK))
         {
            _loc4_ = this.readMessageLength(_loc2_,param1);
            if(param1.bytesAvailable >= _loc4_)
            {
               return this.rawParser.parse(param1,_loc3_,_loc4_);
            }
         }
         return null;
      }
      
      protected function receive(param1:IDataInput, param2:Uri) : void {
         var _loc4_:INetworkMessage = null;
         var _loc3_:uint = param1.bytesAvailable;
         while(param1.bytesAvailable > 0)
         {
            _loc4_ = this.lowReceive(param1);
            if(!_loc4_)
            {
               if(_loc3_ == param1.bytesAvailable)
               {
                  _log.error("Error while reading " + param2 + " : malformated data");
                  return;
               }
               _log.error("Unknow message from " + param2);
               return;
            }
            _loc3_ = param1.bytesAvailable;
            if(_loc4_ is INetworkDataContainerMessage)
            {
               while(INetworkDataContainerMessage(_loc4_).content.bytesAvailable)
               {
                  this.receive(INetworkDataContainerMessage(_loc4_).content,param2);
               }
            }
            else
            {
               if(!this._whiteListCount || (this._whiteList[Object(_loc4_).constructor]))
               {
                  _log.info("Dispatch " + _loc4_ + " from " + param2);
                  this.handler.process(_loc4_);
               }
               else
               {
                  _log.error("Packet " + _loc4_ + " cannot be used from a web server (uri: " + param2.toString() + ")");
               }
            }
         }
      }
      
      private function onReceive(param1:ResourceLoadedEvent) : void {
         delete this._errorCallback[[param1.uri]];
         var _loc2_:Number = getTimer();
         this.receive(param1.resource as ByteArray,param1.uri);
         _log.info("Network packet parsed in " + (getTimer() - _loc2_) + " ms");
      }
      
      private function onError(param1:ResourceErrorEvent) : void {
         _log.error("Cannot load " + param1.uri + " : " + param1.errorMsg);
         if(this._errorCallback[param1.uri] != null)
         {
            this._errorCallback[param1.uri](param1.uri);
         }
         delete this._errorCallback[[param1.uri]];
      }
   }
}
