package com.ankamagames.jerakine.interfaces
{
    import com.ankamagames.jerakine.interfaces.*;

    public interface ISlotDataHolder extends IDragAndDropHandler
    {

        public function ISlotDataHolder();

        function refresh() : void;

        function set data(param1) : void;

        function get data();

    }
}
