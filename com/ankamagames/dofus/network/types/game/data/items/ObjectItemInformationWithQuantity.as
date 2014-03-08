package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectItemInformationWithQuantity extends ObjectItemMinimalInformation implements INetworkType
   {
      
      public function ObjectItemInformationWithQuantity() {
         super();
      }
      
      public static const protocolId:uint = 387;
      
      public var quantity:uint = 0;
      
      override public function getTypeId() : uint {
         return 387;
      }
      
      public function initObjectItemInformationWithQuantity(objectGID:uint=0, effects:Vector.<ObjectEffect>=null, quantity:uint=0) : ObjectItemInformationWithQuantity {
         super.initObjectItemMinimalInformation(objectGID,effects);
         this.quantity = quantity;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.quantity = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemInformationWithQuantity(output);
      }
      
      public function serializeAs_ObjectItemInformationWithQuantity(output:IDataOutput) : void {
         super.serializeAs_ObjectItemMinimalInformation(output);
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
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemInformationWithQuantity(input);
      }
      
      public function deserializeAs_ObjectItemInformationWithQuantity(input:IDataInput) : void {
         super.deserialize(input);
         this.quantity = input.readInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemInformationWithQuantity.quantity.");
         }
         else
         {
            return;
         }
      }
   }
}
