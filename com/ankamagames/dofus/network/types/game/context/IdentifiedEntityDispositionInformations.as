package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class IdentifiedEntityDispositionInformations extends EntityDispositionInformations implements INetworkType
   {
      
      public function IdentifiedEntityDispositionInformations() {
         super();
      }
      
      public static const protocolId:uint = 107;
      
      public var id:int = 0;
      
      override public function getTypeId() : uint {
         return 107;
      }
      
      public function initIdentifiedEntityDispositionInformations(cellId:int = 0, direction:uint = 1, id:int = 0) : IdentifiedEntityDispositionInformations {
         super.initEntityDispositionInformations(cellId,direction);
         this.id = id;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.id = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_IdentifiedEntityDispositionInformations(output);
      }
      
      public function serializeAs_IdentifiedEntityDispositionInformations(output:IDataOutput) : void {
         super.serializeAs_EntityDispositionInformations(output);
         output.writeInt(this.id);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IdentifiedEntityDispositionInformations(input);
      }
      
      public function deserializeAs_IdentifiedEntityDispositionInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.id = input.readInt();
      }
   }
}
