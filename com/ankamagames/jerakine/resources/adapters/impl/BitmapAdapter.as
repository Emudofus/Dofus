package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import flash.display.*;

    public class BitmapAdapter extends AbstractLoaderAdapter implements IAdapter
    {

        public function BitmapAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:LoaderInfo)
        {
            return Bitmap(param1.loader.content).bitmapData;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_BITMAP;
        }// end function

    }
}
