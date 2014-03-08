package com.ankamagames.dofus.internalDatacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   
   public class EffectsWrapper extends Object implements IDataCenter
   {
      
      public function EffectsWrapper(effect:Array, spell:Spell, name:String) {
         super();
         this.effects = effect;
         this.spellName = spell.name;
         this.casterName = name;
      }
      
      public var effects:Array;
      
      public var spellName:String = "";
      
      public var casterName:String = "";
   }
}
