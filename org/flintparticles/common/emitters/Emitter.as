package org.flintparticles.common.emitters
{
    import flash.events.*;
    import org.flintparticles.common.actions.*;
    import org.flintparticles.common.activities.*;
    import org.flintparticles.common.counters.*;
    import org.flintparticles.common.events.*;
    import org.flintparticles.common.initializers.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.utils.*;

    public class Emitter extends EventDispatcher
    {
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

        public function Emitter()
        {
            this._particles = new Array();
            this._actions = new PriorityArray();
            this._initializers = new PriorityArray();
            this._activities = new PriorityArray();
            this._counter = new ZeroCounter();
            return;
        }// end function

        public function get maximumFrameTime() : Number
        {
            return this._maximumFrameTime;
        }// end function

        public function set maximumFrameTime(param1:Number) : void
        {
            this._maximumFrameTime = param1;
            return;
        }// end function

        public function addInitializer(param1:Initializer, param2:Number = NaN) : void
        {
            if (isNaN(param2))
            {
                param2 = param1.getDefaultPriority();
            }
            this._initializers.add(param1, param2);
            param1.addedToEmitter(this);
            return;
        }// end function

        public function removeInitializer(param1:Initializer) : void
        {
            if (this._initializers.remove(param1))
            {
                param1.removedFromEmitter(this);
            }
            return;
        }// end function

        public function hasInitializer(param1:Initializer) : Boolean
        {
            return this._initializers.contains(param1);
        }// end function

        public function hasInitializerOfType(param1:Class) : Boolean
        {
            var _loc_2:* = this._initializers.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._initializers[_loc_3] is param1)
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function addAction(param1:Action, param2:Number = NaN) : void
        {
            if (isNaN(param2))
            {
                param2 = param1.getDefaultPriority();
            }
            this._actions.add(param1, param2);
            param1.addedToEmitter(this);
            return;
        }// end function

        public function removeAction(param1:Action) : void
        {
            if (this._actions.remove(param1))
            {
                param1.removedFromEmitter(this);
            }
            return;
        }// end function

        public function hasAction(param1:Action) : Boolean
        {
            return this._actions.contains(param1);
        }// end function

        public function hasActionOfType(param1:Class) : Boolean
        {
            var _loc_2:* = this._actions.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._actions[_loc_3] is param1)
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function addActivity(param1:Activity, param2:Number = NaN) : void
        {
            if (isNaN(param2))
            {
                param2 = param1.org.flintparticles.common.activities:Activity::getDefaultPriority();
            }
            this._activities.add(param1, param2);
            param1.org.flintparticles.common.activities:Activity::addedToEmitter(this);
            return;
        }// end function

        public function removeActivity(param1:Activity) : void
        {
            if (this._activities.remove(param1))
            {
                param1.org.flintparticles.common.activities:Activity::removedFromEmitter(this);
            }
            return;
        }// end function

        public function hasActivity(param1:Activity) : Boolean
        {
            return this._activities.contains(param1);
        }// end function

        public function hasActivityOfType(param1:Class) : Boolean
        {
            var _loc_2:* = this._activities.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._activities[_loc_3] is param1)
                {
                    return true;
                }
                _loc_3 = _loc_3 + 1;
            }
            return false;
        }// end function

        public function get counter() : Counter
        {
            return this._counter;
        }// end function

        public function set counter(param1:Counter) : void
        {
            this._counter = param1;
            return;
        }// end function

        public function get useInternalTick() : Boolean
        {
            return this._useInternalTick;
        }// end function

        public function set useInternalTick(param1:Boolean) : void
        {
            if (this._useInternalTick != param1)
            {
                this._useInternalTick = param1;
                if (this._started)
                {
                    if (this._useInternalTick)
                    {
                        FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE, this.updateEventListener, false, 0, true);
                    }
                    else
                    {
                        FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE, this.updateEventListener);
                    }
                }
            }
            return;
        }// end function

        public function get fixedFrameTime() : Number
        {
            return this._fixedFrameTime;
        }// end function

        public function set fixedFrameTime(param1:Number) : void
        {
            this._fixedFrameTime = param1;
            return;
        }// end function

        public function get running() : Boolean
        {
            return this._running;
        }// end function

        public function get particleFactory() : ParticleFactory
        {
            return this._particleFactory;
        }// end function

        public function set particleFactory(param1:ParticleFactory) : void
        {
            this._particleFactory = param1;
            return;
        }// end function

        public function get particles() : Array
        {
            return this._particles;
        }// end function

        protected function createParticle() : Particle
        {
            var _loc_1:* = this._particleFactory.createParticle();
            var _loc_2:* = this._initializers.length;
            this.initParticle(_loc_1);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this._initializers[_loc_3].initialize(this, _loc_1);
                _loc_3++;
            }
            this._particles.push(_loc_1);
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_CREATED, _loc_1));
            return _loc_1;
        }// end function

        protected function initParticle(param1:Particle) : void
        {
            return;
        }// end function

        public function addExistingParticles(param1:Array, param2:Boolean = false) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_3:* = param1.length;
            if (param2)
            {
                _loc_5 = this._initializers.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3)
                    {
                        
                        this._initializers[_loc_6].initialize(this, param1[_loc_4]);
                        _loc_4++;
                    }
                    _loc_6++;
                }
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                this._particles.push(param1[_loc_4]);
                dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED, param1[_loc_4]));
                _loc_4++;
            }
            return;
        }// end function

        public function killAllParticles() : void
        {
            var _loc_1:* = this._particles.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD, this._particles[_loc_2]));
                this._particleFactory.disposeParticle(this._particles[_loc_2]);
                _loc_2++;
            }
            this._particles.length = 0;
            return;
        }// end function

        public function start() : void
        {
            if (this._useInternalTick)
            {
                FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE, this.updateEventListener, false, 0, true);
            }
            this._started = true;
            this._running = true;
            var _loc_1:* = this._activities.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._activities[_loc_2].initialize(this);
                _loc_2++;
            }
            _loc_1 = this._counter.startEmitter(this);
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this.createParticle();
                _loc_2++;
            }
            return;
        }// end function

        private function updateEventListener(event:UpdateEvent) : void
        {
            if (this._fixedFrameTime)
            {
                this.update(this._fixedFrameTime);
            }
            else
            {
                this.update(event.time);
            }
            return;
        }// end function

        public function update(param1:Number) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (!this._running || param1 > this._maximumFrameTime)
            {
                return;
            }
            var _loc_4:* = this._counter.updateEmitter(this, param1);
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this.createParticle();
                _loc_2++;
            }
            this.sortParticles();
            _loc_4 = this._activities.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_4)
            {
                
                this._activities[_loc_2].update(this, param1);
                _loc_2++;
            }
            if (this._particles.length > 0)
            {
                _loc_4 = this._actions.length;
                _loc_6 = this._particles.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_4)
                {
                    
                    _loc_5 = this._actions[_loc_7];
                    _loc_2 = 0;
                    while (_loc_2 < _loc_6)
                    {
                        
                        _loc_3 = this._particles[_loc_2];
                        _loc_5.update(this, _loc_3, param1);
                        _loc_2++;
                    }
                    _loc_7++;
                }
                _loc_2 = _loc_6;
                while (_loc_2--)
                {
                    
                    _loc_3 = this._particles[_loc_2];
                    if (_loc_3.isDead)
                    {
                        dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD, _loc_3));
                        this._particleFactory.disposeParticle(_loc_3);
                        this._particles.splice(_loc_2, 1);
                    }
                }
            }
            else
            {
                dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_EMPTY));
            }
            dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_UPDATED));
            return;
        }// end function

        protected function sortParticles() : void
        {
            return;
        }// end function

        public function pause() : void
        {
            this._running = false;
            return;
        }// end function

        public function resume() : void
        {
            this._running = true;
            return;
        }// end function

        public function stop() : void
        {
            if (this._useInternalTick)
            {
                FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE, this.updateEventListener);
            }
            this._started = false;
            this.killAllParticles();
            return;
        }// end function

        public function runAhead(param1:Number, param2:Number = 10) : void
        {
            var _loc_3:* = this._maximumFrameTime;
            var _loc_4:* = 1 / param2;
            this._maximumFrameTime = _loc_4;
            while (param1 > 0)
            {
                
                param1 = param1 - _loc_4;
                this.update(_loc_4);
            }
            this._maximumFrameTime = _loc_3;
            return;
        }// end function

    }
}
