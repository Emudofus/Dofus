package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellBoostEffect;
   
   public class SpellBuff extends BasicBuff
   {
      
      public function SpellBuff(effect:FightTemporarySpellBoostEffect = null, castingSpell:CastingSpell = null, actionId:int = 0) {
         if(effect)
         {
            super(effect,castingSpell,actionId,effect.boostedSpellId,null,effect.delta);
            this.spellId = effect.boostedSpellId;
            this.delta = effect.delta;
         }
      }
      
      protected static const _log:Logger;
      
      public var spellId:int;
      
      public var delta:int;
      
      public var modifType:int;
      
      override public function get type() : String {
         return "SpellBuff";
      }
      
      override public function onApplyed() : void {
         var spellModifExists:* = false;
         var spellModif:CharacterSpellModification = null;
         var swsToUpdate:Array = null;
         var swToUpdate:SpellWrapper = null;
         var carac:CharacterBaseCharacteristic = null;
         var modif:CharacterSpellModification = null;
         var targetCaracs:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
         if(targetCaracs)
         {
            if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_RANGEABLE)
            {
               this.modifType = CharacterSpellModificationTypeEnum.RANGEABLE;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_DMG)
            {
               this.modifType = CharacterSpellModificationTypeEnum.DAMAGE;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_BASE_DMG)
            {
               this.modifType = CharacterSpellModificationTypeEnum.BASE_DAMAGE;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_HEAL)
            {
               this.modifType = CharacterSpellModificationTypeEnum.HEAL_BONUS;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_AP_COST)
            {
               this.modifType = CharacterSpellModificationTypeEnum.AP_COST;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL)
            {
               this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL_SET)
            {
               this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CC)
            {
               this.modifType = CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CASTOUTLINE)
            {
               this.modifType = CharacterSpellModificationTypeEnum.CAST_LINE;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_NOLINEOFSIGHT)
            {
               this.modifType = CharacterSpellModificationTypeEnum.LOS;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTURN)
            {
               this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTARGET)
            {
               this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET;
            }
            else if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_RANGE)
            {
               this.modifType = CharacterSpellModificationTypeEnum.RANGE;
            }
            else if(actionId == ActionIdConverter.ACTION_DEBOOST_SPELL_RANGE)
            {
               this.modifType = CharacterSpellModificationTypeEnum.RANGE;
               this.delta = -this.delta;
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            spellModifExists = false;
            for each(spellModif in targetCaracs.spellModifications)
            {
               if(this.spellId == spellModif.spellId)
               {
                  if(spellModif.modificationType == this.modifType)
                  {
                     spellModifExists = true;
                     spellModif.value.contextModif = spellModif.value.contextModif + this.delta;
                  }
               }
            }
            if(!spellModifExists)
            {
               carac = new CharacterBaseCharacteristic();
               carac.base = 0;
               carac.alignGiftBonus = 0;
               carac.contextModif = this.delta;
               carac.objectsAndMountBonus = 0;
               modif = new CharacterSpellModification();
               modif.modificationType = this.modifType;
               modif.spellId = this.spellId;
               modif.value = carac;
               targetCaracs.spellModifications.push(modif);
            }
            swsToUpdate = SpellWrapper.getSpellWrappersById(this.spellId,targetId);
            for each(swToUpdate in swsToUpdate)
            {
               swToUpdate = SpellWrapper.create(swToUpdate.position,swToUpdate.spellId,swToUpdate.spellLevel,true,targetId);
               swToUpdate.versionNum++;
            }
         }
         super.onApplyed();
      }
      
      override public function onRemoved() : void {
         var targetCaracs:CharacterCharacteristicsInformations = null;
         var spellModif:CharacterSpellModification = null;
         var swsToUpdate:Array = null;
         var swToUpdate:SpellWrapper = null;
         if(!_removed)
         {
            targetCaracs = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations(targetId);
            if(targetCaracs)
            {
               for each(spellModif in targetCaracs.spellModifications)
               {
                  if(this.spellId == spellModif.spellId)
                  {
                     if(spellModif.modificationType == this.modifType)
                     {
                        spellModif.value.contextModif = spellModif.value.contextModif - this.delta;
                     }
                  }
               }
               swsToUpdate = SpellWrapper.getSpellWrappersById(this.spellId,targetId);
               for each(swToUpdate in swsToUpdate)
               {
                  swToUpdate = SpellWrapper.create(swToUpdate.position,swToUpdate.spellId,swToUpdate.spellLevel,true,targetId);
                  swToUpdate.versionNum++;
               }
            }
         }
         super.onRemoved();
      }
      
      override public function clone(id:int = 0) : BasicBuff {
         var sb:SpellBuff = new SpellBuff();
         sb.spellId = this.spellId;
         sb.delta = this.delta;
         sb.id = uid;
         sb.uid = uid;
         sb.actionId = actionId;
         sb.targetId = targetId;
         sb.castingSpell = castingSpell;
         sb.duration = duration;
         sb.dispelable = dispelable;
         sb.source = source;
         sb.aliveSource = aliveSource;
         sb.parentBoostUid = parentBoostUid;
         sb.initParam(param1,param2,param3);
         return sb;
      }
   }
}
