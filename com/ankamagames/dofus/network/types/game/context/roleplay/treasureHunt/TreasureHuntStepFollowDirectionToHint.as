package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TreasureHuntStepFollowDirectionToHint extends TreasureHuntStep implements INetworkType
   {
      
      public function TreasureHuntStepFollowDirectionToHint()
      {
         super();
      }
      
      public static const protocolId:uint = 472;
      
      public var direction:uint = 1;
      
      public var npcId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 472;
      }
      
      public function initTreasureHuntStepFollowDirectionToHint(param1:uint = 1, param2:uint = 0) : TreasureHuntStepFollowDirectionToHint
      {
         this.direction = param1;
         this.npcId = param2;
         return this;
      }
      
      override public function reset() : void
      {
         this.direction = 1;
         this.npcId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_TreasureHuntStepFollowDirectionToHint(param1);
      }
      
      public function serializeAs_TreasureHuntStepFollowDirectionToHint(param1:ICustomDataOutput) : void
      {
         super.serializeAs_TreasureHuntStep(param1);
         param1.writeByte(this.direction);
         if(this.npcId < 0)
         {
            throw new Error("Forbidden value (" + this.npcId + ") on element npcId.");
         }
         else
         {
            param1.writeVarShort(this.npcId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntStepFollowDirectionToHint(param1);
      }
      
      public function deserializeAs_TreasureHuntStepFollowDirectionToHint(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.direction = param1.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of TreasureHuntStepFollowDirectionToHint.direction.");
         }
         else
         {
            this.npcId = param1.readVarUhShort();
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
