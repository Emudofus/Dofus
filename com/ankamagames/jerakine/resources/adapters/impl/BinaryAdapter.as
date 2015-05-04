package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.resources.ResourceType;
   import flash.net.URLLoaderDataFormat;
   
   public class BinaryAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      public function BinaryAdapter()
      {
         super();
      }
      
      override protected function getResource(param1:String, param2:*) : *
      {
         return param2;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_BINARY;
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.BINARY;
      }
   }
}
