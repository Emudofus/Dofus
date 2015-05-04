package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeStartOkMulticraftCrafterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeStartOkMulticraftCrafterMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5818;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var maxCase:uint = 0;
      
      public var skillId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5818;
      }
      
      public function initExchangeStartOkMulticraftCrafterMessage(param1:uint = 0, param2:uint = 0) : ExchangeStartOkMulticraftCrafterMessage
      {
         this.maxCase = param1;
         this.skillId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.maxCase = 0;
         this.skillId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ExchangeStartOkMulticraftCrafterMessage(param1);
      }
      
      public function serializeAs_ExchangeStartOkMulticraftCrafterMessage(param1:ICustomDataOutput) : void
      {
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
               param1.writeVarInt(this.skillId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeStartOkMulticraftCrafterMessage(param1);
      }
      
      public function deserializeAs_ExchangeStartOkMulticraftCrafterMessage(param1:ICustomDataInput) : void
      {
         this.maxCase = param1.readByte();
         if(this.maxCase < 0)
         {
            throw new Error("Forbidden value (" + this.maxCase + ") on element of ExchangeStartOkMulticraftCrafterMessage.maxCase.");
         }
         else
         {
            this.skillId = param1.readVarUhInt();
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element of ExchangeStartOkMulticraftCrafterMessage.skillId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
