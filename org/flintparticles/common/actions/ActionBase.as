package org.flintparticles.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import org.flintparticles.common.emitters.*;
    import org.flintparticles.common.particles.*;

    public class ActionBase extends Object implements Action
    {

        public function ActionBase()
        {
            return;
        }// end function

        public function getDefaultPriority() : Number
        {
            return 0;
        }// end function

        public function addedToEmitter(param1:Emitter) : void
        {
            return;
        }// end function

        public function removedFromEmitter(param1:Emitter) : void
        {
            return;
        }// end function

        public function update(param1:Emitter, param2:Particle, param3:Number) : void
        {
            return;
        }// end function

    }
}
