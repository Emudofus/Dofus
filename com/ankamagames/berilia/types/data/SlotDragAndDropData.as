package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.interfaces.*;

    public class SlotDragAndDropData extends Object
    {
        public var currentHolder:ISlotDataHolder;
        public var slotData:ISlotData;

        public function SlotDragAndDropData(param1:ISlotDataHolder, param2:ISlotData)
        {
            this.currentHolder = param1;
            this.slotData = param2;
            return;
        }// end function

    }
}
