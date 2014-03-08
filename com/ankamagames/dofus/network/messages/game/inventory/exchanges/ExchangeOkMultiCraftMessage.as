package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeOkMultiCraftMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeOkMultiCraftMessage() {
         super();
      }
      
      public static const protocolId:uint = 5768;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var initiatorId:uint = 0;
      
      public var otherId:uint = 0;
      
      public var role:int = 0;
      
      override public function getMessageId() : uint {
         return 5768;
      }
      
      public function initExchangeOkMultiCraftMessage(param1:uint=0, param2:uint=0, param3:int=0) : ExchangeOkMultiCraftMessage {
         this.initiatorId = param1;
         this.otherId = param2;
         this.role = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.initiatorId = 0;
         this.otherId = 0;
         this.role = 0;
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
         this.serializeAs_ExchangeOkMultiCraftMessage(param1);
      }
      
      public function serializeAs_ExchangeOkMultiCraftMessage(param1:IDataOutput) : void {
         if(this.initiatorId < 0)
         {
            throw new Error("Forbidden value (" + this.initiatorId + ") on element initiatorId.");
         }
         else
         {
            param1.writeInt(this.initiatorId);
            if(this.otherId < 0)
            {
               throw new Error("Forbidden value (" + this.otherId + ") on element otherId.");
            }
            else
            {
               param1.writeInt(this.otherId);
               param1.writeByte(this.role);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeOkMultiCraftMessage(param1);
      }
      
      public function deserializeAs_ExchangeOkMultiCraftMessage(param1:IDataInput) : void {
         this.initiatorId = param1.readInt();
         if(this.initiatorId < 0)
         {
            throw new Error("Forbidden value (" + this.initiatorId + ") on element of ExchangeOkMultiCraftMessage.initiatorId.");
         }
         else
         {
            this.otherId = param1.readInt();
            if(this.otherId < 0)
            {
               throw new Error("Forbidden value (" + this.otherId + ") on element of ExchangeOkMultiCraftMessage.otherId.");
            }
            else
            {
               this.role = param1.readByte();
               return;
            }
         }
      }
   }
}
