package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ThemeLoadedMessage extends Object implements Message
   {
      
      public function ThemeLoadedMessage(themeName:String) {
         super();
         this._themeName = themeName;
      }
      
      private var _themeName:String;
      
      public function get themeName() : String {
         return this._themeName;
      }
   }
}
