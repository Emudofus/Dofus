package com.ankamagames.dofus.logic.game.roleplay.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.datacenter.npcs.AnimFunNpcData;
   import com.ankamagames.dofus.datacenter.monsters.AnimFunMonsterData;
   import com.ankamagames.dofus.logic.game.roleplay.types.AnimFun;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.common.types.SynchroTimer;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import com.ankamagames.jerakine.utils.prng.PRNG;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.events.SwlEvent;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import flash.events.Event;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.tiphon.display.TiphonAnimation;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public final class AnimFunManager extends Object
   {
      
      public function AnimFunManager() {
         this._anims = new Vector.<AnimFun>(0);
         this._animSeq = new SerialSequencer();
         this._synchedAnimFuns = new Dictionary();
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
      
      public static const FAST_ANIM_FUN_TIMER_MIN:int = 4000;
      
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
      
      private var _anims:Vector.<AnimFun>;
      
      private var _nbAnims:int;
      
      private var _nbFastAnims:int;
      
      private var _nbNormalAnims:int;
      
      private var _minDelay:int = 40000;
      
      private var _maxDelay:int = 80000;
      
      private var _mapId:int = -1;
      
      private var _entitiesList:Array;
      
      private var _running:Boolean;
      
      private var _animFunPlaying:Boolean;
      
      private var _animFunEntityId:int;
      
      private var _animSeq:SerialSequencer;
      
      private var _synchedAnimFuns:Dictionary;
      
      private var _fastTimer:SynchroTimer;
      
      private var _normalTimer:SynchroTimer;
      
      private var _lastFastAnimTime:int;
      
      private var _nextFastAnimDelay:int;
      
      private var _lastNormalAnimTime:int;
      
      private var _nextNormalAnimDelay:int;
      
      private var _lastAnim:AnimFun;
      
      private var _lastAnimFast:AnimFun;
      
      private var _lastAnimNormal:AnimFun;
      
      private var _cancelledAnim:AnimFun;
      
      private var _firstAnim:Boolean;
      
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
               this._minDelay = ANIM_FUN_TIMER_MIN;
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
      
      public function get mapId() : int {
         return this._mapId;
      }
      
      public function initializeByMap(mapId:uint) : void {
         var entity:GameContextActorInformations = null;
         var i:uint = 0;
         var isFastAnim:* = false;
         var actorId:* = 0;
         var animdelayTime:uint = 0;
         this._mapId = mapId;
         var rnd:PRNG = new ParkMillerCarta();
         rnd.seed(mapId + 5435);
         var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var entities:Dictionary = entitiesFrame.getEntitiesDictionnary();
         this._entitiesList = new Array();
         for each(entity in entities)
         {
            if(this.hasAnimsFun(entity.contextualId))
            {
               this._entitiesList.push(entity);
            }
         }
         this._entitiesList.sortOn("contextualId",Array.NUMERIC);
         this._nbNormalAnims = this._nbFastAnims = 0;
         this._normalTimer = this._fastTimer = null;
         i = 0;
         while(i < ANIM_DELAY_SIZE)
         {
            actorId = this.randomActor(rnd.nextInt());
            if(this.hasAnimsFun(actorId))
            {
               isFastAnim = this.hasFastAnims(actorId);
               if(!isFastAnim)
               {
                  animdelayTime = rnd.nextIntR(this._minDelay,this._maxDelay);
                  this._nbNormalAnims++;
               }
               else
               {
                  animdelayTime = rnd.nextIntR(FAST_ANIM_FUN_TIMER_MIN,FAST_ANIM_FUN_TIMER_MAX);
                  this._nbFastAnims++;
               }
               this._anims.push(new AnimFun(actorId,this.randomAnim(actorId,rnd.nextInt()),animdelayTime,isFastAnim));
            }
            i++;
         }
         this._nbAnims = this._anims.length;
         if(this._anims.length > 0)
         {
            this.start();
         }
      }
      
      public function get running() : Boolean {
         return this._running;
      }
      
      public function start() : void {
         var totalTimeNormalAnim:* = 0;
         var totalTimeFastAnim:* = 0;
         var af:AnimFun = null;
         for each(af in this._anims)
         {
            if(!af.fastAnim)
            {
               totalTimeNormalAnim = totalTimeNormalAnim + af.delayTime;
            }
            else
            {
               totalTimeFastAnim = totalTimeFastAnim + af.delayTime;
            }
         }
         this._animSeq.addEventListener(SequencerEvent.SEQUENCE_END,this.onAnimFunEnd);
         this._firstAnim = true;
         if(this._nbFastAnims > 0)
         {
            this._fastTimer = new SynchroTimer(totalTimeFastAnim);
            this._fastTimer.start(this.checkAvailableAnim);
         }
         if(this._nbNormalAnims > 0)
         {
            this._normalTimer = new SynchroTimer(totalTimeNormalAnim);
            this._normalTimer.start(this.checkAvailableAnim);
         }
         this._running = true;
      }
      
      public function stop() : void {
         Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
         this._running = this._animFunPlaying = false;
         this._animFunEntityId = 0;
         this._lastAnimFast = this._lastAnimNormal = this._lastAnim = null;
         this._anims.length = 0;
         this._animSeq.clear();
         this._animSeq.removeEventListener(SequencerEvent.SEQUENCE_END,this.onAnimFunEnd);
         if(this._fastTimer)
         {
            this._fastTimer.stop();
         }
         if(this._normalTimer)
         {
            this._normalTimer.stop();
         }
      }
      
      public function restart() : void {
         this.stop();
         this.initializeByMap(this._mapId);
      }
      
      public function cancelAnim(pEntityId:int) : void {
         var entitySpr:TiphonSprite = null;
         if((this._animFunPlaying) && (this._animFunEntityId == pEntityId))
         {
            this._cancelledAnim = this._lastAnim;
            entitySpr = DofusEntities.getEntity(this._animFunEntityId) as TiphonSprite;
            entitySpr.dispatchEvent(new Event(TiphonEvent.ANIMATION_END));
         }
         Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
         this._firstAnim = false;
         this._animFunPlaying = false;
         this._animFunEntityId = 0;
      }
      
      private function getTimerValue() : int {
         return getTimer() % int.MAX_VALUE;
      }
      
      private function checkAvailableAnim(pTimer:SynchroTimer) : void {
         var animFun:AnimFun = null;
         var i:* = 0;
         var sum:* = 0;
         var elapsedTime:* = 0;
         var entity:AnimatedCharacter = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = null;
         var cellData:CellData = null;
         var fastAnimTimer:Boolean = pTimer == this._fastTimer;
         if(!this._animFunPlaying)
         {
            sum = 0;
            elapsedTime = 0;
            if(fastAnimTimer)
            {
               if(this.getTimerValue() - this._lastFastAnimTime > this._nextFastAnimDelay)
               {
                  i = 0;
                  while(i < this._nbAnims)
                  {
                     if(this._anims[i].fastAnim)
                     {
                        sum = sum + this._anims[i].delayTime;
                        if(sum >= pTimer.value)
                        {
                           elapsedTime = pTimer.value - (sum - this._anims[i].delayTime);
                           animFun = i > 0?this._anims[i - 1]:this._anims[0];
                           this._lastFastAnimTime = this.getTimerValue();
                           this._nextFastAnimDelay = this._anims[i].delayTime;
                           break;
                        }
                     }
                     i++;
                  }
               }
            }
            else if(this.getTimerValue() - this._lastNormalAnimTime > this._nextNormalAnimDelay)
            {
               i = 0;
               while(i < this._nbAnims)
               {
                  if(!this._anims[i].fastAnim)
                  {
                     sum = sum + this._anims[i].delayTime;
                     if(sum >= pTimer.value)
                     {
                        elapsedTime = pTimer.value - (sum - this._anims[i].delayTime);
                        animFun = i > 0?this._anims[i - 1]:this._anims[0];
                        this._lastNormalAnimTime = this.getTimerValue();
                        this._nextNormalAnimDelay = this._anims[i].delayTime;
                        break;
                     }
                  }
                  i++;
               }
            }
            
         }
         if(!animFun)
         {
            return;
         }
         if(((!this._firstAnim) || (this._firstAnim) && (!this._lastAnim)) && (!(this._lastAnim == animFun)) && ((animFun.fastAnim) && (!(animFun == this._lastAnimFast)) || (!animFun.fastAnim) && (!(animFun == this._lastAnimNormal))))
         {
            if(animFun.fastAnim)
            {
               this._lastAnimFast = animFun;
            }
            else
            {
               this._lastAnimNormal = animFun;
            }
            this._lastAnim = animFun;
            if(animFun)
            {
               if(this.getIsMapStatic())
               {
                  entity = DofusEntities.getEntity(animFun.actorId) as AnimatedCharacter;
                  if(!entity)
                  {
                     return;
                  }
                  roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                  if(!roleplayEntitiesFrame)
                  {
                     return;
                  }
                  cellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[entity.position.cellId];
                  if((!Atouin.getInstance().options.transparentOverlayMode) && (!cellData.visible))
                  {
                     return;
                  }
                  if(roleplayEntitiesFrame.hasIcon(animFun.actorId))
                  {
                     roleplayEntitiesFrame.forceIconUpdate(animFun.actorId);
                  }
                  this.synchCurrentAnim(animFun,elapsedTime);
               }
            }
            return;
         }
      }
      
      private function playAnimFun(pAnimFun:AnimFun, pStartFrame:int = -1) : void {
         var entity:TiphonSprite = DofusEntities.getEntity(pAnimFun.actorId) as TiphonSprite;
         var playAnimStep:PlayAnimationStep = new PlayAnimationStep(entity,pAnimFun.animName);
         playAnimStep.timeout = ANIM_FUN_MAX_ANIM_DURATION;
         playAnimStep.startFrame = pStartFrame;
         this._animFunPlaying = true;
         this._animFunEntityId = pAnimFun.actorId;
         this._animSeq.addStep(playAnimStep);
         this._animSeq.start();
         this._firstAnim = false;
      }
      
      private function onAnimFunEnd(pEvent:SequencerEvent) : void {
         this._animFunPlaying = false;
         this._animFunEntityId = 0;
      }
      
      private function randomActor(monsterSeed:int) : int {
         var rnd:* = 0;
         if(this._entitiesList.length)
         {
            rnd = monsterSeed % this._entitiesList.length;
            return this._entitiesList[rnd].contextualId;
         }
         return 0;
      }
      
      private function randomAnim(actorId:int, animSeed:int) : String {
         var list:Object = null;
         var groupMonsterInfo:GameRolePlayGroupMonsterInformations = null;
         var monster:Monster = null;
         var npcInfo:GameRolePlayNpcInformations = null;
         var npc:Npc = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(!roleplayEntitiesFrame)
         {
            return null;
         }
         var entity:GameContextActorInformations = roleplayEntitiesFrame.getEntityInfos(actorId);
         if(entity is GameRolePlayGroupMonsterInformations)
         {
            groupMonsterInfo = entity as GameRolePlayGroupMonsterInformations;
            monster = Monster.getMonsterById(groupMonsterInfo.staticInfos.mainCreatureLightInfos.creatureGenericId);
            if(!monster)
            {
               return null;
            }
            list = monster.animFunList;
         }
         else if(entity is GameRolePlayNpcInformations)
         {
            npcInfo = entity as GameRolePlayNpcInformations;
            npc = Npc.getNpcById(npcInfo.npcId);
            if(!npc)
            {
               return null;
            }
            list = npc.animFunList;
         }
         else
         {
            return null;
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
               return list[i].animName;
            }
            i++;
         }
         return null;
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
      
      private function synchCurrentAnim(pNextAnimFun:AnimFun, pElapsedTime:int) : void {
         var i:* = 0;
         var af:AnimFun = null;
         var previousAf:AnimFun = null;
         var entitySpr:TiphonSprite = null;
         var callback:Callback = null;
         var swlLoaded:* = false;
         var nextAnimIndex:int = this._anims.indexOf(pNextAnimFun);
         var nbAnims:int = this._anims.length;
         i = nbAnims - 1;
         while(i >= 0)
         {
            if((this._anims[i].fastAnim == pNextAnimFun.fastAnim) && (i < nextAnimIndex))
            {
               previousAf = this._anims[i];
               break;
            }
            i--;
         }
         if((!this._firstAnim) || (previousAf == this._cancelledAnim))
         {
            previousAf = null;
         }
         this._cancelledAnim = null;
         af = pNextAnimFun;
         if(af)
         {
            entitySpr = DofusEntities.getEntity(af.actorId) as TiphonSprite;
            Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            swlLoaded = !(Tiphon.skullLibrary.getResourceById(entitySpr.look.getBone(),af.animName,true) == null);
            if((swlLoaded) && ((!previousAf) || (!(Tiphon.skullLibrary.getResourceById((DofusEntities.getEntity(previousAf.actorId) as TiphonSprite).look.getBone(),previousAf.animName,true) == null))))
            {
               this.playSynchAnim(new AnimFunInfo(af,previousAf,pElapsedTime));
            }
            else
            {
               this._synchedAnimFuns[entitySpr] = new AnimFunInfo(af,previousAf,pElapsedTime,this.getTimerValue());
               Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            }
         }
      }
      
      private function onSwlLoaded(pEvent:SwlEvent) : void {
         var animFunInfo:AnimFunInfo = null;
         var entitySpr:TiphonSprite = DofusEntities.getEntity(this._lastAnim.actorId) as TiphonSprite;
         var hasClass:Boolean = Tiphon.skullLibrary.isLoaded(entitySpr.look.getBone(),this._lastAnim.animName);
         if(hasClass)
         {
            Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            animFunInfo = this._synchedAnimFuns[entitySpr] as AnimFunInfo;
            if((!animFunInfo.previousAnimFun) || (!(Tiphon.skullLibrary.getResourceById((DofusEntities.getEntity(animFunInfo.previousAnimFun.actorId) as TiphonSprite).look.getBone(),animFunInfo.previousAnimFun.animName,true) == null)))
            {
               if(animFunInfo.previousAnimLoadTime > 0)
               {
                  animFunInfo.loadTime = animFunInfo.loadTime + (this.getTimerValue() - animFunInfo.previousAnimLoadTime);
               }
               this.playSynchAnim(animFunInfo);
               delete this._synchedAnimFuns[entitySpr];
            }
            else
            {
               if(animFunInfo.previousAnimFun)
               {
                  animFunInfo.previousAnimLoadTime = this.getTimerValue();
               }
               Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            }
         }
      }
      
      private function getAnimSum(pAnimFun:AnimFun) : int {
         var i:* = 0;
         var sum:* = 0;
         i = 0;
         while(i < this._nbAnims)
         {
            sum = sum + this._anims[i].delayTime;
            if(this._anims[i] == pAnimFun)
            {
               return sum;
            }
            i++;
         }
         return 0;
      }
      
      private function playSynchAnim(pAnimFunInfo:AnimFunInfo) : void {
         var animClipInfo:AnimFunClipInfo = null;
         var previousSum:* = 0;
         var currentSum:* = 0;
         var ratio:* = NaN;
         var delay:int = pAnimFunInfo.elapsedTime + (pAnimFunInfo.loadTime > 0?this.getTimerValue() - pAnimFunInfo.loadTime:0);
         var previousAnimInfo:AnimFunClipInfo = pAnimFunInfo.previousAnimFun?this.getAnimClipInfo(pAnimFunInfo.previousAnimFun):null;
         var animFun:AnimFun = pAnimFunInfo.animFun;
         if(previousAnimInfo)
         {
            previousSum = this.getAnimSum(pAnimFunInfo.previousAnimFun);
            currentSum = this.getAnimSum(pAnimFunInfo.animFun);
            if(previousSum + previousAnimInfo.duration > currentSum + delay)
            {
               animClipInfo = previousAnimInfo;
               delay = previousAnimInfo.duration - (previousSum + previousAnimInfo.duration - currentSum + delay);
               animFun = pAnimFunInfo.previousAnimFun;
               this._lastAnim = animFun;
            }
            else
            {
               animClipInfo = this.getAnimClipInfo(pAnimFunInfo.animFun);
            }
         }
         else
         {
            animClipInfo = this.getAnimClipInfo(pAnimFunInfo.animFun);
         }
         if(animClipInfo)
         {
            if((!this._firstAnim) || (this._firstAnim) && (delay < animClipInfo.duration))
            {
               if(this._firstAnim)
               {
                  ratio = delay / animClipInfo.duration;
                  this.playAnimFun(animFun,ratio * animClipInfo.totalFrames);
               }
               else
               {
                  this.playAnimFun(animFun,0);
               }
            }
            else
            {
               this._firstAnim = false;
               this._animFunPlaying = false;
               this._animFunEntityId = 0;
            }
         }
         else
         {
            this._firstAnim = false;
            this._animFunPlaying = false;
            this._animFunEntityId = 0;
         }
      }
      
      private function getAnimClipInfo(pAnimFun:AnimFun) : AnimFunClipInfo {
         var animClass:Class = null;
         var s:String = null;
         var clip:TiphonAnimation = null;
         var entitySpr:TiphonSprite = DofusEntities.getEntity(pAnimFun.actorId) as TiphonSprite;
         var swl:Swl = Tiphon.skullLibrary.getResourceById(entitySpr.look.getBone(),pAnimFun.animName);
         var directions:Array = entitySpr.getAvaibleDirection(pAnimFun.animName,true);
         var finalDirection:uint = entitySpr.getDirection();
         if(!directions[finalDirection])
         {
            for(s in directions)
            {
               if(directions[s])
               {
                  finalDirection = uint(s);
                  break;
               }
            }
         }
         var className:String = pAnimFun.animName + "_" + finalDirection;
         if(swl.hasDefinition(className))
         {
            animClass = swl.getDefinition(className) as Class;
         }
         else
         {
            className = pAnimFun.animName + "_" + TiphonUtility.getFlipDirection(finalDirection);
            if(swl.hasDefinition(className))
            {
               animClass = swl.getDefinition(className) as Class;
            }
         }
         if(animClass)
         {
            clip = new animClass() as TiphonAnimation;
            return new AnimFunClipInfo(clip.totalFrames / swl.frameRate * 1000,clip.totalFrames);
         }
         return null;
      }
      
      private function hasFastAnims(pActorId:int) : Boolean {
         var monster:Monster = null;
         var npc:Npc = null;
         var actorInfos:GameContextActorInformations = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(pActorId);
         if(actorInfos is GameRolePlayGroupMonsterInformations)
         {
            monster = Monster.getMonsterById((actorInfos as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.creatureGenericId);
            return monster.fastAnimsFun;
         }
         if(actorInfos is GameRolePlayNpcInformations)
         {
            npc = Npc.getNpcById((actorInfos as GameRolePlayNpcInformations).npcId);
            return npc.fastAnimsFun;
         }
         return false;
      }
      
      private function hasAnimsFun(pActorId:int) : Boolean {
         var monster:Monster = null;
         var npc:Npc = null;
         var actorInfos:GameContextActorInformations = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(pActorId);
         if(actorInfos is GameRolePlayGroupMonsterInformations)
         {
            monster = Monster.getMonsterById((actorInfos as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.creatureGenericId);
            return (monster) && (!(monster.animFunList.length == 0));
         }
         if(actorInfos is GameRolePlayNpcInformations)
         {
            npc = Npc.getNpcById((actorInfos as GameRolePlayNpcInformations).npcId);
            return (npc) && (!(npc.animFunList.length == 0));
         }
         return false;
      }
   }
}
import com.ankamagames.dofus.logic.game.roleplay.types.AnimFun;

class AnimFunInfo extends Object
{
   
   function AnimFunInfo(pAnimFun:AnimFun, pPreviousAnimFun:AnimFun, pElapsedTime:int, pLoadTime:int = 0) {
      super();
      this.animFun = pAnimFun;
      this.previousAnimFun = pPreviousAnimFun;
      this.elapsedTime = pElapsedTime;
      this.loadTime = pLoadTime;
   }
   
   public var animFun:AnimFun;
   
   public var previousAnimFun:AnimFun;
   
   public var elapsedTime:int;
   
   public var loadTime:int;
   
   public var previousAnimLoadTime:int;
}
class AnimFunClipInfo extends Object
{
   
   function AnimFunClipInfo(pDuration:int, pTotalFrames:int) {
      super();
      this.duration = pDuration;
      this.totalFrames = pTotalFrames;
   }
   
   public var duration:int;
   
   public var totalFrames:int;
}
