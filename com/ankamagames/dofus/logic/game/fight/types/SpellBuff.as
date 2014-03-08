package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterBaseCharacteristic;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellBoostEffect;
   
   public class SpellBuff extends BasicBuff
   {
      
      public function SpellBuff(param1:FightTemporarySpellBoostEffect=null, param2:CastingSpell=null, param3:int=0) {
         if(param1)
         {
            super(param1,param2,param3,param1.boostedSpellId,null,param1.delta);
            this.spellId = param1.boostedSpellId;
            this.delta = param1.delta;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellBuff));
      
      public var spellId:int;
      
      public var delta:int;
      
      public var modifType:int;
      
      override public function get type() : String {
         return "SpellBuff";
      }
      
      override public function onApplyed() : void {
         var _loc1_:* = false;
         var _loc2_:CharacterSpellModification = null;
         var _loc3_:Array = null;
         var _loc4_:SpellWrapper = null;
         var _loc5_:CharacterBaseCharacteristic = null;
         var _loc6_:CharacterSpellModification = null;
         if(targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_RANGEABLE)
            {
               this.modifType = CharacterSpellModificationTypeEnum.RANGEABLE;
            }
            else
            {
               if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_DMG)
               {
                  this.modifType = CharacterSpellModificationTypeEnum.DAMAGE;
               }
               else
               {
                  if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_BASE_DMG)
                  {
                     this.modifType = CharacterSpellModificationTypeEnum.BASE_DAMAGE;
                  }
                  else
                  {
                     if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_HEAL)
                     {
                        this.modifType = CharacterSpellModificationTypeEnum.HEAL_BONUS;
                     }
                     else
                     {
                        if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_AP_COST)
                        {
                           this.modifType = CharacterSpellModificationTypeEnum.AP_COST;
                        }
                        else
                        {
                           if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL)
                           {
                              this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL;
                           }
                           else
                           {
                              if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL_SET)
                              {
                                 this.modifType = CharacterSpellModificationTypeEnum.CAST_INTERVAL_SET;
                              }
                              else
                              {
                                 if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CC)
                                 {
                                    this.modifType = CharacterSpellModificationTypeEnum.CRITICAL_HIT_BONUS;
                                 }
                                 else
                                 {
                                    if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_CASTOUTLINE)
                                    {
                                       this.modifType = CharacterSpellModificationTypeEnum.CAST_LINE;
                                    }
                                    else
                                    {
                                       if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_NOLINEOFSIGHT)
                                       {
                                          this.modifType = CharacterSpellModificationTypeEnum.LOS;
                                       }
                                       else
                                       {
                                          if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTURN)
                                          {
                                             this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TURN;
                                          }
                                          else
                                          {
                                             if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTARGET)
                                             {
                                                this.modifType = CharacterSpellModificationTypeEnum.MAX_CAST_PER_TARGET;
                                             }
                                             else
                                             {
                                                if(actionId == ActionIdConverter.ACTION_BOOST_SPELL_RANGE)
                                                {
                                                   this.modifType = CharacterSpellModificationTypeEnum.RANGE;
                                                }
                                                else
                                                {
                                                   if(actionId == ActionIdConverter.ACTION_DEBOOST_SPELL_RANGE)
                                                   {
                                                      this.modifType = CharacterSpellModificationTypeEnum.RANGE;
                                                      this.delta = -this.delta;
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc1_ = false;
            for each (_loc2_ in PlayedCharacterManager.getInstance().characteristics.spellModifications)
            {
               if(this.spellId == _loc2_.spellId)
               {
                  if(_loc2_.modificationType == this.modifType)
                  {
                     _loc1_ = true;
                     _loc2_.value.contextModif = _loc2_.value.contextModif + this.delta;
                  }
               }
            }
            if(!_loc1_)
            {
               _loc5_ = new CharacterBaseCharacteristic();
               _loc5_.base = 0;
               _loc5_.alignGiftBonus = 0;
               _loc5_.contextModif = this.delta;
               _loc5_.objectsAndMountBonus = 0;
               _loc6_ = new CharacterSpellModification();
               _loc6_.modificationType = this.modifType;
               _loc6_.spellId = this.spellId;
               _loc6_.value = _loc5_;
               PlayedCharacterManager.getInstance().characteristics.spellModifications.push(_loc6_);
            }
            _loc3_ = SpellWrapper.getSpellWrappersById(this.spellId,targetId);
            for each (_loc4_ in _loc3_)
            {
               _loc4_ = SpellWrapper.create(_loc4_.position,_loc4_.spellId,_loc4_.spellLevel,true,targetId);
               _loc4_.versionNum++;
            }
         }
         super.onApplyed();
      }
      
      override public function onRemoved() : void {
         var _loc1_:CharacterSpellModification = null;
         var _loc2_:Array = null;
         var _loc3_:SpellWrapper = null;
         if(!_removed)
         {
            if(targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
               for each (_loc1_ in PlayedCharacterManager.getInstance().characteristics.spellModifications)
               {
                  if(this.spellId == _loc1_.spellId)
                  {
                     if(_loc1_.modificationType == this.modifType)
                     {
                        _loc1_.value.contextModif = _loc1_.value.contextModif - this.delta;
                     }
                  }
               }
               _loc2_ = SpellWrapper.getSpellWrappersById(this.spellId,targetId);
               for each (_loc3_ in _loc2_)
               {
                  _loc3_ = SpellWrapper.create(_loc3_.position,_loc3_.spellId,_loc3_.spellLevel,true,targetId);
                  _loc3_.versionNum++;
               }
            }
         }
         super.onRemoved();
      }
      
      override public function clone(param1:int=0) : BasicBuff {
         var _loc2_:SpellBuff = new SpellBuff();
         _loc2_.spellId = this.spellId;
         _loc2_.delta = this.delta;
         _loc2_.id = uid;
         _loc2_.uid = uid;
         _loc2_.actionId = actionId;
         _loc2_.targetId = targetId;
         _loc2_.castingSpell = castingSpell;
         _loc2_.duration = duration;
         _loc2_.dispelable = dispelable;
         _loc2_.source = source;
         _loc2_.aliveSource = aliveSource;
         _loc2_.parentBoostUid = parentBoostUid;
         _loc2_.initParam(param1,param2,param3);
         return _loc2_;
      }
   }
}
