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
      
      public function initFightEntityDispositionInformations(param1:int=0, param2:uint=1, param3:int=0) : FightEntityDispositionInformations {
         super.initEntityDispositionInformations(param1,param2);
         this.carryingCharacterId = param3;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.carryingCharacterId = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightEntityDispositionInformations(param1);
      }
      
      public function serializeAs_FightEntityDispositionInformations(param1:IDataOutput) : void {
         super.serializeAs_EntityDispositionInformations(param1);
         param1.writeInt(this.carryingCharacterId);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightEntityDispositionInformations(param1);
      }
      
      public function deserializeAs_FightEntityDispositionInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.carryingCharacterId = param1.readInt();
      }
   }
}
