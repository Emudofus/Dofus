package com.ankamagames.dofus.network.messages.game.character.status
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PlayerStatusUpdateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PlayerStatusUpdateRequestMessage() {
         this.status = new PlayerStatus();
         super();
      }
      
      public static const protocolId:uint = 6387;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var status:PlayerStatus;
      
      override public function getMessageId() : uint {
         return 6387;
      }
      
      public function initPlayerStatusUpdateRequestMessage(status:PlayerStatus=null) : PlayerStatusUpdateRequestMessage {
         this.status = status;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.status = new PlayerStatus();
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
         this.serializeAs_PlayerStatusUpdateRequestMessage(output);
      }
      
      public function serializeAs_PlayerStatusUpdateRequestMessage(output:IDataOutput) : void {
         output.writeShort(this.status.getTypeId());
         this.status.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PlayerStatusUpdateRequestMessage(input);
      }
      
      public function deserializeAs_PlayerStatusUpdateRequestMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id1);
         this.status.deserialize(input);
      }
   }
}
