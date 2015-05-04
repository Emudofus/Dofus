package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.LoaderContext;
   import flash.display.LoaderInfo;
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.resources.ResourceType;
   
   public class BitmapAdapter extends AbstractLoaderAdapter implements IAdapter
   {
      
      public function BitmapAdapter()
      {
         super();
      }
      
      override public function loadDirectly(param1:Uri, param2:String, param3:IResourceObserver, param4:Boolean) : void
      {
         if(AirScanner.isStreamingVersion())
         {
            if(param1.loaderContext)
            {
               param1.loaderContext.checkPolicyFile = true;
            }
            else
            {
               param1.loaderContext = new LoaderContext(true);
            }
         }
         super.loadDirectly(param1,param2,param3,param4);
      }
      
      override protected function getResource(param1:LoaderInfo) : *
      {
         return Bitmap(param1.loader.content).bitmapData;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_BITMAP;
      }
   }
}
