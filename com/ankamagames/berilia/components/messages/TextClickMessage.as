package com.ankamagames.berilia.components.messages
{
   import flash.display.InteractiveObject;
   
   public class TextClickMessage extends ComponentMessage
   {
      
      public function TextClickMessage(target:InteractiveObject, textEvent:String) {
         this._textEvent = textEvent;
         super(target);
      }
      
      private var _textEvent:String;
      
      public function get textEvent() : String {
         return this._textEvent;
      }
   }
}
