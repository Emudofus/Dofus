package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterBaseCharacteristic extends Object implements INetworkType
   {
      
      public function CharacterBaseCharacteristic() {
         super();
      }
      
      public static const protocolId:uint = 4;
      
      public var base:int = 0;
      
      public var objectsAndMountBonus:int = 0;
      
      public var alignGiftBonus:int = 0;
      
      public var contextModif:int = 0;
      
      public function getTypeId() : uint {
         return 4;
      }
      
      public function initCharacterBaseCharacteristic(base:int=0, objectsAndMountBonus:int=0, alignGiftBonus:int=0, contextModif:int=0) : CharacterBaseCharacteristic {
         this.base = base;
         this.objectsAndMountBonus = objectsAndMountBonus;
         this.alignGiftBonus = alignGiftBonus;
         this.contextModif = contextModif;
         return this;
      }
      
      public function reset() : void {
         this.base = 0;
         this.objectsAndMountBonus = 0;
         this.alignGiftBonus = 0;
         this.contextModif = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterBaseCharacteristic(output);
      }
      
      public function serializeAs_CharacterBaseCharacteristic(output:IDataOutput) : void {
         output.writeShort(this.base);
         output.writeShort(this.objectsAndMountBonus);
         output.writeShort(this.alignGiftBonus);
         output.writeShort(this.contextModif);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterBaseCharacteristic(input);
      }
      
      public function deserializeAs_CharacterBaseCharacteristic(input:IDataInput) : void {
         this.base = input.readShort();
         this.objectsAndMountBonus = input.readShort();
         this.alignGiftBonus = input.readShort();
         this.contextModif = input.readShort();
      }
   }
}
