package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TreasureHuntStepDig extends TreasureHuntStep implements INetworkType
   {
      
      public function TreasureHuntStepDig()
      {
         super();
      }
      
      public static const protocolId:uint = 465;
      
      override public function getTypeId() : uint
      {
         return 465;
      }
      
      public function initTreasureHuntStepDig() : TreasureHuntStepDig
      {
         return this;
      }
      
      override public function reset() : void
      {
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
      }
      
      public function serializeAs_TreasureHuntStepDig(param1:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_TreasureHuntStepDig(param1:ICustomDataInput) : void
      {
      }
   }
}
