package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectItemInRolePlay extends Object implements INetworkType
   {
      
      public function ObjectItemInRolePlay()
      {
         super();
      }
      
      public static const protocolId:uint = 198;
      
      public var cellId:uint = 0;
      
      public var objectGID:uint = 0;
      
      public function getTypeId() : uint
      {
         return 198;
      }
      
      public function initObjectItemInRolePlay(param1:uint = 0, param2:uint = 0) : ObjectItemInRolePlay
      {
         this.cellId = param1;
         this.objectGID = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.cellId = 0;
         this.objectGID = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemInRolePlay(param1);
      }
      
      public function serializeAs_ObjectItemInRolePlay(param1:ICustomDataOutput) : void
      {
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            param1.writeVarShort(this.cellId);
            if(this.objectGID < 0)
            {
               throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
            }
            else
            {
               param1.writeVarShort(this.objectGID);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemInRolePlay(param1);
      }
      
      public function deserializeAs_ObjectItemInRolePlay(param1:ICustomDataInput) : void
      {
         this.cellId = param1.readVarUhShort();
         if(this.cellId < 0 || this.cellId > 559)
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of ObjectItemInRolePlay.cellId.");
         }
         else
         {
            this.objectGID = param1.readVarUhShort();
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
