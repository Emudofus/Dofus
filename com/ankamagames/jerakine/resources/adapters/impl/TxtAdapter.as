package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import flash.utils.*;

    public class TxtAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {

        public function TxtAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            if (param1 == ResourceType.getName(ResourceType.RESOURCE_BINARY) && param2 is IDataInput)
            {
                return IDataInput(param2).readUTFBytes(IDataInput(param2).bytesAvailable);
            }
            return param2 as String;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_TXT;
        }// end function

    }
}
