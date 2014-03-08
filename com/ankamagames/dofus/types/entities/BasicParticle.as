package com.ankamagames.dofus.types.entities
{
   import flash.display.DisplayObject;
   
   public class BasicParticle extends Object implements IParticule
   {
      
      public function BasicParticle(param1:DisplayObject, param2:uint, param3:Boolean, param4:Function) {
         super();
         this._sprite = param1;
         this._life = this._initialLife = param2;
         this._subExplosion = param3;
         this._deathCallback = param4;
      }
      
      protected var _sprite:DisplayObject;
      
      protected var _life:uint;
      
      protected var _subExplosion:Boolean;
      
      protected var _initialLife:uint;
      
      protected var _deathDispatched:Boolean;
      
      protected var _deathCallback:Function;
      
      public function update() : void {
         var _loc1_:* = false;
         var _loc2_:Number = this._life / this._initialLife;
         if((this._subExplosion) && Math.random() > _loc2_)
         {
            _loc1_ = true;
         }
         if((!this._life || (_loc1_)) && !this._deathDispatched)
         {
            this._deathCallback(this,_loc1_);
         }
         this._sprite.alpha = _loc2_ > 1 / 2?1:_loc2_ * 2;
         if(this._life)
         {
            this._life--;
         }
      }
      
      public function get sprite() : DisplayObject {
         return this._sprite;
      }
      
      public function get life() : uint {
         return this._life;
      }
      
      public function get subExplosion() : Boolean {
         return this._subExplosion;
      }
      
      public function set subExplosion(param1:Boolean) : void {
         this._subExplosion = param1;
      }
   }
}
