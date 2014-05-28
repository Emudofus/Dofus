package com.ankamagames.dofus.logic.game.roleplay.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.npcs.AnimFunNpcData;
   import com.ankamagames.dofus.datacenter.monsters.AnimFunMonsterData;
   import com.ankamagames.dofus.logic.game.roleplay.types.AnimFunTimer;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import com.ankamagames.jerakine.utils.prng.PRNG;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public final class AnimFunManager extends Object
   {
      
      public function AnimFunManager() {
         this._timerList = new Vector.<AnimFunTimer>();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this.fastDelay = false;
            return;
         }
      }
      
      protected static const _log:Logger;
      
      public static const ANIM_FUN_TIMER_MIN:int = 40000;
      
      public static const ANIM_FUN_TIMER_MAX:int = 80000;
      
      public static const ANIM_FUN_MAX_ANIM_DURATION:int = 20000;
      
      public static const FAST_ANIM_FUN_TIMER_MIN:int = 1000;
      
      public static const FAST_ANIM_FUN_TIMER_MAX:int = 5000;
      
      public static const ANIM_DELAY_SIZE:uint = 20;
      
      private static var _self:AnimFunManager;
      
      public static function getInstance() : AnimFunManager {
         if(!_self)
         {
            _self = new AnimFunManager();
         }
         return _self;
      }
      
      private var _animFunNpcData:AnimFunNpcData;
      
      private var _animFunMonsterData:AnimFunMonsterData;
      
      private var _timerList:Vector.<AnimFunTimer>;
      
      private var _animDelays:Array;
      
      private var _animDelaysSum:uint;
      
      private var _minDelay:int = 40000;
      
      private var _maxDelay:int = 80000;
      
      private var _mapId:int = -1;
      
      public function set fastDelay(value:Boolean) : void {
         if(value != this.fastDelay)
         {
            if(value)
            {
               this._minDelay = FAST_ANIM_FUN_TIMER_MIN;
               this._maxDelay = FAST_ANIM_FUN_TIMER_MAX;
            }
            else
            {
               this._minDelay = ANIM_FUN_TIMER_MAX;
               this._maxDelay = ANIM_FUN_TIMER_MAX;
            }
            if(this._mapId != -1)
            {
               this.initializeByMap(this._mapId);
            }
         }
      }
      
      public function get fastDelay() : Boolean {
         return this._minDelay == 1000;
      }
      
      public function initializeByMap(mapId:uint) : void {
         var num:uint = 0;
         var actor:uint = 0;
         var idAnim:uint = 0;
         this._mapId = mapId;
         var rnd:PRNG = new ParkMillerCarta();
         rnd.seed(mapId + 5435);
         this._animDelays = new Array();
         this._animDelaysSum = 0;
         var i:uint = 0;
         while(i < ANIM_DELAY_SIZE)
         {
            num = rnd.nextIntR(this._minDelay,this._maxDelay);
            actor = rnd.nextInt();
            idAnim = rnd.nextInt();
            this._animDelays.push(
               {
                  "delay":num,
                  "actor":actor,
                  "anim":idAnim
               });
            this._animDelaysSum = this._animDelaysSum + num;
            i++;
         }
         this.stopAllTimer();
         this.initNextAnimFun();
      }
      
      public function get running() : Boolean {
         var t:AnimFunTimer = null;
         for each(t in this._timerList)
         {
            if(t.running)
            {
               return true;
            }
         }
         return false;
      }
      
      public function restart() : void {
         if(!this.running)
         {
            this.initNextAnimFun();
         }
      }
      
      public function newAnimFunTimer(actorId:int, delay:int, anim:int) : void {
         this._timerList.push(new AnimFunTimer(actorId,delay,anim,this.onTimer));
      }
      
      public function stopAllTimer() : void {
         var num:int = this._timerList.length;
         var i:int = 0;
         while(i < num)
         {
            this._timerList[i].destroy();
            i++;
         }
         this._timerList = new Vector.<AnimFunTimer>();
      }
      
      private function onTimer(animFunTimer:AnimFunTimer) : void {
         var list:Object = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = null;
         var entity:TiphonSprite = null;
         var entityInfo:GameContextActorInformations = null;
         var sq:SerialSequencer = null;
         var playAnimStep:PlayAnimationStep = null;
         var groupMonsterInfo:GameRolePlayGroupMonsterInformations = null;
         var monster:Monster = null;
         var npcInfo:GameRolePlayNpcInformations = null;
         var npc:Npc = null;
         var index:int = this._timerList.indexOf(animFunTimer);
         if(index != -1)
         {
            animFunTimer.destroy();
            this._timerList.splice(index,1);
         }
         if(this.getIsMapStatic())
         {
            roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if(!roleplayEntitiesFrame)
            {
               return;
            }
            entity = DofusEntities.getEntity(animFunTimer.actorId) as TiphonSprite;
            if(!entity)
            {
               return;
            }
            entityInfo = roleplayEntitiesFrame.getEntityInfos(animFunTimer.actorId);
            if(entityInfo is GameRolePlayGroupMonsterInformations)
            {
               groupMonsterInfo = entityInfo as GameRolePlayGroupMonsterInformations;
               monster = Monster.getMonsterById(groupMonsterInfo.staticInfos.mainCreatureLightInfos.creatureGenericId);
               if((!monster) || (monster.animFunList.length == 0))
               {
                  return;
               }
               list = monster.animFunList;
            }
            else if(entityInfo is GameRolePlayNpcInformations)
            {
               npcInfo = entityInfo as GameRolePlayNpcInformations;
               npc = Npc.getNpcById(npcInfo.npcId);
               if(!npc)
               {
                  return;
               }
               list = npc.animFunList;
            }
            else
            {
               return;
            }
            
            if(roleplayEntitiesFrame.hasIcon(entityInfo.contextualId))
            {
               roleplayEntitiesFrame.forceIconUpdate(entityInfo.contextualId);
            }
            sq = new SerialSequencer();
            playAnimStep = new PlayAnimationStep(entity,list[animFunTimer.animId].animName);
            playAnimStep.timeout = ANIM_FUN_MAX_ANIM_DURATION;
            sq.addStep(playAnimStep);
            sq.start();
         }
         this.initNextAnimFun();
      }
      
      private function initNextAnimFun() : void {
         var delay:Object = null;
         var actorId:* = 0;
         var anim:* = 0;
         if(this._animDelaysSum == 0)
         {
            _log.error("try to init a new animFun with a 0 delay sum");
            return;
         }
         var timestamp:Number = TimeManager.getInstance().getTimestamp();
         timestamp = timestamp % this._animDelaysSum;
         for each(delay in this._animDelays)
         {
            if(timestamp > delay.delay)
            {
               timestamp = timestamp - delay.delay;
               continue;
            }
            actorId = this.randomActor(delay.actor);
            anim = this.randomAnim(actorId,delay.anim);
            if(actorId != 0)
            {
               this.newAnimFunTimer(actorId,delay.delay - timestamp,anim);
            }
            return;
         }
      }
      
      private function randomActor(monsterSeed:int) : int {
         var entity:GameContextActorInformations = null;
         var monster:Monster = null;
         var npc:Npc = null;
         var rnd:* = 0;
         var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var entities:Dictionary = entitiesFrame.getEntitiesDictionnary();
         var list:Array = new Array();
         for each(entity in entities)
         {
            if(entity is GameRolePlayGroupMonsterInformations)
            {
               monster = Monster.getMonsterById((entity as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.creatureGenericId);
               if((monster) && (!(monster.animFunList.length == 0)))
               {
                  list.push(entity);
               }
            }
            else if(entity is GameRolePlayNpcInformations)
            {
               npc = Npc.getNpcById((entity as GameRolePlayNpcInformations).npcId);
               if((npc) && (!(npc.animFunList.length == 0)))
               {
                  list.push(entity);
               }
            }
            
         }
         if(list.length)
         {
            rnd = monsterSeed % list.length;
            return list[rnd].contextualId;
         }
         return 0;
      }
      
      private function randomAnim(actorId:int, animSeed:int) : int {
         var list:Object = null;
         var groupMonsterInfo:GameRolePlayGroupMonsterInformations = null;
         var monster:Monster = null;
         var npcInfo:GameRolePlayNpcInformations = null;
         var npc:Npc = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(!roleplayEntitiesFrame)
         {
            return 0;
         }
         var entity:GameContextActorInformations = roleplayEntitiesFrame.getEntityInfos(actorId);
         if(entity is GameRolePlayGroupMonsterInformations)
         {
            groupMonsterInfo = entity as GameRolePlayGroupMonsterInformations;
            monster = Monster.getMonsterById(groupMonsterInfo.staticInfos.mainCreatureLightInfos.creatureGenericId);
            if(!monster)
            {
               return 0;
            }
            list = monster.animFunList;
         }
         else if(entity is GameRolePlayNpcInformations)
         {
            npcInfo = entity as GameRolePlayNpcInformations;
            npc = Npc.getNpcById(npcInfo.npcId);
            if(!npc)
            {
               return 0;
            }
            list = npc.animFunList;
         }
         else
         {
            return 0;
         }
         
         var animIndex:int = 0;
         var max:int = 0;
         var num:int = list.length;
         var i:int = 0;
         while(i < num)
         {
            max = max + list[i].animWeight;
            i++;
         }
         var rand:Number = animSeed % max;
         max = 0;
         i = 0;
         while(i < num)
         {
            max = max + list[i].animWeight;
            if(max > rand)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
      
      private function getIsMapStatic() : Boolean {
         var entity:GameContextActorInformations = null;
         var sprite:AnimatedCharacter = null;
         var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var entities:Dictionary = entitiesFrame.getEntitiesDictionnary();
         var monsters:Array = new Array();
         for each(entity in entities)
         {
            sprite = DofusEntities.getEntity(entity.contextualId) as AnimatedCharacter;
            if((sprite) && (sprite.isMoving))
            {
               return false;
            }
         }
         return true;
      }
   }
}
