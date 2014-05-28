package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightNewRoundMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightNewRoundMessage() {
         super();
      }
      
      public static const protocolId:uint = 6239;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var roundNumber:uint = 0;
      
      override public function getMessageId() : uint {
         return 6239;
      }
      
      public function initGameFightNewRoundMessage(roundNumber:uint = 0) : GameFightNewRoundMessage {
         this.roundNumber = roundNumber;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.roundNumber = 0;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightNewRoundMessage(output);
      }
      
      public function serializeAs_GameFightNewRoundMessage(output:IDataOutput) : void {
         if(this.roundNumber < 0)
         {
            throw new Error("Forbidden value (" + this.roundNumber + ") on element roundNumber.");
         }
         else
         {
            output.writeInt(this.roundNumber);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightNewRoundMessage(input);
      }
      
      public function deserializeAs_GameFightNewRoundMessage(input:IDataInput) : void {
         this.roundNumber = input.readInt();
         if(this.roundNumber < 0)
         {
            throw new Error("Forbidden value (" + this.roundNumber + ") on element of GameFightNewRoundMessage.roundNumber.");
         }
         else
         {
            return;
         }
      }
   }
}
