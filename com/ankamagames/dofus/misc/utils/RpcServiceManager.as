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
      
      public function RpcServiceManager(param1:String = "", param2:String = "", param3:String = "1.0")
      {
         super();
         this._busy = false;
         if(param1 != "")
         {
            this.service = param1;
         }
         if(param2 != "")
         {
            this.type = param2;
         }
         this.version = param3;
      }
      
      private static const DELAY_BEFORE_TIMED_OUT:int = 15000;
      
      private static const RETRY_AFTER_TIMED_OUT:int = 2;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RpcServiceManager));
      
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
      
      private var _ignoreTimedoutRequest:Boolean;
      
      private function onComplete(param1:Event) : void
      {
         this._busy = false;
         this.clearTimedOutTimer();
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
            if(this._callback != null)
            {
               this._callback(true,this.getAllResultData(),this.requestData);
            }
            else
            {
               dispatchEvent(new RpcEvent(RpcEvent.EVENT_DATA,this._method,this._result));
               dispatchEvent(param1);
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
      
      private function onError(param1:Event) : void
      {
         this._busy = false;
         this.clearTimedOutTimer();
         if(this._callback != null)
         {
            this._callback(false,param1,this.requestData);
         }
         else
         {
            if(hasEventListener(param1.type))
            {
               dispatchEvent(param1);
            }
            dispatchEvent(new RpcEvent(RpcEvent.EVENT_ERROR,this._method,null));
         }
      }
      
      private function onTimedOut(param1:TimerEvent) : void
      {
         var e:TimerEvent = param1;
         if(this._busy)
         {
            if(this._ignoreTimedoutRequest)
            {
               try
               {
                  this._loader.close();
               }
               catch(e:Error)
               {
                  _log.error("RPC timed out while its loader was already closed");
               }
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
      
      private function formateJsonResult(param1:String) : Boolean
      {
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
      
      private function createRpcObject(param1:String) : Object
      {
         var _loc2_:Object = new Object();
         switch(this._type)
         {
            case "json":
               switch(this._version)
               {
                  case "1.1":
                     _loc2_.version = "1.1";
                     break;
                  case "2.0":
                     _loc2_.jsonrpc = "2.0";
                     break;
               }
               _loc2_.method = param1;
               _loc2_.params = this._params;
               _loc2_.id = 1;
               break;
            case "xml":
               break;
         }
         return _loc2_;
      }
      
      private function clearTimedOutTimer() : void
      {
         if(this._timedOutTimer)
         {
            this._timedOutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimedOut);
            this._timedOutTimer.stop();
            this._timedOutTimer = null;
         }
         this._timedOutRetry = 0;
      }
      
      public function destroy() : void
      {
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
      
      public function getAllResultData() : *
      {
         return this._result;
      }
      
      public function getResultData(param1:String) : *
      {
         if(this._result == null)
         {
            return null;
         }
         return this._result[param1];
      }
      
      public function callMethod(param1:String, param2:*, param3:Function = null, param4:Boolean = true, param5:Boolean = true) : void
      {
         var _loc6_:Object = null;
         this._busy = true;
         this._method = param1;
         this._params = param2;
         this._callback = param3;
         this._ignoreTimedoutRequest = param5;
         if(this._request == null || this._loader == null)
         {
            throw new Error("there is no data to handle ...");
         }
         else
         {
            _loc6_ = this.createRpcObject(param1);
            switch(this._type)
            {
               case "json":
                  this._request.data = com.ankamagames.jerakine.json.JSON.encode(_loc6_);
                  break;
               case "xml":
                  throw new Error("Not implemented yet");
            }
            if(!param4)
            {
               this._timedOutRetry = RETRY_AFTER_TIMED_OUT;
            }
            this._timedOutTimer = new Timer(DELAY_BEFORE_TIMED_OUT,1);
            this._timedOutTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimedOut);
            this._timedOutTimer.start();
            this._loader.load(this._request);
            _log.debug("callMethod() - " + this._request.data);
            return;
         }
      }
      
      public function set type(param1:String) : void
      {
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
      
      public function set version(param1:String) : void
      {
         this._version = param1;
      }
      
      public function set service(param1:String) : void
      {
         this._service = param1;
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
      
      public function get requestData() : *
      {
         if(this._request == null)
         {
            return null;
         }
         return com.ankamagames.jerakine.json.JSON.decode(this._request.data as String);
      }
      
      public function get busy() : Boolean
      {
         return this._busy;
      }
   }
}
