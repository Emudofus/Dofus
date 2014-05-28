package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOptionObjectUse extends HumanOption implements INetworkType
   {
      
      public function HumanOptionObjectUse() {
         super();
      }
      
      public static const protocolId:uint = 449;
      
      public var delayTypeId:uint = 0;
      
      public var delayEndTime:Number = 0;
      
      public var objectGID:uint = 0;
      
      override public function getTypeId() : uint {
         return 449;
      }
      
      public function initHumanOptionObjectUse(delayTypeId:uint = 0, delayEndTime:Number = 0, objectGID:uint = 0) : HumanOptionObjectUse {
         this.delayTypeId = delayTypeId;
         this.delayEndTime = delayEndTime;
         this.objectGID = objectGID;
         return this;
      }
      
      override public function reset() : void {
         this.delayTypeId = 0;
         this.delayEndTime = 0;
         this.objectGID = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_HumanOptionObjectUse(output);
      }
      
      public function serializeAs_HumanOptionObjectUse(output:IDataOutput) : void {
         super.serializeAs_HumanOption(output);
         output.writeByte(this.delayTypeId);
         if(this.delayEndTime < 0)
         {
            throw new Error("Forbidden value (" + this.delayEndTime + ") on element delayEndTime.");
         }
         else
         {
            output.writeDouble(this.delayEndTime);
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
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HumanOptionObjectUse(input);
      }
      
      public function deserializeAs_HumanOptionObjectUse(input:IDataInput) : void {
         super.deserialize(input);
         this.delayTypeId = input.readByte();
         if(this.delayTypeId < 0)
         {
            throw new Error("Forbidden value (" + this.delayTypeId + ") on element of HumanOptionObjectUse.delayTypeId.");
         }
         else
         {
            this.delayEndTime = input.readDouble();
            if(this.delayEndTime < 0)
            {
               throw new Error("Forbidden value (" + this.delayEndTime + ") on element of HumanOptionObjectUse.delayEndTime.");
            }
            else
            {
               this.objectGID = input.readShort();
               if(this.objectGID < 0)
               {
                  throw new Error("Forbidden value (" + this.objectGID + ") on element of HumanOptionObjectUse.objectGID.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
