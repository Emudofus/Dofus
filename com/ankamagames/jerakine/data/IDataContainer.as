package com.ankamagames.jerakine.data
{

    public interface IDataContainer
    {

        public function IDataContainer();

        function get container() : Array;

        function get fileList() : Array;

        function get chunkLength() : uint;

        function get moduleName() : String;

        function get id() : uint;

        function create() : void;

    }
}
