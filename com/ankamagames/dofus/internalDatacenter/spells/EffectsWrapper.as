package com.ankamagames.dofus.internalDatacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   
   public class EffectsWrapper extends Object implements IDataCenter
   {
      
      public function EffectsWrapper(param1:Array, param2:Spell, param3:String) {
         super();
         this.effects = param1;
         this.spellName = param2.name;
         this.casterName = param3;
      }
      
      public var effects:Array;
      
      public var spellName:String = "";
      
      public var casterName:String = "";
   }
}
