package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeBidPriceForSellerMessage extends ExchangeBidPriceMessage implements INetworkMessage
   {
      
      public function ExchangeBidPriceForSellerMessage() {
         this.minimalPrices = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6464;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var allIdentical:Boolean = false;
      
      public var minimalPrices:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6464;
      }
      
      public function initExchangeBidPriceForSellerMessage(param1:uint=0, param2:int=0, param3:Boolean=false, param4:Vector.<uint>=null) : ExchangeBidPriceForSellerMessage {
         super.initExchangeBidPriceMessage(param1,param2);
         this.allIdentical = param3;
         this.minimalPrices = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.allIdentical = false;
         this.minimalPrices = new Vector.<uint>();
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ExchangeBidPriceForSellerMessage(param1);
      }
      
      public function serializeAs_ExchangeBidPriceForSellerMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeBidPriceMessage(param1);
         param1.writeBoolean(this.allIdentical);
         param1.writeShort(this.minimalPrices.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.minimalPrices.length)
         {
            if(this.minimalPrices[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.minimalPrices[_loc2_] + ") on element 2 (starting at 1) of minimalPrices.");
            }
            else
            {
               param1.writeInt(this.minimalPrices[_loc2_]);
               _loc2_++;
               continue;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeBidPriceForSellerMessage(param1);
      }
      
      public function deserializeAs_ExchangeBidPriceForSellerMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         super.deserialize(param1);
         this.allIdentical = param1.readBoolean();
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInt();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of minimalPrices.");
            }
            else
            {
               this.minimalPrices.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
      }
   }
}
