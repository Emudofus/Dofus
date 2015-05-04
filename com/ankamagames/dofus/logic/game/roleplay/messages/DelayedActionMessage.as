package com.ankamagames.dofus.logic.game.roleplay.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class DelayedActionMessage extends Object implements Message
   {
      
      public function DelayedActionMessage(param1:int, param2:uint, param3:Number)
      {
         super();
         this._playerId = param1;
         this._itemId = param2;
         this._endTime = param3;
      }
      
      private var _playerId:int;
      
      private var _itemId:uint;
      
      private var _endTime:Number;
      
      public function get playerId() : int
      {
         return this._playerId;
      }
      
      public function get itemId() : uint
      {
         return this._itemId;
      }
      
      public function get endTime() : Number
      {
         return this._endTime;
      }
   }
}
