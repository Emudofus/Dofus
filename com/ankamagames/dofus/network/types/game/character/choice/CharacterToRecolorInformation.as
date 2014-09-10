package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterToRecolorInformation extends AbstractCharacterToRefurbishInformation implements INetworkType
   {
      
      public function CharacterToRecolorInformation() {
         super();
      }
      
      public static const protocolId:uint = 212;
      
      override public function getTypeId() : uint {
         return 212;
      }
      
      public function initCharacterToRecolorInformation(id:uint = 0, colors:Vector.<int> = null, cosmeticId:uint = 0) : CharacterToRecolorInformation {
         super.initAbstractCharacterToRefurbishInformation(id,colors,cosmeticId);
         return this;
      }
      
      override public function reset() : void {
         super.reset();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterToRecolorInformation(output);
      }
      
      public function serializeAs_CharacterToRecolorInformation(output:IDataOutput) : void {
         super.serializeAs_AbstractCharacterToRefurbishInformation(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterToRecolorInformation(input);
      }
      
      public function deserializeAs_CharacterToRecolorInformation(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
