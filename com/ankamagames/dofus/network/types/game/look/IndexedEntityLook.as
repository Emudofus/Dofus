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
      
      public function initIndexedEntityLook(look:EntityLook = null, index:uint = 0) : IndexedEntityLook {
         this.look = look;
         this.index = index;
         return this;
      }
      
      public function reset() : void {
         this.look = new EntityLook();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_IndexedEntityLook(output);
      }
      
      public function serializeAs_IndexedEntityLook(output:IDataOutput) : void {
         this.look.serializeAs_EntityLook(output);
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         else
         {
            output.writeByte(this.index);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IndexedEntityLook(input);
      }
      
      public function deserializeAs_IndexedEntityLook(input:IDataInput) : void {
         this.look = new EntityLook();
         this.look.deserialize(input);
         this.index = input.readByte();
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
