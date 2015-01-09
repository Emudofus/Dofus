package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
    import com.ankamagames.jerakine.resources.adapters.IAdapter;
    import flash.display.Bitmap;
    import flash.display.LoaderInfo;
    import com.ankamagames.jerakine.resources.ResourceType;

    public class BitmapAdapter extends AbstractLoaderAdapter implements IAdapter 
    {


        override protected function getResource(ldr:LoaderInfo)
        {
            return (Bitmap(ldr.loader.content).bitmapData);
        }

        override public function getResourceType():uint
        {
            return (ResourceType.RESOURCE_BITMAP);
        }


    }
}//package com.ankamagames.jerakine.resources.adapters.impl

