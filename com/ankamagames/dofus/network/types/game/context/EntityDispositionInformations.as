package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class EntityDispositionInformations extends Object implements INetworkType
   {
      
      public function EntityDispositionInformations() {
         super();
      }
      
      public static const protocolId:uint = 60;
      
      public var cellId:int = 0;
      
      public var direction:uint = 1;
      
      public function getTypeId() : uint {
         return 60;
      }
      
      public function initEntityDispositionInformations(cellId:int=0, direction:uint=1) : EntityDispositionInformations {
         this.cellId = cellId;
         this.direction = direction;
         return this;
      }
      
      public function reset() : void {
         this.cellId = 0;
         this.direction = 1;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_EntityDispositionInformations(output);
      }
      
      public function serializeAs_EntityDispositionInformations(output:IDataOutput) : void {
         if((this.cellId < -1) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            output.writeShort(this.cellId);
            output.writeByte(this.direction);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_EntityDispositionInformations(input);
      }
      
      public function deserializeAs_EntityDispositionInformations(input:IDataInput) : void {
         this.cellId = input.readShort();
         if((this.cellId < -1) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of EntityDispositionInformations.cellId.");
         }
         else
         {
            this.direction = input.readByte();
            if(this.direction < 0)
            {
               throw new Error("Forbidden value (" + this.direction + ") on element of EntityDispositionInformations.direction.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
