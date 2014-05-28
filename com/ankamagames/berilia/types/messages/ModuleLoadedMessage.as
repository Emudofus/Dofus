package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ModuleLoadedMessage extends Object implements Message
   {
      
      public function ModuleLoadedMessage(moduleName:String) {
         super();
         this._moduleName = moduleName;
      }
      
      private var _moduleName:String;
      
      public function get moduleName() : String {
         return this._moduleName;
      }
   }
}
