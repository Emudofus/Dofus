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
      
      public function RpcServiceManager(pServiceName:String="", pType:String="") {
         super();
         if(pServiceName != "")
         {
            this.service = pServiceName;
         }
         if(pType != "")
         {
            this.type = pType;
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
      
      private function onComplete(pEvt:Event) : void {
         var value:Boolean = true;
         if(this._type == "json")
         {
            value = this.formateJsonResult(pEvt.currentTarget.data);
         }
         else
         {
            value = false;
         }
         if(value)
         {
            dispatchEvent(new RpcEvent(RpcEvent.EVENT_DATA,this._method,this._result));
            dispatchEvent(pEvt);
         }
         else
         {
            dispatchEvent(new RpcEvent(RpcEvent.EVENT_ERROR,this._method,this._result));
            dispatchEvent(new Event(SERVER_ERROR));
         }
      }
      
      private function formateJsonResult(data:String) : Boolean {
         var de:Object = null;
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
                  _log.error("ERROR RPC SERVICE: " + de.error + (!(de.type == null)?", " + de.type:"") + (!(de.message == null)?", " + de.message:""));
                  break;
               case "object":
                  _log.error((!(de.error.type == null)?de.error.type:de.error.code) + " -> " + de.error.message);
                  break;
            }
            return false;
         }
         this._result = de.result;
         return (this._result is Boolean) && (this._result) || (!((!(this._result is Boolean)) && (!(this._result.success == null)) && (this._result.success == false)));
      }
      
      private function createRpcObject(method:String) : Object {
         var rpcObject:Object = new Object();
         switch(this._type)
         {
            case "json":
               rpcObject.method = method;
               rpcObject.params = this._params;
               rpcObject.id = 1;
               break;
            case "xml":
               break;
         }
         return rpcObject;
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
      
      public function getResultData(name:String) : * {
         if(this._result == null)
         {
            return null;
         }
         return this._result[name];
      }
      
      public function callMethod(name:String, params:*) : void {
         var obj:Object = null;
         this._method = name;
         this._params = params;
         if((this._request == null) || (this._loader == null))
         {
            throw new Error("there is no data to handle ...");
         }
         else
         {
            obj = this.createRpcObject(name);
            switch(this._type)
            {
               case "json":
                  this._request.data = com.ankamagames.jerakine.json.JSON.encode(obj);
                  break;
               case "xml":
                  throw new Error("Not implemented yet");
            }
            this._request.method = URLRequestMethod.POST;
            this._loader.load(this._request);
            return;
         }
      }
      
      public function set type(val:String) : void {
         var val:String = val.toLowerCase();
         switch(val)
         {
            case "json":
            case "jsonrpc":
               this._type = "json";
               break;
            case "xmlrpc":
            case "xml":
               this._type = "xml";
               break;
         }
      }
      
      public function set service(val:String) : void {
         this._service = val;
         this._request = new URLRequest(val);
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
      }
      
      private function onError(pEvt:Event) : void {
         if(hasEventListener(pEvt.type))
         {
            dispatchEvent(pEvt);
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
