package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class RenameTabMessage extends ComponentMessage
   {
      
      public function RenameTabMessage(param1:InteractiveObject, param2:int, param3:String) {
         super(param1);
         this._index = param2;
         this._name = param3;
      }
      
      private var _index:int;
      
      private var _name:String;
      
      public function get index() : int {
         return this._index;
      }
      
      public function get name() : String {
         return this._name;
      }
   }
}
