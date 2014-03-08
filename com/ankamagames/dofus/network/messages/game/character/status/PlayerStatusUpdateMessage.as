package com.ankamagames.dofus.network.messages.game.character.status
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatus;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PlayerStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PlayerStatusUpdateMessage() {
         this.status = new PlayerStatus();
         super();
      }
      
      public static const protocolId:uint = 6386;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var accountId:uint = 0;
      
      public var playerId:uint = 0;
      
      public var status:PlayerStatus;
      
      override public function getMessageId() : uint {
         return 6386;
      }
      
      public function initPlayerStatusUpdateMessage(accountId:uint=0, playerId:uint=0, status:PlayerStatus=null) : PlayerStatusUpdateMessage {
         this.accountId = accountId;
         this.playerId = playerId;
         this.status = status;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accountId = 0;
         this.playerId = 0;
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
         this.serializeAs_PlayerStatusUpdateMessage(output);
      }
      
      public function serializeAs_PlayerStatusUpdateMessage(output:IDataOutput) : void {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            output.writeInt(this.accountId);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               output.writeInt(this.playerId);
               output.writeShort(this.status.getTypeId());
               this.status.serialize(output);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PlayerStatusUpdateMessage(input);
      }
      
      public function deserializeAs_PlayerStatusUpdateMessage(input:IDataInput) : void {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of PlayerStatusUpdateMessage.accountId.");
         }
         else
         {
            this.playerId = input.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of PlayerStatusUpdateMessage.playerId.");
            }
            else
            {
               _id3 = input.readUnsignedShort();
               this.status = ProtocolTypeManager.getInstance(PlayerStatus,_id3);
               this.status.deserialize(input);
               return;
            }
         }
      }
   }
}
