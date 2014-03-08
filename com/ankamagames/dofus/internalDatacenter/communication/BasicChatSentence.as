package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class BasicChatSentence extends Object implements IDataCenter
   {
      
      public function BasicChatSentence(param1:uint, param2:String, param3:String, param4:uint=0, param5:Number=0, param6:String="") {
         super();
         this._id = param1;
         this._baseMsg = param2;
         this._msg = param3;
         this._channel = param4;
         this._timestamp = param5;
         this._fingerprint = param6;
      }
      
      private var _id:uint;
      
      private var _baseMsg:String;
      
      private var _msg:String;
      
      private var _channel:uint;
      
      private var _timestamp:Number;
      
      private var _fingerprint:String;
      
      public function get id() : uint {
         return this._id;
      }
      
      public function get baseMsg() : String {
         return this._baseMsg;
      }
      
      public function get msg() : String {
         return this._msg;
      }
      
      public function get channel() : uint {
         return this._channel;
      }
      
      public function get timestamp() : Number {
         return this._timestamp;
      }
      
      public function get fingerprint() : String {
         return this._fingerprint;
      }
   }
}
