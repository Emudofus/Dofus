package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidPriceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidPriceMessage() {
         super();
      }
      
      public static const protocolId:uint = 5755;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var genericId:uint = 0;
      
      public var averagePrice:int = 0;
      
      override public function getMessageId() : uint {
         return 5755;
      }
      
      public function initExchangeBidPriceMessage(param1:uint=0, param2:int=0) : ExchangeBidPriceMessage {
         this.genericId = param1;
         this.averagePrice = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.genericId = 0;
         this.averagePrice = 0;
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
         this.serializeAs_ExchangeBidPriceMessage(param1);
      }
      
      public function serializeAs_ExchangeBidPriceMessage(param1:IDataOutput) : void {
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element genericId.");
         }
         else
         {
            param1.writeInt(this.genericId);
            param1.writeInt(this.averagePrice);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeBidPriceMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidPriceMessage(param1:IDataInput) : void {
         this.genericId = param1.readInt();
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element of ExchangeBidPriceMessage.genericId.");
         }
         else
         {
            this.averagePrice = param1.readInt();
            return;
         }
      }
   }
}
