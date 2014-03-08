package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.display.LoaderInfo;
   import flash.display.Bitmap;
   import com.ankamagames.jerakine.resources.ResourceType;
   
   public class BitmapAdapter extends AbstractLoaderAdapter implements IAdapter
   {
      
      public function BitmapAdapter() {
         super();
      }
      
      override protected function getResource(ldr:LoaderInfo) : * {
         return Bitmap(ldr.loader.content).bitmapData;
      }
      
      override public function getResourceType() : uint {
         return ResourceType.RESOURCE_BITMAP;
      }
   }
}
