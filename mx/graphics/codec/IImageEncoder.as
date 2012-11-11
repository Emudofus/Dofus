package mx.graphics.codec
{
    import flash.display.*;
    import flash.utils.*;

    public interface IImageEncoder
    {

        public function IImageEncoder();

        function get contentType() : String;

        function encode(param1:BitmapData) : ByteArray;

        function encodeByteArray(param1:ByteArray, param2:int, param3:int, param4:Boolean = true) : ByteArray;

    }
}
