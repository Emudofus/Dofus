package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ModuleExecErrorMessage extends Object implements Message
   {
      
      public function ModuleExecErrorMessage(moduleName:String, stackTrace:String) {
         super();
         this._moduleName = moduleName;
         this._stackTrace = stackTrace;
      }
      
      private var _moduleName:String;
      
      private var _stackTrace:String;
      
      public function get moduleName() : String {
         return this._moduleName;
      }
      
      public function get stackTrace() : String {
         return this._stackTrace;
      }
   }
}
