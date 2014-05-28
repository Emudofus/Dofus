package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseTypeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseTypeMessage() {
         super();
      }
      
      public static const protocolId:uint = 5803;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      override public function getMessageId() : uint {
         return 5803;
      }
      
      public function initExchangeBidHouseTypeMessage(type:uint = 0) : ExchangeBidHouseTypeMessage {
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.type = 0;
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
         this.serializeAs_ExchangeBidHouseTypeMessage(output);
      }
      
      public function serializeAs_ExchangeBidHouseTypeMessage(output:IDataOutput) : void {
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element type.");
         }
         else
         {
            output.writeInt(this.type);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseTypeMessage(input);
      }
      
      public function deserializeAs_ExchangeBidHouseTypeMessage(input:IDataInput) : void {
         this.type = input.readInt();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of ExchangeBidHouseTypeMessage.type.");
         }
         else
         {
            return;
         }
      }
   }
}
