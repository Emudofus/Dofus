package com.hurlant.util.der
{
    import flash.utils.*;

    public interface IAsn1Type
    {

        public function IAsn1Type();

        function getType() : uint;

        function getLength() : uint;

        function toDER() : ByteArray;

    }
}
