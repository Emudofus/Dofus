package com.ankamagames.jerakine.types
{
    import com.ankamagames.jerakine.interfaces.Secure;
    import com.ankamagames.jerakine.interfaces.INoBoxing;

    public dynamic class DynamicSecureObject implements Secure, INoBoxing 
    {


        public function getObject(accessKey:Object)
        {
            return (this);
        }


    }
}//package com.ankamagames.jerakine.types

