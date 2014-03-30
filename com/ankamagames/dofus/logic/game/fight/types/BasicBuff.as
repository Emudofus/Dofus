package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.enums.FightDispellableEnum;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.network.types.game.actions.fight.AbstractFightDispellableEffect;
   
   public class BasicBuff extends Object
   {
      
      public function BasicBuff(effect:AbstractFightDispellableEffect=null, castingSpell:CastingSpell=null, actionId:uint=0, param1:*=null, param2:*=null, param3:*=null) {
         var fightBattleFrame:FightBattleFrame = null;
         super();
         if(effect)
         {
            this.id = effect.uid;
            this.uid = effect.uid;
            this.actionId = actionId;
            this.targetId = effect.targetId;
            this.castingSpell = castingSpell;
            this.duration = effect.turnDuration;
            this.dispelable = effect.dispelable;
            this.source = castingSpell.casterId;
            fightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            if((Kernel.beingInReconection) || (PlayedCharacterManager.getInstance().isSpectator) || (fightBattleFrame.currentPlayerId == 0))
            {
               this.aliveSource = this.source;
            }
            else
            {
               this.aliveSource = fightBattleFrame.currentPlayerId;
            }
            this.parentBoostUid = this.parentBoostUid;
            this.initParam(param1,param2,param3);
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BasicBuff));
      
      protected var _effect:EffectInstance;
      
      protected var _disabled:Boolean = false;
      
      protected var _removed:Boolean = false;
      
      public var uid:uint;
      
      public var duration:int;
      
      public var castingSpell:CastingSpell;
      
      public var targetId:int;
      
      public var critical:Boolean = false;
      
      public var dispelable:int;
      
      public var actionId:uint;
      
      public var id:uint;
      
      public var source:int;
      
      public var aliveSource:int;
      
      public var stack:Vector.<BasicBuff>;
      
      public var parentBoostUid:uint;
      
      public var finishing:Boolean;
      
      public function get effects() : EffectInstance {
         return this._effect;
      }
      
      public function get type() : String {
         return "BasicBuff";
      }
      
      public function get param1() : * {
         if(this._effect is EffectInstanceDice)
         {
            return EffectInstanceDice(this._effect).diceNum;
         }
         return null;
      }
      
      public function get param2() : * {
         if(this._effect is EffectInstanceDice)
         {
            return EffectInstanceDice(this._effect).diceSide;
         }
         return null;
      }
      
      public function get param3() : * {
         if(this._effect is EffectInstanceInteger)
         {
            return EffectInstanceInteger(this._effect).value;
         }
         return null;
      }
      
      public function set param1(v:*) : void {
         this._effect.setParameter(0,v == 0?null:v);
      }
      
      public function set param2(v:*) : void {
         this._effect.setParameter(1,v == 0?null:v);
      }
      
      public function set param3(v:*) : void {
         this._effect.setParameter(2,v == 0?null:v);
      }
      
      public function get unusableNextTurn() : Boolean {
         var currentPlayerId:* = 0;
         var playerId:* = 0;
         var playerPos:* = 0;
         var currentPos:* = 0;
         var casterPos:* = 0;
         var i:* = 0;
         var fighter:* = 0;
         if((this.duration > 1) || (this.duration < 0))
         {
            return false;
         }
         var frame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(frame)
         {
            currentPlayerId = frame.currentPlayerId;
            playerId = PlayedCharacterManager.getInstance().id;
            if((currentPlayerId == playerId) || (currentPlayerId == this.source))
            {
               return false;
            }
            playerPos = -1;
            currentPos = -1;
            casterPos = -1;
            i = 0;
            while(i < frame.fightersList.length)
            {
               fighter = frame.fightersList[i];
               if(fighter == playerId)
               {
                  playerPos = i;
               }
               else
               {
                  if(fighter == currentPlayerId)
                  {
                     currentPos = i;
                  }
                  else
                  {
                     if(fighter == this.source)
                     {
                        casterPos = i;
                     }
                  }
               }
               i++;
            }
            if(casterPos < currentPos)
            {
               casterPos = casterPos + frame.fightersList.length;
            }
            if(playerPos < currentPos)
            {
               playerPos = playerPos + frame.fightersList.length;
            }
            if((playerPos > currentPos) && (playerPos < casterPos))
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function get trigger() : Boolean {
         return false;
      }
      
      public function initParam(param1:int, param2:int, param3:int) : void {
         if((param1) && (!(param1 == 0)) || (param2) && (!(param2 == 0)))
         {
            this._effect = new EffectInstanceDice();
            this._effect.effectId = this.actionId;
            this._effect.duration = this.duration;
            (this._effect as EffectInstanceDice).diceNum = param1;
            (this._effect as EffectInstanceDice).diceSide = param2;
            (this._effect as EffectInstanceDice).value = param3;
            this._effect.trigger = this.trigger;
         }
         else
         {
            this._effect = new EffectInstanceInteger();
            this._effect.effectId = this.actionId;
            this._effect.duration = this.duration;
            (this._effect as EffectInstanceInteger).value = param3;
            this._effect.trigger = this.trigger;
         }
      }
      
      public function canBeDispell(forceUndispellable:Boolean=false, targetBuffId:int=-2147483648, dying:Boolean=false) : Boolean {
         if(targetBuffId == this.id)
         {
            return true;
         }
         switch(this.dispelable)
         {
            case FightDispellableEnum.DISPELLABLE:
               return true;
            case FightDispellableEnum.DISPELLABLE_BY_STRONG_DISPEL:
               return forceUndispellable;
            case FightDispellableEnum.DISPELLABLE_BY_DEATH:
               return (dying) || (forceUndispellable);
            case FightDispellableEnum.REALLY_NOT_DISPELLABLE:
               return targetBuffId == this.id;
         }
      }
      
      public function dispellableByDeath() : Boolean {
         return (this.dispelable == FightDispellableEnum.DISPELLABLE_BY_DEATH) || (this.dispelable == FightDispellableEnum.DISPELLABLE);
      }
      
      public function onDisabled() : void {
         this._disabled = true;
      }
      
      public function undisable() : void {
         this._disabled = false;
      }
      
      public function onRemoved() : void {
         this._removed = true;
         if(!this._disabled)
         {
            this.onDisabled();
         }
      }
      
      public function onApplyed() : void {
         this._disabled = false;
         this._removed = false;
      }
      
      public function equals(other:BasicBuff, osefSpell:Boolean=false) : Boolean {
         var sb1:StateBuff = null;
         var sb2:StateBuff = null;
         if(((((!(this.targetId == other.targetId) || !(this.effects.effectId == other.actionId) || !(this.duration == other.duration) || this.effects.hasOwnProperty("delay") && other.effects.hasOwnProperty("delay") && !(this.effects.delay == other.effects.delay)) || (((this.castingSpell.spellRank && other.castingSpell.spellRank) && (!osefSpell)) && (!(this.castingSpell.spellRank.id == other.castingSpell.spellRank.id)))) || (!osefSpell && !(this.castingSpell.spell.id == other.castingSpell.spell.id))) || (!(getQualifiedClassName(this) == getQualifiedClassName(other)))) || (!(this.source == other.source)) || (this.trigger))
         {
            return false;
         }
         var actionIdsForSpellModificatorEffect:Array = [ActionIdConverter.ACTION_BOOST_SPELL_RANGE,ActionIdConverter.ACTION_BOOST_SPELL_RANGEABLE,ActionIdConverter.ACTION_BOOST_SPELL_DMG,ActionIdConverter.ACTION_BOOST_SPELL_HEAL,ActionIdConverter.ACTION_BOOST_SPELL_AP_COST,ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL,ActionIdConverter.ACTION_BOOST_SPELL_CC,ActionIdConverter.ACTION_BOOST_SPELL_CASTOUTLINE,ActionIdConverter.ACTION_BOOST_SPELL_NOLINEOFSIGHT,ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTURN,ActionIdConverter.ACTION_BOOST_SPELL_MAXPERTARGET,ActionIdConverter.ACTION_BOOST_SPELL_CAST_INTVL_SET,ActionIdConverter.ACTION_BOOST_SPELL_BASE_DMG,ActionIdConverter.ACTION_DEBOOST_SPELL_RANGE,406,787,792,793,1017,1018,1019,1035,1036,1044,1045];
         var thisActionId:uint = this.actionId;
         if(thisActionId == 788)
         {
            if(this.param1 != other.param1)
            {
               return false;
            }
         }
         else
         {
            if(actionIdsForSpellModificatorEffect.indexOf(thisActionId) != -1)
            {
               if(this.param1 != other.param1)
               {
                  return false;
               }
            }
            else
            {
               if(thisActionId == 165)
               {
                  return false;
               }
               if((thisActionId == other.actionId) && ((thisActionId == 952) || (thisActionId == 951) || (thisActionId == 950)))
               {
                  sb1 = this as StateBuff;
                  sb2 = other as StateBuff;
                  if((sb1) && (sb2))
                  {
                     if(sb1.stateId != sb2.stateId)
                     {
                        return false;
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public function add(buff:BasicBuff) : void {
         if(!this.stack)
         {
            this.stack = new Vector.<BasicBuff>();
            this.stack.push(this.clone(this.id));
         }
         this.stack.push(buff);
         switch(this.actionId)
         {
            case 293:
               this.param1 = buff.param1;
               this.param2 = this.param2 + buff.param2;
               this.param3 = this.param3 + buff.param3;
               break;
            case 788:
               this.param1 = this.param1 + buff.param2;
               break;
            case 950:
            case 951:
            case 952:
               break;
         }
         this.refreshDescription();
      }
      
      public function updateParam(value1:int=0, value2:int=0, value3:int=0, buffId:int=-1) : void {
         var stackBuff:BasicBuff = null;
         var p1:int = 0;
         var p2:int = 0;
         var p3:int = 0;
         if(buffId == -1)
         {
            p1 = value1;
            p2 = value2;
            p3 = value3;
         }
         else
         {
            if((this.stack) && (this.stack.length < 1))
            {
               for each (stackBuff in this.stack)
               {
                  if(stackBuff.id == buffId)
                  {
                     switch(stackBuff.actionId)
                     {
                        case 788:
                        case 950:
                        case 951:
                        case 952:
                           break;
                     }
                  }
                  p1 = p1 + stackBuff.param1;
                  p2 = p2 + stackBuff.param2;
                  p3 = p3 + stackBuff.param3;
               }
            }
            else
            {
               p1 = value1;
               p2 = value2;
               p3 = value3;
            }
         }
         switch(this.actionId)
         {
            case 788:
               this.param1 = p2;
               break;
            case 950:
            case 951:
            case 952:
               break;
         }
         this.refreshDescription();
      }
      
      public function refreshDescription() : void {
         this._effect.forceDescriptionRefresh();
      }
      
      public function incrementDuration(delta:int, dispellEffect:Boolean=false) : Boolean {
         if((!dispellEffect) || (this.canBeDispell()))
         {
            if(this.duration >= 63)
            {
               return false;
            }
            if(this.duration + delta > 0)
            {
               this.duration = this.duration + delta;
               this.effects.duration = this.effects.duration + delta;
               return true;
            }
            if(this.duration > 0)
            {
               this.duration = 0;
               this.effects.duration = 0;
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function get active() : Boolean {
         return !(this.duration == 0);
      }
      
      public function clone(id:int=0) : BasicBuff {
         var bb:BasicBuff = new BasicBuff();
         bb.id = this.uid;
         bb.uid = this.uid;
         bb.actionId = this.actionId;
         bb.targetId = this.targetId;
         bb.castingSpell = this.castingSpell;
         bb.duration = this.duration;
         bb.dispelable = this.dispelable;
         bb.source = this.source;
         bb.aliveSource = this.aliveSource;
         bb.parentBoostUid = this.parentBoostUid;
         bb.initParam(this.param1,this.param2,this.param3);
         return bb;
      }
   }
}
