package com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PurchasableDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PurchasableDialogMessage() {
         super();
      }
      
      public static const protocolId:uint = 5739;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var buyOrSell:Boolean = false;
      
      public var purchasableId:uint = 0;
      
      public var price:uint = 0;
      
      override public function getMessageId() : uint {
         return 5739;
      }
      
      public function initPurchasableDialogMessage(buyOrSell:Boolean = false, purchasableId:uint = 0, price:uint = 0) : PurchasableDialogMessage {
         this.buyOrSell = buyOrSell;
         this.purchasableId = purchasableId;
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.buyOrSell = false;
         this.purchasableId = 0;
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
         this.serializeAs_PurchasableDialogMessage(output);
      }
      
      public function serializeAs_PurchasableDialogMessage(output:IDataOutput) : void {
         output.writeBoolean(this.buyOrSell);
         if(this.purchasableId < 0)
         {
            throw new Error("Forbidden value (" + this.purchasableId + ") on element purchasableId.");
         }
         else
         {
            output.writeInt(this.purchasableId);
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
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PurchasableDialogMessage(input);
      }
      
      public function deserializeAs_PurchasableDialogMessage(input:IDataInput) : void {
         this.buyOrSell = input.readBoolean();
         this.purchasableId = input.readInt();
         if(this.purchasableId < 0)
         {
            throw new Error("Forbidden value (" + this.purchasableId + ") on element of PurchasableDialogMessage.purchasableId.");
         }
         else
         {
            this.price = input.readInt();
            if(this.price < 0)
            {
               throw new Error("Forbidden value (" + this.price + ") on element of PurchasableDialogMessage.price.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
