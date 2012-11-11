package org.flintparticles.common.renderers
{
    import flash.display.*;
    import flash.events.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.events.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.common.renderers.*;

    public class SpriteRendererBase extends Sprite implements Renderer
    {
        protected var _emitters:Array;

        public function SpriteRendererBase()
        {
            this._emitters = new Array();
            mouseEnabled = false;
            mouseChildren = false;
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStage, false, 0, true);
            return;
        }// end function

        public function addEmitter(param1:Emitter) : void
        {
            var _loc_2:* = null;
            this._emitters.push(param1);
            if (stage)
            {
                stage.invalidate();
            }
            param1.addEventListener(EmitterEvent.EMITTER_UPDATED, this.emitterUpdated, false, 0, true);
            param1.addEventListener(ParticleEvent.PARTICLE_CREATED, this.particleAdded, false, 0, true);
            param1.addEventListener(ParticleEvent.PARTICLE_ADDED, this.particleAdded, false, 0, true);
            param1.addEventListener(ParticleEvent.PARTICLE_DEAD, this.particleRemoved, false, 0, true);
            for each (_loc_2 in param1.particles)
            {
                
                this.addParticle(_loc_2);
            }
            if (this._emitters.length == 1)
            {
                addEventListener(Event.RENDER, this.updateParticles, false, 0, true);
            }
            return;
        }// end function

        public function removeEmitter(param1:Emitter) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._emitters.length)
            {
                
                if (this._emitters[_loc_2] == param1)
                {
                    this._emitters.splice(_loc_2, 1);
                    param1.removeEventListener(EmitterEvent.EMITTER_UPDATED, this.emitterUpdated);
                    param1.removeEventListener(ParticleEvent.PARTICLE_CREATED, this.particleAdded);
                    param1.removeEventListener(ParticleEvent.PARTICLE_ADDED, this.particleAdded);
                    param1.removeEventListener(ParticleEvent.PARTICLE_DEAD, this.particleRemoved);
                    for each (_loc_3 in param1.particles)
                    {
                        
                        this.removeParticle(_loc_3);
                    }
                    if (this._emitters.length == 0)
                    {
                        removeEventListener(Event.RENDER, this.updateParticles);
                        this.renderParticles([]);
                    }
                    else
                    {
                        stage.invalidate();
                    }
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        private function particleAdded(event:ParticleEvent) : void
        {
            this.addParticle(event.particle);
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        private function particleRemoved(event:ParticleEvent) : void
        {
            this.removeParticle(event.particle);
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        private function emitterUpdated(event:EmitterEvent) : void
        {
            if (stage)
            {
                stage.invalidate();
            }
            return;
        }// end function

        private function updateParticles(event:Event) : void
        {
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            while (_loc_3 < this._emitters.length)
            {
                
                _loc_2 = _loc_2.concat(this._emitters[_loc_3].particles);
                _loc_3++;
            }
            this.renderParticles(_loc_2);
            return;
        }// end function

        protected function addParticle(param1:Particle) : void
        {
            return;
        }// end function

        protected function removeParticle(param1:Particle) : void
        {
            return;
        }// end function

        protected function renderParticles(param1:Array) : void
        {
            return;
        }// end function

        public function get emitters() : Array
        {
            return this._emitters;
        }// end function

    }
}
