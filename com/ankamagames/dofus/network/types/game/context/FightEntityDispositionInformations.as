package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightEntityDispositionInformations extends EntityDispositionInformations implements INetworkType
   {
      
      public function FightEntityDispositionInformations() {
         super();
      }
      
      public static const protocolId:uint = 217;
      
      public var carryingCharacterId:int = 0;
      
      override public function getTypeId() : uint {
         return 217;
      }
      
      public function initFightEntityDispositionInformations(cellId:int = 0, direction:uint = 1, carryingCharacterId:int = 0) : FightEntityDispositionInformations {
         super.initEntityDispositionInformations(cellId,direction);
         this.carryingCharacterId = carryingCharacterId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.carryingCharacterId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightEntityDispositionInformations(output);
      }
      
      public function serializeAs_FightEntityDispositionInformations(output:IDataOutput) : void {
         super.serializeAs_EntityDispositionInformations(output);
         output.writeInt(this.carryingCharacterId);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightEntityDispositionInformations(input);
      }
      
      public function deserializeAs_FightEntityDispositionInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.carryingCharacterId = input.readInt();
      }
   }
}
