package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectItemQuantity extends Item implements INetworkType
   {
      
      public function ObjectItemQuantity()
      {
         super();
      }
      
      public static const protocolId:uint = 119;
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 119;
      }
      
      public function initObjectItemQuantity(param1:uint = 0, param2:uint = 0) : ObjectItemQuantity
      {
         this.objectUID = param1;
         this.quantity = param2;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectUID = 0;
         this.quantity = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemQuantity(param1);
      }
      
      public function serializeAs_ObjectItemQuantity(param1:ICustomDataOutput) : void
      {
         super.serializeAs_Item(param1);
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            param1.writeVarInt(this.objectUID);
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
         this.deserializeAs_ObjectItemQuantity(param1);
      }
      
      public function deserializeAs_ObjectItemQuantity(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.objectUID = param1.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItemQuantity.objectUID.");
         }
         else
         {
            this.quantity = param1.readVarUhInt();
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemQuantity.quantity.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
