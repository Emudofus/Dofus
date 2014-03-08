package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   
   public interface ISpellCastProvider
   {
      
      function get castingSpell() : CastingSpell;
      
      function get stepsBuffer() : Vector.<ISequencable>;
   }
}
