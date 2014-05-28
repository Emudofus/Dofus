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
      
      public function initGameFightTurnResumeMessage(id:int = 0, waitTime:uint = 0) : GameFightTurnResumeMessage {
         super.initGameFightTurnStartMessage(id,waitTime);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightTurnResumeMessage(output);
      }
      
      public function serializeAs_GameFightTurnResumeMessage(output:IDataOutput) : void {
         super.serializeAs_GameFightTurnStartMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightTurnResumeMessage(input);
      }
      
      public function deserializeAs_GameFightTurnResumeMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
