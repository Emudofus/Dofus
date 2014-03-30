package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TreasureHuntStepFollowDirection extends TreasureHuntStep implements INetworkType
   {
      
      public function TreasureHuntStepFollowDirection() {
         super();
      }
      
      public static const protocolId:uint = 468;
      
      public var direction:uint = 1;
      
      public var mapCount:uint = 0;
      
      override public function getTypeId() : uint {
         return 468;
      }
      
      public function initTreasureHuntStepFollowDirection(direction:uint=1, mapCount:uint=0) : TreasureHuntStepFollowDirection {
         this.direction = direction;
         this.mapCount = mapCount;
         return this;
      }
      
      override public function reset() : void {
         this.direction = 1;
         this.mapCount = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_TreasureHuntStepFollowDirection(output);
      }
      
      public function serializeAs_TreasureHuntStepFollowDirection(output:IDataOutput) : void {
         super.serializeAs_TreasureHuntStep(output);
         output.writeByte(this.direction);
         if(this.mapCount < 0)
         {
            throw new Error("Forbidden value (" + this.mapCount + ") on element mapCount.");
         }
         else
         {
            output.writeInt(this.mapCount);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TreasureHuntStepFollowDirection(input);
      }
      
      public function deserializeAs_TreasureHuntStepFollowDirection(input:IDataInput) : void {
         super.deserialize(input);
         this.direction = input.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of TreasureHuntStepFollowDirection.direction.");
         }
         else
         {
            this.mapCount = input.readInt();
            if(this.mapCount < 0)
            {
               throw new Error("Forbidden value (" + this.mapCount + ") on element of TreasureHuntStepFollowDirection.mapCount.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
