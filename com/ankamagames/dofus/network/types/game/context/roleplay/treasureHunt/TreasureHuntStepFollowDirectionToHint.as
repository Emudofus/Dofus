package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TreasureHuntStepFollowDirectionToHint extends TreasureHuntStep implements INetworkType
   {
      
      public function TreasureHuntStepFollowDirectionToHint() {
         super();
      }
      
      public static const protocolId:uint = 472;
      
      public var direction:uint = 1;
      
      public var npcId:uint = 0;
      
      override public function getTypeId() : uint {
         return 472;
      }
      
      public function initTreasureHuntStepFollowDirectionToHint(direction:uint = 1, npcId:uint = 0) : TreasureHuntStepFollowDirectionToHint {
         this.direction = direction;
         this.npcId = npcId;
         return this;
      }
      
      override public function reset() : void {
         this.direction = 1;
         this.npcId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_TreasureHuntStepFollowDirectionToHint(output);
      }
      
      public function serializeAs_TreasureHuntStepFollowDirectionToHint(output:IDataOutput) : void {
         super.serializeAs_TreasureHuntStep(output);
         output.writeByte(this.direction);
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element npcId.");
         }
         else
         {
            output.writeShort(this.npcId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TreasureHuntStepFollowDirectionToHint(input);
      }
      
      public function deserializeAs_TreasureHuntStepFollowDirectionToHint(input:IDataInput) : void {
         super.deserialize(input);
         this.direction = input.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of TreasureHuntStepFollowDirectionToHint.direction.");
         }
         else
         {
            this.npcId = input.readShort();
            if(this.npcId < 0)
            {
               throw new Error("Forbidden value (" + this.npcId + ") on element of TreasureHuntStepFollowDirectionToHint.npcId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
