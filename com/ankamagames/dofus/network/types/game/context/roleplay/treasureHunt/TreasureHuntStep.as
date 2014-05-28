package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TreasureHuntStep extends Object implements INetworkType
   {
      
      public function TreasureHuntStep() {
         super();
      }
      
      public static const protocolId:uint = 463;
      
      public function getTypeId() : uint {
         return 463;
      }
      
      public function initTreasureHuntStep() : TreasureHuntStep {
         return this;
      }
      
      public function reset() : void {
      }
      
      public function serialize(output:IDataOutput) : void {
      }
      
      public function serializeAs_TreasureHuntStep(output:IDataOutput) : void {
      }
      
      public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_TreasureHuntStep(input:IDataInput) : void {
      }
   }
}
