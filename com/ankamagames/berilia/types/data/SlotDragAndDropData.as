package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   
   public class SlotDragAndDropData extends Object
   {
      
      public function SlotDragAndDropData(param1:ISlotDataHolder, param2:ISlotData) {
         super();
         this.currentHolder = param1;
         this.slotData = param2;
      }
      
      public var currentHolder:ISlotDataHolder;
      
      public var slotData:ISlotData;
   }
}
