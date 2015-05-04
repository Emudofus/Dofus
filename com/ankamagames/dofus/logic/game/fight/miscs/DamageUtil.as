package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.datacenter.spells.SpellBomb;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamageInfo;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;
   import com.ankamagames.dofus.logic.game.fight.types.EffectDamage;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.logic.game.fight.types.SplashDamage;
   import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.logic.game.fight.types.EffectModification;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.types.TriggeredSpell;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DamageUtil extends Object
   {
      
      public function DamageUtil()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DamageUtil));
      
      private static const exclusiveTargetMasks:RegExp = new RegExp("\\*?[bBeEfFzZKoOPpTWUvV][0-9]*","g");
      
      public static const NEUTRAL_ELEMENT:int = 0;
      
      public static const EARTH_ELEMENT:int = 1;
      
      public static const FIRE_ELEMENT:int = 2;
      
      public static const WATER_ELEMENT:int = 3;
      
      public static const AIR_ELEMENT:int = 4;
      
      public static const NONE_ELEMENT:int = 5;
      
      public static const EFFECTSHAPE_DEFAULT_AREA_SIZE:int = 1;
      
      public static const EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE:int = 0;
      
      public static const EFFECTSHAPE_DEFAULT_EFFICIENCY:int = 10;
      
      public static const EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY:int = 4;
      
      private static const DAMAGE_NOT_BOOSTED:int = 1;
      
      private static const UNLIMITED_ZONE_SIZE:int = 50;
      
      public static const DAMAGE_EFFECT_CATEGORY:int = 2;
      
      public static const EROSION_DAMAGE_EFFECTS_IDS:Array = [1092,1093,1094,1095,1096];
      
      public static const HEALING_EFFECTS_IDS:Array = [81,108,1109,90];
      
      public static const IMMEDIATE_BOOST_EFFECTS_IDS:Array = [266,268,269,271,414];
      
      public static const BOMB_SPELLS_IDS:Array = [2796,2797,2808];
      
      public static const SPLASH_EFFECTS_IDS:Array = [1123,1124,1125,1126,1127,1128];
      
      public static const MP_BASED_DAMAGE_EFFECTS_IDS:Array = [1012,1013,1014,1015,1016];
      
      public static const HP_BASED_DAMAGE_EFFECTS_IDS:Array = [672,85,86,87,88,89];
      
      public static const TARGET_HP_BASED_DAMAGE_EFFECTS_IDS:Array = [1067,1068,1069,1070,1071];
      
      public static const TRIGGERED_EFFECTS_IDS:Array = [138,1040];
      
      public static const NO_BOOST_EFFECTS_IDS:Array = [144,82];
      
      public static function isDamagedOrHealedBySpell(param1:int, param2:int, param3:Object, param4:int) : Boolean
      {
         var _loc10_:* = false;
         var _loc11_:EffectInstance = null;
         var _loc14_:Array = null;
         var _loc15_:BasicBuff = null;
         var _loc5_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!param3 || !_loc5_)
         {
            return false;
         }
         var _loc6_:GameFightFighterInformations = _loc5_.getEntityInfos(param2) as GameFightFighterInformations;
         if(!_loc6_)
         {
            return false;
         }
         var _loc7_:TiphonSprite = DofusEntities.getEntity(param2) as AnimatedCharacter;
         var _loc8_:* = param2 == param1;
         var _loc9_:Boolean = (_loc7_) && (_loc7_.parentSprite) && _loc7_.parentSprite.carriedEntity == _loc7_;
         if(!(param3 is SpellWrapper) || param3.id == 0)
         {
            if(!_loc8_ && !_loc9_)
            {
               return true;
            }
            return false;
         }
         var _loc12_:Boolean = PushUtil.isPushableEntity(_loc6_);
         if(BOMB_SPELLS_IDS.indexOf(param3.id) != -1)
         {
            var param3:Object = getBombDirectDamageSpellWrapper(param3 as SpellWrapper);
         }
         var _loc13_:GameFightFighterInformations = _loc5_.getEntityInfos(param1) as GameFightFighterInformations;
         for each(_loc11_ in param3.effects)
         {
            if(_loc11_.triggers == "I" && (_loc11_.category == 2 || !(HEALING_EFFECTS_IDS.indexOf(_loc11_.effectId) == -1) || _loc11_.effectId == 5 && (_loc12_)) && (verifySpellEffectMask(param1,param2,_loc11_,param4)) && (!(_loc11_.targetMask.indexOf("C") == -1) && (_loc8_) || (verifySpellEffectZone(param2,_loc11_,param4,_loc13_.disposition.cellId))))
            {
               _loc10_ = true;
               break;
            }
         }
         if(!_loc10_)
         {
            for each(_loc11_ in param3.criticalEffect)
            {
               if(_loc11_.triggers == "I" && (_loc11_.category == 2 || !(HEALING_EFFECTS_IDS.indexOf(_loc11_.effectId) == -1) || _loc11_.effectId == 5 && (_loc12_)) && (verifySpellEffectMask(param1,param2,_loc11_,param4)) && (verifySpellEffectZone(param2,_loc11_,param4,_loc13_.disposition.cellId)))
               {
                  _loc10_ = true;
                  break;
               }
            }
         }
         if(!_loc10_)
         {
            _loc14_ = BuffManager.getInstance().getAllBuff(param2);
            if(_loc14_)
            {
               for each(_loc15_ in _loc14_)
               {
                  if(_loc15_.effects.category == DAMAGE_EFFECT_CATEGORY)
                  {
                     for each(_loc11_ in param3.effects)
                     {
                        if(verifyEffectTrigger(param1,param2,param3.effects,_loc11_,param3 is SpellWrapper,_loc15_.effects.triggers,param4))
                        {
                           _loc10_ = true;
                           break;
                        }
                     }
                     for each(_loc11_ in param3.criticalEffect)
                     {
                        if(verifyEffectTrigger(param1,param2,param3.criticalEffect,_loc11_,param3 is SpellWrapper,_loc15_.effects.triggers,param4))
                        {
                           _loc10_ = true;
                           break;
                        }
                     }
                  }
               }
            }
         }
         return _loc10_;
      }
      
      public static function getBombDirectDamageSpellWrapper(param1:SpellWrapper) : SpellWrapper
      {
         return SpellWrapper.create(0,SpellBomb.getSpellBombById((param1.effects[0] as EffectInstanceDice).diceNum).instantSpellId,param1.spellLevel,true,param1.playerId);
      }
      
      public static function getBuffEffectElements(param1:BasicBuff) : Vector.<int>
      {
         var _loc2_:Vector.<int> = null;
         var _loc4_:EffectInstance = null;
         var _loc5_:SpellLevel = null;
         var _loc3_:Effect = Effect.getEffectById(param1.effects.effectId);
         if(_loc3_.elementId == -1)
         {
            _loc5_ = param1.castingSpell.spellRank;
            if(!_loc5_)
            {
               _loc5_ = SpellLevel.getLevelById(param1.castingSpell.spell.spellLevels[0]);
            }
            for each(_loc4_ in _loc5_.effects)
            {
               if(_loc4_.effectId == param1.effects.effectId)
               {
                  if(!_loc2_)
                  {
                     _loc2_ = new Vector.<int>(0);
                  }
                  if(!(_loc4_.triggers.indexOf("DA") == -1) && _loc2_.indexOf(AIR_ELEMENT) == -1)
                  {
                     _loc2_.push(AIR_ELEMENT);
                  }
                  if(!(_loc4_.triggers.indexOf("DE") == -1) && _loc2_.indexOf(EARTH_ELEMENT) == -1)
                  {
                     _loc2_.push(EARTH_ELEMENT);
                  }
                  if(!(_loc4_.triggers.indexOf("DF") == -1) && _loc2_.indexOf(FIRE_ELEMENT) == -1)
                  {
                     _loc2_.push(FIRE_ELEMENT);
                  }
                  if(!(_loc4_.triggers.indexOf("DN") == -1) && _loc2_.indexOf(NEUTRAL_ELEMENT) == -1)
                  {
                     _loc2_.push(NEUTRAL_ELEMENT);
                  }
                  if(!(_loc4_.triggers.indexOf("DW") == -1) && _loc2_.indexOf(WATER_ELEMENT) == -1)
                  {
                     _loc2_.push(WATER_ELEMENT);
                  }
                  break;
               }
            }
         }
         return _loc2_;
      }
      
      public static function verifyBuffTriggers(param1:SpellDamageInfo, param2:BasicBuff) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:EffectInstance = null;
         var _loc3_:String = param2.effects.triggers;
         if(_loc3_)
         {
            _loc4_ = _loc3_.split("|");
            for each(_loc5_ in _loc4_)
            {
               for each(_loc6_ in param1.spellEffects)
               {
                  if(verifyEffectTrigger(param1.casterId,param1.targetId,param1.spellEffects,_loc6_,param1.isWeapon,_loc5_,param1.spellCenterCell))
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public static function verifyEffectTrigger(param1:int, param2:int, param3:Vector.<EffectInstance>, param4:EffectInstance, param5:Boolean, param6:String, param7:int) : Boolean
      {
         var _loc10_:String = null;
         var _loc11_:* = false;
         var _loc8_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!_loc8_)
         {
            return false;
         }
         var _loc9_:Array = param6.split("|");
         var _loc12_:GameFightFighterInformations = _loc8_.getEntityInfos(param1) as GameFightFighterInformations;
         var _loc13_:GameFightFighterInformations = _loc8_.getEntityInfos(param2) as GameFightFighterInformations;
         var _loc14_:* = _loc13_.teamId == (_loc8_.getEntityInfos(param1) as GameFightFighterInformations).teamId;
         var _loc15_:uint = MapPoint.fromCellId(_loc12_.disposition.cellId).distanceTo(MapPoint.fromCellId(_loc13_.disposition.cellId));
         for each(var _loc18_ in _loc9_)
         {
            switch(_loc10_)
            {
               case "I":
                  _loc11_ = true;
                  break;
               case "D":
                  _loc11_ = param4.category == DAMAGE_EFFECT_CATEGORY;
                  break;
               case "DA":
                  _loc11_ = param4.category == DAMAGE_EFFECT_CATEGORY && Effect.getEffectById(param4.effectId).elementId == AIR_ELEMENT;
                  break;
               case "DBA":
                  _loc11_ = _loc14_;
                  break;
               case "DBE":
                  _loc11_ = !_loc14_;
                  break;
               case "DC":
                  _loc11_ = param5;
                  break;
               case "DE":
                  _loc11_ = param4.category == DAMAGE_EFFECT_CATEGORY && Effect.getEffectById(param4.effectId).elementId == EARTH_ELEMENT;
                  break;
               case "DF":
                  _loc11_ = param4.category == DAMAGE_EFFECT_CATEGORY && Effect.getEffectById(param4.effectId).elementId == FIRE_ELEMENT;
                  break;
               case "DG":
                  break;
               case "DI":
                  break;
               case "DM":
                  _loc11_ = _loc15_ <= 1;
                  break;
               case "DN":
                  _loc11_ = param4.category == DAMAGE_EFFECT_CATEGORY && Effect.getEffectById(param4.effectId).elementId == NEUTRAL_ELEMENT;
                  break;
               case "DP":
                  break;
               case "DR":
                  _loc11_ = _loc15_ > 1;
                  break;
               case "Dr":
                  break;
               case "DS":
                  _loc11_ = !param5;
                  break;
               case "DTB":
                  break;
               case "DTE":
                  break;
               case "DW":
                  _loc11_ = param4.category == DAMAGE_EFFECT_CATEGORY && Effect.getEffectById(param4.effectId).elementId == WATER_ELEMENT;
                  break;
               case "MD":
                  _loc11_ = PushUtil.hasPushDamages(param1,param2,param3,param4,param7);
                  break;
               case "MDM":
                  break;
               case "MDP":
                  break;
               case "A":
                  _loc11_ = param4.effectId == 101;
                  break;
               case "m":
                  _loc11_ = param4.effectId == 127;
                  break;
            }
            if(_loc11_)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function verifySpellEffectMask(param1:int, param2:int, param3:EffectInstance, param4:int, param5:int = 0) : Boolean
      {
         var _loc15_:RegExp = null;
         var _loc16_:String = null;
         var _loc17_:Array = null;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:* = false;
         var _loc21_:* = false;
         var _loc22_:* = 0;
         var _loc23_:Vector.<String> = null;
         var _loc24_:Vector.<String> = null;
         var _loc25_:String = null;
         var _loc26_:Vector.<String> = null;
         var _loc6_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!param3 || !_loc6_ || param3.delay > 0 || !param3.targetMask)
         {
            return false;
         }
         var _loc7_:TiphonSprite = DofusEntities.getEntity(param2) as AnimatedCharacter;
         var _loc8_:* = param2 == param1;
         var _loc9_:Boolean = (_loc7_) && (_loc7_.parentSprite) && _loc7_.parentSprite.carriedEntity == _loc7_;
         var _loc10_:GameFightFighterInformations = _loc6_.getEntityInfos(param2) as GameFightFighterInformations;
         var _loc11_:GameFightMonsterInformations = _loc10_ as GameFightMonsterInformations;
         var _loc12_:Array = FightersStateManager.getInstance().getStates(param1);
         var _loc13_:Array = FightersStateManager.getInstance().getStates(param2);
         var _loc14_:* = _loc10_.teamId == (_loc6_.getEntityInfos(param1) as GameFightFighterInformations).teamId;
         if(param1 == CurrentPlayedFighterManager.getInstance().currentFighterId && param3.category == 0 && param3.targetMask == "C")
         {
            return true;
         }
         if(_loc8_)
         {
            if(param3.effectId == 90)
            {
               return true;
            }
            if(param3.targetMask.indexOf("g") == -1)
            {
               if(verifySpellEffectZone(param1,param3,param4,_loc10_.disposition.cellId))
               {
                  _loc16_ = "ca";
               }
               else
               {
                  _loc16_ = "C";
               }
            }
            else
            {
               return false;
            }
         }
         else
         {
            if((_loc9_) && !(param3.zoneShape == SpellShapeEnum.A) && !(param3.zoneShape == SpellShapeEnum.a))
            {
               return false;
            }
            if((_loc10_.stats.summoned) && (_loc11_) && !Monster.getMonsterById(_loc11_.creatureGenericId).canPlay)
            {
               _loc16_ = _loc14_?"agsj":"ASJ";
            }
            else if(_loc10_.stats.summoned)
            {
               _loc16_ = _loc14_?"agij":"AIJ";
            }
            else if(_loc10_ is GameFightCompanionInformations)
            {
               _loc16_ = _loc14_?"agdl":"ADL";
            }
            else if(_loc10_ is GameFightMonsterInformations)
            {
               _loc16_ = _loc14_?"agm":"AM";
            }
            else
            {
               _loc16_ = _loc14_?"gahl":"AHL";
            }
            
            
            
         }
         _loc15_ = new RegExp("[" + _loc16_ + "]","g");
         _loc21_ = param3.targetMask.match(_loc15_).length > 0;
         if(_loc21_)
         {
            _loc17_ = param3.targetMask.match(exclusiveTargetMasks);
            if(_loc17_.length > 0)
            {
               _loc21_ = false;
               _loc23_ = new Vector.<String>(0);
               _loc24_ = new Vector.<String>(0);
               for each(_loc18_ in _loc17_)
               {
                  _loc25_ = _loc18_.charAt(0);
                  if(_loc25_ == "*")
                  {
                     _loc25_ = _loc18_.substr(0,2);
                  }
                  if(!(_loc24_.indexOf(_loc25_) == -1) && _loc23_.indexOf(_loc25_) == -1)
                  {
                     _loc23_.push(_loc25_);
                  }
                  _loc24_.push(_loc25_);
               }
               _loc26_ = new Vector.<String>(0);
               for each(_loc18_ in _loc17_)
               {
                  _loc20_ = _loc18_.charAt(0) == "*";
                  _loc18_ = _loc20_?_loc18_.substr(1,_loc18_.length - 1):_loc18_;
                  _loc19_ = _loc18_.length > 1?_loc18_.substr(1,_loc18_.length - 1):null;
                  _loc18_ = _loc18_.charAt(0);
                  switch(_loc18_)
                  {
                     case "b":
                        break;
                     case "B":
                        break;
                     case "e":
                        _loc22_ = parseInt(_loc19_);
                        if(_loc20_)
                        {
                           _loc21_ = !_loc12_ || _loc12_.indexOf(_loc22_) == -1;
                        }
                        else
                        {
                           _loc21_ = !_loc13_ || _loc13_.indexOf(_loc22_) == -1;
                        }
                        break;
                     case "E":
                        _loc22_ = parseInt(_loc19_);
                        if(_loc20_)
                        {
                           _loc21_ = (_loc12_) && !(_loc12_.indexOf(_loc22_) == -1);
                        }
                        else
                        {
                           _loc21_ = (_loc13_) && !(_loc13_.indexOf(_loc22_) == -1);
                        }
                        break;
                     case "f":
                        _loc21_ = !_loc11_ || !(_loc11_.creatureGenericId == parseInt(_loc19_));
                        break;
                     case "F":
                        _loc21_ = (_loc11_) && _loc11_.creatureGenericId == parseInt(_loc19_);
                        break;
                     case "z":
                        break;
                     case "Z":
                        break;
                     case "K":
                        break;
                     case "o":
                        break;
                     case "O":
                        _loc21_ = !(param5 == 0) && param2 == param5;
                        break;
                     case "p":
                        break;
                     case "P":
                        break;
                     case "T":
                        break;
                     case "W":
                        break;
                     case "U":
                        break;
                     case "v":
                        _loc21_ = _loc10_.stats.lifePoints / _loc10_.stats.maxLifePoints * 100 > parseInt(_loc19_);
                        break;
                     case "V":
                        _loc21_ = _loc10_.stats.lifePoints / _loc10_.stats.maxLifePoints * 100 <= parseInt(_loc19_);
                        break;
                  }
                  _loc25_ = _loc20_?"*" + _loc18_:_loc18_;
                  if((_loc21_) && !(_loc23_.indexOf(_loc25_) == -1))
                  {
                     _loc26_.push(_loc25_);
                  }
                  else if(!_loc21_)
                  {
                     if(_loc23_.indexOf(_loc25_) == -1)
                     {
                        return false;
                     }
                     if(_loc26_.indexOf(_loc25_) != -1)
                     {
                        _loc21_ = true;
                     }
                  }
                  
               }
            }
         }
         return _loc21_;
      }
      
      public static function verifySpellEffectZone(param1:int, param2:EffectInstance, param3:int, param4:int) : Boolean
      {
         var _loc5_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!_loc5_)
         {
            return false;
         }
         var _loc6_:GameFightFighterInformations = _loc5_.getEntityInfos(param1) as GameFightFighterInformations;
         var _loc7_:IZone = SpellZoneManager.getInstance().getZone(param2.zoneShape,uint(param2.zoneSize),uint(param2.zoneMinSize));
         _loc7_.direction = MapPoint(MapPoint.fromCellId(param4)).advancedOrientationTo(MapPoint.fromCellId(FightContextFrame.currentCell),false);
         var _loc8_:Vector.<uint> = _loc7_.getCells(param3);
         return _loc8_?!(_loc8_.indexOf(_loc6_.disposition.cellId) == -1):false;
      }
      
      public static function getSpellElementDamage(param1:Object, param2:int, param3:int, param4:int, param5:int) : SpellDamage
      {
         var _loc9_:EffectDamage = null;
         var _loc10_:EffectInstance = null;
         var _loc11_:EffectInstanceDice = null;
         var _loc12_:* = 0;
         var _loc15_:* = false;
         var _loc18_:* = 0;
         var _loc19_:SpellWrapper = null;
         var _loc6_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!_loc6_)
         {
            return null;
         }
         var _loc7_:GameFightFighterInformations = _loc6_.getEntityInfos(param4) as GameFightFighterInformations;
         var _loc8_:SpellDamage = new SpellDamage();
         var _loc13_:int = param1.effects.length;
         var _loc14_:Boolean = !(param1 is SpellWrapper) || param1.id == 0;
         _loc12_ = 0;
         while(_loc12_ < _loc13_)
         {
            _loc10_ = param1.effects[_loc12_];
            _loc15_ = !(HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(_loc10_.effectId) == -1) && _loc10_.targetMask == "C" && !(_loc10_.triggers == "I");
            if((_loc10_.category == DAMAGE_EFFECT_CATEGORY && (_loc14_ || _loc10_.triggers == "I") && HEALING_EFFECTS_IDS.indexOf(_loc10_.effectId) == -1 && Effect.getEffectById(_loc10_.effectId).elementId == param2) && (!_loc10_.targetMask || _loc14_ || _loc10_.targetMask && DamageUtil.verifySpellEffectMask(param3,param4,_loc10_,param5)) && !_loc15_)
            {
               _loc9_ = new EffectDamage(_loc10_.effectId,param2,_loc10_.random);
               _loc8_.addEffectDamage(_loc9_);
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(_loc10_.effectId) != -1)
               {
                  _loc11_ = _loc10_ as EffectInstanceDice;
                  _loc9_.minErosionPercent = _loc9_.maxErosionPercent = _loc11_.diceNum;
               }
               else if(!(_loc10_ is EffectInstanceDice))
               {
                  if(_loc10_ is EffectInstanceInteger)
                  {
                     _loc9_.minDamage = _loc9_.minDamage + (_loc10_ as EffectInstanceInteger).value;
                     _loc9_.maxDamage = _loc9_.maxDamage + (_loc10_ as EffectInstanceInteger).value;
                  }
                  else if(_loc10_ is EffectInstanceMinMax)
                  {
                     _loc9_.minDamage = _loc9_.minDamage + (_loc10_ as EffectInstanceMinMax).min;
                     _loc9_.maxDamage = _loc9_.maxDamage + (_loc10_ as EffectInstanceMinMax).max;
                  }
                  
               }
               else
               {
                  _loc11_ = _loc10_ as EffectInstanceDice;
                  _loc9_.minDamage = _loc9_.minDamage + _loc11_.diceNum;
                  _loc9_.maxDamage = _loc9_.maxDamage + (_loc11_.diceSide == 0?_loc11_.diceNum:_loc11_.diceSide);
               }
               
            }
            _loc12_++;
         }
         var _loc16_:int = _loc8_.effectDamages.length;
         var _loc17_:int = param1.criticalEffect?param1.criticalEffect.length:0;
         _loc12_ = 0;
         while(_loc12_ < _loc17_)
         {
            _loc10_ = param1.criticalEffect[_loc12_];
            _loc15_ = !(HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(_loc10_.effectId) == -1) && _loc10_.targetMask == "C" && !(_loc10_.triggers == "I");
            if((_loc10_.category == DAMAGE_EFFECT_CATEGORY && (_loc14_ || _loc10_.triggers == "I") && HEALING_EFFECTS_IDS.indexOf(_loc10_.effectId) == -1 && Effect.getEffectById(_loc10_.effectId).elementId == param2) && (!_loc10_.targetMask || _loc14_ || _loc10_.targetMask && DamageUtil.verifySpellEffectMask(param3,param4,_loc10_,param5)) && !_loc15_)
            {
               if(_loc18_ < _loc16_)
               {
                  _loc9_ = _loc8_.effectDamages[_loc18_];
               }
               else
               {
                  _loc9_ = new EffectDamage(_loc10_.effectId,param2,_loc10_.random);
                  _loc8_.addEffectDamage(_loc9_);
               }
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(_loc10_.effectId) != -1)
               {
                  _loc11_ = _loc10_ as EffectInstanceDice;
                  _loc9_.minCriticalErosionPercent = _loc9_.maxCriticalErosionPercent = _loc11_.diceNum;
               }
               else if(!(_loc10_ is EffectInstanceDice))
               {
                  if(_loc10_ is EffectInstanceInteger)
                  {
                     _loc9_.minCriticalDamage = _loc9_.minCriticalDamage + (_loc10_ as EffectInstanceInteger).value;
                     _loc9_.maxCriticalDamage = _loc9_.maxCriticalDamage + (_loc10_ as EffectInstanceInteger).value;
                  }
                  else if(_loc10_ is EffectInstanceMinMax)
                  {
                     _loc9_.minCriticalDamage = _loc9_.minCriticalDamage + (_loc10_ as EffectInstanceMinMax).min;
                     _loc9_.maxCriticalDamage = _loc9_.maxCriticalDamage + (_loc10_ as EffectInstanceMinMax).max;
                  }
                  
               }
               else
               {
                  _loc11_ = _loc10_ as EffectInstanceDice;
                  _loc9_.minCriticalDamage = _loc9_.minCriticalDamage + _loc11_.diceNum;
                  _loc9_.maxCriticalDamage = _loc9_.maxCriticalDamage + (_loc11_.diceSide == 0?_loc11_.diceNum:_loc11_.diceSide);
               }
               
               _loc8_.hasCriticalDamage = _loc9_.hasCritical = true;
               _loc18_++;
            }
            _loc12_++;
         }
         if(param3 == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            _loc19_ = param1 as SpellWrapper;
            for each(_loc9_ in _loc8_.effectDamages)
            {
               applySpellModificationsOnEffect(_loc9_,_loc19_);
            }
         }
         return _loc8_;
      }
      
      public static function applySpellModificationsOnEffect(param1:EffectDamage, param2:SpellWrapper) : void
      {
         if(!param2)
         {
            return;
         }
         var _loc3_:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2.id,CharacterSpellModificationTypeEnum.BASE_DAMAGE);
         if(_loc3_)
         {
            param1.minDamage = param1.minDamage + (param1.minDamage > 0?_loc3_.value.contextModif:0);
            param1.maxDamage = param1.maxDamage + (param1.maxDamage > 0?_loc3_.value.contextModif:0);
            if(param1.hasCritical)
            {
               param1.minCriticalDamage = param1.minCriticalDamage + (param1.minCriticalDamage > 0?_loc3_.value.contextModif:0);
               param1.maxCriticalDamage = param1.maxCriticalDamage + (param1.maxCriticalDamage > 0?_loc3_.value.contextModif:0);
            }
         }
      }
      
      public static function getSpellDamage(param1:SpellDamageInfo, param2:Boolean = true, param3:Boolean = true) : SpellDamage
      {
         var efficiencyMultiplier:Number = NaN;
         var splashEffectDamages:Vector.<EffectDamage> = null;
         var finalNeutralDmg:EffectDamage = null;
         var finalEarthDmg:EffectDamage = null;
         var finalWaterDmg:EffectDamage = null;
         var finalAirDmg:EffectDamage = null;
         var finalFireDmg:EffectDamage = null;
         var erosion:EffectDamage = null;
         var targetHpBasedBuffDamages:Vector.<SpellDamage> = null;
         var dmgMultiplier:Number = NaN;
         var sharedDamageEffect:EffectDamage = null;
         var splashEffectDmg:EffectDamage = null;
         var splashDmg:SplashDamage = null;
         var splashCasterCell:uint = 0;
         var pushDamages:EffectDamage = null;
         var pushedEntity:PushedEntity = null;
         var pushIndex:uint = 0;
         var hasPushedDamage:Boolean = false;
         var pushDmg:int = 0;
         var criticalPushDmg:int = 0;
         var buff:BasicBuff = null;
         var buffDamage:EffectDamage = null;
         var buffEffectDamage:EffectDamage = null;
         var buffSpellDamage:SpellDamage = null;
         var effid:EffectInstanceDice = null;
         var buffEffectMinDamage:int = 0;
         var buffEffectMaxDamage:int = 0;
         var buffEffectDispelled:Boolean = false;
         var finalBuffDmg:EffectDamage = null;
         var currentTargetLifePoints:int = 0;
         var targetHpBasedBuffDamage:SpellDamage = null;
         var finalTargetHpBasedBuffDmg:EffectDamage = null;
         var minShieldDiff:int = 0;
         var maxShieldDiff:int = 0;
         var minCriticalShieldDiff:int = 0;
         var maxCriticalShieldDiff:int = 0;
         var pSpellDamageInfo:SpellDamageInfo = param1;
         var pWithTargetBuffs:Boolean = param2;
         var pWithTargetResists:Boolean = param3;
         var finalDamage:SpellDamage = new SpellDamage();
         if(pSpellDamageInfo.sharedDamage)
         {
            sharedDamageEffect = computeDamage(pSpellDamageInfo.sharedDamage,pSpellDamageInfo,1,true);
            finalDamage.invulnerableState = pSpellDamageInfo.targetIsInvulnerable;
            finalDamage.hasCriticalDamage = pSpellDamageInfo.spellHasCriticalDamage;
            finalDamage.addEffectDamage(sharedDamageEffect);
            finalDamage.updateDamage();
            return finalDamage;
         }
         var currentCasterLifePoints:int = ((Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(pSpellDamageInfo.casterId) as GameFightFighterInformations).stats.lifePoints;
         if(pSpellDamageInfo.splashDamages)
         {
            splashEffectDamages = new Vector.<EffectDamage>(0);
            for each(splashDmg in pSpellDamageInfo.splashDamages)
            {
               if(splashDmg.targets.indexOf(pSpellDamageInfo.targetId) != -1)
               {
                  splashCasterCell = EntitiesManager.getInstance().getEntity(splashDmg.casterId).position.cellId;
                  efficiencyMultiplier = getShapeEfficiency(splashDmg.spellShape,splashCasterCell,pSpellDamageInfo.targetCell,splashDmg.spellShapeSize != null?int(splashDmg.spellShapeSize):EFFECTSHAPE_DEFAULT_AREA_SIZE,splashDmg.spellShapeMinSize != null?int(splashDmg.spellShapeMinSize):EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE,splashDmg.spellShapeEfficiencyPercent != null?int(splashDmg.spellShapeEfficiencyPercent):EFFECTSHAPE_DEFAULT_EFFICIENCY,splashDmg.spellShapeMaxEfficiency != null?int(splashDmg.spellShapeMaxEfficiency):EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY);
                  splashEffectDmg = computeDamage(splashDmg.damage,pSpellDamageInfo,efficiencyMultiplier,true,!splashDmg.hasCritical);
                  splashEffectDamages.push(splashEffectDmg);
                  finalDamage.addEffectDamage(splashEffectDmg);
                  if(pSpellDamageInfo.targetId == pSpellDamageInfo.casterId)
                  {
                     if(pSpellDamageInfo.casterLifePointsAfterNormalMinDamage == 0)
                     {
                        pSpellDamageInfo.casterLifePointsAfterNormalMinDamage = currentCasterLifePoints - splashEffectDmg.minDamage;
                     }
                     else
                     {
                        pSpellDamageInfo.casterLifePointsAfterNormalMinDamage = pSpellDamageInfo.casterLifePointsAfterNormalMinDamage - splashEffectDmg.minDamage;
                     }
                     if(pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage == 0)
                     {
                        pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage = currentCasterLifePoints - splashEffectDmg.maxDamage;
                     }
                     else
                     {
                        pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage = pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage - splashEffectDmg.maxDamage;
                     }
                     if(pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage == 0)
                     {
                        pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage = currentCasterLifePoints - splashEffectDmg.minCriticalDamage;
                     }
                     else
                     {
                        pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage = pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage - splashEffectDmg.minCriticalDamage;
                     }
                     if(pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage == 0)
                     {
                        pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage = currentCasterLifePoints - splashEffectDmg.maxCriticalDamage;
                     }
                     else
                     {
                        pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage = pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage - splashEffectDmg.maxCriticalDamage;
                     }
                  }
               }
            }
         }
         var shapeSize:int = pSpellDamageInfo.spellShapeSize != null?int(pSpellDamageInfo.spellShapeSize):EFFECTSHAPE_DEFAULT_AREA_SIZE;
         var shapeMinSize:int = pSpellDamageInfo.spellShapeMinSize != null?int(pSpellDamageInfo.spellShapeMinSize):EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE;
         var shapeEfficiencyPercent:int = pSpellDamageInfo.spellShapeEfficiencyPercent != null?int(pSpellDamageInfo.spellShapeEfficiencyPercent):EFFECTSHAPE_DEFAULT_EFFICIENCY;
         var shapeMaxEfficiency:int = pSpellDamageInfo.spellShapeMaxEfficiency != null?int(pSpellDamageInfo.spellShapeMaxEfficiency):EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY;
         efficiencyMultiplier = getShapeEfficiency(pSpellDamageInfo.spellShape,pSpellDamageInfo.spellCenterCell,pSpellDamageInfo.targetCell,shapeSize,shapeMinSize,shapeEfficiencyPercent,shapeMaxEfficiency);
         efficiencyMultiplier = efficiencyMultiplier * pSpellDamageInfo.portalsSpellEfficiencyBonus;
         finalNeutralDmg = computeDamage(pSpellDamageInfo.neutralDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalEarthDmg = computeDamage(pSpellDamageInfo.earthDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalWaterDmg = computeDamage(pSpellDamageInfo.waterDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalAirDmg = computeDamage(pSpellDamageInfo.airDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalFireDmg = computeDamage(pSpellDamageInfo.fireDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         var finalFixedDmg:EffectDamage = computeDamage(pSpellDamageInfo.fixedDamage,pSpellDamageInfo,1,true,true,true);
         pSpellDamageInfo.casterLifePointsAfterNormalMinDamage = 0;
         pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage = 0;
         pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage = 0;
         pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage = 0;
         var totalMinErosionDamage:int = finalNeutralDmg.minErosionDamage + finalEarthDmg.minErosionDamage + finalWaterDmg.minErosionDamage + finalAirDmg.minErosionDamage + finalFireDmg.minErosionDamage;
         var totalMaxErosionDamage:int = finalNeutralDmg.maxErosionDamage + finalEarthDmg.maxErosionDamage + finalWaterDmg.maxErosionDamage + finalAirDmg.maxErosionDamage + finalFireDmg.maxErosionDamage;
         var totalMinCriticaErosionDamage:int = finalNeutralDmg.minCriticalErosionDamage + finalEarthDmg.minCriticalErosionDamage + finalWaterDmg.minCriticalErosionDamage + finalAirDmg.minCriticalErosionDamage + finalFireDmg.minCriticalErosionDamage;
         var totalMaxCriticaErosionlDamage:int = finalNeutralDmg.maxCriticalErosionDamage + finalEarthDmg.maxCriticalErosionDamage + finalWaterDmg.maxCriticalErosionDamage + finalAirDmg.maxCriticalErosionDamage + finalFireDmg.maxCriticalErosionDamage;
         var casterIntelligence:int = pSpellDamageInfo.casterIntelligence <= 0?1:pSpellDamageInfo.casterIntelligence;
         var totalMinLifePointsAdded:int = Math.floor(pSpellDamageInfo.healDamage.minLifePointsAdded * (100 + casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.minLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0);
         var totalMaxLifePointsAdded:int = Math.floor(pSpellDamageInfo.healDamage.maxLifePointsAdded * (100 + casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.maxLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0);
         var totalMinCriticalLifePointsAdded:int = Math.floor(pSpellDamageInfo.healDamage.minCriticalLifePointsAdded * (100 + casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.minCriticalLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0);
         var totalMaxCriticalLifePointsAdded:int = Math.floor(pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded * (100 + casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0);
         totalMinLifePointsAdded = totalMinLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent;
         totalMaxLifePointsAdded = totalMaxLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent;
         totalMinCriticalLifePointsAdded = totalMinCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         totalMaxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         finalDamage.hasHeal = totalMinLifePointsAdded > 0 || totalMaxLifePointsAdded > 0 || totalMinCriticalLifePointsAdded > 0 || totalMaxCriticalLifePointsAdded > 0;
         var targetLostLifePoints:int = pSpellDamageInfo.targetInfos.stats.maxLifePoints - pSpellDamageInfo.targetInfos.stats.lifePoints;
         if(targetLostLifePoints > 0 || (pSpellDamageInfo.isHealingSpell))
         {
            totalMinLifePointsAdded = totalMinLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMinLifePointsAdded;
            totalMaxLifePointsAdded = totalMaxLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMaxLifePointsAdded;
            totalMinCriticalLifePointsAdded = totalMinCriticalLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMinCriticalLifePointsAdded;
            totalMaxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMaxCriticalLifePointsAdded;
         }
         var heal:EffectDamage = new EffectDamage(-1,-1,-1);
         heal.minLifePointsAdded = totalMinLifePointsAdded * efficiencyMultiplier;
         heal.maxLifePointsAdded = totalMaxLifePointsAdded * efficiencyMultiplier;
         heal.minCriticalLifePointsAdded = totalMinCriticalLifePointsAdded * efficiencyMultiplier;
         heal.maxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded * efficiencyMultiplier;
         erosion = new EffectDamage(-1,-1,-1);
         erosion.minDamage = totalMinErosionDamage;
         erosion.maxDamage = totalMaxErosionDamage;
         erosion.minCriticalDamage = totalMinCriticaErosionDamage;
         erosion.maxCriticalDamage = totalMaxCriticaErosionlDamage;
         if((pSpellDamageInfo.pushedEntities) && pSpellDamageInfo.pushedEntities.length > 0)
         {
            pushDamages = new EffectDamage(5,-1,-1);
            for each(pushedEntity in pSpellDamageInfo.pushedEntities)
            {
               if(pushedEntity.id == pSpellDamageInfo.targetId)
               {
                  pushedEntity.damage = 0;
                  for each(pushIndex in pushedEntity.pushedIndexes)
                  {
                     pushDmg = (pSpellDamageInfo.casterLevel / 2 + (pSpellDamageInfo.casterPushDamageBonus - pSpellDamageInfo.targetPushDamageFixedResist) + 32) * pushedEntity.force / (4 * Math.pow(2,pushIndex));
                     pushedEntity.damage = pushedEntity.damage + (pushDmg > 0?pushDmg:0);
                     criticalPushDmg = (pSpellDamageInfo.casterLevel / 2 + (pSpellDamageInfo.casterCriticalPushDamageBonus - pSpellDamageInfo.targetPushDamageFixedResist) + 32) * pushedEntity.force / (4 * Math.pow(2,pushIndex));
                     pushedEntity.criticalDamage = pushedEntity.criticalDamage + (criticalPushDmg > 0?criticalPushDmg:0);
                  }
                  hasPushedDamage = true;
                  break;
               }
            }
            if(hasPushedDamage)
            {
               pushDamages.minDamage = pushDamages.maxDamage = pushedEntity.damage;
               if(pSpellDamageInfo.spellHasCriticalDamage)
               {
                  pushDamages.minCriticalDamage = pushDamages.maxCriticalDamage = pushedEntity.criticalDamage;
               }
            }
            finalDamage.addEffectDamage(pushDamages);
         }
         var applyDamageMultiplier:Function = function(param1:Number):void
         {
            var _loc2_:EffectDamage = null;
            erosion.applyDamageMultiplier(param1);
            finalNeutralDmg.applyDamageMultiplier(param1);
            finalEarthDmg.applyDamageMultiplier(param1);
            finalWaterDmg.applyDamageMultiplier(param1);
            finalAirDmg.applyDamageMultiplier(param1);
            finalFireDmg.applyDamageMultiplier(param1);
            if(splashEffectDamages)
            {
               for each(_loc2_ in splashEffectDamages)
               {
                  _loc2_.applyDamageMultiplier(param1);
               }
            }
         };
         if(pWithTargetBuffs)
         {
            for each(buff in pSpellDamageInfo.targetBuffs)
            {
               buffEffectDispelled = (buff.canBeDispell()) && buff.effects.duration - pSpellDamageInfo.spellTargetEffectsDurationReduction <= 0;
               if((!buff.hasOwnProperty("delay") || buff["delay"] == 0) && (!(buff is StatBuff) || !(buff as StatBuff).statName) && (verifyBuffTriggers(pSpellDamageInfo,buff)) && !buffEffectDispelled)
               {
                  switch(buff.actionId)
                  {
                     case 1163:
                        applyDamageMultiplier(buff.param1 / 100);
                        break;
                     case 1164:
                        erosion.convertDamageToHeal();
                        finalNeutralDmg.convertDamageToHeal();
                        finalEarthDmg.convertDamageToHeal();
                        finalWaterDmg.convertDamageToHeal();
                        finalAirDmg.convertDamageToHeal();
                        finalFireDmg.convertDamageToHeal();
                        pSpellDamageInfo.spellHasCriticalHeal = pSpellDamageInfo.spellHasCriticalDamage;
                        break;
                  }
                  if(!(buff.targetId == pSpellDamageInfo.casterId) && buff.effects.category == DAMAGE_EFFECT_CATEGORY && HEALING_EFFECTS_IDS.indexOf(buff.effects.effectId) == -1)
                  {
                     buffSpellDamage = new SpellDamage();
                     buffEffectDamage = new EffectDamage(buff.effects.effectId,Effect.getEffectById(buff.effects.effectId).elementId,-1);
                     if(buff.effects is EffectInstanceDice)
                     {
                        effid = buff.effects as EffectInstanceDice;
                        buffEffectMinDamage = effid.value + effid.diceNum;
                        buffEffectMaxDamage = effid.value + effid.diceSide;
                     }
                     else if(buff.effects is EffectInstanceMinMax)
                     {
                        buffEffectMinDamage = (buff.effects as EffectInstanceMinMax).min;
                        buffEffectMaxDamage = (buff.effects as EffectInstanceMinMax).max;
                     }
                     else if(buff.effects is EffectInstanceInteger)
                     {
                        buffEffectMinDamage = buffEffectMaxDamage = (buff.effects as EffectInstanceInteger).value;
                     }
                     
                     
                     buffEffectDamage.minDamage = buff.effects.duration - pSpellDamageInfo.spellTargetEffectsDurationReduction > 0?buffEffectMinDamage:0;
                     buffEffectDamage.maxDamage = buff.effects.duration - pSpellDamageInfo.spellTargetEffectsDurationReduction > 0?buffEffectMaxDamage:0;
                     buffEffectDamage.minCriticalDamage = buff.effects.duration - pSpellDamageInfo.spellTargetEffectsDurationCriticalReduction > 0?buffEffectMinDamage:0;
                     buffEffectDamage.maxCriticalDamage = buff.effects.duration - pSpellDamageInfo.spellTargetEffectsDurationCriticalReduction > 0?buffEffectMaxDamage:0;
                     buffSpellDamage.addEffectDamage(buffEffectDamage);
                     if(TARGET_HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(buff.actionId) == -1)
                     {
                        buffDamage = computeDamage(buffSpellDamage,pSpellDamageInfo,1);
                        finalDamage.addEffectDamage(buffDamage);
                     }
                     else
                     {
                        if(!targetHpBasedBuffDamages)
                        {
                           targetHpBasedBuffDamages = new Vector.<SpellDamage>(0);
                        }
                        targetHpBasedBuffDamages.push(buffSpellDamage);
                     }
                  }
               }
            }
         }
         if(pSpellDamageInfo.casterDamageBoostPercent > 0)
         {
            applyDamageMultiplier((100 + pSpellDamageInfo.casterDamageBoostPercent) / 100);
         }
         if(pSpellDamageInfo.casterDamageDeboostPercent > 0)
         {
            dmgMultiplier = 100 - pSpellDamageInfo.casterDamageDeboostPercent;
            applyDamageMultiplier(dmgMultiplier < 0?0:dmgMultiplier / 100);
         }
         if(pSpellDamageInfo.originalTargetsIds.indexOf(pSpellDamageInfo.targetId) != -1)
         {
            finalDamage.addEffectDamage(heal);
            finalDamage.addEffectDamage(erosion);
            finalDamage.addEffectDamage(finalNeutralDmg);
            finalDamage.addEffectDamage(finalEarthDmg);
            finalDamage.addEffectDamage(finalWaterDmg);
            finalDamage.addEffectDamage(finalAirDmg);
            finalDamage.addEffectDamage(finalFireDmg);
            finalDamage.addEffectDamage(finalFixedDmg);
            if(pSpellDamageInfo.buffDamage)
            {
               finalDamage.updateDamage();
               pSpellDamageInfo.casterLifePointsAfterNormalMinDamage = currentCasterLifePoints - finalDamage.minDamage;
               pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage = currentCasterLifePoints - finalDamage.maxDamage;
               pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage = currentCasterLifePoints - finalDamage.minCriticalDamage;
               pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage = currentCasterLifePoints - finalDamage.maxCriticalDamage;
               finalBuffDmg = computeDamage(pSpellDamageInfo.buffDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
            }
            if(finalBuffDmg)
            {
               finalDamage.addEffectDamage(finalBuffDmg);
            }
            if(targetHpBasedBuffDamages)
            {
               finalDamage.updateDamage();
               currentTargetLifePoints = ((Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(pSpellDamageInfo.targetId) as GameFightFighterInformations).stats.lifePoints;
               pSpellDamageInfo.targetLifePointsAfterNormalMinDamage = currentTargetLifePoints - finalDamage.minDamage < 0?0:currentTargetLifePoints - finalDamage.minDamage;
               pSpellDamageInfo.targetLifePointsAfterNormalMaxDamage = currentTargetLifePoints - finalDamage.maxDamage < 0?0:currentTargetLifePoints - finalDamage.maxDamage;
               pSpellDamageInfo.targetLifePointsAfterCriticalMinDamage = currentTargetLifePoints - finalDamage.minCriticalDamage < 0?0:currentTargetLifePoints - finalDamage.minCriticalDamage;
               pSpellDamageInfo.targetLifePointsAfterCriticalMaxDamage = currentTargetLifePoints - finalDamage.maxCriticalDamage < 0?0:currentTargetLifePoints - finalDamage.maxCriticalDamage;
               for each(targetHpBasedBuffDamage in targetHpBasedBuffDamages)
               {
                  finalTargetHpBasedBuffDmg = computeDamage(targetHpBasedBuffDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
                  finalDamage.addEffectDamage(finalTargetHpBasedBuffDmg);
               }
            }
         }
         finalDamage.hasCriticalDamage = pSpellDamageInfo.spellHasCriticalDamage;
         finalDamage.updateDamage();
         pSpellDamageInfo.targetShieldPoints = pSpellDamageInfo.targetShieldPoints + pSpellDamageInfo.targetTriggeredShieldPoints;
         if(pSpellDamageInfo.targetShieldPoints > 0)
         {
            minShieldDiff = finalDamage.minDamage - pSpellDamageInfo.targetShieldPoints;
            if(minShieldDiff < 0)
            {
               finalDamage.minShieldPointsRemoved = finalDamage.minDamage;
               finalDamage.minDamage = 0;
            }
            else
            {
               finalDamage.minDamage = finalDamage.minDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.minShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            maxShieldDiff = finalDamage.maxDamage - pSpellDamageInfo.targetShieldPoints;
            if(maxShieldDiff < 0)
            {
               finalDamage.maxShieldPointsRemoved = finalDamage.maxDamage;
               finalDamage.maxDamage = 0;
            }
            else
            {
               finalDamage.maxDamage = finalDamage.maxDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.maxShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            minCriticalShieldDiff = finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldPoints;
            if(minCriticalShieldDiff < 0)
            {
               finalDamage.minCriticalShieldPointsRemoved = finalDamage.minCriticalDamage;
               finalDamage.minCriticalDamage = 0;
            }
            else
            {
               finalDamage.minCriticalDamage = finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.minCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            maxCriticalShieldDiff = finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldPoints;
            if(maxCriticalShieldDiff < 0)
            {
               finalDamage.maxCriticalShieldPointsRemoved = finalDamage.maxCriticalDamage;
               finalDamage.maxCriticalDamage = 0;
            }
            else
            {
               finalDamage.maxCriticalDamage = finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.maxCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            if(pSpellDamageInfo.spellHasCriticalDamage)
            {
               finalDamage.hasCriticalShieldPointsRemoved = true;
            }
         }
         if((pSpellDamageInfo.casterStates) && !(pSpellDamageInfo.casterStates.indexOf(218) == -1))
         {
            finalDamage.minDamage = finalDamage.maxDamage = finalDamage.minCriticalDamage = finalDamage.maxCriticalDamage = 0;
         }
         finalDamage.hasCriticalLifePointsAdded = pSpellDamageInfo.spellHasCriticalHeal;
         finalDamage.invulnerableState = pSpellDamageInfo.targetIsInvulnerable;
         finalDamage.unhealableState = pSpellDamageInfo.targetIsUnhealable;
         finalDamage.isHealingSpell = pSpellDamageInfo.isHealingSpell;
         return finalDamage;
      }
      
      private static function computeDamage(param1:SpellDamage, param2:SpellDamageInfo, param3:Number, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : EffectDamage
      {
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:EffectModification = null;
         var _loc19_:* = 0;
         var _loc20_:EffectDamage = null;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc42_:* = 0;
         var _loc43_:* = 0;
         var _loc46_:* = 0;
         var _loc47_:* = 0;
         var _loc48_:* = 0;
         var _loc7_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!_loc7_)
         {
            return null;
         }
         var _loc14_:int = param2.casterAllDamagesBonus;
         var _loc15_:int = param2.casterCriticalDamageBonus;
         var _loc16_:int = param2.targetCriticalDamageFixedResist;
         var _loc21_:* = -1;
         var _loc30_:GameFightFighterInformations = _loc7_.getEntityInfos(param2.casterId) as GameFightFighterInformations;
         var _loc31_:Number = _loc30_.stats.movementPoints / _loc30_.stats.maxMovementPoints;
         var _loc32_:uint = param2.casterLifePointsAfterNormalMinDamage > 0?param2.casterLifePointsAfterNormalMinDamage:_loc30_.stats.lifePoints;
         var _loc33_:uint = param2.casterLifePointsAfterNormalMaxDamage > 0?param2.casterLifePointsAfterNormalMaxDamage:_loc30_.stats.lifePoints;
         var _loc34_:uint = param2.casterLifePointsAfterCriticalMinDamage > 0?param2.casterLifePointsAfterCriticalMinDamage:_loc30_.stats.lifePoints;
         var _loc35_:uint = param2.casterLifePointsAfterCriticalMaxDamage > 0?param2.casterLifePointsAfterCriticalMaxDamage:_loc30_.stats.lifePoints;
         var _loc36_:uint = param2.targetLifePointsAfterNormalMinDamage > 0?param2.targetLifePointsAfterNormalMinDamage:param2.targetInfos.stats.lifePoints;
         var _loc37_:uint = param2.targetLifePointsAfterNormalMaxDamage > 0?param2.targetLifePointsAfterNormalMaxDamage:param2.targetInfos.stats.lifePoints;
         var _loc38_:uint = param2.targetLifePointsAfterCriticalMinDamage > 0?param2.targetLifePointsAfterCriticalMinDamage:param2.targetInfos.stats.lifePoints;
         var _loc39_:uint = param2.targetLifePointsAfterCriticalMaxDamage > 0?param2.targetLifePointsAfterCriticalMaxDamage:param2.targetInfos.stats.lifePoints;
         var _loc40_:* = param1 == param2.sharedDamage;
         var _loc41_:Number = 1;
         if(_loc40_)
         {
            _loc16_ = getAverageStat("criticalDamageFixedResist",param2.damageSharingTargets);
            _loc41_ = 1 / param2.damageSharingTargets.length;
         }
         var _loc44_:int = param1.effectDamages.length;
         _loc42_ = 0;
         while(_loc42_ < _loc44_)
         {
            _loc20_ = param1.effectDamages[_loc42_];
            _loc21_ = _loc20_.effectId;
            _loc11_ = 0;
            if(NO_BOOST_EFFECTS_IDS.indexOf(_loc20_.effectId) != -1)
            {
               var param4:* = true;
            }
            _loc18_ = param2.getEffectModification(_loc20_.effectId,_loc42_,_loc20_.hasCritical);
            if(_loc18_)
            {
               _loc19_ = _loc18_.damagesBonus;
               if(_loc18_.shieldPoints > param2.targetTriggeredShieldPoints)
               {
                  param2.targetTriggeredShieldPoints = _loc18_.shieldPoints;
               }
            }
            if(_loc40_)
            {
               _loc11_ = getAverageElementResistance(_loc20_.element,param2.damageSharingTargets);
               _loc13_ = getAverageElementReduction(_loc20_.element,param2.damageSharingTargets);
               _loc13_ = _loc13_ + getAverageBuffElementReduction(param2,_loc20_,param2.damageSharingTargets);
            }
            else
            {
               switch(_loc20_.element)
               {
                  case NEUTRAL_ELEMENT:
                     if(!param4)
                     {
                        _loc43_ = param2.casterStrength > 0?param2.casterStrength:0;
                        _loc8_ = _loc43_ + param2.casterDamagesBonus + _loc19_ + (param2.isWeapon?param2.casterWeaponDamagesBonus:param2.casterSpellDamagesBonus);
                        _loc9_ = param2.casterStrengthBonus;
                        _loc10_ = param2.casterCriticalStrengthBonus;
                     }
                     if(!param6)
                     {
                        _loc11_ = param2.targetNeutralElementResistPercent;
                        _loc13_ = param2.targetNeutralElementReduction;
                     }
                     _loc17_ = param2.casterNeutralDamageBonus;
                     break;
                  case EARTH_ELEMENT:
                     if(!param4)
                     {
                        _loc43_ = param2.casterStrength > 0?param2.casterStrength:0;
                        _loc8_ = _loc43_ + param2.casterDamagesBonus + _loc19_ + (param2.isWeapon?param2.casterWeaponDamagesBonus:param2.casterSpellDamagesBonus);
                        _loc9_ = param2.casterStrengthBonus;
                        _loc10_ = param2.casterCriticalStrengthBonus;
                     }
                     if(!param6)
                     {
                        _loc11_ = param2.targetEarthElementResistPercent;
                        _loc13_ = param2.targetEarthElementReduction;
                     }
                     _loc17_ = param2.casterEarthDamageBonus;
                     break;
                  case FIRE_ELEMENT:
                     if(!param4)
                     {
                        _loc43_ = param2.casterIntelligence > 0?param2.casterIntelligence:0;
                        _loc8_ = _loc43_ + param2.casterDamagesBonus + _loc19_ + (param2.isWeapon?param2.casterWeaponDamagesBonus:param2.casterSpellDamagesBonus);
                        _loc9_ = param2.casterIntelligenceBonus;
                        _loc10_ = param2.casterCriticalIntelligenceBonus;
                     }
                     if(!param6)
                     {
                        _loc11_ = param2.targetFireElementResistPercent;
                        _loc13_ = param2.targetFireElementReduction;
                     }
                     _loc17_ = param2.casterFireDamageBonus;
                     break;
                  case WATER_ELEMENT:
                     if(!param4)
                     {
                        _loc43_ = param2.casterChance > 0?param2.casterChance:0;
                        _loc8_ = _loc43_ + param2.casterDamagesBonus + _loc19_ + (param2.isWeapon?param2.casterWeaponDamagesBonus:param2.casterSpellDamagesBonus);
                        _loc9_ = param2.casterChanceBonus;
                        _loc10_ = param2.casterCriticalChanceBonus;
                     }
                     if(!param6)
                     {
                        _loc11_ = param2.targetWaterElementResistPercent;
                        _loc13_ = param2.targetWaterElementReduction;
                     }
                     _loc17_ = param2.casterWaterDamageBonus;
                     break;
                  case AIR_ELEMENT:
                     if(!param4)
                     {
                        _loc43_ = param2.casterAgility > 0?param2.casterAgility:0;
                        _loc8_ = _loc43_ + param2.casterDamagesBonus + _loc19_ + (param2.isWeapon?param2.casterWeaponDamagesBonus:param2.casterSpellDamagesBonus);
                        _loc9_ = param2.casterAgilityBonus;
                        _loc10_ = param2.casterCriticalAgilityBonus;
                     }
                     if(!param6)
                     {
                        _loc11_ = param2.targetAirElementResistPercent;
                        _loc13_ = param2.targetAirElementReduction;
                     }
                     _loc17_ = param2.casterAirDamageBonus;
                     break;
               }
               if(!param6)
               {
                  _loc13_ = _loc13_ + getBuffElementReduction(param2,_loc20_,param2.targetId);
               }
            }
            _loc11_ = 100 - _loc11_;
            _loc12_ = (isNaN(_loc20_.efficiencyMultiplier)?param3:_loc20_.efficiencyMultiplier) * 100;
            if(HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(_loc20_.effectId) == -1 && TARGET_HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(_loc20_.effectId) == -1)
            {
               if(param4)
               {
                  _loc17_ = _loc14_ = _loc15_ = 0;
               }
               if(param5)
               {
                  _loc16_ = 0;
               }
               _loc46_ = param2.spellDamageModification?param2.spellDamageModification.value.objectsAndMountBonus:0;
               _loc26_ = getDamage(_loc20_.minDamage,param4,_loc8_,_loc9_,_loc17_,_loc14_,_loc46_,_loc13_,_loc11_,_loc12_,_loc41_);
               _loc27_ = getDamage(param2.spellWeaponCriticalBonus != 0?_loc20_.minDamage > 0?_loc20_.minDamage + param2.spellWeaponCriticalBonus:0:_loc20_.minCriticalDamage,param4,_loc8_,_loc10_,_loc17_ + _loc15_,_loc14_,_loc46_,_loc13_ + _loc16_,_loc11_,_loc12_,_loc41_);
               _loc28_ = getDamage(_loc20_.maxDamage,param4,_loc8_,_loc9_,_loc17_,_loc14_,_loc46_,_loc13_,_loc11_,_loc12_,_loc41_);
               _loc29_ = getDamage(param2.spellWeaponCriticalBonus != 0?_loc20_.maxDamage > 0?_loc20_.maxDamage + param2.spellWeaponCriticalBonus:0:_loc20_.maxCriticalDamage,param4,_loc8_,_loc10_,_loc17_ + _loc15_,_loc14_,_loc46_,_loc13_ + _loc16_,_loc11_,_loc12_,_loc41_);
            }
            else
            {
               switch(_loc20_.effectId)
               {
                  case 672:
                     _loc47_ = _loc20_.maxDamage * _loc30_.stats.baseMaxLifePoints * getMidLifeDamageMultiplier(Math.min(100,Math.max(0,100 * _loc30_.stats.lifePoints / _loc30_.stats.maxLifePoints))) / 100 * _loc12_ / 100;
                     _loc26_ = _loc28_ = (_loc47_ - _loc13_) * _loc11_ / 100;
                     _loc48_ = _loc20_.maxCriticalDamage * _loc30_.stats.baseMaxLifePoints * getMidLifeDamageMultiplier(Math.min(100,Math.max(0,100 * _loc30_.stats.lifePoints / _loc30_.stats.maxLifePoints))) / 100 * _loc12_ / 100;
                     _loc27_ = _loc29_ = (_loc48_ - _loc13_) * _loc11_ / 100;
                     break;
                  case 85:
                  case 86:
                  case 87:
                  case 88:
                  case 89:
                     _loc47_ = _loc20_.minDamage * _loc32_ / 100 * _loc12_ / 100;
                     _loc26_ = (_loc47_ - _loc13_) * _loc11_ / 100;
                     _loc47_ = _loc20_.maxDamage * _loc33_ / 100 * _loc12_ / 100;
                     _loc28_ = (_loc47_ - _loc13_) * _loc11_ / 100;
                     _loc48_ = _loc20_.minCriticalDamage * _loc34_ / 100 * _loc12_ / 100;
                     _loc27_ = (_loc48_ - _loc13_) * _loc11_ / 100;
                     _loc48_ = _loc20_.maxCriticalDamage * _loc35_ / 100 * _loc12_ / 100;
                     _loc29_ = (_loc48_ - _loc13_) * _loc11_ / 100;
                     _loc32_ = _loc32_ - _loc26_;
                     _loc33_ = _loc33_ - _loc28_;
                     _loc34_ = _loc34_ - _loc27_;
                     _loc35_ = _loc35_ - _loc29_;
                     break;
                  case 1067:
                  case 1068:
                  case 1069:
                  case 1070:
                  case 1071:
                     _loc47_ = _loc20_.minDamage * _loc36_ / 100 * _loc12_ / 100;
                     _loc26_ = (_loc47_ - _loc13_) * _loc11_ / 100;
                     _loc47_ = _loc20_.maxDamage * _loc37_ / 100 * _loc12_ / 100;
                     _loc28_ = (_loc47_ - _loc13_) * _loc11_ / 100;
                     _loc48_ = _loc20_.minCriticalDamage * _loc38_ / 100 * _loc12_ / 100;
                     _loc27_ = (_loc48_ - _loc13_) * _loc11_ / 100;
                     _loc48_ = _loc20_.maxCriticalDamage * _loc39_ / 100 * _loc12_ / 100;
                     _loc29_ = (_loc48_ - _loc13_) * _loc11_ / 100;
                     _loc36_ = _loc36_ - _loc26_;
                     _loc37_ = _loc37_ - _loc28_;
                     _loc38_ = _loc38_ - _loc27_;
                     _loc39_ = _loc39_ - _loc29_;
                     break;
               }
            }
            _loc26_ = _loc26_ < 0?0:_loc26_;
            _loc28_ = _loc28_ < 0?0:_loc28_;
            _loc27_ = _loc27_ < 0?0:_loc27_;
            _loc29_ = _loc29_ < 0?0:_loc29_;
            if(MP_BASED_DAMAGE_EFFECTS_IDS.indexOf(_loc20_.effectId) != -1)
            {
               _loc26_ = _loc26_ * _loc31_;
               _loc28_ = _loc28_ * _loc31_;
               _loc27_ = _loc27_ * _loc31_;
               _loc29_ = _loc29_ * _loc31_;
            }
            if(DamageUtil.EROSION_DAMAGE_EFFECTS_IDS.indexOf(_loc20_.effectId) != -1)
            {
               _loc20_.minErosionDamage = _loc20_.minErosionDamage + (param2.targetErosionLifePoints + param2.targetSpellMinErosionLifePoints) * _loc20_.minErosionPercent / 100;
               _loc20_.maxErosionDamage = _loc20_.maxErosionDamage + (param2.targetErosionLifePoints + param2.targetSpellMaxErosionLifePoints) * _loc20_.maxErosionPercent / 100;
               if(_loc20_.hasCritical)
               {
                  _loc20_.minCriticalErosionDamage = _loc20_.minCriticalErosionDamage + (param2.targetErosionLifePoints + param2.targetSpellMinCriticalErosionLifePoints) * _loc20_.minCriticalErosionPercent / 100;
                  _loc20_.maxCriticalErosionDamage = _loc20_.maxCriticalErosionDamage + (param2.targetErosionLifePoints + param2.targetSpellMaxCriticalErosionLifePoints) * _loc20_.maxCriticalErosionPercent / 100;
               }
            }
            else
            {
               param2.targetSpellMinErosionLifePoints = param2.targetSpellMinErosionLifePoints + _loc26_ * (10 + param2.targetErosionPercentBonus) / 100;
               param2.targetSpellMaxErosionLifePoints = param2.targetSpellMaxErosionLifePoints + _loc28_ * (10 + param2.targetErosionPercentBonus) / 100;
               param2.targetSpellMinCriticalErosionLifePoints = param2.targetSpellMinCriticalErosionLifePoints + _loc27_ * (10 + param2.targetErosionPercentBonus) / 100;
               param2.targetSpellMaxCriticalErosionLifePoints = param2.targetSpellMaxCriticalErosionLifePoints + _loc29_ * (10 + param2.targetErosionPercentBonus) / 100;
            }
            _loc22_ = _loc22_ + _loc26_;
            _loc24_ = _loc24_ + _loc28_;
            _loc23_ = _loc23_ + _loc27_;
            _loc25_ = _loc25_ + _loc29_;
            _loc42_++;
         }
         var _loc45_:EffectDamage = new EffectDamage(_loc21_,param1.element,param1.random);
         _loc45_.minDamage = _loc22_;
         _loc45_.maxDamage = _loc24_;
         _loc45_.minCriticalDamage = _loc23_;
         _loc45_.maxCriticalDamage = _loc25_;
         _loc45_.minErosionDamage = param1.minErosionDamage * _loc12_ / 100;
         _loc45_.minErosionDamage = _loc45_.minErosionDamage * _loc11_ / 100;
         _loc45_.maxErosionDamage = param1.maxErosionDamage * _loc12_ / 100;
         _loc45_.maxErosionDamage = _loc45_.maxErosionDamage * _loc11_ / 100;
         _loc45_.minCriticalErosionDamage = param1.minCriticalErosionDamage * _loc12_ / 100;
         _loc45_.minCriticalErosionDamage = _loc45_.minCriticalErosionDamage * _loc11_ / 100;
         _loc45_.maxCriticalErosionDamage = param1.maxCriticalErosionDamage * _loc12_ / 100;
         _loc45_.maxCriticalErosionDamage = _loc45_.maxCriticalErosionDamage * _loc11_ / 100;
         _loc45_.hasCritical = param1.hasCriticalDamage;
         return _loc45_;
      }
      
      private static function getDamage(param1:int, param2:Boolean, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Number = 1) : int
      {
         if(!param2 && param3 + param4 <= 0)
         {
            var param3:* = 1;
            var param4:* = 0;
         }
         var _loc12_:int = param1 > 0?Math.floor(param1 * (100 + param3 + param4) / 100) + param5 + param6:0;
         var _loc13_:int = _loc12_ > 0?(_loc12_ + param7) * param10 / 100:0;
         var _loc14_:int = _loc13_ > 0?_loc13_ - param8:0;
         _loc14_ = _loc14_ < 0?0:_loc14_;
         return _loc14_ * param9 / 100 * param11;
      }
      
      private static function getMidLifeDamageMultiplier(param1:int) : Number
      {
         return Math.pow(Math.cos(2 * Math.PI * (param1 * 0.01 - 0.5)) + 1,2) / 4;
      }
      
      private static function getDistance(param1:uint, param2:uint) : int
      {
         return MapPoint.fromCellId(param1).distanceToCell(MapPoint.fromCellId(param2));
      }
      
      private static function getSquareDistance(param1:uint, param2:uint) : int
      {
         var _loc3_:MapPoint = MapPoint.fromCellId(param1);
         var _loc4_:MapPoint = MapPoint.fromCellId(param2);
         return Math.max(Math.abs(_loc3_.x - _loc4_.x),Math.abs(_loc3_.y - _loc4_.y));
      }
      
      public static function getShapeEfficiency(param1:uint, param2:uint, param3:uint, param4:int, param5:int, param6:int, param7:int) : Number
      {
         var _loc8_:* = 0;
         switch(param1)
         {
            case SpellShapeEnum.A:
            case SpellShapeEnum.a:
            case SpellShapeEnum.Z:
            case SpellShapeEnum.I:
            case SpellShapeEnum.O:
            case SpellShapeEnum.semicolon:
            case SpellShapeEnum.empty:
            case SpellShapeEnum.P:
               return DAMAGE_NOT_BOOSTED;
            case SpellShapeEnum.B:
            case SpellShapeEnum.V:
            case SpellShapeEnum.G:
            case SpellShapeEnum.W:
               _loc8_ = getSquareDistance(param2,param3);
               break;
            case SpellShapeEnum.minus:
            case SpellShapeEnum.plus:
            case SpellShapeEnum.U:
               _loc8_ = getDistance(param2,param3) / 2;
               break;
            default:
               _loc8_ = getDistance(param2,param3);
         }
         return getSimpleEfficiency(_loc8_,param4,param5,param6,param7);
      }
      
      public static function getSimpleEfficiency(param1:int, param2:int, param3:int, param4:int, param5:int) : Number
      {
         if(param4 == 0)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param2 <= 0 || param2 >= UNLIMITED_ZONE_SIZE)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param1 > param2)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param4 <= 0)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param3 != 0)
         {
            if(param1 <= param3)
            {
               return DAMAGE_NOT_BOOSTED;
            }
            return Math.max(0,DAMAGE_NOT_BOOSTED - 0.01 * Math.min(param1 - param3,param5) * param4);
         }
         return Math.max(0,DAMAGE_NOT_BOOSTED - 0.01 * Math.min(param1,param5) * param4);
      }
      
      public static function getPortalsSpellEfficiencyBonus(param1:int) : Number
      {
         var _loc3_:* = false;
         var _loc4_:MapPoint = null;
         var _loc8_:Vector.<MarkInstance> = null;
         var _loc9_:* = 0;
         var _loc10_:MarkInstance = null;
         var _loc11_:MarkInstance = null;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc2_:Number = 1;
         var _loc5_:Vector.<MapPoint> = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
         for each(_loc4_ in _loc5_)
         {
            if(_loc4_.cellId == param1)
            {
               _loc3_ = true;
               break;
            }
         }
         if(!_loc3_)
         {
            return _loc2_;
         }
         var _loc6_:Vector.<uint> = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(param1),_loc5_);
         var _loc7_:int = _loc6_.length;
         if(_loc7_ > 1)
         {
            _loc8_ = new Vector.<MarkInstance>(0);
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc8_.push(MarkedCellsManager.getInstance().getMarkAtCellId(_loc6_[_loc9_],GameActionMarkTypeEnum.PORTAL));
               _loc9_++;
            }
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc10_ = _loc8_[_loc9_];
               _loc12_ = Math.max(_loc12_,int(_loc10_.associatedSpellLevel.effects[0].parameter2));
               if(_loc11_)
               {
                  _loc13_ = _loc13_ + MapPoint.fromCellId(_loc10_.cells[0]).distanceToCell(MapPoint.fromCellId(_loc11_.cells[0]));
               }
               _loc11_ = _loc10_;
               _loc9_++;
            }
            _loc2_ = 1 + (_loc12_ + _loc8_.length * _loc13_) / 100;
         }
         return _loc2_;
      }
      
      public static function getSplashDamages(param1:Vector.<TriggeredSpell>, param2:SpellDamageInfo) : Vector.<SplashDamage>
      {
         var _loc3_:Vector.<SplashDamage> = null;
         var _loc4_:TriggeredSpell = null;
         var _loc5_:SpellWrapper = null;
         var _loc6_:EffectInstance = null;
         var _loc7_:IZone = null;
         var _loc8_:Vector.<uint> = null;
         var _loc9_:uint = 0;
         var _loc10_:Vector.<int> = null;
         var _loc12_:Array = null;
         var _loc13_:IEntity = null;
         var _loc11_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         for each(_loc4_ in param1)
         {
            _loc5_ = _loc4_.spell;
            for each(_loc6_ in _loc5_.effects)
            {
               if(SPLASH_EFFECTS_IDS.indexOf(_loc6_.effectId) != -1)
               {
                  _loc7_ = SpellZoneManager.getInstance().getSpellZone(_loc5_,false,false);
                  _loc8_ = _loc7_.getCells(param2.targetCell);
                  _loc10_ = null;
                  for each(_loc9_ in _loc8_)
                  {
                     _loc12_ = EntitiesManager.getInstance().getEntitiesOnCell(_loc9_,AnimatedCharacter);
                     for each(_loc13_ in _loc12_)
                     {
                        if((_loc11_.getEntityInfos(_loc13_.id)) && (verifySpellEffectMask(_loc5_.playerId,_loc13_.id,_loc6_,param2.targetCell)))
                        {
                           if(!_loc3_)
                           {
                              _loc3_ = new Vector.<SplashDamage>(0);
                           }
                           if(!_loc10_)
                           {
                              _loc10_ = new Vector.<int>(0);
                           }
                           _loc10_.push(_loc13_.id);
                        }
                     }
                  }
                  if(_loc10_)
                  {
                     _loc3_.push(new SplashDamage(_loc5_.id,_loc5_.playerId,_loc10_,DamageUtil.getSpellDamage(param2,false,false),_loc6_.effectId,(_loc6_ as EffectInstanceDice).diceNum,Effect.getEffectById(_loc6_.effectId).elementId,_loc6_.random,_loc6_.rawZone.charCodeAt(0),_loc6_.zoneSize,_loc6_.zoneMinSize,_loc6_.zoneEfficiencyPercent,_loc6_.zoneMaxEfficiency,_loc4_.hasCritical));
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public static function getAverageElementResistance(param1:uint, param2:Vector.<int>) : int
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case NEUTRAL_ELEMENT:
               _loc3_ = "neutralElementResistPercent";
               break;
            case EARTH_ELEMENT:
               _loc3_ = "earthElementResistPercent";
               break;
            case FIRE_ELEMENT:
               _loc3_ = "fireElementResistPercent";
               break;
            case WATER_ELEMENT:
               _loc3_ = "waterElementResistPercent";
               break;
            case AIR_ELEMENT:
               _loc3_ = "airElementResistPercent";
               break;
         }
         return getAverageStat(_loc3_,param2);
      }
      
      public static function getAverageElementReduction(param1:uint, param2:Vector.<int>) : int
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case NEUTRAL_ELEMENT:
               _loc3_ = "neutralElementReduction";
               break;
            case EARTH_ELEMENT:
               _loc3_ = "earthElementReduction";
               break;
            case FIRE_ELEMENT:
               _loc3_ = "fireElementReduction";
               break;
            case WATER_ELEMENT:
               _loc3_ = "waterElementReduction";
               break;
            case AIR_ELEMENT:
               _loc3_ = "airElementReduction";
               break;
         }
         return getAverageStat(_loc3_,param2);
      }
      
      public static function getAverageBuffElementReduction(param1:SpellDamageInfo, param2:EffectDamage, param3:Vector.<int>) : int
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         for each(_loc5_ in param3)
         {
            _loc4_ = _loc4_ + getBuffElementReduction(param1,param2,_loc5_);
         }
         return _loc4_ / param3.length;
      }
      
      public static function getBuffElementReduction(param1:SpellDamageInfo, param2:EffectDamage, param3:int) : int
      {
         var _loc5_:BasicBuff = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:EffectInstance = null;
         var _loc10_:* = 0;
         var _loc12_:* = false;
         var _loc4_:Array = BuffManager.getInstance().getAllBuff(param3);
         var _loc11_:Dictionary = new Dictionary(true);
         _loc9_ = new EffectInstance();
         _loc9_.effectId = param2.effectId;
         for each(_loc5_ in _loc4_)
         {
            _loc7_ = _loc5_.effects.triggers;
            _loc12_ = (_loc5_.canBeDispell()) && _loc5_.effects.duration - param1.spellTargetEffectsDurationReduction <= 0;
            if(!_loc12_ && (_loc7_))
            {
               _loc8_ = _loc7_.split("|");
               if(!_loc11_[_loc5_.castingSpell.spell.id])
               {
                  _loc11_[_loc5_.castingSpell.spell.id] = new Vector.<int>(0);
               }
               for each(_loc6_ in _loc8_)
               {
                  if(_loc5_.actionId == 265 && (verifyEffectTrigger(param1.casterId,param3,null,_loc9_,param1.isWeapon,_loc6_,param1.spellCenterCell)))
                  {
                     if(_loc11_[_loc5_.castingSpell.spell.id].indexOf(param2.element) == -1)
                     {
                        _loc10_ = _loc10_ + (param1.targetLevel / 20 + 1) * (_loc5_.effects as EffectInstanceInteger).value;
                        if(_loc11_[_loc5_.castingSpell.spell.id].indexOf(param2.element) == -1)
                        {
                           _loc11_[_loc5_.castingSpell.spell.id].push(param2.element);
                        }
                     }
                  }
               }
            }
         }
         return _loc10_;
      }
      
      public static function getAverageStat(param1:String, param2:Vector.<int>) : int
      {
         var _loc4_:* = 0;
         var _loc5_:GameFightFighterInformations = null;
         var _loc6_:* = 0;
         var _loc3_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!_loc3_ || !param2 || param2.length == 0)
         {
            return -1;
         }
         if(param1)
         {
            for each(_loc4_ in param2)
            {
               _loc5_ = _loc3_.getEntityInfos(_loc4_) as GameFightFighterInformations;
               _loc6_ = _loc6_ + _loc5_.stats[param1];
            }
         }
         return _loc6_ / param2.length;
      }
   }
}
