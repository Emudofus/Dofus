package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightTurnResumeMessage extends GameFightTurnStartMessage implements INetworkMessage
   {
      
      public function GameFightTurnResumeMessage() {
         super();
      }
      
      public static const protocolId:uint = 6307;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6307;
      }
      
      public function initGameFightTurnResumeMessage(param1:int=0, param2:uint=0) : GameFightTurnResumeMessage {
         super.initGameFightTurnStartMessage(param1,param2);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightTurnResumeMessage(param1);
      }
      
      public function serializeAs_GameFightTurnResumeMessage(param1:IDataOutput) : void {
         super.serializeAs_GameFightTurnStartMessage(param1);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightTurnResumeMessage(param1);
      }
      
      public function deserializeAs_GameFightTurnResumeMessage(param1:IDataInput) : void {
         super.deserialize(param1);
      }
   }
}
