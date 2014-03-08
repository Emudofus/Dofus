package com.ankamagames.dofus.network.types.game.look
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class SubEntity extends Object implements INetworkType
   {
      
      public function SubEntity() {
         this.subEntityLook = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 54;
      
      public var bindingPointCategory:uint = 0;
      
      public var bindingPointIndex:uint = 0;
      
      public var subEntityLook:EntityLook;
      
      public function getTypeId() : uint {
         return 54;
      }
      
      public function initSubEntity(param1:uint=0, param2:uint=0, param3:EntityLook=null) : SubEntity {
         this.bindingPointCategory = param1;
         this.bindingPointIndex = param2;
         this.subEntityLook = param3;
         return this;
      }
      
      public function reset() : void {
         this.bindingPointCategory = 0;
         this.bindingPointIndex = 0;
         this.subEntityLook = new EntityLook();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_SubEntity(param1);
      }
      
      public function serializeAs_SubEntity(param1:IDataOutput) : void {
         param1.writeByte(this.bindingPointCategory);
         if(this.bindingPointIndex < 0)
         {
            throw new Error("Forbidden value (" + this.bindingPointIndex + ") on element bindingPointIndex.");
         }
         else
         {
            param1.writeByte(this.bindingPointIndex);
            this.subEntityLook.serializeAs_EntityLook(param1);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SubEntity(param1);
      }
      
      public function deserializeAs_SubEntity(param1:IDataInput) : void {
         this.bindingPointCategory = param1.readByte();
         if(this.bindingPointCategory < 0)
         {
            throw new Error("Forbidden value (" + this.bindingPointCategory + ") on element of SubEntity.bindingPointCategory.");
         }
         else
         {
            this.bindingPointIndex = param1.readByte();
            if(this.bindingPointIndex < 0)
            {
               throw new Error("Forbidden value (" + this.bindingPointIndex + ") on element of SubEntity.bindingPointIndex.");
            }
            else
            {
               this.subEntityLook = new EntityLook();
               this.subEntityLook.deserialize(param1);
               return;
            }
         }
      }
   }
}
