package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.utils.construct;
   
   public class ImageClass extends InitializerBase
   {
      
      public function ImageClass(param1:Class, ... rest) {
         super();
         this._imageClass = param1;
         this._parameters = rest;
      }
      
      private var _imageClass:Class;
      
      private var _parameters:Array;
      
      public function get imageClass() : Class {
         return this._imageClass;
      }
      
      public function set imageClass(param1:Class) : void {
         this._imageClass = param1;
      }
      
      public function get parameters() : Array {
         return this._parameters;
      }
      
      public function set parameters(param1:Array) : void {
         this._parameters = param1;
      }
      
      override public function initialize(param1:Emitter, param2:Particle) : void {
         param2.image = construct(this._imageClass,this._parameters);
      }
   }
}
