package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PaddockAbandonnedInformations extends PaddockBuyableInformations implements INetworkType
   {
      
      public function PaddockAbandonnedInformations() {
         super();
      }
      
      public static const protocolId:uint = 133;
      
      public var guildId:int = 0;
      
      override public function getTypeId() : uint {
         return 133;
      }
      
      public function initPaddockAbandonnedInformations(param1:uint=0, param2:uint=0, param3:uint=0, param4:Boolean=false, param5:int=0) : PaddockAbandonnedInformations {
         super.initPaddockBuyableInformations(param1,param2,param3,param4);
         this.guildId = param5;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guildId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PaddockAbandonnedInformations(param1);
      }
      
      public function serializeAs_PaddockAbandonnedInformations(param1:IDataOutput) : void {
         super.serializeAs_PaddockBuyableInformations(param1);
         param1.writeInt(this.guildId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PaddockAbandonnedInformations(param1);
      }
      
      public function deserializeAs_PaddockAbandonnedInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.guildId = param1.readInt();
      }
   }
}
