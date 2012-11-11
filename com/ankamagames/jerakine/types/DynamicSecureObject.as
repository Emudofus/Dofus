package com.ankamagames.jerakine.types
{
    import com.ankamagames.jerakine.interfaces.*;

    dynamic public class DynamicSecureObject extends Object implements Secure, INoBoxing
    {

        public function DynamicSecureObject()
        {
            return;
        }// end function

        public function getObject(param1:Object)
        {
            return this;
        }// end function

    }
}
