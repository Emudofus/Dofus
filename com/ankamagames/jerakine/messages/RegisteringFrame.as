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
      
      public function process(param1:Message) : Boolean {
         var _loc2_:Function = this._registeredTypes[param1["constructor"]];
         if(_loc2_ != null)
         {
            return _loc2_(param1);
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
      
      protected function register(param1:Class, param2:Function) : void {
         if(!this._allowsRegistration || !param1 || (this._registeredTypes[param1]))
         {
            throw new IllegalOperationError();
         }
         else
         {
            this._registeredTypes[param1] = param2;
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
