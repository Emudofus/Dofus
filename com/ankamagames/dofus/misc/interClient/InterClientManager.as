package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.dofus.logic.common.managers.DofusFpsManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class InterClientManager extends Object
   {
      
      public function InterClientManager() {
         this.hex_chars = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
         this.clientListInfo = new Array("_dofus",0);
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InterClientManager));
      
      private static var _self:InterClientManager;
      
      public static function getInstance() : InterClientManager {
         if(!_self)
         {
            _self = new InterClientManager();
         }
         return _self;
      }
      
      public static function destroy() : void {
         if(_self)
         {
            try
            {
               if(_self._client)
               {
                  _self._client.destroy();
               }
               if(_self._master)
               {
                  _self._master.destroy();
               }
            }
            catch(ae:ArgumentError)
            {
               _log.warn("Closing a disconnected LocalConnection in destroy(). Exception catched.");
            }
         }
         if(_self)
         {
            return;
         }
      }
      
      public static function isMaster() : Boolean {
         return !(getInstance()._master == null);
      }
      
      private var _client:InterClientSlave;
      
      private var _master:InterClientMaster;
      
      private var hex_chars:Array;
      
      private var _identity:String;
      
      public var clientListInfo:Array;
      
      public function get flashKey() : String {
         if(!this._identity)
         {
            return this.getRandomFlashKey();
         }
         return this._identity;
      }
      
      public function set flashKey(param1:String) : void {
         this._identity = param1;
      }
      
      public function get isAlone() : Boolean {
         return (isMaster()) && (this._master.isAlone);
      }
      
      public function identifyFromFlashKey() : void {
         var _loc1_:CustomSharedObject = CustomSharedObject.getLocal("uid");
         if(!_loc1_.data["identity"])
         {
            this._identity = this.getRandomFlashKey();
            _loc1_.data["identity"] = this._identity;
            _loc1_.flush();
         }
         else
         {
            this._identity = _loc1_.data["identity"];
         }
         _loc1_.close();
      }
      
      public function update() : void {
         this._master = InterClientMaster.etreLeCalif();
         if(!this._master && !this._client)
         {
            this._client = new InterClientSlave();
            this._client.retreiveUid();
         }
         if((this._master) && (this._client))
         {
            try
            {
               this._client.destroy();
               this._client = null;
            }
            catch(ae:ArgumentError)
            {
               _log.warn("Closing a disconnected LocalConnection in update(). Exception catched.");
            }
            this.gainFocus();
         }
      }
      
      public function gainFocus() : void {
         var _loc1_:Number = new Date().time;
         if(this._client)
         {
            this._client.gainFocus(_loc1_);
         }
         else
         {
            if(this._master)
            {
               this._master.clientGainFocus("_dofus," + new Date().time);
            }
         }
      }
      
      public function resetFocus() : void {
         if(this._client)
         {
            this._client.gainFocus(0);
         }
         else
         {
            if(this._master)
            {
               this._master.clientGainFocus("_dofus,0");
            }
         }
      }
      
      public function updateFocusList() : void {
         var _loc1_:String = this._master?"_dofus":this._client.connId;
         DofusFpsManager.updateFocusList(this.clientListInfo,_loc1_);
      }
      
      private function getRandomFlashKey() : String {
         var _loc1_:* = "";
         var _loc2_:Number = 20;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc1_ + this.getRandomChar();
            _loc3_++;
         }
         return _loc1_ + this.checksum(_loc1_);
      }
      
      private function checksum(param1:String) : String {
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + param1.charCodeAt(_loc3_) % 16;
            _loc3_++;
         }
         return this.hex_chars[_loc2_ % 16];
      }
      
      private function getRandomChar() : String {
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
   }
}
