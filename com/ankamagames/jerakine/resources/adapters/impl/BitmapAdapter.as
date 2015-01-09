package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
    import com.ankamagames.jerakine.resources.adapters.IAdapter;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import flash.system.LoaderContext;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.jerakine.resources.IResourceObserver;
    import flash.display.Bitmap;
    import flash.display.LoaderInfo;
    import com.ankamagames.jerakine.resources.ResourceType;

    public class BitmapAdapter extends AbstractLoaderAdapter implements IAdapter 
    {


        override public function loadDirectly(uri:Uri, path:String, observer:IResourceObserver, dispatchProgress:Boolean):void
        {
            if (AirScanner.isStreamingVersion())
            {
                if (uri.loaderContext)
                {
                    uri.loaderContext.checkPolicyFile = true;
                }
                else
                {
                    uri.loaderContext = new LoaderContext(true);
                };
            };
            super.loadDirectly(uri, path, observer, dispatchProgress);
        }

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

