package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PaddockSellBuyDialogMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PaddockSellBuyDialogMessage() {
         super();
      }
      
      public static const protocolId:uint = 6018;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var bsell:Boolean = false;
      
      public var ownerId:uint = 0;
      
      public var price:uint = 0;
      
      override public function getMessageId() : uint {
         return 6018;
      }
      
      public function initPaddockSellBuyDialogMessage(bsell:Boolean=false, ownerId:uint=0, price:uint=0) : PaddockSellBuyDialogMessage {
         this.bsell = bsell;
         this.ownerId = ownerId;
         this.price = price;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.bsell = false;
         this.ownerId = 0;
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
         this.serializeAs_PaddockSellBuyDialogMessage(output);
      }
      
      public function serializeAs_PaddockSellBuyDialogMessage(output:IDataOutput) : void {
         output.writeBoolean(this.bsell);
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
         }
         else
         {
            output.writeInt(this.ownerId);
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
         this.deserializeAs_PaddockSellBuyDialogMessage(input);
      }
      
      public function deserializeAs_PaddockSellBuyDialogMessage(input:IDataInput) : void {
         this.bsell = input.readBoolean();
         this.ownerId = input.readInt();
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element of PaddockSellBuyDialogMessage.ownerId.");
         }
         else
         {
            this.price = input.readInt();
            if(this.price < 0)
            {
               throw new Error("Forbidden value (" + this.price + ") on element of PaddockSellBuyDialogMessage.price.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
