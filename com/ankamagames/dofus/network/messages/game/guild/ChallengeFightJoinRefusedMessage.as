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
      
      public function initChallengeFightJoinRefusedMessage(param1:uint=0, param2:int=0) : ChallengeFightJoinRefusedMessage {
         this.playerId = param1;
         this.reason = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playerId = 0;
         this.reason = 0;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ChallengeFightJoinRefusedMessage(param1);
      }
      
      public function serializeAs_ChallengeFightJoinRefusedMessage(param1:IDataOutput) : void {
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            param1.writeByte(this.reason);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChallengeFightJoinRefusedMessage(param1);
      }
      
      public function deserializeAs_ChallengeFightJoinRefusedMessage(param1:IDataInput) : void {
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of ChallengeFightJoinRefusedMessage.playerId.");
         }
         else
         {
            this.reason = param1.readByte();
            return;
         }
      }
   }
}
