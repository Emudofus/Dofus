package com.ankamagames.dofus.kernel.net
{

    public class DisconnectionReason extends Object
    {
        private var _expected:Boolean;
        private var _reason:uint;

        public function DisconnectionReason(param1:Boolean, param2:uint)
        {
            this._expected = param1;
            this._reason = param2;
            return;
        }// end function

        public function get expected() : Boolean
        {
            return this._expected;
        }// end function

        public function get reason() : uint
        {
            return this._reason;
        }// end function

    }
}
