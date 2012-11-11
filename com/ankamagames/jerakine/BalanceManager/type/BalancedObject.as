package com.ankamagames.jerakine.BalanceManager.type
{
    import com.ankamagames.jerakine.BalanceManager.events.*;
    import flash.events.*;

    public class BalancedObject extends EventDispatcher
    {
        public var item:Object;
        private var _nbCall:uint;
        public var chanceToBeNonCall:Number;
        public var chanceToBeCall:Number;

        public function BalancedObject(param1:Object)
        {
            this.item = param1;
            this.nbCall = 0;
            return;
        }// end function

        public function increment() : uint
        {
            this.nbCall = this._nbCall + 1;
            return this._nbCall;
        }// end function

        public function set nbCall(param1:uint) : void
        {
            var _loc_2:* = this._nbCall;
            this._nbCall = param1;
            var _loc_3:* = new BalanceEvent(BalanceEvent.BALANCE_UPDATE);
            _loc_3.previousBalance = _loc_2;
            _loc_3.newBalance = this._nbCall;
            _loc_3.item = this.item;
            dispatchEvent(_loc_3);
            return;
        }// end function

        public function get nbCall() : uint
        {
            return this._nbCall;
        }// end function

    }
}
