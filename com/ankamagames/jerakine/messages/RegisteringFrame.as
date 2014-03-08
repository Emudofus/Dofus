package com.ankamagames.jerakine.messages
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import flash.errors.IllegalOperationError;
   
   public class RegisteringFrame extends Object implements Frame
   {
      
      public function RegisteringFrame() {
         super();
         this.initialize();
      }
      
      private var _allowsRegistration:Boolean;
      
      private var _registeredTypes:Dictionary;
      
      protected var _priority:int = 1;
      
      public function get priority() : int {
         return this._priority;
      }
      
      public function process(msg:Message) : Boolean {
         var handler:Function = this._registeredTypes[msg["constructor"]];
         if(handler != null)
         {
            return handler(msg);
         }
         return false;
      }
      
      protected function registerMessages() : void {
         throw new AbstractMethodCallError();
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      protected function register(type:Class, handler:Function) : void {
         if((!this._allowsRegistration) || (!type) || (this._registeredTypes[type]))
         {
            throw new IllegalOperationError();
         }
         else
         {
            this._registeredTypes[type] = handler;
            return;
         }
      }
      
      private function initialize() : void {
         this._registeredTypes = new Dictionary();
         this._allowsRegistration = true;
         this.registerMessages();
         this._allowsRegistration = false;
      }
   }
}
