package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class IdentifiedEntityDispositionInformations extends EntityDispositionInformations implements INetworkType
   {
      
      public function IdentifiedEntityDispositionInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 107;
      
      public var id:int = 0;
      
      override public function getTypeId() : uint
      {
         return 107;
      }
      
      public function initIdentifiedEntityDispositionInformations(param1:int = 0, param2:uint = 1, param3:int = 0) : IdentifiedEntityDispositionInformations
      {
         super.initEntityDispositionInformations(param1,param2);
         this.id = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.id = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_IdentifiedEntityDispositionInformations(param1);
      }
      
      public function serializeAs_IdentifiedEntityDispositionInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_EntityDispositionInformations(param1);
         param1.writeInt(this.id);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_IdentifiedEntityDispositionInformations(param1);
      }
      
      public function deserializeAs_IdentifiedEntityDispositionInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.id = param1.readInt();
      }
   }
}
