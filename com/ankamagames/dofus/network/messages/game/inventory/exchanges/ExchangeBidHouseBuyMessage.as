package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHouseBuyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHouseBuyMessage() {
         super();
      }
      
      public static const protocolId:uint = 5804;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var uid:uint = 0;
      
      public var qty:uint = 0;
      
      public var price:uint = 0;
      
      override public function getMessageId() : uint {
         return 5804;
      }
      
      public function initExchangeBidHouseBuyMessage(param1:uint=0, param2:uint=0, param3:uint=0) : ExchangeBidHouseBuyMessage {
         this.uid = param1;
         this.qty = param2;
         this.price = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.uid = 0;
         this.qty = 0;
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
         this.serializeAs_ExchangeBidHouseBuyMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHouseBuyMessage(param1:IDataOutput) : void {
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         else
         {
            param1.writeInt(this.uid);
            if(this.qty < 0)
            {
               throw new Error("Forbidden value (" + this.qty + ") on element qty.");
            }
            else
            {
               param1.writeInt(this.qty);
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
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseBuyMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHouseBuyMessage(param1:IDataInput) : void {
         this.uid = param1.readInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of ExchangeBidHouseBuyMessage.uid.");
         }
         else
         {
            this.qty = param1.readInt();
            if(this.qty < 0)
            {
               throw new Error("Forbidden value (" + this.qty + ") on element of ExchangeBidHouseBuyMessage.qty.");
            }
            else
            {
               this.price = param1.readInt();
               if(this.price < 0)
               {
                  throw new Error("Forbidden value (" + this.price + ") on element of ExchangeBidHouseBuyMessage.price.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
