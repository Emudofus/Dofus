package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import flash.display.InteractiveObject;
   
   public class DropMessage extends ComponentMessage
   {
      
      public function DropMessage(target:InteractiveObject, source:ISlotDataHolder) {
         super(target);
         this._source = source;
      }
      
      private var _source:ISlotDataHolder;
      
      public function get source() : ISlotDataHolder {
         return this._source;
      }
   }
}
