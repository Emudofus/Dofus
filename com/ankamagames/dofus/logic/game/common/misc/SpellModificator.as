package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   
   public final class SpellModificator extends Object
   {
      
      public function SpellModificator()
      {
         this.apCost = new CharacterBaseCharacteristic();
         this.castInterval = new CharacterBaseCharacteristic();
         this.castIntervalSet = new CharacterBaseCharacteristic();
         this.maxCastPerTurn = new CharacterBaseCharacteristic();
         this.maxCastPerTarget = new CharacterBaseCharacteristic();
         super();
      }
      
      public var apCost:CharacterBaseCharacteristic;
      
      public var castInterval:CharacterBaseCharacteristic;
      
      public var castIntervalSet:CharacterBaseCharacteristic;
      
      public var maxCastPerTurn:CharacterBaseCharacteristic;
      
      public var maxCastPerTarget:CharacterBaseCharacteristic;
      
      public function getTotalBonus(param1:CharacterBaseCharacteristic) : int
      {
         if(!param1)
         {
            return 0;
         }
         return param1.alignGiftBonus + param1.base + param1.additionnal + param1.contextModif + param1.objectsAndMountBonus;
      }
   }
}
