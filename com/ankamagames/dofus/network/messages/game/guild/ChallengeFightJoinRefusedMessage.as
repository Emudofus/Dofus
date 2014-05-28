package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChallengeFightJoinRefusedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeFightJoinRefusedMessage() {
         super();
      }
      
      public static const protocolId:uint = 5908;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playerId:uint = 0;
      
      public var reason:int = 0;
      
      override public function getMessageId() : uint {
         return 5908;
      }
      
      public function initChallengeFightJoinRefusedMessage(playerId:uint = 0, reason:int = 0) : ChallengeFightJoinRefusedMessage {
         this.playerId = playerId;
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerId = 0;
         this.reason = 0;
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
         this.serializeAs_ChallengeFightJoinRefusedMessage(output);
      }
      
      public function serializeAs_ChallengeFightJoinRefusedMessage(output:IDataOutput) : void {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            output.writeInt(this.playerId);
            output.writeByte(this.reason);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChallengeFightJoinRefusedMessage(input);
      }
      
      public function deserializeAs_ChallengeFightJoinRefusedMessage(input:IDataInput) : void {
         this.playerId = input.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of ChallengeFightJoinRefusedMessage.playerId.");
         }
         else
         {
            this.reason = input.readByte();
            return;
         }
      }
   }
}
