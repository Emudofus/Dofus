package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidHousePriceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeBidHousePriceMessage() {
         super();
      }
      
      public static const protocolId:uint = 5805;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var genId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5805;
      }
      
      public function initExchangeBidHousePriceMessage(param1:uint=0) : ExchangeBidHousePriceMessage {
         this.genId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.genId = 0;
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
         this.serializeAs_ExchangeBidHousePriceMessage(param1);
      }
      
      public function serializeAs_ExchangeBidHousePriceMessage(param1:IDataOutput) : void {
         if(this.genId < 0)
         {
            throw new Error("Forbidden value (" + this.genId + ") on element genId.");
         }
         else
         {
            param1.writeInt(this.genId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeBidHousePriceMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidHousePriceMessage(param1:IDataInput) : void {
         this.genId = param1.readInt();
         if(this.genId < 0)
         {
            throw new Error("Forbidden value (" + this.genId + ") on element of ExchangeBidHousePriceMessage.genId.");
         }
         else
         {
            return;
         }
      }
   }
}
