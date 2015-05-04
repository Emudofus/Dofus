package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.display.LoaderInfo;
   import com.ankamagames.jerakine.resources.ResourceType;
   
   public class SwfAdapter extends AbstractLoaderAdapter implements IAdapter
   {
      
      public function SwfAdapter()
      {
         super();
      }
      
      override protected function getResource(param1:LoaderInfo) : *
      {
         return param1.loader.content;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_SWF;
      }
   }
}
