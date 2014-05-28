package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   
   public class SpellDamageInfo extends Object
   {
      
      public function SpellDamageInfo() {
         super();
      }
      
      protected static const _log:Logger;
      
      public static function fromCurrentPlayer(pSpell:Object, pTargetId:int) : SpellDamageInfo {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private static function applyBuffModification(pSpellInfo:SpellDamageInfo, pBuffActionId:int, pModif:int) : void {
         switch(pBuffActionId)
         {
            case 118:
               pSpellInfo.casterStrength = pSpellInfo.casterStrength + pModif;
               break;
            case 119:
               pSpellInfo.casterAgility = pSpellInfo.casterAgility + pModif;
               break;
            case 123:
               pSpellInfo.casterChance = pSpellInfo.casterChance + pModif;
               break;
            case 126:
               pSpellInfo.casterIntelligence = pSpellInfo.casterIntelligence + pModif;
               break;
            case 414:
               pSpellInfo.casterPushDamageBonus = pSpellInfo.casterPushDamageBonus + pModif;
               break;
         }
      }
      
      private static function groupBuffsBySpell(pBuffs:Array) : Dictionary {
         var spellBuffs:Dictionary = null;
         var buff:BasicBuff = null;
         for each(buff in pBuffs)
         {
            if(!spellBuffs)
            {
               spellBuffs = new Dictionary();
            }
            if(!spellBuffs[buff.castingSpell.spell.id])
            {
               spellBuffs[buff.castingSpell.spell.id] = new Vector.<BasicBuff>(0);
            }
            spellBuffs[buff.castingSpell.spell.id].push(buff);
         }
         return spellBuffs;
      }
      
      private static function getMinimumDamageEffectOrder(pCasterId:int, pTargetId:int, pEffects:Vector.<EffectInstance>) : int {
         var effi:EffectInstance = null;
         var minOrder:int = -1;
         for each(effi in pEffects)
         {
            if(((effi.category == 2) || (!(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1)) || (effi.effectId == 5)) && (DamageUtil.verifySpellEffectMask(pCasterId,pTargetId,effi)))
            {
               if(minOrder == -1)
               {
                  minOrder = effi.order;
               }
               else
               {
                  minOrder = effi.order < minOrder?effi.order:minOrder;
               }
            }
         }
         return minOrder;
      }
      
      private var _targetId:int;
      
      private var _targetInfos:GameFightFighterInformations;
      
      private var _originalTargetsIds:Vector.<int>;
      
      private var _buffsWithSpellsTriggered:Vector.<uint>;
      
      private var _effectsModifications:Vector.<EffectModification>;
      
      private var _criticalEffectsModifications:Vector.<EffectModification>;
      
      public var isWeapon:Boolean;
      
      public var isHealingSpell:Boolean;
      
      public var casterId:int;
      
      public var casterLevel:int;
      
      public var casterStrength:int;
      
      public var casterChance:int;
      
      public var casterAgility:int;
      
      public var casterIntelligence:int;
      
      public var casterStrengthBonus:int;
      
      public var casterChanceBonus:int;
      
      public var casterAgilityBonus:int;
      
      public var casterIntelligenceBonus:int;
      
      public var casterCriticalStrengthBonus:int;
      
      public var casterCriticalChanceBonus:int;
      
      public var casterCriticalAgilityBonus:int;
      
      public var casterCriticalIntelligenceBonus:int;
      
      public var casterCriticalHit:int;
      
      public var casterCriticalHitWeapon:int;
      
      public var casterHealBonus:int;
      
      public var casterAllDamagesBonus:int;
      
      public var casterDamagesBonus:int;
      
      public var casterSpellDamagesBonus:int;
      
      public var casterWeaponDamagesBonus:int;
      
      public var casterTrapBonus:int;
      
      public var casterTrapBonusPercent:int;
      
      public var casterGlyphBonusPercent:int;
      
      public var casterPermanentDamagePercent:int;
      
      public var casterPushDamageBonus:int;
      
      public var casterCriticalDamageBonus:int;
      
      public var casterNeutralDamageBonus:int;
      
      public var casterEarthDamageBonus:int;
      
      public var casterWaterDamageBonus:int;
      
      public var casterAirDamageBonus:int;
      
      public var casterFireDamageBonus:int;
      
      public var casterDamageBoostPercent:int;
      
      public var casterDamageDeboostPercent:int;
      
      public var spellEffects:Vector.<EffectInstance>;
      
      public var spellCriticalEffects:Vector.<EffectInstance>;
      
      public var spellCenterCell:int;
      
      public var neutralDamage:SpellDamage;
      
      public var earthDamage:SpellDamage;
      
      public var fireDamage:SpellDamage;
      
      public var waterDamage:SpellDamage;
      
      public var airDamage:SpellDamage;
      
      public var spellWeaponCriticalBonus:int;
      
      public var spellShape:uint;
      
      public var spellShapeSize:Object;
      
      public var spellShapeMinSize:Object;
      
      public var spellShapeEfficiencyPercent:Object;
      
      public var spellShapeMaxEfficiency:Object;
      
      public var healDamage:SpellDamage;
      
      public var spellHasCriticalDamage:Boolean;
      
      public var spellHasCriticalHeal:Boolean;
      
      public var spellHasRandomEffects:Boolean;
      
      public var targetLevel:int;
      
      public var targetIsInvulnerable:Boolean;
      
      public var targetIsUnhealable:Boolean;
      
      public var targetCell:int = -1;
      
      public var targetShieldPoints:uint;
      
      public var targetTriggeredShieldPoints:uint;
      
      public var targetNeutralElementResistPercent:int;
      
      public var targetEarthElementResistPercent:int;
      
      public var targetWaterElementResistPercent:int;
      
      public var targetAirElementResistPercent:int;
      
      public var targetFireElementResistPercent:int;
      
      public var targetBuffs:Array;
      
      public var targetStates:Array;
      
      public var targetNeutralElementReduction:int;
      
      public var targetEarthElementReduction:int;
      
      public var targetWaterElementReduction:int;
      
      public var targetAirElementReduction:int;
      
      public var targetFireElementReduction:int;
      
      public var targetCriticalDamageFixedResist:int;
      
      public var targetPushDamageFixedResist:int;
      
      public var targetErosionLifePoints:int;
      
      public var targetSpellMinErosionLifePoints:int;
      
      public var targetSpellMaxErosionLifePoints:int;
      
      public var targetSpellMinCriticalErosionLifePoints:int;
      
      public var targetSpellMaxCriticalErosionLifePoints:int;
      
      public var targetErosionPercentBonus:int;
      
      public var pushedEntities:Vector.<PushedEntity>;
      
      public var splashDamages:Vector.<SplashDamage>;
      
      public var sharedDamage:SpellDamage;
      
      public var damageSharingTargets:Vector.<int>;
      
      public function getEffectModification(pEffectId:int, pEffectOrder:int, pHasCritical:Boolean) : EffectModification {
         var i:* = 0;
         var numEffectsModifications:int = this._effectsModifications?this._effectsModifications.length:0;
         var numCriticalEffectsModifications:int = this._criticalEffectsModifications?this._criticalEffectsModifications.length:0;
         var remainingEffects:int = pEffectOrder;
         if((!pHasCritical) && (this._effectsModifications))
         {
            i = 0;
            while(i < numEffectsModifications)
            {
               if(this._effectsModifications[i].effectId == pEffectId)
               {
                  if(remainingEffects == 0)
                  {
                     return this._effectsModifications[i];
                  }
                  remainingEffects--;
               }
               i++;
            }
         }
         else if(this._criticalEffectsModifications)
         {
            i = 0;
            while(i < numCriticalEffectsModifications)
            {
               if(this._criticalEffectsModifications[i].effectId == pEffectId)
               {
                  if(remainingEffects == 0)
                  {
                     return this._criticalEffectsModifications[i];
                  }
                  remainingEffects--;
               }
               i++;
            }
         }
         
         return null;
      }
      
      public function get targetId() : int {
         return this._targetId;
      }
      
      public function set targetId(pTargetId:int) : void {
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!fightContextFrame)
         {
            return;
         }
         this._targetId = pTargetId;
         this.targetLevel = fightContextFrame.getFighterLevel(this._targetId);
         this._targetInfos = fightContextFrame.entitiesFrame.getEntityInfos(this._targetId) as GameFightFighterInformations;
         if(this.targetInfos)
         {
            this.targetShieldPoints = this.targetInfos.stats.shieldPoints;
            this.targetNeutralElementResistPercent = this.targetInfos.stats.neutralElementResistPercent;
            this.targetEarthElementResistPercent = this.targetInfos.stats.earthElementResistPercent;
            this.targetWaterElementResistPercent = this.targetInfos.stats.waterElementResistPercent;
            this.targetAirElementResistPercent = this.targetInfos.stats.airElementResistPercent;
            this.targetFireElementResistPercent = this.targetInfos.stats.fireElementResistPercent;
            this.targetNeutralElementReduction = this.targetInfos.stats.neutralElementReduction;
            this.targetEarthElementReduction = this.targetInfos.stats.earthElementReduction;
            this.targetWaterElementReduction = this.targetInfos.stats.waterElementReduction;
            this.targetAirElementReduction = this.targetInfos.stats.airElementReduction;
            this.targetFireElementReduction = this.targetInfos.stats.fireElementReduction;
            this.targetCriticalDamageFixedResist = this.targetInfos.stats.criticalDamageFixedResist;
            this.targetPushDamageFixedResist = this.targetInfos.stats.pushDamageFixedResist;
            this.targetErosionLifePoints = this.targetInfos.stats.baseMaxLifePoints - this.targetInfos.stats.maxLifePoints;
            this.targetCell = this.targetInfos.disposition.cellId;
         }
         this.targetBuffs = BuffManager.getInstance().getAllBuff(this._targetId);
         this.targetIsInvulnerable = false;
         this.targetIsUnhealable = false;
         this.targetStates = FightersStateManager.getInstance().getStates(pTargetId);
         if(this.targetStates)
         {
            this.targetIsInvulnerable = !(this.targetStates.indexOf(56) == -1);
            this.targetIsUnhealable = !(this.targetStates.indexOf(76) == -1);
         }
      }
      
      public function get targetInfos() : GameFightFighterInformations {
         return this._targetInfos;
      }
      
      public function get originalTargetsIds() : Vector.<int> {
         return this._originalTargetsIds;
      }
      
      public function get triggeredSpellsByCasterOnTarget() : Vector.<TriggeredSpell> {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function get targetTriggeredSpells() : Vector.<TriggeredSpell> {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function addTriggeredSpellsEffects(pTriggeredSpells:Vector.<TriggeredSpell>) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function getDamageSharingTargets() : Vector.<int> {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
