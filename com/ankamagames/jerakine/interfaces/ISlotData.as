package com.ankamagames.jerakine.interfaces
{
    import com.ankamagames.jerakine.types.*;

    public interface ISlotData
    {

        public function ISlotData();

        function get iconUri() : Uri;

        function get fullSizeIconUri() : Uri;

        function get errorIconUri() : Uri;

        function get info1() : String;

        function get active() : Boolean;

        function get timer() : int;

        function addHolder(param1:ISlotDataHolder) : void;

        function removeHolder(param1:ISlotDataHolder) : void;

    }
}
