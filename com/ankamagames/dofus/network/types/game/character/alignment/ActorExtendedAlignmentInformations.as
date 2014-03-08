package com.ankamagames.dofus.network.types.game.character.alignment
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ActorExtendedAlignmentInformations extends ActorAlignmentInformations implements INetworkType
   {
      
      public function ActorExtendedAlignmentInformations() {
         super();
      }
      
      public static const protocolId:uint = 202;
      
      public var honor:uint = 0;
      
      public var honorGradeFloor:uint = 0;
      
      public var honorNextGradeFloor:uint = 0;
      
      public var aggressable:uint = 0;
      
      override public function getTypeId() : uint {
         return 202;
      }
      
      public function initActorExtendedAlignmentInformations(param1:int=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0, param7:uint=0, param8:uint=0) : ActorExtendedAlignmentInformations {
         super.initActorAlignmentInformations(param1,param2,param3,param4);
         this.honor = param5;
         this.honorGradeFloor = param6;
         this.honorNextGradeFloor = param7;
         this.aggressable = param8;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.honor = 0;
         this.honorGradeFloor = 0;
         this.honorNextGradeFloor = 0;
         this.aggressable = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ActorExtendedAlignmentInformations(param1);
      }
      
      public function serializeAs_ActorExtendedAlignmentInformations(param1:IDataOutput) : void {
         super.serializeAs_ActorAlignmentInformations(param1);
         if(this.honor < 0 || this.honor > 20000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element honor.");
         }
         else
         {
            param1.writeShort(this.honor);
            if(this.honorGradeFloor < 0 || this.honorGradeFloor > 20000)
            {
               throw new Error("Forbidden value (" + this.honorGradeFloor + ") on element honorGradeFloor.");
            }
            else
            {
               param1.writeShort(this.honorGradeFloor);
               if(this.honorNextGradeFloor < 0 || this.honorNextGradeFloor > 20000)
               {
                  throw new Error("Forbidden value (" + this.honorNextGradeFloor + ") on element honorNextGradeFloor.");
               }
               else
               {
                  param1.writeShort(this.honorNextGradeFloor);
                  param1.writeByte(this.aggressable);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ActorExtendedAlignmentInformations(param1);
      }
      
      public function deserializeAs_ActorExtendedAlignmentInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.honor = param1.readUnsignedShort();
         if(this.honor < 0 || this.honor > 20000)
         {
            throw new Error("Forbidden value (" + this.honor + ") on element of ActorExtendedAlignmentInformations.honor.");
         }
         else
         {
            this.honorGradeFloor = param1.readUnsignedShort();
            if(this.honorGradeFloor < 0 || this.honorGradeFloor > 20000)
            {
               throw new Error("Forbidden value (" + this.honorGradeFloor + ") on element of ActorExtendedAlignmentInformations.honorGradeFloor.");
            }
            else
            {
               this.honorNextGradeFloor = param1.readUnsignedShort();
               if(this.honorNextGradeFloor < 0 || this.honorNextGradeFloor > 20000)
               {
                  throw new Error("Forbidden value (" + this.honorNextGradeFloor + ") on element of ActorExtendedAlignmentInformations.honorNextGradeFloor.");
               }
               else
               {
                  this.aggressable = param1.readByte();
                  if(this.aggressable < 0)
                  {
                     throw new Error("Forbidden value (" + this.aggressable + ") on element of ActorExtendedAlignmentInformations.aggressable.");
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
}
