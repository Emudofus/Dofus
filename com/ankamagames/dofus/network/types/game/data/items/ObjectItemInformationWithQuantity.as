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
      
      public function initObjectItemInformationWithQuantity(param1:uint=0, param2:Vector.<ObjectEffect>=null, param3:uint=0) : ObjectItemInformationWithQuantity {
         super.initObjectItemMinimalInformation(param1,param2);
         this.quantity = param3;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.quantity = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ObjectItemInformationWithQuantity(param1);
      }
      
      public function serializeAs_ObjectItemInformationWithQuantity(param1:IDataOutput) : void {
         super.serializeAs_ObjectItemMinimalInformation(param1);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         else
         {
            param1.writeInt(this.quantity);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectItemInformationWithQuantity(param1);
      }
      
      public function deserializeAs_ObjectItemInformationWithQuantity(param1:IDataInput) : void {
         super.deserialize(param1);
         this.quantity = param1.readInt();
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
