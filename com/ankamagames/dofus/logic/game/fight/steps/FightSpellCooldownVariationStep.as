package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastInFightManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.types.castSpellManager.SpellManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   
   public class FightSpellCooldownVariationStep extends AbstractSequencable implements IFightStep
   {
      
      public function FightSpellCooldownVariationStep(param1:int, param2:int, param3:int, param4:int) {
         super();
         this._fighterId = param1;
         this._spellId = param3;
         this._actionId = param2;
         this._value = param4;
      }
      
      private var _fighterId:int;
      
      private var _spellId:int;
      
      private var _actionId:int;
      
      private var _value:int;
      
      public function get stepType() : String {
         return "spellCooldownVariation";
      }
      
      override public function start() : void {
         var _loc1_:SpellCastInFightManager = null;
         var _loc2_:PlayedCharacterManager = null;
         var _loc3_:uint = 0;
         var _loc4_:SpellWrapper = null;
         var _loc5_:SpellManager = null;
         if(this._fighterId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            _loc1_ = CurrentPlayedFighterManager.getInstance().getSpellCastManagerById(this._fighterId);
            _loc2_ = PlayedCharacterManager.getInstance();
            for each (_loc4_ in _loc2_.spellsInventory)
            {
               if(_loc4_.id == this._spellId)
               {
                  _loc3_ = _loc4_.spellLevel;
               }
            }
            if((_loc1_) && _loc3_ > 0)
            {
               if(!_loc1_.getSpellManagerBySpellId(this._spellId))
               {
                  _loc1_.castSpell(this._spellId,_loc3_,[],false);
               }
               _loc5_ = _loc1_.getSpellManagerBySpellId(this._spellId);
               _loc5_.forceCooldown(this._value);
            }
         }
         executeCallbacks();
      }
   }
}
