package com.ankamagames.jerakine.console
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ConsoleOutputMessage extends Object implements Message
   {
      
      public function ConsoleOutputMessage(param1:String, param2:String, param3:uint) {
         super();
         this._consoleId = param1;
         this._text = param2;
         this._type = param3;
      }
      
      private var _consoleId:String;
      
      private var _text:String;
      
      private var _type:uint;
      
      public function get consoleId() : String {
         return this._consoleId;
      }
      
      public function get text() : String {
         return this._text;
      }
      
      public function get type() : uint {
         return this._type;
      }
   }
}
