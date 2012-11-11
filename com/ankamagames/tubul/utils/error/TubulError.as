package com.ankamagames.tubul.utils.error
{

    public class TubulError extends Error
    {

        public function TubulError(param1:String = "", param2:uint = 0)
        {
            super("[TUBUL ERROR]" + param1, param2);
            return;
        }// end function

    }
}
