package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseGuildNoneMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseGuildNoneMessage() {
         super();
      }
      
      public static const protocolId:uint = 5701;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var houseId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5701;
      }
      
      public function initHouseGuildNoneMessage(houseId:uint = 0) : HouseGuildNoneMessage {
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
         this.serializeAs_HouseGuildNoneMessage(output);
      }
      
      public function serializeAs_HouseGuildNoneMessage(output:IDataOutput) : void {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         else
         {
            output.writeShort(this.houseId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseGuildNoneMessage(input);
      }
      
      public function deserializeAs_HouseGuildNoneMessage(input:IDataInput) : void {
         this.houseId = input.readShort();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HouseGuildNoneMessage.houseId.");
         }
         else
         {
            return;
         }
      }
   }
}
