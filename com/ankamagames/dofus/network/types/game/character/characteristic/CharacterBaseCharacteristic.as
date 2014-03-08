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
      
      public function initCharacterBaseCharacteristic(param1:int=0, param2:int=0, param3:int=0, param4:int=0) : CharacterBaseCharacteristic {
         this.base = param1;
         this.objectsAndMountBonus = param2;
         this.alignGiftBonus = param3;
         this.contextModif = param4;
         return this;
      }
      
      public function reset() : void {
         this.base = 0;
         this.objectsAndMountBonus = 0;
         this.alignGiftBonus = 0;
         this.contextModif = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterBaseCharacteristic(param1);
      }
      
      public function serializeAs_CharacterBaseCharacteristic(param1:IDataOutput) : void {
         param1.writeShort(this.base);
         param1.writeShort(this.objectsAndMountBonus);
         param1.writeShort(this.alignGiftBonus);
         param1.writeShort(this.contextModif);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterBaseCharacteristic(param1);
      }
      
      public function deserializeAs_CharacterBaseCharacteristic(param1:IDataInput) : void {
         this.base = param1.readShort();
         this.objectsAndMountBonus = param1.readShort();
         this.alignGiftBonus = param1.readShort();
         this.contextModif = param1.readShort();
      }
   }
}
