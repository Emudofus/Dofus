package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectFoundWhileRecoltingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ObjectFoundWhileRecoltingMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6017;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var genericId:uint = 0;
      
      public var quantity:uint = 0;
      
      public var resourceGenericId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6017;
      }
      
      public function initObjectFoundWhileRecoltingMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ObjectFoundWhileRecoltingMessage
      {
         this.genericId = param1;
         this.quantity = param2;
         this.resourceGenericId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.genericId = 0;
         this.quantity = 0;
         this.resourceGenericId = 0;
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
         this.serializeAs_ObjectFoundWhileRecoltingMessage(param1);
      }
      
      public function serializeAs_ObjectFoundWhileRecoltingMessage(param1:ICustomDataOutput) : void
      {
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element genericId.");
         }
         else
         {
            param1.writeVarShort(this.genericId);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               param1.writeVarInt(this.quantity);
               if(this.resourceGenericId < 0)
               {
                  throw new Error("Forbidden value (" + this.resourceGenericId + ") on element resourceGenericId.");
               }
               else
               {
                  param1.writeVarInt(this.resourceGenericId);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectFoundWhileRecoltingMessage(param1);
      }
      
      public function deserializeAs_ObjectFoundWhileRecoltingMessage(param1:ICustomDataInput) : void
      {
         this.genericId = param1.readVarUhShort();
         if(this.genericId < 0)
         {
            throw new Error("Forbidden value (" + this.genericId + ") on element of ObjectFoundWhileRecoltingMessage.genericId.");
         }
         else
         {
            this.quantity = param1.readVarUhInt();
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectFoundWhileRecoltingMessage.quantity.");
            }
            else
            {
               this.resourceGenericId = param1.readVarUhInt();
               if(this.resourceGenericId < 0)
               {
                  throw new Error("Forbidden value (" + this.resourceGenericId + ") on element of ObjectFoundWhileRecoltingMessage.resourceGenericId.");
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
