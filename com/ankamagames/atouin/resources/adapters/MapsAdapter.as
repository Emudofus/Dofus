package com.ankamagames.atouin.resources.adapters
{
    import com.ankamagames.atouin.resources.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.*;
    import flash.errors.*;
    import flash.net.*;
    import flash.utils.*;

    public class MapsAdapter extends AbstractUrlLoaderAdapter implements IAdapter
    {

        public function MapsAdapter()
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
            if (header != 77)
            {
                ba.position = 0;
                try
                {
                    ba.uncompress();
                }
                catch (ioe:IOError)
                {
                    dispatchFailure("Wrong header and non-compressed file.", ResourceErrorCode.MALFORMED_MAP_FILE);
                    return null;
                }
                header = ba.readByte();
                if (header != 77)
                {
                    dispatchFailure("Wrong header file.", ResourceErrorCode.MALFORMED_MAP_FILE);
                    return null;
                }
            }
            ba.position = 0;
            return ba;
        }// end function

        override public function getResourceType() : uint
        {
            return AtouinResourceType.RESOURCE_MAP;
        }// end function

        override protected function getDataFormat() : String
        {
            return URLLoaderDataFormat.BINARY;
        }// end function

    }
}
