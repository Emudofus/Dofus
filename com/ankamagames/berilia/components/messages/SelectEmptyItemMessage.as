package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class SelectEmptyItemMessage extends ComponentMessage
   {
      
      public function SelectEmptyItemMessage(param1:InteractiveObject, param2:uint=7) {
         super(param1);
         this._method = param2;
      }
      
      private var _method:uint;
      
      public function get selectMethod() : uint {
         return this._method;
      }
   }
}
