package com.ankamagames.dofus.misc.utils
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.events.Event;
   import com.ankamagames.dofus.types.events.RpcEvent;
   import com.ankamagames.jerakine.json.JSON;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequestMethod;
   
   public class RpcServiceManager extends EventDispatcher
   {
      
      public function RpcServiceManager(param1:String="", param2:String="") {
         super();
         if(param1 != "")
         {
            this.service = param1;
         }
         if(param2 != "")
         {
            this.type = param2;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RpcServiceManager));
      
      public static const SERVER_ERROR:String = "InternalServerError";
      
      private var _loader:URLLoader;
      
      private var _request:URLRequest;
      
      private var _service:String;
      
      private var _params;
      
      private var _method:String;
      
      private var _result:Object;
      
      private var _type:String;
      
      private function onComplete(param1:Event) : void {
         var _loc2_:* = true;
         if(this._type == "json")
         {
            _loc2_ = this.formateJsonResult(param1.currentTarget.data);
         }
         else
         {
            _loc2_ = false;
         }
         if(_loc2_)
         {
            dispatchEvent(new RpcEvent(RpcEvent.EVENT_DATA,this._method,this._result));
            dispatchEvent(param1);
         }
         else
         {
            dispatchEvent(new RpcEvent(RpcEvent.EVENT_ERROR,this._method,this._result));
            dispatchEvent(new Event(SERVER_ERROR));
         }
      }
      
      private function formateJsonResult(param1:String) : Boolean {
         var de:Object = null;
         var data:String = param1;
         try
         {
            de = com.ankamagames.jerakine.json.JSON.decode(data);
         }
         catch(e:Error)
         {
            _log.error("Can\'t decode string, JSON required !!");
            return false;
         }
         if(de == null)
         {
            _log.error("No information received from the server ...");
            return false;
         }
         if(de.error != null)
         {
            switch(typeof de.error)
            {
               case "string":
               case "number":
                  _log.error("ERROR RPC SERVICE: " + de.error + (de.type != null?", " + de.type:"") + (de.message != null?", " + de.message:""));
                  break;
               case "object":
                  _log.error((de.error.type != null?de.error.type:de.error.code) + " -> " + de.error.message);
                  break;
               default:
                  _log.error("ERROR RPC SERVICE: " + de.error);
            }
            return false;
         }
         this._result = de.result;
         return this._result is Boolean && (this._result) || !(!(this._result is Boolean) && !(this._result.success == null) && this._result.success == false);
      }
      
      private function createRpcObject(param1:String) : Object {
         var _loc2_:Object = new Object();
         switch(this._type)
         {
            case "json":
               _loc2_.method = param1;
               _loc2_.params = this._params;
               _loc2_.id = 1;
               break;
            case "xml":
               break;
         }
         return _loc2_;
      }
      
      public function destroy() : void {
         if(this._loader.hasEventListener(Event.COMPLETE))
         {
            this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
         }
         if(this._loader.hasEventListener(IOErrorEvent.IO_ERROR))
         {
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         }
         if(this._loader.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
         {
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         }
         this._loader = null;
         this._request = null;
      }
      
      public function getAllResultData() : * {
         return this._result;
      }
      
      public function getResultData(param1:String) : * {
         if(this._result == null)
         {
            return null;
         }
         return this._result[param1];
      }
      
      public function callMethod(param1:String, param2:*) : void {
         var _loc3_:Object = null;
         this._method = param1;
         this._params = param2;
         if(this._request == null || this._loader == null)
         {
            throw new Error("there is no data to handle ...");
         }
         else
         {
            _loc3_ = this.createRpcObject(param1);
            switch(this._type)
            {
               case "json":
                  this._request.data = com.ankamagames.jerakine.json.JSON.encode(_loc3_);
                  break;
               case "xml":
                  throw new Error("Not implemented yet");
            }
            this._request.method = URLRequestMethod.POST;
            this._loader.load(this._request);
            return;
         }
      }
      
      public function set type(param1:String) : void {
         var param1:String = param1.toLowerCase();
         switch(param1)
         {
            case "json":
            case "jsonrpc":
               this._type = "json";
               break;
            case "xmlrpc":
            case "xml":
            default:
               this._type = "xml";
         }
      }
      
      public function set service(param1:String) : void {
         this._service = param1;
         this._request = new URLRequest(param1);
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      private function onError(param1:Event) : void {
         if(hasEventListener(param1.type))
         {
            dispatchEvent(param1);
         }
         dispatchEvent(new RpcEvent(RpcEvent.EVENT_ERROR,this._method,null));
      }
      
      public function get requestData() : * {
         if(this._request == null)
         {
            return null;
         }
         return com.ankamagames.jerakine.json.JSON.decode(this._request.data as String);
      }
   }
}
