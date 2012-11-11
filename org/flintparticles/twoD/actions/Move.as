package org.flintparticles.twoD.actions
{
    import org.flintparticles.common.actions.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;
    import org.flintparticles.twoD.particles.*;

    public class Move extends ActionBase
    {
        private var p:Particle2D;

        public function Move()
        {
            return;
        }// end function

        override public function getDefaultPriority() : Number
        {
            return -10;
        }// end function

        override public function update(param1:Emitter, param2:Particle, param3:Number) : void
        {
            this.p = Particle2D(param2);
            this.p.x = this.p.x + this.p.velX * param3;
            this.p.y = this.p.y + this.p.velY * param3;
            return;
        }// end function

    }
}
