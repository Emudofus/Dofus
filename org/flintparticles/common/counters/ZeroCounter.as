package org.flintparticles.common.counters
{
    import org.flintparticles.common.counters.*;
    import org.flintparticles.common.emitters.*;

    public class ZeroCounter extends Object implements Counter
    {

        public function ZeroCounter()
        {
            return;
        }// end function

        public function startEmitter(param1:Emitter) : uint
        {
            return 0;
        }// end function

        public function updateEmitter(param1:Emitter, param2:Number) : uint
        {
            return 0;
        }// end function

        public function stop() : void
        {
            return;
        }// end function

        public function resume() : void
        {
            return;
        }// end function

    }
}
