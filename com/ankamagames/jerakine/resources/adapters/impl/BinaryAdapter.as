package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import flash.net.*;

    public class BinaryAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {

        public function BinaryAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            return param2;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_BINARY;
        }// end function

        override protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.BINARY;
        }// end function

    }
}
