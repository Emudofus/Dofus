package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import flash.net.*;
    import flash.utils.*;
    import nochump.util.zip.*;

    public class ZipAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {

        public function ZipAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            return new ZipFile(param2 as ByteArray);
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_ZIP;
        }// end function

        override protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.BINARY;
        }// end function

    }
}
