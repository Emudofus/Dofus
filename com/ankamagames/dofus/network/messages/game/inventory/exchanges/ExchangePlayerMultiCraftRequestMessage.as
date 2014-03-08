package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangePlayerMultiCraftRequestMessage extends ExchangeRequestMessage implements INetworkMessage
   {
      
      public function ExchangePlayerMultiCraftRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5784;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var target:uint = 0;
      
      public var skillId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5784;
      }
      
      public function initExchangePlayerMultiCraftRequestMessage(param1:int=0, param2:uint=0, param3:uint=0) : ExchangePlayerMultiCraftRequestMessage {
         super.initExchangeRequestMessage(param1);
         this.target = param2;
         this.skillId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.target = 0;
         this.skillId = 0;
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
         this.serializeAs_ExchangePlayerMultiCraftRequestMessage(param1);
      }
      
      public function serializeAs_ExchangePlayerMultiCraftRequestMessage(param1:IDataOutput) : void {
         super.serializeAs_ExchangeRequestMessage(param1);
         if(this.target < 0)
         {
            throw new Error("Forbidden value (" + this.target + ") on element target.");
         }
         else
         {
            param1.writeInt(this.target);
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            else
            {
               param1.writeInt(this.skillId);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangePlayerMultiCraftRequestMessage(param1);
      }
      
      public function deserializeAs_ExchangePlayerMultiCraftRequestMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.target = param1.readInt();
         if(this.target < 0)
         {
            throw new Error("Forbidden value (" + this.target + ") on element of ExchangePlayerMultiCraftRequestMessage.target.");
         }
         else
         {
            this.skillId = param1.readInt();
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangePlayerMultiCraftRequestMessage.skillId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
