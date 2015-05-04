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
      
      public function AnimFunManager()
      {
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
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimFunManager));
      
      public static const ANIM_FUN_TIMER_MIN:int = 40000;
      
      public static const ANIM_FUN_TIMER_MAX:int = 80000;
      
      public static const ANIM_FUN_MAX_ANIM_DURATION:int = 20000;
      
      public static const FAST_ANIM_FUN_TIMER_MIN:int = 4000;
      
      public static const FAST_ANIM_FUN_TIMER_MAX:int = 5000;
      
      public static const ANIM_DELAY_SIZE:uint = 20;
      
      private static var _self:AnimFunManager;
      
      public static function getInstance() : AnimFunManager
      {
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
      
      public function get mapId() : int
      {
         return this._mapId;
      }
      
      public function initializeByMap(param1:uint) : void
      {
         var _loc5_:GameContextActorInformations = null;
         var _loc6_:uint = 0;
         var _loc7_:* = false;
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         this._mapId = param1;
         var _loc2_:PRNG = new ParkMillerCarta();
         _loc2_.seed(param1 + 5435);
         var _loc3_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var _loc4_:Dictionary = _loc3_.getEntitiesDictionnary();
         this._entitiesList = new Array();
         for each(_loc5_ in _loc4_)
         {
            if(this.hasAnimsFun(_loc5_.contextualId))
            {
               this._entitiesList.push(_loc5_);
            }
         }
         this._entitiesList.sortOn("contextualId",Array.NUMERIC);
         this._nbNormalAnims = this._nbFastAnims = 0;
         this._normalTimer = this._fastTimer = null;
         _loc6_ = 0;
         while(_loc6_ < ANIM_DELAY_SIZE)
         {
            _loc8_ = this.randomActor(_loc2_.nextInt());
            if(this.hasAnimsFun(_loc8_))
            {
               _loc7_ = this.hasFastAnims(_loc8_);
               if(!_loc7_)
               {
                  _loc9_ = _loc2_.nextIntR(ANIM_FUN_TIMER_MIN,ANIM_FUN_TIMER_MAX);
                  this._nbNormalAnims++;
               }
               else
               {
                  _loc9_ = _loc2_.nextIntR(FAST_ANIM_FUN_TIMER_MIN,FAST_ANIM_FUN_TIMER_MAX);
                  this._nbFastAnims++;
               }
               this._anims.push(new AnimFun(_loc8_,this.randomAnim(_loc8_,_loc2_.nextInt()),_loc9_,_loc7_));
            }
            _loc6_++;
         }
         this._nbAnims = this._anims.length;
         if(this._anims.length > 0)
         {
            this.start();
         }
      }
      
      public function get running() : Boolean
      {
         return this._running;
      }
      
      public function start() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:AnimFun = null;
         for each(_loc3_ in this._anims)
         {
            if(!_loc3_.fastAnim)
            {
               _loc1_ = _loc1_ + _loc3_.delayTime;
            }
            else
            {
               _loc2_ = _loc2_ + _loc3_.delayTime;
            }
         }
         this._animSeq.addEventListener(SequencerEvent.SEQUENCE_END,this.onAnimFunEnd);
         this._firstAnim = true;
         if(this._nbFastAnims > 0)
         {
            this._fastTimer = new SynchroTimer(_loc2_);
            this._fastTimer.start(this.checkAvailableAnim);
         }
         if(this._nbNormalAnims > 0)
         {
            this._normalTimer = new SynchroTimer(_loc1_);
            this._normalTimer.start(this.checkAvailableAnim);
         }
         this._running = true;
      }
      
      public function stop() : void
      {
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
      
      public function restart() : void
      {
         this.stop();
         this.initializeByMap(this._mapId);
      }
      
      public function cancelAnim(param1:int) : void
      {
         var _loc2_:TiphonSprite = null;
         if((this._animFunPlaying) && this._animFunEntityId == param1)
         {
            this._cancelledAnim = this._lastAnim;
            _loc2_ = DofusEntities.getEntity(this._animFunEntityId) as TiphonSprite;
            _loc2_.dispatchEvent(new Event(TiphonEvent.ANIMATION_END));
         }
         Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
         this._firstAnim = false;
         this._animFunPlaying = false;
         this._animFunEntityId = 0;
      }
      
      private function getTimerValue() : int
      {
         return getTimer() % int.MAX_VALUE;
      }
      
      private function checkAvailableAnim(param1:SynchroTimer) : void
      {
         var _loc2_:AnimFun = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:AnimatedCharacter = null;
         var _loc8_:RoleplayEntitiesFrame = null;
         var _loc9_:CellData = null;
         var _loc3_:* = param1 == this._fastTimer;
         if(!this._animFunPlaying)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            if(_loc3_)
            {
               if(this.getTimerValue() - this._lastFastAnimTime > this._nextFastAnimDelay)
               {
                  _loc4_ = 0;
                  while(_loc4_ < this._nbAnims)
                  {
                     if(this._anims[_loc4_].fastAnim)
                     {
                        _loc5_ = _loc5_ + this._anims[_loc4_].delayTime;
                        if(_loc5_ >= param1.value)
                        {
                           _loc6_ = param1.value - (_loc5_ - this._anims[_loc4_].delayTime);
                           _loc2_ = _loc4_ > 0?this._anims[_loc4_ - 1]:this._anims[0];
                           this._lastFastAnimTime = this.getTimerValue();
                           this._nextFastAnimDelay = this._anims[_loc4_].delayTime;
                           break;
                        }
                     }
                     _loc4_++;
                  }
               }
            }
            else if(this.getTimerValue() - this._lastNormalAnimTime > this._nextNormalAnimDelay)
            {
               _loc4_ = 0;
               while(_loc4_ < this._nbAnims)
               {
                  if(!this._anims[_loc4_].fastAnim)
                  {
                     _loc5_ = _loc5_ + this._anims[_loc4_].delayTime;
                     if(_loc5_ >= param1.value)
                     {
                        _loc6_ = param1.value - (_loc5_ - this._anims[_loc4_].delayTime);
                        _loc2_ = _loc4_ > 0?this._anims[_loc4_ - 1]:this._anims[0];
                        this._lastNormalAnimTime = this.getTimerValue();
                        this._nextNormalAnimDelay = this._anims[_loc4_].delayTime;
                        break;
                     }
                  }
                  _loc4_++;
               }
            }
            
         }
         if(!_loc2_)
         {
            return;
         }
         if((!this._firstAnim || (this._firstAnim) && !this._lastAnim) && !(this._lastAnim == _loc2_) && ((_loc2_.fastAnim) && !(_loc2_ == this._lastAnimFast) || !_loc2_.fastAnim && !(_loc2_ == this._lastAnimNormal)))
         {
            if(_loc2_.fastAnim)
            {
               this._lastAnimFast = _loc2_;
            }
            else
            {
               this._lastAnimNormal = _loc2_;
            }
            this._lastAnim = _loc2_;
            if(_loc2_)
            {
               if(this.getIsMapStatic())
               {
                  _loc7_ = DofusEntities.getEntity(_loc2_.actorId) as AnimatedCharacter;
                  if(!_loc7_)
                  {
                     return;
                  }
                  _loc8_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                  if(!_loc8_)
                  {
                     return;
                  }
                  _loc9_ = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[_loc7_.position.cellId];
                  if(!Atouin.getInstance().options.transparentOverlayMode && !_loc9_.visible)
                  {
                     return;
                  }
                  if(_loc8_.hasIcon(_loc2_.actorId))
                  {
                     _loc8_.forceIconUpdate(_loc2_.actorId);
                  }
                  this.synchCurrentAnim(_loc2_,_loc6_);
               }
            }
            return;
         }
      }
      
      private function playAnimFun(param1:AnimFun, param2:int = -1) : void
      {
         var _loc3_:TiphonSprite = DofusEntities.getEntity(param1.actorId) as TiphonSprite;
         var _loc4_:PlayAnimationStep = new PlayAnimationStep(_loc3_,param1.animName);
         _loc4_.timeout = ANIM_FUN_MAX_ANIM_DURATION;
         _loc4_.startFrame = param2;
         this._animFunPlaying = true;
         this._animFunEntityId = param1.actorId;
         this._animSeq.addStep(_loc4_);
         this._animSeq.start();
         this._firstAnim = false;
      }
      
      private function onAnimFunEnd(param1:SequencerEvent) : void
      {
         this._animFunPlaying = false;
         this._animFunEntityId = 0;
      }
      
      private function randomActor(param1:int) : int
      {
         var _loc2_:* = 0;
         if(this._entitiesList.length)
         {
            _loc2_ = param1 % this._entitiesList.length;
            return this._entitiesList[_loc2_].contextualId;
         }
         return 0;
      }
      
      private function randomAnim(param1:int, param2:int) : String
      {
         var _loc3_:Object = null;
         var _loc11_:GameRolePlayGroupMonsterInformations = null;
         var _loc12_:Monster = null;
         var _loc13_:GameRolePlayNpcInformations = null;
         var _loc14_:Npc = null;
         var _loc4_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:GameContextActorInformations = _loc4_.getEntityInfos(param1);
         if(_loc5_ is GameRolePlayGroupMonsterInformations)
         {
            _loc11_ = _loc5_ as GameRolePlayGroupMonsterInformations;
            _loc12_ = Monster.getMonsterById(_loc11_.staticInfos.mainCreatureLightInfos.creatureGenericId);
            if(!_loc12_)
            {
               return null;
            }
            _loc3_ = _loc12_.animFunList;
         }
         else if(_loc5_ is GameRolePlayNpcInformations)
         {
            _loc13_ = _loc5_ as GameRolePlayNpcInformations;
            _loc14_ = Npc.getNpcById(_loc13_.npcId);
            if(!_loc14_)
            {
               return null;
            }
            _loc3_ = _loc14_.animFunList;
         }
         else
         {
            return null;
         }
         
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:int = _loc3_.length;
         var _loc9_:* = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = _loc7_ + _loc3_[_loc9_].animWeight;
            _loc9_++;
         }
         var _loc10_:Number = param2 % _loc7_;
         _loc7_ = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_ = _loc7_ + _loc3_[_loc9_].animWeight;
            if(_loc7_ > _loc10_)
            {
               return _loc3_[_loc9_].animName;
            }
            _loc9_++;
         }
         return null;
      }
      
      private function getIsMapStatic() : Boolean
      {
         var _loc4_:GameContextActorInformations = null;
         var _loc5_:AnimatedCharacter = null;
         var _loc1_:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var _loc2_:Dictionary = _loc1_.getEntitiesDictionnary();
         var _loc3_:Array = new Array();
         for each(_loc4_ in _loc2_)
         {
            _loc5_ = DofusEntities.getEntity(_loc4_.contextualId) as AnimatedCharacter;
            if((_loc5_) && (_loc5_.isMoving))
            {
               return false;
            }
         }
         return true;
      }
      
      private function synchCurrentAnim(param1:AnimFun, param2:int) : void
      {
         var _loc4_:* = 0;
         var _loc6_:AnimFun = null;
         var _loc7_:AnimFun = null;
         var _loc8_:TiphonSprite = null;
         var _loc9_:Callback = null;
         var _loc10_:* = false;
         var _loc3_:int = this._anims.indexOf(param1);
         var _loc5_:int = this._anims.length;
         _loc4_ = _loc5_ - 1;
         while(_loc4_ >= 0)
         {
            if(this._anims[_loc4_].fastAnim == param1.fastAnim && _loc4_ < _loc3_)
            {
               _loc7_ = this._anims[_loc4_];
               break;
            }
            _loc4_--;
         }
         if(!this._firstAnim || _loc7_ == this._cancelledAnim)
         {
            _loc7_ = null;
         }
         this._cancelledAnim = null;
         _loc6_ = param1;
         if(_loc6_)
         {
            _loc8_ = DofusEntities.getEntity(_loc6_.actorId) as TiphonSprite;
            Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            _loc10_ = !(Tiphon.skullLibrary.getResourceById(_loc8_.look.getBone(),_loc6_.animName,true) == null);
            if((_loc10_) && (!_loc7_ || !(Tiphon.skullLibrary.getResourceById((DofusEntities.getEntity(_loc7_.actorId) as TiphonSprite).look.getBone(),_loc7_.animName,true) == null)))
            {
               this.playSynchAnim(new AnimFunInfo(_loc6_,_loc7_,param2));
            }
            else
            {
               this._synchedAnimFuns[_loc8_] = new AnimFunInfo(_loc6_,_loc7_,param2,this.getTimerValue());
               Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            }
         }
      }
      
      private function onSwlLoaded(param1:SwlEvent) : void
      {
         var _loc4_:AnimFunInfo = null;
         var _loc2_:TiphonSprite = DofusEntities.getEntity(this._lastAnim.actorId) as TiphonSprite;
         var _loc3_:Boolean = Tiphon.skullLibrary.isLoaded(_loc2_.look.getBone(),this._lastAnim.animName);
         if(_loc3_)
         {
            Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            _loc4_ = this._synchedAnimFuns[_loc2_] as AnimFunInfo;
            if(!_loc4_.previousAnimFun || !(Tiphon.skullLibrary.getResourceById((DofusEntities.getEntity(_loc4_.previousAnimFun.actorId) as TiphonSprite).look.getBone(),_loc4_.previousAnimFun.animName,true) == null))
            {
               if(_loc4_.previousAnimLoadTime > 0)
               {
                  _loc4_.loadTime = _loc4_.loadTime + (this.getTimerValue() - _loc4_.previousAnimLoadTime);
               }
               this.playSynchAnim(_loc4_);
               delete this._synchedAnimFuns[_loc2_];
               true;
            }
            else
            {
               if(_loc4_.previousAnimFun)
               {
                  _loc4_.previousAnimLoadTime = this.getTimerValue();
               }
               Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.onSwlLoaded);
            }
         }
      }
      
      private function getAnimSum(param1:AnimFun) : int
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < this._nbAnims)
         {
            _loc3_ = _loc3_ + this._anims[_loc2_].delayTime;
            if(this._anims[_loc2_] == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function playSynchAnim(param1:AnimFunInfo) : void
      {
         var _loc4_:AnimFunClipInfo = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = NaN;
         var _loc2_:int = param1.elapsedTime + (param1.loadTime > 0?this.getTimerValue() - param1.loadTime:0);
         var _loc3_:AnimFunClipInfo = param1.previousAnimFun?this.getAnimClipInfo(param1.previousAnimFun):null;
         var _loc5_:AnimFun = param1.animFun;
         if(_loc3_)
         {
            _loc6_ = this.getAnimSum(param1.previousAnimFun);
            _loc7_ = this.getAnimSum(param1.animFun);
            if(_loc6_ + _loc3_.duration > _loc7_ + _loc2_)
            {
               _loc4_ = _loc3_;
               _loc2_ = _loc3_.duration - (_loc6_ + _loc3_.duration - _loc7_ + _loc2_);
               _loc5_ = param1.previousAnimFun;
               this._lastAnim = _loc5_;
            }
            else
            {
               _loc4_ = this.getAnimClipInfo(param1.animFun);
            }
         }
         else
         {
            _loc4_ = this.getAnimClipInfo(param1.animFun);
         }
         if(_loc4_)
         {
            if(!this._firstAnim || (this._firstAnim) && _loc2_ < _loc4_.duration)
            {
               if(this._firstAnim)
               {
                  _loc8_ = _loc2_ / _loc4_.duration;
                  this.playAnimFun(_loc5_,_loc8_ * _loc4_.totalFrames);
               }
               else
               {
                  this.playAnimFun(_loc5_,0);
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
      
      private function getAnimClipInfo(param1:AnimFun) : AnimFunClipInfo
      {
         var _loc6_:Class = null;
         var _loc8_:String = null;
         var _loc9_:TiphonAnimation = null;
         var _loc2_:TiphonSprite = DofusEntities.getEntity(param1.actorId) as TiphonSprite;
         var _loc3_:Swl = Tiphon.skullLibrary.getResourceById(_loc2_.look.getBone(),param1.animName);
         var _loc4_:Array = _loc2_.getAvaibleDirection(param1.animName,true);
         var _loc5_:uint = _loc2_.getDirection();
         if(!_loc4_[_loc5_])
         {
            for(_loc8_ in _loc4_)
            {
               if(_loc4_[_loc8_])
               {
                  _loc5_ = uint(_loc8_);
                  break;
               }
            }
         }
         var _loc7_:String = param1.animName + "_" + _loc5_;
         if(_loc3_.hasDefinition(_loc7_))
         {
            _loc6_ = _loc3_.getDefinition(_loc7_) as Class;
         }
         else
         {
            _loc7_ = param1.animName + "_" + TiphonUtility.getFlipDirection(_loc5_);
            if(_loc3_.hasDefinition(_loc7_))
            {
               _loc6_ = _loc3_.getDefinition(_loc7_) as Class;
            }
         }
         if(_loc6_)
         {
            _loc9_ = new _loc6_() as TiphonAnimation;
            return new AnimFunClipInfo(_loc9_.totalFrames / _loc3_.frameRate * 1000,_loc9_.totalFrames);
         }
         return null;
      }
      
      private function hasFastAnims(param1:int) : Boolean
      {
         var _loc3_:Monster = null;
         var _loc4_:Npc = null;
         var _loc2_:GameContextActorInformations = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(param1);
         if(_loc2_ is GameRolePlayGroupMonsterInformations)
         {
            _loc3_ = Monster.getMonsterById((_loc2_ as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.creatureGenericId);
            return _loc3_.fastAnimsFun;
         }
         if(_loc2_ is GameRolePlayNpcInformations)
         {
            _loc4_ = Npc.getNpcById((_loc2_ as GameRolePlayNpcInformations).npcId);
            return _loc4_.fastAnimsFun;
         }
         return false;
      }
      
      private function hasAnimsFun(param1:int) : Boolean
      {
         var _loc3_:Monster = null;
         var _loc4_:Npc = null;
         var _loc2_:GameContextActorInformations = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(param1);
         if(_loc2_ is GameRolePlayGroupMonsterInformations)
         {
            _loc3_ = Monster.getMonsterById((_loc2_ as GameRolePlayGroupMonsterInformations).staticInfos.mainCreatureLightInfos.creatureGenericId);
            return (_loc3_) && !(_loc3_.animFunList.length == 0);
         }
         if(_loc2_ is GameRolePlayNpcInformations)
         {
            _loc4_ = Npc.getNpcById((_loc2_ as GameRolePlayNpcInformations).npcId);
            return (_loc4_) && !(_loc4_.animFunList.length == 0);
         }
         return false;
      }
   }
}
import com.ankamagames.dofus.logic.game.roleplay.types.AnimFun;

class AnimFunInfo extends Object
{
   
   function AnimFunInfo(param1:AnimFun, param2:AnimFun, param3:int, param4:int = 0)
   {
      super();
      this.animFun = param1;
      this.previousAnimFun = param2;
      this.elapsedTime = param3;
      this.loadTime = param4;
   }
   
   public var animFun:AnimFun;
   
   public var previousAnimFun:AnimFun;
   
   public var elapsedTime:int;
   
   public var loadTime:int;
   
   public var previousAnimLoadTime:int;
}
class AnimFunClipInfo extends Object
{
   
   function AnimFunClipInfo(param1:int, param2:int)
   {
      super();
      this.duration = param1;
      this.totalFrames = param2;
   }
   
   public var duration:int;
   
   public var totalFrames:int;
}
