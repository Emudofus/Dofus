package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostWeaponDamagesEffect;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellImmunityEffect;
   import com.ankamagames.dofus.logic.game.fight.types.SpellBuff;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporarySpellBoostEffect;
   import com.ankamagames.dofus.logic.game.fight.types.TriggeredBuff;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTriggeredEffect;
   import com.ankamagames.dofus.logic.game.fight.types.StateBuff;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostStateEffect;
   import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
   import com.ankamagames.dofus.network.types.game.actions.fight.FightTemporaryBoostEffect;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class BuffManager extends Object
   {
      
      public function BuffManager() {
         this._buffs = new Array();
         this._finishingBuffs = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      public static const INCREMENT_MODE_SOURCE:int = 1;
      
      public static const INCREMENT_MODE_TARGET:int = 2;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BuffManager));
      
      private static var _self:BuffManager;
      
      public static function getInstance() : BuffManager {
         if(!_self)
         {
            _self = new BuffManager();
         }
         return _self;
      }
      
      public static function makeBuffFromEffect(param1:AbstractFightDispellableEffect, param2:CastingSpell, param3:uint) : BasicBuff {
         var _loc4_:BasicBuff = null;
         var _loc5_:FightTemporaryBoostWeaponDamagesEffect = null;
         var _loc6_:FightTemporarySpellImmunityEffect = null;
         switch(true)
         {
            case param1 is FightTemporarySpellBoostEffect:
               _loc4_ = new SpellBuff(param1 as FightTemporarySpellBoostEffect,param2,param3);
               break;
            case param1 is FightTriggeredEffect:
               _loc4_ = new TriggeredBuff(param1 as FightTriggeredEffect,param2,param3);
               break;
            case param1 is FightTemporaryBoostWeaponDamagesEffect:
               _loc5_ = param1 as FightTemporaryBoostWeaponDamagesEffect;
               _loc4_ = new BasicBuff(param1,param2,param3,_loc5_.weaponTypeId,_loc5_.delta,_loc5_.weaponTypeId);
               break;
            case param1 is FightTemporaryBoostStateEffect:
               _loc4_ = new StateBuff(param1 as FightTemporaryBoostStateEffect,param2,param3);
               break;
            case param1 is FightTemporarySpellImmunityEffect:
               _loc6_ = param1 as FightTemporarySpellImmunityEffect;
               _loc4_ = new BasicBuff(param1,param2,param3,_loc6_.immuneSpellId,null,null);
               break;
            case param1 is FightTemporaryBoostEffect:
               _loc4_ = new StatBuff(param1 as FightTemporaryBoostEffect,param2,param3);
               break;
         }
         _loc4_.id = param1.uid;
         return _loc4_;
      }
      
      private var _buffs:Array;
      
      private var _finishingBuffs:Dictionary;
      
      public function destroy() : void {
         _self = null;
      }
      
      public function decrementDuration(param1:int) : void {
         this.incrementDuration(param1,-1);
      }
      
      public function synchronize() : void {
         var _loc1_:Array = null;
         var _loc2_:BasicBuff = null;
         for each (_loc1_ in this._buffs)
         {
            for each (_loc2_ in _loc1_)
            {
               _loc2_.undisable();
            }
         }
      }
      
      public function incrementDuration(param1:int, param2:int, param3:Boolean=false, param4:int=1) : void {
         var _loc7_:Array = null;
         var _loc8_:BasicBuff = null;
         var _loc9_:* = false;
         var _loc5_:Array = new Array();
         var _loc6_:* = false;
         for each (_loc7_ in this._buffs)
         {
            for each (_loc8_ in _loc7_)
            {
               if(param4 == INCREMENT_MODE_SOURCE && _loc8_.aliveSource == param1 || param4 == INCREMENT_MODE_TARGET && _loc8_.targetId == param1)
               {
                  _loc9_ = _loc8_.incrementDuration(param2,param3);
                  if(_loc8_.active)
                  {
                     if(!_loc5_.hasOwnProperty(String(_loc8_.targetId)))
                     {
                        _loc5_[_loc8_.targetId] = new Array();
                     }
                     _loc5_[_loc8_.targetId].push(_loc8_);
                     if(_loc9_)
                     {
                        KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,_loc8_.id,_loc8_.targetId);
                     }
                  }
                  else
                  {
                     BasicBuff(_loc8_).onRemoved();
                     KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,_loc8_,_loc8_.targetId,"CoolDown");
                     if(param1 == CurrentPlayedFighterManager.getInstance().currentFighterId)
                     {
                        _loc6_ = true;
                     }
                  }
               }
               else
               {
                  if(!_loc5_.hasOwnProperty(String(_loc8_.targetId)))
                  {
                     _loc5_[_loc8_.targetId] = new Array();
                  }
                  _loc5_[_loc8_.targetId].push(_loc8_);
               }
            }
         }
         if(_loc6_)
         {
            KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
         }
         this._buffs = _loc5_;
      }
      
      public function markFinishingBuffs(param1:int, param2:Boolean=false) : void {
         var _loc3_:* = false;
         var _loc4_:BasicBuff = null;
         var _loc5_:* = false;
         var _loc6_:FightBattleFrame = null;
         var _loc7_:* = 0;
         var _loc8_:* = false;
         var _loc9_:* = 0;
         var _loc10_:StatBuff = null;
         if(this._buffs.hasOwnProperty(String(param1)))
         {
            _loc3_ = false;
            for each (_loc4_ in this._buffs[param1])
            {
               _loc5_ = false;
               if(_loc4_.duration == 1)
               {
                  _loc6_ = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                  if(_loc6_ == null)
                  {
                     return;
                  }
                  _loc7_ = 0;
                  _loc8_ = false;
                  for each (_loc9_ in _loc6_.fightersList)
                  {
                     if(_loc9_ == _loc4_.aliveSource)
                     {
                        _loc8_ = true;
                     }
                     if(_loc9_ == _loc6_.currentPlayerId)
                     {
                        _loc7_ = 1;
                     }
                     if(_loc7_ == 1)
                     {
                        if((_loc8_) && (!(_loc9_ == _loc6_.currentPlayerId) || !param2))
                        {
                           _loc7_ = 2;
                           _loc5_ = true;
                        }
                        else
                        {
                           if(_loc9_ == param1 && !(_loc9_ == _loc6_.currentPlayerId))
                           {
                              _loc7_ = 2;
                              _loc5_ = false;
                           }
                        }
                     }
                  }
                  if((_loc5_) && !param2)
                  {
                     _loc4_.finishing = true;
                     if(_loc4_ is StatBuff && !(param1 == PlayedCharacterManager.getInstance().id))
                     {
                        _loc10_ = _loc4_ as StatBuff;
                        if(_loc10_.statName)
                        {
                           param1 = _loc10_.targetId;
                           if(!this._finishingBuffs[param1])
                           {
                              this._finishingBuffs[param1] = new Array();
                           }
                           this._finishingBuffs[param1].push(_loc4_);
                        }
                     }
                     BasicBuff(_loc4_).onDisabled();
                     if(param1 == CurrentPlayedFighterManager.getInstance().currentFighterId)
                     {
                        _loc3_ = true;
                     }
                  }
               }
            }
            if(_loc3_)
            {
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            }
         }
      }
      
      public function addBuff(param1:BasicBuff, param2:Boolean=true) : void {
         var _loc3_:BasicBuff = null;
         var _loc4_:BasicBuff = null;
         if(!this._buffs[param1.targetId])
         {
            this._buffs[param1.targetId] = new Array();
         }
         for each (_loc4_ in this._buffs[param1.targetId])
         {
            if(param1.equals(_loc4_))
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         if(!_loc3_)
         {
            this._buffs[param1.targetId].push(param1);
         }
         else
         {
            if(((_loc3_.castingSpell.spellRank) && (_loc3_.castingSpell.spellRank.maxStack > 0)) && (_loc3_.stack) && _loc3_.stack.length == _loc3_.castingSpell.spellRank.maxStack)
            {
               return;
            }
            _loc3_.add(param1);
         }
         if(param2)
         {
            param1.onApplyed();
         }
         if(!_loc3_)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffAdd,param1.id,param1.targetId);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,_loc3_.id,_loc3_.targetId);
         }
      }
      
      public function updateBuff(param1:BasicBuff) : Boolean {
         var _loc3_:BasicBuff = null;
         var _loc2_:int = param1.targetId;
         if(!this._buffs[_loc2_])
         {
            return false;
         }
         var _loc4_:int = this.getBuffIndex(_loc2_,param1.id);
         if(_loc4_ == -1)
         {
            return false;
         }
         (this._buffs[_loc2_][_loc4_] as BasicBuff).onRemoved();
         (this._buffs[_loc2_][_loc4_] as BasicBuff).updateParam(param1.param1,param1.param2,param1.param3,param1.id);
         _loc3_ = this._buffs[_loc2_][_loc4_];
         if(!_loc3_)
         {
            return false;
         }
         _loc3_.onApplyed();
         KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,_loc3_.id,_loc2_);
         return true;
      }
      
      public function dispell(param1:int, param2:Boolean=false, param3:Boolean=false, param4:Boolean=false) : void {
         var _loc7_:BasicBuff = null;
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         for each (_loc7_ in this._buffs[param1])
         {
            if(_loc7_.canBeDispell(param2,int.MIN_VALUE,param4))
            {
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,_loc7_,param1,"Dispell");
               _loc7_.onRemoved();
               _loc5_.push(_loc7_);
            }
            else
            {
               _loc6_.push(_loc7_);
            }
         }
         this._buffs[param1] = _loc6_;
      }
      
      public function dispellSpell(param1:int, param2:uint, param3:Boolean=false, param4:Boolean=false, param5:Boolean=false) : void {
         var _loc8_:BasicBuff = null;
         var _loc9_:BasicBuff = null;
         var _loc6_:Array = new Array();
         var _loc7_:Array = new Array();
         for each (_loc8_ in this._buffs[param1])
         {
            if(param2 == _loc8_.castingSpell.spell.id && (_loc8_.canBeDispell(param3,int.MIN_VALUE,param5)))
            {
               _loc8_.onRemoved();
               _loc6_.push(_loc8_);
            }
            else
            {
               _loc7_.push(_loc8_);
            }
         }
         this._buffs[param1] = _loc7_;
         for each (_loc9_ in _loc6_)
         {
            if(_loc9_.stack)
            {
               while(_loc9_.stack.length)
               {
                  _loc9_.stack.shift().onRemoved();
               }
            }
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,_loc9_,param1,"Dispell");
         }
      }
      
      public function dispellUniqueBuff(param1:int, param2:int, param3:Boolean=false, param4:Boolean=false, param5:Boolean=true) : void {
         var _loc6_:int = this.getBuffIndex(param1,param2);
         if(_loc6_ == -1)
         {
            return;
         }
         var _loc7_:BasicBuff = this._buffs[param1][_loc6_];
         if(_loc7_.canBeDispell(param3,param5?param2:int.MIN_VALUE,param4))
         {
            if((_loc7_.stack) && (_loc7_.stack.length > 1) && !param4)
            {
               _loc7_.onRemoved();
               switch(_loc7_.actionId)
               {
                  case 293:
                     _loc7_.param1 = _loc7_.stack[0].param1;
                     _loc7_.param2 = _loc7_.param2 - _loc7_.stack[0].param2;
                     _loc7_.param3 = _loc7_.param3 - _loc7_.stack[0].param3;
                     if((_loc7_.castingSpell.spellRank) && (_loc7_.castingSpell.spellRank.maxStack > 0) && _loc7_.stack.length == _loc7_.castingSpell.spellRank.maxStack)
                     {
                        return;
                     }
                     break;
                  case 788:
                     _loc7_.param1 = _loc7_.param1 - _loc7_.stack[0].param2;
                     break;
                  case 950:
                  case 951:
                     break;
                  default:
                     _loc7_.param1 = _loc7_.param1 - _loc7_.stack[0].param1;
                     _loc7_.param2 = _loc7_.param2 - _loc7_.stack[0].param2;
                     _loc7_.param3 = _loc7_.param3 - _loc7_.stack[0].param3;
               }
               _loc7_.stack.shift();
               _loc7_.refreshDescription();
               _loc7_.onApplyed();
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,_loc7_.id,_loc7_.targetId);
            }
            else
            {
               this._buffs[param1].splice(this._buffs[param1].indexOf(_loc7_),1);
               _loc7_.onRemoved();
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,_loc7_,param1,"Dispell");
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,_loc7_,param1,"");
               if(param1 == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               }
            }
         }
      }
      
      public function removeLinkedBuff(param1:int, param2:Boolean=false, param3:Boolean=false) : Array {
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:BasicBuff = null;
         var _loc4_:Array = [];
         var _loc5_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc6_:GameFightFighterInformations = _loc5_.getEntityInfos(param1) as GameFightFighterInformations;
         for each (_loc7_ in this._buffs)
         {
            _loc8_ = new Array();
            for each (_loc9_ in _loc7_)
            {
               _loc8_.push(_loc9_);
            }
            for each (_loc9_ in _loc8_)
            {
               if(_loc9_.source == param1)
               {
                  this.dispellUniqueBuff(_loc9_.targetId,_loc9_.id,param2,param3,false);
                  if(_loc4_.indexOf(_loc9_.targetId) == -1)
                  {
                     _loc4_.push(_loc9_.targetId);
                  }
                  if((param3) && (_loc6_.stats.summoned))
                  {
                     _loc9_.aliveSource = _loc6_.stats.summoner;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function reaffectBuffs(param1:int) : void {
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         var _loc5_:BasicBuff = null;
         var _loc2_:GameFightFighterInformations = this.fightEntitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
         if(_loc2_.stats.summoned)
         {
            _loc3_ = this.getNextFighter(param1);
            if(_loc3_ == -1)
            {
               return;
            }
            for each (_loc4_ in this._buffs)
            {
               for each (_loc5_ in _loc4_)
               {
                  if(_loc5_.aliveSource == param1)
                  {
                     _loc5_.aliveSource = _loc3_;
                  }
               }
            }
         }
      }
      
      private function getNextFighter(param1:int) : int {
         var _loc4_:* = 0;
         var _loc2_:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(_loc2_ == null)
         {
            return -1;
         }
         var _loc3_:* = false;
         for each (_loc4_ in _loc2_.fightersList)
         {
            if(_loc3_)
            {
               return _loc4_;
            }
            if(_loc4_ == param1)
            {
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            return _loc2_.fightersList[0];
         }
         return -1;
      }
      
      public function getFighterInfo(param1:int) : GameFightFighterInformations {
         return this.fightEntitiesFrame.getEntityInfos(param1) as GameFightFighterInformations;
      }
      
      public function getAllBuff(param1:int) : Array {
         return this._buffs[param1];
      }
      
      public function getBuff(param1:uint, param2:int) : BasicBuff {
         var _loc3_:BasicBuff = null;
         for each (_loc3_ in this._buffs[param2])
         {
            if(param1 == _loc3_.id)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getFinishingBuffs(param1:int) : Array {
         var _loc2_:Array = this._finishingBuffs[param1];
         delete this._finishingBuffs[[param1]];
         return _loc2_;
      }
      
      private function get fightEntitiesFrame() : FightEntitiesFrame {
         return Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
      }
      
      private function getBuffIndex(param1:int, param2:int) : int {
         var _loc3_:Object = null;
         var _loc4_:BasicBuff = null;
         for (_loc3_ in this._buffs[param1])
         {
            if(param2 == this._buffs[param1][_loc3_].id)
            {
               return int(_loc3_);
            }
            for each (_loc4_ in (this._buffs[param1][_loc3_] as BasicBuff).stack)
            {
               if(param2 == _loc4_.id)
               {
                  return int(_loc3_);
               }
            }
         }
         return -1;
      }
   }
}
