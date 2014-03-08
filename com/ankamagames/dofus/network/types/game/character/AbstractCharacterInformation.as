package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AbstractCharacterInformation extends Object implements INetworkType
   {
      
      public function AbstractCharacterInformation() {
         super();
      }
      
      public static const protocolId:uint = 400;
      
      public var id:uint = 0;
      
      public function getTypeId() : uint {
         return 400;
      }
      
      public function initAbstractCharacterInformation(id:uint=0) : AbstractCharacterInformation {
         this.id = id;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AbstractCharacterInformation(output);
      }
      
      public function serializeAs_AbstractCharacterInformation(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AbstractCharacterInformation(input);
      }
      
      public function deserializeAs_AbstractCharacterInformation(input:IDataInput) : void {
         this.id = input.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AbstractCharacterInformation.id.");
         }
         else
         {
            return;
         }
      }
   }
}
