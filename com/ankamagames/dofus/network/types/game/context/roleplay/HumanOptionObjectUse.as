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
      
      public function initHumanOptionObjectUse(param1:uint=0, param2:Number=0, param3:uint=0) : HumanOptionObjectUse {
         this.delayTypeId = param1;
         this.delayEndTime = param2;
         this.objectGID = param3;
         return this;
      }
      
      override public function reset() : void {
         this.delayTypeId = 0;
         this.delayEndTime = 0;
         this.objectGID = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HumanOptionObjectUse(param1);
      }
      
      public function serializeAs_HumanOptionObjectUse(param1:IDataOutput) : void {
         super.serializeAs_HumanOption(param1);
         param1.writeByte(this.delayTypeId);
         if(this.delayEndTime < 0)
         {
            throw new Error("Forbidden value (" + this.delayEndTime + ") on element delayEndTime.");
         }
         else
         {
            param1.writeDouble(this.delayEndTime);
            if(this.objectGID < 0)
            {
               throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
            }
            else
            {
               param1.writeShort(this.objectGID);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HumanOptionObjectUse(param1);
      }
      
      public function deserializeAs_HumanOptionObjectUse(param1:IDataInput) : void {
         super.deserialize(param1);
         this.delayTypeId = param1.readByte();
         if(this.delayTypeId < 0)
         {
            throw new Error("Forbidden value (" + this.delayTypeId + ") on element of HumanOptionObjectUse.delayTypeId.");
         }
         else
         {
            this.delayEndTime = param1.readDouble();
            if(this.delayEndTime < 0)
            {
               throw new Error("Forbidden value (" + this.delayEndTime + ") on element of HumanOptionObjectUse.delayEndTime.");
            }
            else
            {
               this.objectGID = param1.readShort();
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
