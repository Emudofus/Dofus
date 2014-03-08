package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   
   public class CastingSpell extends Object
   {
      
      public function CastingSpell(updateCastingId:Boolean=true) {
         super();
         if(updateCastingId)
         {
            this.castingSpellId = _unicID++;
         }
      }
      
      private static var _unicID:uint = 0;
      
      public var castingSpellId:uint;
      
      public var casterId:int;
      
      public var targetedCell:MapPoint;
      
      public var spell:Spell;
      
      public var spellRank:SpellLevel;
      
      public var markId:int;
      
      public var markType:int;
      
      public var silentCast:Boolean;
      
      public var weaponId:int = -1;
      
      public var isCriticalHit:Boolean;
      
      public var isCriticalFail:Boolean;
   }
}
