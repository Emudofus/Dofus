package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.interfaces.*;

    dynamic public class UnsecureArray extends Array implements Secure
    {

        public function UnsecureArray()
        {
            return;
        }// end function

        public function getObject(param1:Object)
        {
            return this;
        }// end function

    }
}
