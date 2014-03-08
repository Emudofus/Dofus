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
      
      public function initExchangeStartOkMulticraftCustomerMessage(param1:uint=0, param2:uint=0, param3:uint=0) : ExchangeStartOkMulticraftCustomerMessage {
         this.maxCase = param1;
         this.skillId = param2;
         this.crafterJobLevel = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.maxCase = 0;
         this.skillId = 0;
         this.crafterJobLevel = 0;
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
         this.serializeAs_ExchangeStartOkMulticraftCustomerMessage(param1);
      }
      
      public function serializeAs_ExchangeStartOkMulticraftCustomerMessage(param1:IDataOutput) : void {
         if(this.maxCase < 0)
         {
            throw new Error("Forbidden value (" + this.maxCase + ") on element maxCase.");
         }
         else
         {
            param1.writeByte(this.maxCase);
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            else
            {
               param1.writeInt(this.skillId);
               if(this.crafterJobLevel < 0)
               {
                  throw new Error("Forbidden value (" + this.crafterJobLevel + ") on element crafterJobLevel.");
               }
               else
               {
                  param1.writeByte(this.crafterJobLevel);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ExchangeStartOkMulticraftCustomerMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartOkMulticraftCustomerMessage(param1:IDataInput) : void {
         this.maxCase = param1.readByte();
         if(this.maxCase < 0)
         {
            throw new Error("Forbidden value (" + this.maxCase + ") on element of ExchangeStartOkMulticraftCustomerMessage.maxCase.");
         }
         else
         {
            this.skillId = param1.readInt();
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangeStartOkMulticraftCustomerMessage.skillId.");
            }
            else
            {
               this.crafterJobLevel = param1.readByte();
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
