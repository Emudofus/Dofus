package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.AbstractCharacterInformation;
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterToRelookInformation extends AbstractCharacterInformation implements INetworkType
   {
      
      public function CharacterToRelookInformation() {
         super();
      }
      
      public static const protocolId:uint = 399;
      
      public var cosmeticId:uint = 0;
      
      override public function getTypeId() : uint {
         return 399;
      }
      
      public function initCharacterToRelookInformation(id:uint = 0, cosmeticId:uint = 0) : CharacterToRelookInformation {
         super.initAbstractCharacterInformation(id);
         this.cosmeticId = cosmeticId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.cosmeticId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterToRelookInformation(output);
      }
      
      public function serializeAs_CharacterToRelookInformation(output:IDataOutput) : void {
         super.serializeAs_AbstractCharacterInformation(output);
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         else
         {
            output.writeInt(this.cosmeticId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterToRelookInformation(input);
      }
      
      public function deserializeAs_CharacterToRelookInformation(input:IDataInput) : void {
         super.deserialize(input);
         this.cosmeticId = input.readInt();
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterToRelookInformation.cosmeticId.");
         }
         else
         {
            return;
         }
      }
   }
}
