package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class DeleteTabMessage extends ComponentMessage
   {
      
      public function DeleteTabMessage(target:InteractiveObject, deletedIndex:int) {
         super(target);
         this._deletedIndex = deletedIndex;
      }
      
      private var _deletedIndex:int;
      
      public function get deletedIndex() : int {
         return this._deletedIndex;
      }
   }
}
