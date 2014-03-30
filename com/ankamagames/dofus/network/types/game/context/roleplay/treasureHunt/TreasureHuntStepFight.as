package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TreasureHuntStepFight extends TreasureHuntStep implements INetworkType
   {
      
      public function TreasureHuntStepFight() {
         super();
      }
      
      public static const protocolId:uint = 462;
      
      override public function getTypeId() : uint {
         return 462;
      }
      
      public function initTreasureHuntStepFight() : TreasureHuntStepFight {
         return this;
      }
      
      override public function reset() : void {
      }
      
      override public function serialize(output:IDataOutput) : void {
      }
      
      public function serializeAs_TreasureHuntStepFight(output:IDataOutput) : void {
      }
      
      override public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_TreasureHuntStepFight(input:IDataInput) : void {
      }
   }
}
