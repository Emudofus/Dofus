package com.ankamagames.jerakine.utils.misc
{
    public final class PriorityComparer 
    {


        public static function compare(x:Prioritizable, y:Prioritizable):Number
        {
            if (x.priority > y.priority)
            {
                return (-1);
            };
            if (x.priority < y.priority)
            {
                return (1);
            };
            return (0);
        }


    }
}//package com.ankamagames.jerakine.utils.misc

