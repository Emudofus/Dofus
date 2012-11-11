package com.ankamagames.jerakine.utils.misc
{

    final public class PriorityComparer extends Object
    {

        public function PriorityComparer()
        {
            return;
        }// end function

        public static function compare(param1:Prioritizable, param2:Prioritizable) : Number
        {
            if (param1.priority > param2.priority)
            {
                return -1;
            }
            if (param1.priority < param2.priority)
            {
                return 1;
            }
            return 0;
        }// end function

    }
}
