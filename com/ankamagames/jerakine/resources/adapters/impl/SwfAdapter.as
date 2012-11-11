package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import flash.display.*;

    public class SwfAdapter extends AbstractLoaderAdapter implements IAdapter
    {

        public function SwfAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:LoaderInfo)
        {
            return param1.loader.content;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_SWF;
        }// end function

    }
}
