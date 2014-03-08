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
      
      public function initCharacterSpellModification(param1:uint=0, param2:uint=0, param3:CharacterBaseCharacteristic=null) : CharacterSpellModification {
         this.modificationType = param1;
         this.spellId = param2;
         this.value = param3;
         return this;
      }
      
      public function reset() : void {
         this.modificationType = 0;
         this.spellId = 0;
         this.value = new CharacterBaseCharacteristic();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterSpellModification(param1);
      }
      
      public function serializeAs_CharacterSpellModification(param1:IDataOutput) : void {
         param1.writeByte(this.modificationType);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            param1.writeShort(this.spellId);
            this.value.serializeAs_CharacterBaseCharacteristic(param1);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterSpellModification(param1);
      }
      
      public function deserializeAs_CharacterSpellModification(param1:IDataInput) : void {
         this.modificationType = param1.readByte();
         if(this.modificationType < 0)
         {
            throw new Error("Forbidden value (" + this.modificationType + ") on element of CharacterSpellModification.modificationType.");
         }
         else
         {
            this.spellId = param1.readShort();
            if(this.spellId < 0)
            {
               throw new Error("Forbidden value (" + this.spellId + ") on element of CharacterSpellModification.spellId.");
            }
            else
            {
               this.value = new CharacterBaseCharacteristic();
               this.value.deserialize(param1);
               return;
            }
         }
      }
   }
}
