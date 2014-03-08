package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ExchangeStartOkMulticraftCustomerMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkMulticraftCustomerMessage() {
         super();
      }
      
      public static const protocolId:uint = 5817;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var maxCase:uint = 0;
      
      public var skillId:uint = 0;
      
      public var crafterJobLevel:uint = 0;
      
      override public function getMessageId() : uint {
         return 5817;
      }
      
      public function initExchangeStartOkMulticraftCustomerMessage(maxCase:uint=0, skillId:uint=0, crafterJobLevel:uint=0) : ExchangeStartOkMulticraftCustomerMessage {
         this.maxCase = maxCase;
         this.skillId = skillId;
         this.crafterJobLevel = crafterJobLevel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.maxCase = 0;
         this.skillId = 0;
         this.crafterJobLevel = 0;
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
         this.serializeAs_ExchangeStartOkMulticraftCustomerMessage(output);
      }
      
      public function serializeAs_ExchangeStartOkMulticraftCustomerMessage(output:IDataOutput) : void {
         if(this.maxCase < 0)
         {
            throw new Error("Forbidden value (" + this.maxCase + ") on element maxCase.");
         }
         else
         {
            output.writeByte(this.maxCase);
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            else
            {
               output.writeInt(this.skillId);
               if(this.crafterJobLevel < 0)
               {
                  throw new Error("Forbidden value (" + this.crafterJobLevel + ") on element crafterJobLevel.");
               }
               else
               {
                  output.writeByte(this.crafterJobLevel);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkMulticraftCustomerMessage(input);
      }
      
      public function deserializeAs_ExchangeStartOkMulticraftCustomerMessage(input:IDataInput) : void {
         this.maxCase = input.readByte();
         if(this.maxCase < 0)
         {
            throw new Error("Forbidden value (" + this.maxCase + ") on element of ExchangeStartOkMulticraftCustomerMessage.maxCase.");
         }
         else
         {
            this.skillId = input.readInt();
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangeStartOkMulticraftCustomerMessage.skillId.");
            }
            else
            {
               this.crafterJobLevel = input.readByte();
               if(this.crafterJobLevel < 0)
               {
                  throw new Error("Forbidden value (" + this.crafterJobLevel + ") on element of ExchangeStartOkMulticraftCustomerMessage.crafterJobLevel.");
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
