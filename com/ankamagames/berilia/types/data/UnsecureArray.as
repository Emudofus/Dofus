package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.interfaces.Secure;

    public dynamic class UnsecureArray extends Array implements Secure 
    {


        public function getObject(accessKey:Object)
        {
            return (this);
        }


    }
}//package com.ankamagames.berilia.types.data

