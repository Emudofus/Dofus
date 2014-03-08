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
      
      public function initPaddockSellBuyDialogMessage(param1:Boolean=false, param2:uint=0, param3:uint=0) : PaddockSellBuyDialogMessage {
         this.bsell = param1;
         this.ownerId = param2;
         this.price = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.bsell = false;
         this.ownerId = 0;
         this.price = 0;
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
         this.serializeAs_PaddockSellBuyDialogMessage(param1);
      }
      
      public function serializeAs_PaddockSellBuyDialogMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.bsell);
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
         }
         else
         {
            param1.writeInt(this.ownerId);
            if(this.price < 0)
            {
               throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            else
            {
               param1.writeInt(this.price);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PaddockSellBuyDialogMessage(param1);
      }
      
      public function deserializeAs_PaddockSellBuyDialogMessage(param1:IDataInput) : void {
         this.bsell = param1.readBoolean();
         this.ownerId = param1.readInt();
         if(this.ownerId < 0)
         {
            throw new Error("Forbidden value (" + this.ownerId + ") on element of PaddockSellBuyDialogMessage.ownerId.");
         }
         else
         {
            this.price = param1.readInt();
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
