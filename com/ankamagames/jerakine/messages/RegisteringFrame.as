package com.ankamagames.jerakine.messages
{
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.errors.*;
    import flash.utils.*;

    public class RegisteringFrame extends Object implements Frame
    {
        private var _allowsRegistration:Boolean;
        private var _registeredTypes:Dictionary;

        public function RegisteringFrame()
        {
            this.initialize();
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGH;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = this._registeredTypes[param1["constructor"]];
            if (_loc_2 != null)
            {
                return this._loc_2(param1);
            }
            return false;
        }// end function

        protected function registerMessages() : void
        {
            throw new AbstractMethodCallError();
        }// end function

        public function pushed() : Boolean
        {
            throw new AbstractMethodCallError();
        }// end function

        public function pulled() : Boolean
        {
            throw new AbstractMethodCallError();
        }// end function

        protected function register(param1:Class, param2:Function) : void
        {
            if (!this._allowsRegistration || !param1 || this._registeredTypes[param1])
            {
                throw new IllegalOperationError();
            }
            this._registeredTypes[param1] = param2;
            return;
        }// end function

        private function initialize() : void
        {
            this._registeredTypes = new Dictionary();
            this._allowsRegistration = true;
            this.registerMessages();
            this._allowsRegistration = false;
            return;
        }// end function

    }
}
