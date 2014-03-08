package com.ankamagames.dofus.kernel.net
{
   public class DisconnectionReason extends Object
   {
      
      public function DisconnectionReason(param1:Boolean, param2:uint) {
         super();
         this._expected = param1;
         this._reason = param2;
      }
      
      private var _expected:Boolean;
      
      private var _reason:uint;
      
      public function get expected() : Boolean {
         return this._expected;
      }
      
      public function get reason() : uint {
         return this._reason;
      }
   }
}
