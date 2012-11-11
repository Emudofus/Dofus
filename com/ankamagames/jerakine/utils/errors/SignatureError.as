package com.ankamagames.jerakine.utils.errors
{

    public class SignatureError extends Error
    {
        public static const INVALID_HEADER:uint = 1;
        public static const INVALID_SIGNATURE:uint = 2;

        public function SignatureError(param1 = "", param2 = 0)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
