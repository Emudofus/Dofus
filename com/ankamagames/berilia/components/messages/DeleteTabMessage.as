package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class DeleteTabMessage extends ComponentMessage
   {
      
      public function DeleteTabMessage(param1:InteractiveObject, param2:int) {
         super(param1);
         this._deletedIndex = param2;
      }
      
      private var _deletedIndex:int;
      
      public function get deletedIndex() : int {
         return this._deletedIndex;
      }
   }
}
