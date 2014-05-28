package org.flintparticles.common.emitters
{
   import flash.events.EventDispatcher;
   import org.flintparticles.common.particles.ParticleFactory;
   import org.flintparticles.common.utils.PriorityArray;
   import org.flintparticles.common.counters.Counter;
   import org.flintparticles.common.initializers.Initializer;
   import org.flintparticles.common.actions.Action;
   import org.flintparticles.common.activities.Activity;
   import org.flintparticles.common.utils.FrameUpdater;
   import org.flintparticles.common.events.UpdateEvent;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.events.ParticleEvent;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.common.counters.ZeroCounter;
   
   public class Emitter extends EventDispatcher
   {
      
      public function Emitter() {
         super();
         this._particles = new Array();
         this._actions = new PriorityArray();
         this._initializers = new PriorityArray();
         this._activities = new PriorityArray();
         this._counter = new ZeroCounter();
      }
      
      protected var _particleFactory:ParticleFactory;
      
      protected var _initializers:PriorityArray;
      
      protected var _actions:PriorityArray;
      
      protected var _activities:PriorityArray;
      
      protected var _particles:Array;
      
      protected var _counter:Counter;
      
      protected var _useInternalTick:Boolean = true;
      
      protected var _fixedFrameTime:Number = 0;
      
      protected var _running:Boolean = false;
      
      protected var _started:Boolean = false;
      
      protected var _maximumFrameTime:Number = 0.1;
      
      public function get maximumFrameTime() : Number {
         return this._maximumFrameTime;
      }
      
      public function set maximumFrameTime(param1:Number) : void {
         this._maximumFrameTime = param1;
      }
      
      public function addInitializer(param1:Initializer, param2:Number=NaN) : void {
         if(isNaN(param2))
         {
            param2 = param1.getDefaultPriority();
         }
         this._initializers.add(param1,param2);
         param1.addedToEmitter(this);
      }
      
      public function removeInitializer(param1:Initializer) : void {
         if(this._initializers.remove(param1))
         {
            param1.removedFromEmitter(this);
         }
      }
      
      public function hasInitializer(param1:Initializer) : Boolean {
         return this._initializers.contains(param1);
      }
      
      public function hasInitializerOfType(param1:Class) : Boolean {
         var _loc2_:uint = this._initializers.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._initializers[_loc3_] is param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function addAction(param1:Action, param2:Number=NaN) : void {
         if(isNaN(param2))
         {
            param2 = param1.getDefaultPriority();
         }
         this._actions.add(param1,param2);
         param1.addedToEmitter(this);
      }
      
      public function removeAction(param1:Action) : void {
         if(this._actions.remove(param1))
         {
            param1.removedFromEmitter(this);
         }
      }
      
      public function hasAction(param1:Action) : Boolean {
         return this._actions.contains(param1);
      }
      
      public function hasActionOfType(param1:Class) : Boolean {
         var _loc2_:uint = this._actions.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._actions[_loc3_] is param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function addActivity(param1:Activity, param2:Number=NaN) : void {
         if(isNaN(param2))
         {
            param2 = param1.getDefaultPriority();
         }
         this._activities.add(param1,param2);
         param1.addedToEmitter(this);
      }
      
      public function removeActivity(param1:Activity) : void {
         if(this._activities.remove(param1))
         {
            param1.removedFromEmitter(this);
         }
      }
      
      public function hasActivity(param1:Activity) : Boolean {
         return this._activities.contains(param1);
      }
      
      public function hasActivityOfType(param1:Class) : Boolean {
         var _loc2_:uint = this._activities.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._activities[_loc3_] is param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function get counter() : Counter {
         return this._counter;
      }
      
      public function set counter(param1:Counter) : void {
         this._counter = param1;
      }
      
      public function get useInternalTick() : Boolean {
         return this._useInternalTick;
      }
      
      public function set useInternalTick(param1:Boolean) : void {
         if(this._useInternalTick != param1)
         {
            this._useInternalTick = param1;
            if(this._started)
            {
               if(this._useInternalTick)
               {
                  FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE,this.updateEventListener,false,0,true);
               }
               else
               {
                  FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE,this.updateEventListener);
               }
            }
         }
      }
      
      public function get fixedFrameTime() : Number {
         return this._fixedFrameTime;
      }
      
      public function set fixedFrameTime(param1:Number) : void {
         this._fixedFrameTime = param1;
      }
      
      public function get running() : Boolean {
         return this._running;
      }
      
      public function get particleFactory() : ParticleFactory {
         return this._particleFactory;
      }
      
      public function set particleFactory(param1:ParticleFactory) : void {
         this._particleFactory = param1;
      }
      
      public function get particles() : Array {
         return this._particles;
      }
      
      protected function createParticle() : Particle {
         var _loc1_:Particle = this._particleFactory.createParticle();
         var _loc2_:int = this._initializers.length;
         this.initParticle(_loc1_);
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            this._initializers[_loc3_].initialize(this,_loc1_);
            _loc3_++;
         }
         this._particles.push(_loc1_);
         dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_CREATED,_loc1_));
         return _loc1_;
      }
      
      protected function initParticle(param1:Particle) : void {
      }
      
      public function addExistingParticles(param1:Array, param2:Boolean=false) : void {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc3_:int = param1.length;
         if(param2)
         {
            _loc5_ = this._initializers.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  this._initializers[_loc6_].initialize(this,param1[_loc4_]);
                  _loc4_++;
               }
               _loc6_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this._particles.push(param1[_loc4_]);
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED,param1[_loc4_]));
            _loc4_++;
         }
      }
      
      public function killAllParticles() : void {
         var _loc1_:int = this._particles.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,this._particles[_loc2_]));
            this._particleFactory.disposeParticle(this._particles[_loc2_]);
            _loc2_++;
         }
         this._particles.length = 0;
      }
      
      public function start() : void {
         if(this._useInternalTick)
         {
            FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE,this.updateEventListener,false,0,true);
         }
         this._started = true;
         this._running = true;
         var _loc1_:int = this._activities.length;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            this._activities[_loc2_].initialize(this);
            _loc2_++;
         }
         _loc1_ = this._counter.startEmitter(this);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.createParticle();
            _loc2_++;
         }
      }
      
      private function updateEventListener(param1:UpdateEvent) : void {
         if(this._fixedFrameTime)
         {
            this.update(this._fixedFrameTime);
         }
         else
         {
            this.update(param1.time);
         }
      }
      
      public function update(param1:Number) : void {
         var _loc2_:* = 0;
         var _loc3_:Particle = null;
         var _loc5_:Action = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         if(!this._running || param1 > this._maximumFrameTime)
         {
            return;
         }
         var _loc4_:int = this._counter.updateEmitter(this,param1);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            this.createParticle();
            _loc2_++;
         }
         this.sortParticles();
         _loc4_ = this._activities.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            this._activities[_loc2_].update(this,param1);
            _loc2_++;
         }
         if(this._particles.length > 0)
         {
            _loc4_ = this._actions.length;
            _loc6_ = this._particles.length;
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc5_ = this._actions[_loc7_];
               _loc2_ = 0;
               while(_loc2_ < _loc6_)
               {
                  _loc3_ = this._particles[_loc2_];
                  _loc5_.update(this,_loc3_,param1);
                  _loc2_++;
               }
               _loc7_++;
            }
            _loc2_ = _loc6_;
            while(_loc2_--)
            {
               _loc3_ = this._particles[_loc2_];
               if(_loc3_.isDead)
               {
                  dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,_loc3_));
                  this._particleFactory.disposeParticle(_loc3_);
                  this._particles.splice(_loc2_,1);
               }
            }
         }
         else
         {
            dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_EMPTY));
         }
         dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_UPDATED));
      }
      
      protected function sortParticles() : void {
      }
      
      public function pause() : void {
         this._running = false;
      }
      
      public function resume() : void {
         this._running = true;
      }
      
      public function stop() : void {
         if(this._useInternalTick)
         {
            FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE,this.updateEventListener);
         }
         this._started = false;
         this.killAllParticles();
      }
      
      public function runAhead(param1:Number, param2:Number=10) : void {
         var _loc3_:Number = this._maximumFrameTime;
         var _loc4_:Number = 1 / param2;
         this._maximumFrameTime = _loc4_;
         while(param1 > 0)
         {
            param1 = param1 - _loc4_;
            this.update(_loc4_);
         }
         this._maximumFrameTime = _loc3_;
      }
   }
}
