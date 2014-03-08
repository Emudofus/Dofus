package com.ankamagames.dofus.network.types.game.look
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class IndexedEntityLook extends Object implements INetworkType
   {
      
      public function IndexedEntityLook() {
         this.look = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 405;
      
      public var look:EntityLook;
      
      public var index:uint = 0;
      
      public function getTypeId() : uint {
         return 405;
      }
      
      public function initIndexedEntityLook(param1:EntityLook=null, param2:uint=0) : IndexedEntityLook {
         this.look = param1;
         this.index = param2;
         return this;
      }
      
      public function reset() : void {
         this.look = new EntityLook();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_IndexedEntityLook(param1);
      }
      
      public function serializeAs_IndexedEntityLook(param1:IDataOutput) : void {
         this.look.serializeAs_EntityLook(param1);
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         else
         {
            param1.writeByte(this.index);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IndexedEntityLook(param1);
      }
      
      public function deserializeAs_IndexedEntityLook(param1:IDataInput) : void {
         this.look = new EntityLook();
         this.look.deserialize(param1);
         this.index = param1.readByte();
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element of IndexedEntityLook.index.");
         }
         else
         {
            return;
         }
      }
   }
}
