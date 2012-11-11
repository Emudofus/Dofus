package com.ankamagames.jerakine.tasking
{
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.events.*;

    public class SplittedTask extends EventDispatcher implements Prioritizable
    {
        private var _nPriority:int;

        public function SplittedTask()
        {
            return;
        }// end function

        public function step() : Boolean
        {
            throw new AbstractMethodCallError("step() must be redefined");
        }// end function

        public function stepsPerFrame() : uint
        {
            throw new AbstractMethodCallError("stepsPerFrame() must be redefined");
        }// end function

        public function get priority() : int
        {
            if (isNaN(this._nPriority))
            {
                return Priority.NORMAL;
            }
            return this._nPriority;
        }// end function

        public function set priority(param1:int) : void
        {
            this._nPriority = param1;
            return;
        }// end function

    }
}
