package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import flash.display.InteractiveObject;
   
   public class DropMessage extends ComponentMessage
   {
      
      public function DropMessage(param1:InteractiveObject, param2:ISlotDataHolder) {
         super(param1);
         this._source = param2;
      }
      
      private var _source:ISlotDataHolder;
      
      public function get source() : ISlotDataHolder {
         return this._source;
      }
   }
}
