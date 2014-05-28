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
      
      public function initExchangeOkMultiCraftMessage(initiatorId:uint = 0, otherId:uint = 0, role:int = 0) : ExchangeOkMultiCraftMessage {
         this.initiatorId = initiatorId;
         this.otherId = otherId;
         this.role = role;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.initiatorId = 0;
         this.otherId = 0;
         this.role = 0;
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
         this.serializeAs_ExchangeOkMultiCraftMessage(output);
      }
      
      public function serializeAs_ExchangeOkMultiCraftMessage(output:IDataOutput) : void {
         if(this.initiatorId < 0)
         {
            throw new Error("Forbidden value (" + this.initiatorId + ") on element initiatorId.");
         }
         else
         {
            output.writeInt(this.initiatorId);
            if(this.otherId < 0)
            {
               throw new Error("Forbidden value (" + this.otherId + ") on element otherId.");
            }
            else
            {
               output.writeInt(this.otherId);
               output.writeByte(this.role);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeOkMultiCraftMessage(input);
      }
      
      public function deserializeAs_ExchangeOkMultiCraftMessage(input:IDataInput) : void {
         this.initiatorId = input.readInt();
         if(this.initiatorId < 0)
         {
            throw new Error("Forbidden value (" + this.initiatorId + ") on element of ExchangeOkMultiCraftMessage.initiatorId.");
         }
         else
         {
            this.otherId = input.readInt();
            if(this.otherId < 0)
            {
               throw new Error("Forbidden value (" + this.otherId + ") on element of ExchangeOkMultiCraftMessage.otherId.");
            }
            else
            {
               this.role = input.readByte();
               return;
            }
         }
      }
   }
}
