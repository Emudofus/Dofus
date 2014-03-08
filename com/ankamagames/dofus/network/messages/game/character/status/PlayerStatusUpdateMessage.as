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
      
      public function initPlayerStatusUpdateMessage(param1:uint=0, param2:uint=0, param3:PlayerStatus=null) : PlayerStatusUpdateMessage {
         this.accountId = param1;
         this.playerId = param2;
         this.status = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.accountId = 0;
         this.playerId = 0;
         this.status = new PlayerStatus();
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
         this.serializeAs_PlayerStatusUpdateMessage(param1);
      }
      
      public function serializeAs_PlayerStatusUpdateMessage(param1:IDataOutput) : void {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               param1.writeInt(this.playerId);
               param1.writeShort(this.status.getTypeId());
               this.status.serialize(param1);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PlayerStatusUpdateMessage(param1);
      }
      
      public function deserializeAs_PlayerStatusUpdateMessage(param1:IDataInput) : void {
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of PlayerStatusUpdateMessage.accountId.");
         }
         else
         {
            this.playerId = param1.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of PlayerStatusUpdateMessage.playerId.");
            }
            else
            {
               _loc2_ = param1.readUnsignedShort();
               this.status = ProtocolTypeManager.getInstance(PlayerStatus,_loc2_);
               this.status.deserialize(param1);
               return;
            }
         }
      }
   }
}
