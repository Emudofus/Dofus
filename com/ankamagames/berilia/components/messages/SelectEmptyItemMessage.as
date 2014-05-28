package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class SelectEmptyItemMessage extends ComponentMessage
   {
      
      public function SelectEmptyItemMessage(target:InteractiveObject, selectMethod:uint = 7) {
         super(target);
         this._method = selectMethod;
      }
      
      private var _method:uint;
      
      public function get selectMethod() : uint {
         return this._method;
      }
   }
}
