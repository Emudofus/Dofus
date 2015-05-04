package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ExchangeOnHumanVendorRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ExchangeOnHumanVendorRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5772;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var humanVendorId:uint = 0;
      
      public var humanVendorCell:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5772;
      }
      
      public function initExchangeOnHumanVendorRequestMessage(param1:uint = 0, param2:uint = 0) : ExchangeOnHumanVendorRequestMessage
      {
         this.humanVendorId = param1;
         this.humanVendorCell = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.humanVendorId = 0;
         this.humanVendorCell = 0;
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
         this.serializeAs_ExchangeOnHumanVendorRequestMessage(param1);
      }
      
      public function serializeAs_ExchangeOnHumanVendorRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.humanVendorId < 0)
         {
            throw new Error("Forbidden value (" + this.humanVendorId + ") on element humanVendorId.");
         }
         else
         {
            param1.writeVarInt(this.humanVendorId);
            if(this.humanVendorCell < 0 || this.humanVendorCell > 559)
            {
               throw new Error("Forbidden value (" + this.humanVendorCell + ") on element humanVendorCell.");
            }
            else
            {
               param1.writeVarShort(this.humanVendorCell);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ExchangeOnHumanVendorRequestMessage(param1);
      }
      
      public function deserializeAs_ExchangeOnHumanVendorRequestMessage(param1:ICustomDataInput) : void
      {
         this.humanVendorId = param1.readVarUhInt();
         if(this.humanVendorId < 0)
         {
            throw new Error("Forbidden value (" + this.humanVendorId + ") on element of ExchangeOnHumanVendorRequestMessage.humanVendorId.");
         }
         else
         {
            this.humanVendorCell = param1.readVarUhShort();
            if(this.humanVendorCell < 0 || this.humanVendorCell > 559)
            {
               throw new Error("Forbidden value (" + this.humanVendorCell + ") on element of ExchangeOnHumanVendorRequestMessage.humanVendorCell.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
