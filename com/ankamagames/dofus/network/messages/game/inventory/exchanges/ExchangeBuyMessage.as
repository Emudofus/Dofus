package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBuyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBuyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5774;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var objectToBuyId:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getMessageId() : uint {
         return 5774;
      }
      
      public function initExchangeBuyMessage(objectToBuyId:uint = 0, quantity:uint = 0) : ExchangeBuyMessage {
         this.objectToBuyId = objectToBuyId;
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.objectToBuyId = 0;
         this.quantity = 0;
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
         this.serializeAs_ExchangeBuyMessage(output);
      }
      
      public function serializeAs_ExchangeBuyMessage(output:IDataOutput) : void {
         if(this.objectToBuyId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToBuyId + ") on element objectToBuyId.");
         }
         else
         {
            output.writeInt(this.objectToBuyId);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               output.writeInt(this.quantity);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBuyMessage(input);
      }
      
      public function deserializeAs_ExchangeBuyMessage(input:IDataInput) : void {
         this.objectToBuyId = input.readInt();
         if(this.objectToBuyId < 0)
         {
            throw new Error("Forbidden value (" + this.objectToBuyId + ") on element of ExchangeBuyMessage.objectToBuyId.");
         }
         else
         {
            this.quantity = input.readInt();
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element of ExchangeBuyMessage.quantity.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
