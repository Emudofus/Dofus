package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class SelectItemMessage extends ComponentMessage
   {
      
      public function SelectItemMessage(param1:InteractiveObject, param2:uint=7, param3:Boolean=true) {
         super(param1);
         this._method = param2;
         this._isNewSelection = param3;
      }
      
      private var _method:uint;
      
      private var _isNewSelection:Boolean;
      
      public function get selectMethod() : uint {
         return this._method;
      }
      
      public function get isNewSelection() : Boolean {
         return this._isNewSelection;
      }
   }
}
