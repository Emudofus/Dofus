package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightResultAdditionalData extends Object implements INetworkType
   {
      
      public function FightResultAdditionalData() {
         super();
      }
      
      public static const protocolId:uint = 191;
      
      public function getTypeId() : uint {
         return 191;
      }
      
      public function initFightResultAdditionalData() : FightResultAdditionalData {
         return this;
      }
      
      public function reset() : void {
      }
      
      public function serialize(output:IDataOutput) : void {
      }
      
      public function serializeAs_FightResultAdditionalData(output:IDataOutput) : void {
      }
      
      public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_FightResultAdditionalData(input:IDataInput) : void {
      }
   }
}
