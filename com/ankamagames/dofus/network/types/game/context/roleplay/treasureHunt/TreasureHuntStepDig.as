package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TreasureHuntStepDig extends TreasureHuntStep implements INetworkType
   {
      
      public function TreasureHuntStepDig() {
         super();
      }
      
      public static const protocolId:uint = 465;
      
      override public function getTypeId() : uint {
         return 465;
      }
      
      public function initTreasureHuntStepDig() : TreasureHuntStepDig {
         return this;
      }
      
      override public function reset() : void {
      }
      
      override public function serialize(output:IDataOutput) : void {
      }
      
      public function serializeAs_TreasureHuntStepDig(output:IDataOutput) : void {
      }
      
      override public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_TreasureHuntStepDig(input:IDataInput) : void {
      }
   }
}
