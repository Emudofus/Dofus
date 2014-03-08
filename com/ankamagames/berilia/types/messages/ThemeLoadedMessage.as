package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ThemeLoadedMessage extends Object implements Message
   {
      
      public function ThemeLoadedMessage(param1:String) {
         super();
         this._themeName = param1;
      }
      
      private var _themeName:String;
      
      public function get themeName() : String {
         return this._themeName;
      }
   }
}
