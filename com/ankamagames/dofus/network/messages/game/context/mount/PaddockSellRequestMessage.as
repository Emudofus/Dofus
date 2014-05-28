package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PaddockSellRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockSellRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5953;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var price:uint = 0;
      
      override public function getMessageId() : uint {
         return 5953;
      }
      
      public function initPaddockSellRequestMessage(price:uint = 0) : PaddockSellRequestMessage {
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.price = 0;
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
         this.serializeAs_PaddockSellRequestMessage(output);
      }
      
      public function serializeAs_PaddockSellRequestMessage(output:IDataOutput) : void {
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         else
         {
            output.writeInt(this.price);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockSellRequestMessage(input);
      }
      
      public function deserializeAs_PaddockSellRequestMessage(input:IDataInput) : void {
         this.price = input.readInt();
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of PaddockSellRequestMessage.price.");
         }
         else
         {
            return;
         }
      }
   }
}
