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
      
      public function serialize(param1:IDataOutput) : void {
      }
      
      public function serializeAs_FightResultAdditionalData(param1:IDataOutput) : void {
      }
      
      public function deserialize(param1:IDataInput) : void {
      }
      
      public function deserializeAs_FightResultAdditionalData(param1:IDataInput) : void {
      }
   }
}
