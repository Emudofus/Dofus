package org.audiofx.mp3
{
    import flash.utils.*;

    class ByteArraySegment extends Object
    {
        public var start:uint;
        public var length:uint;
        public var byteArray:ByteArray;

        function ByteArraySegment(param1:ByteArray, param2:uint, param3:uint)
        {
            this.byteArray = param1;
            this.start = param2;
            this.length = param3;
            return;
        }// end function

    }
}
