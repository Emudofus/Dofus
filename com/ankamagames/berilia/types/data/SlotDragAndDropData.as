package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   
   public class SlotDragAndDropData extends Object
   {
      
      public function SlotDragAndDropData(currentHolder:ISlotDataHolder, slotData:ISlotData) {
         super();
         this.currentHolder = currentHolder;
         this.slotData = slotData;
      }
      
      public var currentHolder:ISlotDataHolder;
      
      public var slotData:ISlotData;
   }
}
