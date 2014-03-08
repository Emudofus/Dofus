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
      
      public function initPaddockAbandonnedInformations(maxOutdoorMount:uint=0, maxItems:uint=0, price:uint=0, locked:Boolean=false, guildId:int=0) : PaddockAbandonnedInformations {
         super.initPaddockBuyableInformations(maxOutdoorMount,maxItems,price,locked);
         this.guildId = guildId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guildId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PaddockAbandonnedInformations(output);
      }
      
      public function serializeAs_PaddockAbandonnedInformations(output:IDataOutput) : void {
         super.serializeAs_PaddockBuyableInformations(output);
         output.writeInt(this.guildId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockAbandonnedInformations(input);
      }
      
      public function deserializeAs_PaddockAbandonnedInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.guildId = input.readInt();
      }
   }
}
