package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseListMessage() {
         super();
      }
      
      public static const protocolId:uint = 5807;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      override public function getMessageId() : uint {
         return 5807;
      }
      
      public function initExchangeBidHouseListMessage(id:uint=0) : ExchangeBidHouseListMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_ExchangeBidHouseListMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseListMessage(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseListMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseListMessage(input:IDataInput) : void {
         this.id = input.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of ExchangeBidHouseListMessage.id.");
         }
         else
         {
            return;
         }
      }
   }
}
