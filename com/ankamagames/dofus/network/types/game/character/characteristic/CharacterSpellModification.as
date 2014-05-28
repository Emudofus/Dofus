package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterSpellModification extends Object implements INetworkType
   {
      
      public function CharacterSpellModification() {
         this.value = new CharacterBaseCharacteristic();
         super();
      }
      
      public static const protocolId:uint = 215;
      
      public var modificationType:uint = 0;
      
      public var spellId:uint = 0;
      
      public var value:CharacterBaseCharacteristic;
      
      public function getTypeId() : uint {
         return 215;
      }
      
      public function initCharacterSpellModification(modificationType:uint = 0, spellId:uint = 0, value:CharacterBaseCharacteristic = null) : CharacterSpellModification {
         this.modificationType = modificationType;
         this.spellId = spellId;
         this.value = value;
         return this;
      }
      
      public function reset() : void {
         this.modificationType = 0;
         this.spellId = 0;
         this.value = new CharacterBaseCharacteristic();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterSpellModification(output);
      }
      
      public function serializeAs_CharacterSpellModification(output:IDataOutput) : void {
         output.writeByte(this.modificationType);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            output.writeShort(this.spellId);
            this.value.serializeAs_CharacterBaseCharacteristic(output);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSpellModification(input);
      }
      
      public function deserializeAs_CharacterSpellModification(input:IDataInput) : void {
         this.modificationType = input.readByte();
         if(this.modificationType < 0)
         {
            throw new Error("Forbidden value (" + this.modificationType + ") on element of CharacterSpellModification.modificationType.");
         }
         else
         {
            this.spellId = input.readShort();
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element of CharacterSpellModification.spellId.");
            }
            else
            {
               this.value = new CharacterBaseCharacteristic();
               this.value.deserialize(input);
               return;
            }
         }
      }
   }
}
