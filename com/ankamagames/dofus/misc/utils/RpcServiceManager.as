package com.ankamagames.dofus.misc.utils
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import flash.events.Event;
   import com.ankamagames.dofus.types.events.RpcEvent;
   import flash.events.TimerEvent;
   import flash.events.ErrorEvent;
   import flash.events.IOErrorEvent;
   import com.ankamagames.jerakine.json.JSON;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequestMethod;
   
   public class RpcServiceManager extends EventDispatcher
   {
      
      public function RpcServiceManager(pServiceName:String = "", pType:String = "", pVersion:String = "1.0") {
         super();
         this._busy = false;
         if(pServiceName != "")
         {
            this.service = pServiceName;
         }
         if(pType != "")
         {
            this.type = pType;
         }
         this.version = pVersion;
      }
      
      private static const DELAY_BEFORE_TIMED_OUT:int = 1000;
      
      private static const RETRY_AFTER_TIMED_OUT:int = 2;
      
      protected static const _log:Logger;
      
      public static const SERVER_ERROR:String = "InternalServerError";
      
      private var _loader:URLLoader;
      
      private var _request:URLRequest;
      
      private var _service:String;
      
      private var _params;
      
      private var _method:String;
      
      private var _result:Object;
      
      private var _type:String;
      
      private var _version:String;
      
      private var _busy:Boolean;
      
      private var _callback:Function;
      
      private var _timedOutTimer:Timer;
      
      private var _timedOutRetry:int;
      
      private function onComplete(pEvt:Event) : void {
         this._busy = false;
         this.clearTimedOutTimer();
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
            if(this._callback != null)
            {
               this._callback(true,this.getAllResultData(),this.requestData);
            }
            else
            {
               dispatchEvent(new RpcEvent(RpcEvent.EVENT_DATA,this._method,this._result));
               dispatchEvent(pEvt);
            }
         }
         else if(this._callback != null)
         {
            this._callback(false,"Error calling method " + this._method,this.requestData);
         }
         else
         {
            dispatchEvent(new RpcEvent(RpcEvent.EVENT_ERROR,this._method,this._result));
            dispatchEvent(new Event(SERVER_ERROR));
         }
         
      }
      
      private function onError(pEvt:Event) : void {
         this._busy = false;
         this.clearTimedOutTimer();
         if(this._callback != null)
         {
            this._callback(false,pEvt,this.requestData);
         }
         else
         {
            if(hasEventListener(pEvt.type))
            {
               dispatchEvent(pEvt);
            }
            dispatchEvent(new RpcEvent(RpcEvent.EVENT_ERROR,this._method,null));
         }
      }
      
      private function onTimedOut(e:TimerEvent) : void {
         if(this._busy)
         {
            try
            {
               this._loader.close();
            }
            catch(e:Error)
            {
               _log.error("RPC timed out while its loader was already closed");
            }
            if(this._timedOutRetry < RETRY_AFTER_TIMED_OUT)
            {
               this._timedOutRetry++;
               _log.debug("RPC timed out, but we try again... retry " + this._timedOutRetry + " / " + RETRY_AFTER_TIMED_OUT + "\nrequest: " + this._request.data);
               this._timedOutTimer.reset();
               this._timedOutTimer.start();
               this._loader.load(this._request);
               return;
            }
            this.onError(new ErrorEvent(IOErrorEvent.NETWORK_ERROR,true,false,"RPC timed out"));
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
               default:
                  _log.error("ERROR RPC SERVICE: " + de.error);
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
               switch(this._version)
               {
                  case "1.1":
                     rpcObject.version = "1.1";
                     break;
                  case "2.0":
                     rpcObject.jsonrpc = "2.0";
                     break;
               }
               rpcObject.method = method;
               rpcObject.params = this._params;
               rpcObject.id = 1;
               break;
            case "xml":
               break;
         }
         return rpcObject;
      }
      
      private function clearTimedOutTimer() : void {
         if(this._timedOutTimer)
         {
            this._timedOutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimedOut);
            this._timedOutTimer.stop();
            this._timedOutTimer = null;
         }
         this._timedOutRetry = 0;
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
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         }
         this.clearTimedOutTimer();
         this._loader = null;
         this._request = null;
         this._busy = false;
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
      
      public function callMethod(name:String, params:*, callback:Function = null, retryOnTimedout:Boolean = true) : void {
         var obj:Object = null;
         this._busy = true;
         this._method = name;
         this._params = params;
         this._callback = callback;
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
            if(!retryOnTimedout)
            {
               this._timedOutRetry = RETRY_AFTER_TIMED_OUT;
            }
            this._timedOutTimer = new Timer(5000,1);
            this._timedOutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimedOut);
            this._timedOutTimer.start();
            this._loader.load(this._request);
            _log.debug("callMethod() - " + this._request.data);
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
            default:
               this._type = "xml";
         }
      }
      
      public function set version(val:String) : void {
         this._version = val;
      }
      
      public function set service(val:String) : void {
         this._service = val;
         this.clearTimedOutTimer();
         if(!this._request)
         {
            this._request = new URLRequest(this._service);
            this._request.method = URLRequestMethod.POST;
         }
         else
         {
            this._request.url = this._service;
         }
         if(!this._loader)
         {
            this._loader = new URLLoader();
            this._loader.addEventListener(Event.COMPLETE,this.onComplete);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         }
         else
         {
            try
            {
               this._loader.close();
            }
            catch(error:Error)
            {
            }
         }
      }
      
      public function get requestData() : * {
         if(this._request == null)
         {
            return null;
         }
         return com.ankamagames.jerakine.json.JSON.decode(this._request.data as String);
      }
      
      public function get busy() : Boolean {
         return this._busy;
      }
   }
}
