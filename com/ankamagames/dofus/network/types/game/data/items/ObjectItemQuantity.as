package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectItemQuantity extends Item implements INetworkType
   {
      
      public function ObjectItemQuantity() {
         super();
      }
      
      public static const protocolId:uint = 119;
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      override public function getTypeId() : uint {
         return 119;
      }
      
      public function initObjectItemQuantity(objectUID:uint = 0, quantity:uint = 0) : ObjectItemQuantity {
         this.objectUID = objectUID;
         this.quantity = quantity;
         return this;
      }
      
      override public function reset() : void {
         this.objectUID = 0;
         this.quantity = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemQuantity(output);
      }
      
      public function serializeAs_ObjectItemQuantity(output:IDataOutput) : void {
         super.serializeAs_Item(output);
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         else
         {
            output.writeInt(this.objectUID);
            if(this.quantity < 0)
            {
               throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            else
            {
               output.writeInt(this.quantity);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemQuantity(input);
      }
      
      public function deserializeAs_ObjectItemQuantity(input:IDataInput) : void {
         super.deserialize(input);
         this.objectUID = input.readInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItemQuantity.objectUID.");
         }
         else
         {
            this.quantity = input.readInt();
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
