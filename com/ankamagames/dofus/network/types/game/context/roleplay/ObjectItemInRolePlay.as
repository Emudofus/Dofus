package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectItemInRolePlay extends Object implements INetworkType
   {
      
      public function ObjectItemInRolePlay() {
         super();
      }
      
      public static const protocolId:uint = 198;
      
      public var cellId:uint = 0;
      
      public var objectGID:uint = 0;
      
      public function getTypeId() : uint {
         return 198;
      }
      
      public function initObjectItemInRolePlay(cellId:uint=0, objectGID:uint=0) : ObjectItemInRolePlay {
         this.cellId = cellId;
         this.objectGID = objectGID;
         return this;
      }
      
      public function reset() : void {
         this.cellId = 0;
         this.objectGID = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemInRolePlay(output);
      }
      
      public function serializeAs_ObjectItemInRolePlay(output:IDataOutput) : void {
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            output.writeShort(this.cellId);
            if(this.objectGID < 0)
            {
               throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
            }
            else
            {
               output.writeShort(this.objectGID);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemInRolePlay(input);
      }
      
      public function deserializeAs_ObjectItemInRolePlay(input:IDataInput) : void {
         this.cellId = input.readShort();
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of ObjectItemInRolePlay.cellId.");
         }
         else
         {
            this.objectGID = input.readShort();
            if(this.objectGID < 0)
            {
               throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemInRolePlay.objectGID.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
