package com.ankamagames.jerakine.network
{
    import flash.utils.*;

    public interface INetworkDataContainerMessage
    {

        public function INetworkDataContainerMessage();

        function get content() : ByteArray;

        function set content(param1:ByteArray) : void;

    }
}
