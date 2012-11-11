package com.ankamagames.atouin.resources.adapters
{
    import com.ankamagames.atouin.data.elements.*;
    import com.ankamagames.atouin.resources.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import flash.errors.*;
    import flash.net.*;
    import flash.utils.*;

    public class ElementsAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {

        public function ElementsAdapter()
        {
            return;
        }// end function

        override protected function getResource(param1:String, param2)
        {
            var dataFormat:* = param1;
            var data:* = param2;
            var ba:* = data as ByteArray;
            ba.endian = Endian.BIG_ENDIAN;
            var header:* = ba.readByte();
            if (header != 69)
            {
                ba.position = 0;
                try
                {
                    ba.uncompress();
                }
                catch (ioe:IOError)
                {
                    dispatchFailure("Wrong header and non-compressed file.", ResourceErrorCode.MALFORMED_ELE_FILE);
                    return null;
                }
                header = ba.readByte();
                if (header != 69)
                {
                    dispatchFailure("Wrong header file.", ResourceErrorCode.MALFORMED_ELE_FILE);
                    return null;
                }
                trace("Using a compressed ELE file !!");
            }
            ba.position = 0;
            var ele:* = Elements.getInstance();
            ele.fromRaw(ba);
            return ele;
        }// end function

        override public function getResourceType() : uint
        {
            return AtouinResourceType.RESOURCE_ELEMENTS;
        }// end function

        override protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.BINARY;
        }// end function

    }
}
