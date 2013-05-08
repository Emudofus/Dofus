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
         this._particles=new Array();
         this._actions=new PriorityArray();
         this._initializers=new PriorityArray();
         this._activities=new PriorityArray();
         this._counter=new ZeroCounter();
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

      public function set maximumFrameTime(value:Number) : void {
         this._maximumFrameTime=value;
      }

      public function addInitializer(initializer:Initializer, priority:Number=NaN) : void {
         if(isNaN(priority))
         {
            priority=initializer.getDefaultPriority();
         }
         this._initializers.add(initializer,priority);
         initializer.addedToEmitter(this);
      }

      public function removeInitializer(initializer:Initializer) : void {
         if(this._initializers.remove(initializer))
         {
            initializer.removedFromEmitter(this);
         }
      }

      public function hasInitializer(initializer:Initializer) : Boolean {
         return this._initializers.contains(initializer);
      }

      public function hasInitializerOfType(initializerClass:Class) : Boolean {
         var len:uint = this._initializers.length;
         var i:uint = 0;
         while(i<len)
         {
            if(this._initializers[i] is initializerClass)
            {
               return true;
            }
            i++;
         }
         return false;
      }

      public function addAction(action:Action, priority:Number=NaN) : void {
         if(isNaN(priority))
         {
            priority=action.getDefaultPriority();
         }
         this._actions.add(action,priority);
         action.addedToEmitter(this);
      }

      public function removeAction(action:Action) : void {
         if(this._actions.remove(action))
         {
            action.removedFromEmitter(this);
         }
      }

      public function hasAction(action:Action) : Boolean {
         return this._actions.contains(action);
      }

      public function hasActionOfType(actionClass:Class) : Boolean {
         var len:uint = this._actions.length;
         var i:uint = 0;
         while(i<len)
         {
            if(this._actions[i] is actionClass)
            {
               return true;
            }
            i++;
         }
         return false;
      }

      public function addActivity(activity:Activity, priority:Number=NaN) : void {
         if(isNaN(priority))
         {
            priority=activity.getDefaultPriority();
         }
         this._activities.add(activity,priority);
         activity.addedToEmitter(this);
      }

      public function removeActivity(activity:Activity) : void {
         if(this._activities.remove(activity))
         {
            activity.removedFromEmitter(this);
         }
      }

      public function hasActivity(activity:Activity) : Boolean {
         return this._activities.contains(activity);
      }

      public function hasActivityOfType(activityClass:Class) : Boolean {
         var len:uint = this._activities.length;
         var i:uint = 0;
         while(i<len)
         {
            if(this._activities[i] is activityClass)
            {
               return true;
            }
            i++;
         }
         return false;
      }

      public function get counter() : Counter {
         return this._counter;
      }

      public function set counter(value:Counter) : void {
         this._counter=value;
      }

      public function get useInternalTick() : Boolean {
         return this._useInternalTick;
      }

      public function set useInternalTick(value:Boolean) : void {
         if(this._useInternalTick!=value)
         {
            this._useInternalTick=value;
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

      public function set fixedFrameTime(value:Number) : void {
         this._fixedFrameTime=value;
      }

      public function get running() : Boolean {
         return this._running;
      }

      public function get particleFactory() : ParticleFactory {
         return this._particleFactory;
      }

      public function set particleFactory(value:ParticleFactory) : void {
         this._particleFactory=value;
      }

      public function get particles() : Array {
         return this._particles;
      }

      protected function createParticle() : Particle {
         var particle:Particle = this._particleFactory.createParticle();
         var len:int = this._initializers.length;
         this.initParticle(particle);
         var i:int = 0;
         while(i<len)
         {
            this._initializers[i].initialize(this,particle);
            i++;
         }
         this._particles.push(particle);
         dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_CREATED,particle));
         return particle;
      }

      protected function initParticle(particle:Particle) : void {
         
      }

      public function addExistingParticles(particles:Array, applyInitializers:Boolean=false) : void {
         var i:* = 0;
         var len2:* = 0;
         var j:* = 0;
         var len:int = particles.length;
         if(applyInitializers)
         {
            len2=this._initializers.length;
            j=0;
            while(j<len2)
            {
               i=0;
               while(i<len)
               {
                  this._initializers[j].initialize(this,particles[i]);
                  i++;
               }
               j++;
            }
         }
         i=0;
         while(i<len)
         {
            this._particles.push(particles[i]);
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED,particles[i]));
            i++;
         }
      }

      public function killAllParticles() : void {
         var len:int = this._particles.length;
         var i:int = 0;
         while(i<len)
         {
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,this._particles[i]));
            this._particleFactory.disposeParticle(this._particles[i]);
            i++;
         }
         this._particles.length=0;
      }

      public function start() : void {
         if(this._useInternalTick)
         {
            FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE,this.updateEventListener,false,0,true);
         }
         this._started=true;
         this._running=true;
         var len:int = this._activities.length;
         var i:int = 0;
         while(i<len)
         {
            this._activities[i].initialize(this);
            i++;
         }
         len=this._counter.startEmitter(this);
         i=0;
         while(i<len)
         {
            this.createParticle();
            i++;
         }
      }

      private function updateEventListener(ev:UpdateEvent) : void {
         if(this._fixedFrameTime)
         {
            this.update(this._fixedFrameTime);
         }
         else
         {
            this.update(ev.time);
         }
      }

      public function update(time:Number) : void {
         var i:* = 0;
         var particle:Particle = null;
         var action:Action = null;
         var len2:* = 0;
         var j:* = 0;
         if((!this._running)||(time<this._maximumFrameTime))
         {
            return;
         }
         var len:int = this._counter.updateEmitter(this,time);
         i=0;
         while(i<len)
         {
            this.createParticle();
            i++;
         }
         this.sortParticles();
         len=this._activities.length;
         i=0;
         while(i<len)
         {
            this._activities[i].update(this,time);
            i++;
         }
         if(this._particles.length>0)
         {
            len=this._actions.length;
            len2=this._particles.length;
            j=0;
            while(j<len)
            {
               action=this._actions[j];
               i=0;
               while(i<len2)
               {
                  particle=this._particles[i];
                  action.update(this,particle,time);
                  i++;
               }
               j++;
            }
            i=len2;
            while(i--)
            {
               particle=this._particles[i];
               if(particle.isDead)
               {
                  dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,particle));
                  this._particleFactory.disposeParticle(particle);
                  this._particles.splice(i,1);
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
         this._running=false;
      }

      public function resume() : void {
         this._running=true;
      }

      public function stop() : void {
         if(this._useInternalTick)
         {
            FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE,this.updateEventListener);
         }
         this._started=false;
         this.killAllParticles();
      }

      public function runAhead(time:Number, frameRate:Number=10) : void {
         var maxTime:Number = this._maximumFrameTime;
         var step:Number = 1/frameRate;
         this._maximumFrameTime=step;
         while(time>0)
         {
            time=time-step;
            this.update(step);
         }
         this._maximumFrameTime=maxTime;
      }
   }

}