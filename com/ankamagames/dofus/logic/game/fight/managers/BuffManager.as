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
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class BuffManager extends Object
   {
      
      public function BuffManager() {
         this._buffs = new Array();
         this._finishingBuffs = new Dictionary();
         this.spellBuffsToIgnore = new Vector.<CastingSpell>();
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
      
      private static var _buffSpellId:int = -1;
      
      private static var _buffTargetId:int;
      
      private static var _buffOrder:int;
      
      public static function getInstance() : BuffManager {
         if(!_self)
         {
            _self = new BuffManager();
         }
         return _self;
      }
      
      public static function makeBuffFromEffect(effect:AbstractFightDispellableEffect, castingSpell:CastingSpell, actionId:uint) : BasicBuff {
         var buff:BasicBuff = null;
         var ftbwde:FightTemporaryBoostWeaponDamagesEffect = null;
         var ftsie:FightTemporarySpellImmunityEffect = null;
         switch(true)
         {
            case effect is FightTemporarySpellBoostEffect:
               buff = new SpellBuff(effect as FightTemporarySpellBoostEffect,castingSpell,actionId);
               break;
            case effect is FightTriggeredEffect:
               buff = new TriggeredBuff(effect as FightTriggeredEffect,castingSpell,actionId);
               break;
            case effect is FightTemporaryBoostWeaponDamagesEffect:
               ftbwde = effect as FightTemporaryBoostWeaponDamagesEffect;
               buff = new BasicBuff(effect,castingSpell,actionId,ftbwde.weaponTypeId,ftbwde.delta,ftbwde.weaponTypeId);
               break;
            case effect is FightTemporaryBoostStateEffect:
               buff = new StateBuff(effect as FightTemporaryBoostStateEffect,castingSpell,actionId);
               break;
            case effect is FightTemporarySpellImmunityEffect:
               ftsie = effect as FightTemporarySpellImmunityEffect;
               buff = new BasicBuff(effect,castingSpell,actionId,ftsie.immuneSpellId,null,null);
               break;
            case effect is FightTemporaryBoostEffect:
               buff = new StatBuff(effect as FightTemporaryBoostEffect,castingSpell,actionId);
               break;
         }
         buff.id = effect.uid;
         if((!(_buffSpellId == castingSpell.spell.id)) || (!(_buffTargetId == buff.targetId)))
         {
            _buffSpellId = castingSpell.spell.id;
            _buffTargetId = buff.targetId;
            _buffOrder = 0;
         }
         else
         {
            _buffOrder++;
         }
         buff.effects.order = _buffOrder;
         return buff;
      }
      
      private var _buffs:Array;
      
      private var _finishingBuffs:Dictionary;
      
      public var spellBuffsToIgnore:Vector.<CastingSpell>;
      
      public function destroy() : void {
         _self = null;
         this.spellBuffsToIgnore.length = 0;
      }
      
      public function decrementDuration(targetId:int) : void {
         this.incrementDuration(targetId,-1);
      }
      
      public function synchronize() : void {
         var buffTarget:Array = null;
         var buffItem:BasicBuff = null;
         for each (buffTarget in this._buffs)
         {
            for each (buffItem in buffTarget)
            {
               buffItem.undisable();
            }
         }
      }
      
      public function incrementDuration(targetId:int, delta:int, dispellEffect:Boolean=false, incrementMode:int=1) : void {
         var buffTarget:Array = null;
         var buffItem:BasicBuff = null;
         var modified:* = false;
         var skipBuffUpdate:* = false;
         var spell:CastingSpell = null;
         var newBuffs:Array = new Array();
         var updateStatList:Boolean = false;
         for each (buffTarget in this._buffs)
         {
            for each (buffItem in buffTarget)
            {
               if((incrementMode == INCREMENT_MODE_SOURCE) && (buffItem.aliveSource == targetId) || (incrementMode == INCREMENT_MODE_TARGET) && (buffItem.targetId == targetId))
               {
                  if((incrementMode == INCREMENT_MODE_SOURCE) && (this.spellBuffsToIgnore.length))
                  {
                     skipBuffUpdate = false;
                     for each (spell in this.spellBuffsToIgnore)
                     {
                        if((spell.castingSpellId == buffItem.castingSpell.castingSpellId) && (spell.casterId == targetId))
                        {
                           skipBuffUpdate = true;
                           break;
                        }
                     }
                     if(skipBuffUpdate)
                     {
                        if(!newBuffs.hasOwnProperty(String(buffItem.targetId)))
                        {
                           newBuffs[buffItem.targetId] = new Array();
                        }
                        newBuffs[buffItem.targetId].push(buffItem);
                        continue;
                     }
                  }
                  modified = buffItem.incrementDuration(delta,dispellEffect);
                  if(buffItem.active)
                  {
                     if(!newBuffs.hasOwnProperty(String(buffItem.targetId)))
                     {
                        newBuffs[buffItem.targetId] = new Array();
                     }
                     newBuffs[buffItem.targetId].push(buffItem);
                     if(modified)
                     {
                        KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,buffItem.id,buffItem.targetId);
                     }
                  }
                  else
                  {
                     BasicBuff(buffItem).onRemoved();
                     KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,buffItem,buffItem.targetId,"CoolDown");
                     if(targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                     {
                        updateStatList = true;
                     }
                  }
               }
               else
               {
                  if(!newBuffs.hasOwnProperty(String(buffItem.targetId)))
                  {
                     newBuffs[buffItem.targetId] = new Array();
                  }
                  newBuffs[buffItem.targetId].push(buffItem);
               }
            }
         }
         if(updateStatList)
         {
            KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
         }
         this._buffs = newBuffs;
      }
      
      public function markFinishingBuffs(targetId:int, ignoreCurrent:Boolean=false) : void {
         var updateStatList:* = false;
         var buffItem:BasicBuff = null;
         var mark:* = false;
         var fightBattleFrame:FightBattleFrame = null;
         var state:* = 0;
         var casterFound:* = false;
         var fighter:* = 0;
         var statBuffItem:StatBuff = null;
         if(this._buffs.hasOwnProperty(String(targetId)))
         {
            updateStatList = false;
            for each (buffItem in this._buffs[targetId])
            {
               mark = false;
               if(buffItem.duration == 1)
               {
                  fightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
                  if(fightBattleFrame == null)
                  {
                     return;
                  }
                  state = 0;
                  casterFound = false;
                  for each (fighter in fightBattleFrame.fightersList)
                  {
                     if(fighter == buffItem.aliveSource)
                     {
                        casterFound = true;
                     }
                     if(fighter == fightBattleFrame.currentPlayerId)
                     {
                        state = 1;
                     }
                     if(state == 1)
                     {
                        if((casterFound) && ((!(fighter == fightBattleFrame.currentPlayerId)) || (!ignoreCurrent)))
                        {
                           state = 2;
                           mark = true;
                        }
                        else
                        {
                           if((fighter == targetId) && (!(fighter == fightBattleFrame.currentPlayerId)))
                           {
                              state = 2;
                              mark = false;
                           }
                        }
                     }
                  }
                  if((mark) && (!ignoreCurrent))
                  {
                     buffItem.finishing = true;
                     if((buffItem is StatBuff) && (!(targetId == PlayedCharacterManager.getInstance().id)))
                     {
                        statBuffItem = buffItem as StatBuff;
                        if(statBuffItem.statName)
                        {
                           targetId = statBuffItem.targetId;
                           if(!this._finishingBuffs[targetId])
                           {
                              this._finishingBuffs[targetId] = new Array();
                           }
                           this._finishingBuffs[targetId].push(buffItem);
                        }
                     }
                     BasicBuff(buffItem).onDisabled();
                     if(targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
                     {
                        updateStatList = true;
                     }
                  }
               }
            }
            if(updateStatList)
            {
               KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
            }
         }
      }
      
      public function addBuff(buff:BasicBuff, applyBuff:Boolean=true) : void {
         var sameBuff:BasicBuff = null;
         var actualBuff:BasicBuff = null;
         if(!this._buffs[buff.targetId])
         {
            this._buffs[buff.targetId] = new Array();
         }
         for each (actualBuff in this._buffs[buff.targetId])
         {
            if(buff.equals(actualBuff))
            {
               sameBuff = actualBuff;
               break;
            }
         }
         if(!sameBuff)
         {
            this._buffs[buff.targetId].push(buff);
         }
         else
         {
            if(((sameBuff.castingSpell.spellRank) && (sameBuff.castingSpell.spellRank.maxStack > 0)) && (sameBuff.stack) && (sameBuff.stack.length == sameBuff.castingSpell.spellRank.maxStack))
            {
               return;
            }
            sameBuff.add(buff);
         }
         if(applyBuff)
         {
            buff.onApplyed();
         }
         if(!sameBuff)
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffAdd,buff.id,buff.targetId);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,sameBuff.id,sameBuff.targetId);
         }
      }
      
      public function updateBuff(buff:BasicBuff) : Boolean {
         var oldBuff:BasicBuff = null;
         var targetId:int = buff.targetId;
         if(!this._buffs[targetId])
         {
            return false;
         }
         var i:int = this.getBuffIndex(targetId,buff.id);
         if(i == -1)
         {
            return false;
         }
         (this._buffs[targetId][i] as BasicBuff).onRemoved();
         (this._buffs[targetId][i] as BasicBuff).updateParam(buff.param1,buff.param2,buff.param3,buff.id);
         oldBuff = this._buffs[targetId][i];
         if(!oldBuff)
         {
            return false;
         }
         oldBuff.onApplyed();
         KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,oldBuff.id,targetId);
         return true;
      }
      
      public function dispell(targetId:int, forceUndispellable:Boolean=false, critical:Boolean=false, dying:Boolean=false) : void {
         var buff:BasicBuff = null;
         var deletedBuffs:Array = new Array();
         var newBuffs:Array = new Array();
         for each (buff in this._buffs[targetId])
         {
            if(buff.canBeDispell(forceUndispellable,int.MIN_VALUE,dying))
            {
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,buff,targetId,"Dispell");
               buff.onRemoved();
               deletedBuffs.push(buff);
            }
            else
            {
               newBuffs.push(buff);
            }
         }
         this._buffs[targetId] = newBuffs;
      }
      
      public function dispellSpell(targetId:int, spellId:uint, forceUndispellable:Boolean=false, critical:Boolean=false, dying:Boolean=false) : void {
         var buff:BasicBuff = null;
         var deletedBuff:BasicBuff = null;
         var deletedBuffs:Array = new Array();
         var newBuffs:Array = new Array();
         for each (buff in this._buffs[targetId])
         {
            if((spellId == buff.castingSpell.spell.id) && (buff.canBeDispell(forceUndispellable,int.MIN_VALUE,dying)))
            {
               buff.onRemoved();
               deletedBuffs.push(buff);
            }
            else
            {
               newBuffs.push(buff);
            }
         }
         this._buffs[targetId] = newBuffs;
         for each (deletedBuff in deletedBuffs)
         {
            if(deletedBuff.stack)
            {
               while(deletedBuff.stack.length)
               {
                  deletedBuff.stack.shift().onRemoved();
               }
            }
            KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,deletedBuff,targetId,"Dispell");
         }
      }
      
      public function dispellUniqueBuff(targetId:int, boostUID:int, forceUndispellable:Boolean=false, dying:Boolean=false, ultimateDebuff:Boolean=true) : void {
         var i:int = this.getBuffIndex(targetId,boostUID);
         if(i == -1)
         {
            return;
         }
         var buff:BasicBuff = this._buffs[targetId][i];
         if(buff.canBeDispell(forceUndispellable,ultimateDebuff?boostUID:int.MIN_VALUE,dying))
         {
            if((buff.stack) && (buff.stack.length > 1) && (!dying))
            {
               buff.onRemoved();
               switch(buff.actionId)
               {
                  case 293:
                     buff.param1 = buff.stack[0].param1;
                     buff.param2 = buff.param2 - buff.stack[0].param2;
                     buff.param3 = buff.param3 - buff.stack[0].param3;
                     if((buff.castingSpell.spellRank) && (buff.castingSpell.spellRank.maxStack > 0) && (buff.stack.length == buff.castingSpell.spellRank.maxStack))
                     {
                        return;
                     }
                     break;
                  case 788:
                     buff.param1 = buff.param1 - buff.stack[0].param2;
                     break;
                  case 950:
                  case 951:
                     break;
               }
               buff.stack.shift();
               buff.refreshDescription();
               buff.onApplyed();
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffUpdate,buff.id,buff.targetId);
            }
            else
            {
               this._buffs[targetId].splice(this._buffs[targetId].indexOf(buff),1);
               buff.onRemoved();
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,buff,targetId,"Dispell");
               KernelEventsManager.getInstance().processCallback(FightHookList.BuffRemove,buff,targetId,"");
               if(targetId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               }
            }
         }
      }
      
      public function removeLinkedBuff(sourceId:int, forceUndispellable:Boolean=false, dying:Boolean=false) : Array {
         var buffList:Array = null;
         var buffListCopy:Array = null;
         var buff:BasicBuff = null;
         var impactedTarget:Array = [];
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var infos:GameFightFighterInformations = entitiesFrame.getEntityInfos(sourceId) as GameFightFighterInformations;
         for each (buffList in this._buffs)
         {
            buffListCopy = new Array();
            for each (buff in buffList)
            {
               buffListCopy.push(buff);
            }
            for each (buff in buffListCopy)
            {
               if(buff.source == sourceId)
               {
                  this.dispellUniqueBuff(buff.targetId,buff.id,forceUndispellable,dying,false);
                  if(impactedTarget.indexOf(buff.targetId) == -1)
                  {
                     impactedTarget.push(buff.targetId);
                  }
                  if((dying) && (infos.stats.summoned))
                  {
                     buff.aliveSource = infos.stats.summoner;
                  }
               }
            }
         }
         return impactedTarget;
      }
      
      public function reaffectBuffs(sourceId:int) : void {
         var next:* = 0;
         var buffList:Array = null;
         var buff:BasicBuff = null;
         var entity:GameFightFighterInformations = this.fightEntitiesFrame.getEntityInfos(sourceId) as GameFightFighterInformations;
         if(entity.stats.summoned)
         {
            next = this.getNextFighter(sourceId);
            if(next == -1)
            {
               return;
            }
            for each (buffList in this._buffs)
            {
               for each (buff in buffList)
               {
                  if(buff.aliveSource == sourceId)
                  {
                     buff.aliveSource = next;
                  }
               }
            }
         }
      }
      
      private function getNextFighter(sourceId:int) : int {
         var fighter:* = 0;
         var frame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(frame == null)
         {
            return -1;
         }
         var found:Boolean = false;
         for each (fighter in frame.fightersList)
         {
            if(found)
            {
               return fighter;
            }
            if(fighter == sourceId)
            {
               found = true;
            }
         }
         if(found)
         {
            return frame.fightersList[0];
         }
         return -1;
      }
      
      public function getFighterInfo(targetId:int) : GameFightFighterInformations {
         return this.fightEntitiesFrame.getEntityInfos(targetId) as GameFightFighterInformations;
      }
      
      public function getAllBuff(targetId:int) : Array {
         return this._buffs[targetId];
      }
      
      public function getBuff(buffId:uint, playerId:int) : BasicBuff {
         var buff:BasicBuff = null;
         for each (buff in this._buffs[playerId])
         {
            if(buffId == buff.id)
            {
               return buff;
            }
         }
         return null;
      }
      
      public function getFinishingBuffs(fighterid:int) : Array {
         var buffArray:Array = this._finishingBuffs[fighterid];
         delete this._finishingBuffs[[fighterid]];
         return buffArray;
      }
      
      private function get fightEntitiesFrame() : FightEntitiesFrame {
         return Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
      }
      
      private function getBuffIndex(targetId:int, buffId:int) : int {
         var i:Object = null;
         var subBuff:BasicBuff = null;
         for (i in this._buffs[targetId])
         {
            if(buffId == this._buffs[targetId][i].id)
            {
               return int(i);
            }
            for each (subBuff in (this._buffs[targetId][i] as BasicBuff).stack)
            {
               if(buffId == subBuff.id)
               {
                  return int(i);
               }
            }
         }
         return -1;
      }
   }
}
