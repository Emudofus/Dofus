package org.flintparticles.common.renderers
{
   import flash.display.Sprite;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.common.events.ParticleEvent;
   import flash.events.Event;
   
   public class SpriteRendererBase extends Sprite implements Renderer
   {
      
      public function SpriteRendererBase() {
         super();
         this._emitters = new Array();
         mouseEnabled = false;
         mouseChildren = false;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage,false,0,true);
      }
      
      protected var _emitters:Array;
      
      public function addEmitter(param1:Emitter) : void {
         var _loc2_:Particle = null;
         this._emitters.push(param1);
         if(stage)
         {
            stage.invalidate();
         }
         param1.addEventListener(EmitterEvent.EMITTER_UPDATED,this.emitterUpdated,false,0,true);
         param1.addEventListener(ParticleEvent.PARTICLE_CREATED,this.particleAdded,false,0,true);
         param1.addEventListener(ParticleEvent.PARTICLE_ADDED,this.particleAdded,false,0,true);
         param1.addEventListener(ParticleEvent.PARTICLE_DEAD,this.particleRemoved,false,0,true);
         for each (_loc2_ in param1.particles)
         {
            this.addParticle(_loc2_);
         }
         if(this._emitters.length == 1)
         {
            addEventListener(Event.RENDER,this.updateParticles,false,0,true);
         }
      }
      
      public function removeEmitter(param1:Emitter) : void {
         var _loc3_:Particle = null;
         var _loc2_:* = 0;
         while(_loc2_ < this._emitters.length)
         {
            if(this._emitters[_loc2_] == param1)
            {
               this._emitters.splice(_loc2_,1);
               param1.removeEventListener(EmitterEvent.EMITTER_UPDATED,this.emitterUpdated);
               param1.removeEventListener(ParticleEvent.PARTICLE_CREATED,this.particleAdded);
               param1.removeEventListener(ParticleEvent.PARTICLE_ADDED,this.particleAdded);
               param1.removeEventListener(ParticleEvent.PARTICLE_DEAD,this.particleRemoved);
               for each (_loc3_ in param1.particles)
               {
                  this.removeParticle(_loc3_);
               }
               if(this._emitters.length == 0)
               {
                  removeEventListener(Event.RENDER,this.updateParticles);
                  this.renderParticles([]);
               }
               else
               {
                  stage.invalidate();
               }
               return;
            }
            _loc2_++;
         }
      }
      
      private function addedToStage(param1:Event) : void {
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function particleAdded(param1:ParticleEvent) : void {
         this.addParticle(param1.particle);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function particleRemoved(param1:ParticleEvent) : void {
         this.removeParticle(param1.particle);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function emitterUpdated(param1:EmitterEvent) : void {
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function updateParticles(param1:Event) : void {
         var _loc2_:Array = new Array();
         var _loc3_:* = 0;
         while(_loc3_ < this._emitters.length)
         {
            _loc2_ = _loc2_.concat(this._emitters[_loc3_].particles);
            _loc3_++;
         }
         this.renderParticles(_loc2_);
      }
      
      protected function addParticle(param1:Particle) : void {
      }
      
      protected function removeParticle(param1:Particle) : void {
      }
      
      protected function renderParticles(param1:Array) : void {
      }
      
      public function get emitters() : Array {
         return this._emitters;
      }
   }
}
