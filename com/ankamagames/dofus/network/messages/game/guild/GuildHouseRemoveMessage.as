package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildHouseRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildHouseRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 6180;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6180;
      }
      
      public function initGuildHouseRemoveMessage(houseId:uint=0) : GuildHouseRemoveMessage {
         this.houseId = houseId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.houseId = 0;
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
         this.serializeAs_GuildHouseRemoveMessage(output);
      }
      
      public function serializeAs_GuildHouseRemoveMessage(output:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            output.writeInt(this.houseId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildHouseRemoveMessage(input);
      }
      
      public function deserializeAs_GuildHouseRemoveMessage(input:IDataInput) : void {
         this.houseId = input.readInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of GuildHouseRemoveMessage.houseId.");
         }
         else
         {
            return;
         }
      }
   }
}
