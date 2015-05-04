package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterBaseCharacteristic extends Object implements INetworkType
   {
      
      public function CharacterBaseCharacteristic()
      {
         super();
      }
      
      public static const protocolId:uint = 4;
      
      public var base:int = 0;
      
      public var additionnal:int = 0;
      
      public var objectsAndMountBonus:int = 0;
      
      public var alignGiftBonus:int = 0;
      
      public var contextModif:int = 0;
      
      public function getTypeId() : uint
      {
         return 4;
      }
      
      public function initCharacterBaseCharacteristic(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0) : CharacterBaseCharacteristic
      {
         this.base = param1;
         this.additionnal = param2;
         this.objectsAndMountBonus = param3;
         this.alignGiftBonus = param4;
         this.contextModif = param5;
         return this;
      }
      
      public function reset() : void
      {
         this.base = 0;
         this.additionnal = 0;
         this.objectsAndMountBonus = 0;
         this.alignGiftBonus = 0;
         this.contextModif = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterBaseCharacteristic(param1);
      }
      
      public function serializeAs_CharacterBaseCharacteristic(param1:ICustomDataOutput) : void
      {
         param1.writeVarShort(this.base);
         param1.writeVarShort(this.additionnal);
         param1.writeVarShort(this.objectsAndMountBonus);
         param1.writeVarShort(this.alignGiftBonus);
         param1.writeVarShort(this.contextModif);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterBaseCharacteristic(param1);
      }
      
      public function deserializeAs_CharacterBaseCharacteristic(param1:ICustomDataInput) : void
      {
         this.base = param1.readVarShort();
         this.additionnal = param1.readVarShort();
         this.objectsAndMountBonus = param1.readVarShort();
         this.alignGiftBonus = param1.readVarShort();
         this.contextModif = param1.readVarShort();
      }
   }
}
