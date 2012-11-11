package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.dofus.types.entities.*;
    import flash.display.*;

    public class BasicParticle extends Object implements IParticule
    {
        protected var _sprite:DisplayObject;
        protected var _life:uint;
        protected var _subExplosion:Boolean;
        protected var _initialLife:uint;
        protected var _deathDispatched:Boolean;
        protected var _deathCallback:Function;

        public function BasicParticle(param1:DisplayObject, param2:uint, param3:Boolean, param4:Function)
        {
            this._sprite = param1;
            var _loc_5:* = param2;
            this._initialLife = param2;
            this._life = _loc_5;
            this._subExplosion = param3;
            this._deathCallback = param4;
            return;
        }// end function

        public function update() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = this._life / this._initialLife;
            if (this._subExplosion && Math.random() > _loc_2)
            {
                _loc_1 = true;
            }
            if ((!this._life || _loc_1) && !this._deathDispatched)
            {
                this._deathCallback(this, _loc_1);
            }
            this._sprite.alpha = _loc_2 > 1 / 2 ? (1) : (_loc_2 * 2);
            if (this._life)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._life - 1;
                _loc_3._life = _loc_4;
            }
            return;
        }// end function

        public function get sprite() : DisplayObject
        {
            return this._sprite;
        }// end function

        public function get life() : uint
        {
            return this._life;
        }// end function

        public function get subExplosion() : Boolean
        {
            return this._subExplosion;
        }// end function

        public function set subExplosion(param1:Boolean) : void
        {
            this._subExplosion = param1;
            return;
        }// end function

    }
}
