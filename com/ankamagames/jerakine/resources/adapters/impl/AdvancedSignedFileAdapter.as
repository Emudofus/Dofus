package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.utils.crypto.*;

    public class AdvancedSignedFileAdapter extends SignedFileAdapter
    {

        public function AdvancedSignedFileAdapter(param1:SignatureKey = null)
        {
            super(param1, true);
            return;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_BINARY;
        }// end function

    }
}
