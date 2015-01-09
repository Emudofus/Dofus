package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
    import com.ankamagames.jerakine.interfaces.ISlotData;

    public class SlotDragAndDropData 
    {

        public var currentHolder:ISlotDataHolder;
        public var slotData:ISlotData;

        public function SlotDragAndDropData(currentHolder:ISlotDataHolder, slotData:ISlotData)
        {
            this.currentHolder = currentHolder;
            this.slotData = slotData;
        }

    }
}//package com.ankamagames.berilia.types.data

