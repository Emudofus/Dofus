package org.flintparticles.common.actions
{
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.energyEasing.*;
    import org.flintparticles.common.particles.*;

    public class Age extends ActionBase
    {
        private var _easing:Function;

        public function Age(param1:Function = null)
        {
            if (param1 == null)
            {
                this._easing = Linear.easeNone;
            }
            else
            {
                this._easing = param1;
            }
            return;
        }// end function

        public function get easing() : Function
        {
            return this._easing;
        }// end function

        public function set easing(param1:Function) : void
        {
            this._easing = param1;
            return;
        }// end function

        override public function update(param1:Emitter, param2:Particle, param3:Number) : void
        {
            param2.age = param2.age + param3;
            if (param2.age >= param2.lifetime)
            {
                param2.energy = 0;
                param2.isDead = true;
            }
            else
            {
                param2.energy = this._easing(param2.age, param2.lifetime);
            }
            return;
        }// end function

    }
}
