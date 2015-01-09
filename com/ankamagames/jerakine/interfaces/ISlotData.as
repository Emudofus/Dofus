package com.ankamagames.jerakine.interfaces
{
    import com.ankamagames.jerakine.types.Uri;

    public interface ISlotData 
    {

        function get iconUri():Uri;
        function get fullSizeIconUri():Uri;
        function get errorIconUri():Uri;
        function get info1():String;
        function get active():Boolean;
        function get timer():int;
        function get startTime():int;
        function get endTime():int;
        function set endTime(_arg_1:int):void;
        function addHolder(_arg_1:ISlotDataHolder):void;
        function removeHolder(_arg_1:ISlotDataHolder):void;

    }
}//package com.ankamagames.jerakine.interfaces

