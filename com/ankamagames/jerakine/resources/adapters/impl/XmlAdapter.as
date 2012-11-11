package com.ankamagames.jerakine.resources.adapters.impl
{
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;

    public class XmlAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {

        public function XmlAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            var str:String;
            var dataFormat:* = param1;
            var data:* = param2;
            var xml:XML;
            try
            {
                str = data.toString();
                xml = new XML(data);
            }
            catch (te:TypeError)
            {
                this.dispatchFailure(te.message, ResourceErrorCode.XML_MALFORMED_FILE);
            }
            return xml;
        }// end function

        override public function getResourceType() : uint
        {
            return ResourceType.RESOURCE_XML;
        }// end function

    }
}
