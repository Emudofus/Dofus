package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class HumanOption extends Object implements INetworkType
   {
      
      public function HumanOption() {
         super();
      }
      
      public static const protocolId:uint = 406;
      
      public function getTypeId() : uint {
         return 406;
      }
      
      public function initHumanOption() : HumanOption {
         return this;
      }
      
      public function reset() : void {
      }
      
      public function serialize(output:IDataOutput) : void {
      }
      
      public function serializeAs_HumanOption(output:IDataOutput) : void {
      }
      
      public function deserialize(input:IDataInput) : void {
      }
      
      public function deserializeAs_HumanOption(input:IDataInput) : void {
      }
   }
}
