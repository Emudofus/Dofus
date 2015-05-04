package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.net.LocalConnection;
   import flash.events.AsyncErrorEvent;
   import flash.events.StatusEvent;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.PanicMessages;
   
   public class InterClientKeyManager extends Object
   {
      
      public function InterClientKeyManager()
      {
         super();
         this._sendingLc = new LocalConnection();
         this.initLocalConnection(this._sendingLc);
         this._receivingLc = new LocalConnection();
         this.initLocalConnection(this._receivingLc);
         this._receivingLc.client = new Object();
         this._receivingLc.client.ping = this.lc_ping;
         this._receivingLc.client.askKey = this.lc_askKey;
         this._receivingLc.client.receiveKey = this.lc_receiveKey;
         this._clientsIds = new Vector.<uint>(0);
         this._clientsKeys = new Array();
      }
      
      private static var hex_chars:Array = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
      
      private static const MAX_CLIENTS:uint = 50;
      
      private static const CONNECTION_NAME:String = "_dofusClient#";
      
      private static const KEY_SIZE:uint = 21;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientKeyManager));
      
      private static var _instance:InterClientKeyManager;
      
      public static function getInstance() : InterClientKeyManager
      {
         if(!_instance)
         {
            _instance = new InterClientKeyManager();
         }
         return _instance;
      }
      
      private static function getRandomFlashKey() : String
      {
         var _loc1_:* = "";
         var _loc2_:Number = KEY_SIZE - (1 + 3);
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc1_ + getRandomChar();
            _loc3_++;
         }
         return _loc1_ + checksum(_loc1_);
      }
      
      private static function checksum(param1:String) : String
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + param1.charCodeAt(_loc3_) % 16;
            _loc3_++;
         }
         return hex_chars[_loc2_ % 16];
      }
      
      private static function getRandomChar() : String
      {
         var _loc1_:Number = Math.ceil(Math.random() * 100);
         if(_loc1_ <= 40)
         {
            return String.fromCharCode(Math.floor(Math.random() * 26) + 65);
         }
         if(_loc1_ <= 80)
         {
            return String.fromCharCode(Math.floor(Math.random() * 26) + 97);
         }
         return String.fromCharCode(Math.floor(Math.random() * 10) + 48);
      }
      
      private var _sendingLc:LocalConnection;
      
      private var _receivingLc:LocalConnection;
      
      private var _key:String;
      
      private var _keyTimestamp:Number;
      
      private var _initKey:Boolean;
      
      private var _connected:Boolean;
      
      private var _connectionName:String;
      
      private var _currentClientId:uint;
      
      private var _clientsIds:Vector.<uint>;
      
      private var _clientsKeys:Array;
      
      public function getKey() : void
      {
         this._initKey = true;
         this._connected = false;
         this._currentClientId = 0;
         this.pingNext();
      }
      
      private function initLocalConnection(param1:LocalConnection) : void
      {
         param1.allowDomain("*");
         param1.allowInsecureDomain("*");
         param1.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onError);
         param1.addEventListener(StatusEvent.STATUS,this.onStatusEvent);
      }
      
      private function onError(param1:AsyncErrorEvent) : void
      {
      }
      
      private function onStatusEvent(param1:StatusEvent) : void
      {
         if(this._initKey)
         {
            if(param1.level == "status")
            {
               if(this._clientsIds.indexOf(this._currentClientId) == -1)
               {
                  this._clientsIds.push(this._currentClientId);
               }
            }
            else if(param1.level == "error")
            {
               if(!this._connected)
               {
                  this._connectionName = CONNECTION_NAME + this._currentClientId.toString();
                  this._receivingLc.connect(this._connectionName);
                  this._connected = true;
               }
            }
            
            this.pingNext();
         }
      }
      
      private function pingNext() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:CustomSharedObject = null;
         var _loc4_:String = null;
         this._currentClientId++;
         if(this._currentClientId <= MAX_CLIENTS)
         {
            _loc1_ = CONNECTION_NAME + this._currentClientId.toString();
            this._sendingLc.send(_loc1_,"ping");
         }
         else if(this._clientsIds.length == 0)
         {
            _loc3_ = CustomSharedObject.getLocal("uid");
            _loc4_ = _loc3_.data["identity"];
            if(!_loc4_ || _loc4_.length > KEY_SIZE - 3)
            {
               _loc2_ = getRandomFlashKey();
               _loc3_.data["identity"] = _loc2_;
               _loc3_.flush();
            }
            else
            {
               _loc2_ = _loc4_;
            }
            _loc3_.close();
            this.saveKey(_loc2_);
            this._initKey = false;
         }
         else if(this._connected)
         {
            this.askKeyFromClients();
         }
         else
         {
            Kernel.panic(PanicMessages.TOO_MANY_CLIENTS);
         }
         
         
      }
      
      private function askKeyFromClients() : void
      {
         var _loc1_:uint = 0;
         this._initKey = false;
         for each(_loc1_ in this._clientsIds)
         {
            this._sendingLc.send(CONNECTION_NAME + _loc1_.toString(),"askKey",this._connectionName);
         }
      }
      
      private function saveKey(param1:String, param2:uint = 1) : void
      {
         var _loc4_:String = null;
         var _loc3_:Date = new Date();
         this._key = param1;
         this._keyTimestamp = _loc3_.getTime();
         _loc4_ = param1 + "#" + (param2 < 10?"0" + param2:param2);
         InterClientManager.getInstance().flashKey = _loc4_;
      }
      
      private function lc_ping() : void
      {
      }
      
      private function lc_askKey(param1:String) : void
      {
         this._sendingLc.send(param1,"receiveKey",this._key,this._keyTimestamp);
      }
      
      private function lc_receiveKey(param1:String, param2:Number) : void
      {
         var _loc3_:ClientKey = null;
         var _loc4_:Array = null;
         var _loc5_:ClientKey = null;
         this._clientsKeys.push(new ClientKey(param1,param2));
         if(this._clientsKeys.length == this._clientsIds.length)
         {
            this._clientsKeys.sortOn("timestamp",Array.NUMERIC);
            _loc3_ = this._clientsKeys[0];
            _loc4_ = new Array();
            for each(_loc5_ in this._clientsKeys)
            {
               if(_loc4_.indexOf(_loc5_.key) == -1)
               {
                  _loc4_.push(_loc5_.key);
               }
            }
            this.saveKey(_loc3_.key,_loc4_.length);
         }
      }
   }
}
class ClientKey extends Object
{
   
   function ClientKey(param1:String, param2:Number)
   {
      super();
      this.key = param1;
      this.timestamp = param2;
   }
   
   public var key:String;
   
   public var timestamp:Number;
}
