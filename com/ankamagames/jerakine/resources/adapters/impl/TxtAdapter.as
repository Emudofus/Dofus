package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import com.ankamagames.jerakine.resources.ResourceType;
   import flash.utils.IDataInput;
   
   public class TxtAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
      
      public function TxtAdapter() {
         super();
      }
      
      override protected function getResource(param1:String, param2:*) : * {
         if(param1 == ResourceType.getName(ResourceType.RESOURCE_BINARY) && param2 is IDataInput)
         {
            return IDataInput(param2).readUTFBytes(IDataInput(param2).bytesAvailable);
         }
         return param2 as String;
      }
      
      override public function getResourceType() : uint {
         return ResourceType.RESOURCE_TXT;
      }
   }
}
