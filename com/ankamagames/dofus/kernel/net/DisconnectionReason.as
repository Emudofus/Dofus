package com.ankamagames.dofus.kernel.net
{
   public class DisconnectionReason extends Object
   {
      
      public function DisconnectionReason(expected:Boolean, reason:uint) {
         super();
         this._expected = expected;
         this._reason = reason;
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
