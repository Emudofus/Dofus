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
      
      protected static const _log:Logger;
      
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
      
      public function set flashKey(key:String) : void {
         this._identity = key;
      }
      
      public function get isAlone() : Boolean {
         return (isMaster()) && (this._master.isAlone);
      }
      
      public function identifyFromFlashKey() : void {
         var so:CustomSharedObject = CustomSharedObject.getLocal("uid");
         if(!so.data["identity"])
         {
            this._identity = this.getRandomFlashKey();
            so.data["identity"] = this._identity;
            so.flush();
         }
         else
         {
            this._identity = so.data["identity"];
         }
         so.close();
      }
      
      public function update() : void {
         this._master = InterClientMaster.etreLeCalif();
         if((!this._master) && (!this._client))
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
         var date:Number = new Date().time;
         if(this._client)
         {
            this._client.gainFocus(date);
         }
         else if(this._master)
         {
            this._master.clientGainFocus("_dofus," + new Date().time);
         }
         
      }
      
      public function resetFocus() : void {
         if(this._client)
         {
            this._client.gainFocus(0);
         }
         else if(this._master)
         {
            this._master.clientGainFocus("_dofus,0");
         }
         
      }
      
      public function updateFocusList() : void {
         var clientId:String = this._master?"_dofus":this._client.connId;
         DofusFpsManager.updateFocusList(this.clientListInfo,clientId);
      }
      
      private function getRandomFlashKey() : String {
         var sSentance:String = "";
         var nLen:Number = 20;
         var i:Number = 0;
         while(i < nLen)
         {
            sSentance = sSentance + this.getRandomChar();
            i++;
         }
         return sSentance + this.checksum(sSentance);
      }
      
      private function checksum(s:String) : String {
         var r:Number = 0;
         var i:Number = 0;
         while(i < s.length)
         {
            r = r + s.charCodeAt(i) % 16;
            i++;
         }
         return this.hex_chars[r % 16];
      }
      
      private function getRandomChar() : String {
         var n:Number = Math.ceil(Math.random() * 100);
         if(n <= 40)
         {
            return String.fromCharCode(Math.floor(Math.random() * 26) + 65);
         }
         if(n <= 80)
         {
            return String.fromCharCode(Math.floor(Math.random() * 26) + 97);
         }
         return String.fromCharCode(Math.floor(Math.random() * 10) + 48);
      }
   }
}
