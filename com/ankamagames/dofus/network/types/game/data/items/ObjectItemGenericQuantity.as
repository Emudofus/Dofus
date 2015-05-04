package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectItemGenericQuantity extends Item implements INetworkType
   {
      
      public function ObjectItemGenericQuantity()
      {
         super();
      }
      
      public static const protocolId:uint = 483;
      
      public var objectGID:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 483;
      }
      
      public function initObjectItemGenericQuantity(param1:uint = 0, param2:uint = 0) : ObjectItemGenericQuantity
      {
         this.objectGID = param1;
         this.quantity = param2;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectGID = 0;
         this.quantity = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemGenericQuantity(param1);
      }
      
      public function serializeAs_ObjectItemGenericQuantity(param1:ICustomDataOutput) : void
      {
         super.serializeAs_Item(param1);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         else
         {
            param1.writeVarShort(this.objectGID);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               param1.writeVarInt(this.quantity);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemGenericQuantity(param1);
      }
      
      public function deserializeAs_ObjectItemGenericQuantity(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.objectGID = param1.readVarUhShort();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemGenericQuantity.objectGID.");
         }
         else
         {
            this.quantity = param1.readVarUhInt();
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemGenericQuantity.quantity.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
