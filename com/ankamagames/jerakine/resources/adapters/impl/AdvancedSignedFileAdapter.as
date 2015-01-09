package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.utils.crypto.SignatureKey;
    import com.ankamagames.jerakine.resources.ResourceType;

    public class AdvancedSignedFileAdapter extends SignedFileAdapter 
    {

        public function AdvancedSignedFileAdapter(signatureKey:SignatureKey=null)
        {
            super(signatureKey, true);
        }

        override public function getResourceType():uint
        {
            return (ResourceType.RESOURCE_BINARY);
        }


    }
}//package com.ankamagames.jerakine.resources.adapters.impl

