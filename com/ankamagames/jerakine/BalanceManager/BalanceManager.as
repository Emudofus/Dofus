package com.ankamagames.jerakine.BalanceManager
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.BalanceManager.events.*;
    import com.ankamagames.jerakine.BalanceManager.type.*;

    public class BalanceManager extends Object
    {
        private var _balancedObjects:Vector.<BalancedObject>;
        private var _nbCall:uint = 0;

        public function BalanceManager(param1:Array = null)
        {
            var _loc_2:Object = null;
            this.init();
            if (param1 != null)
            {
                for each (_loc_2 in param1)
                {
                    
                    this.addItem(_loc_2);
                }
            }
            return;
        }// end function

        public function get nbCall() : uint
        {
            return this._nbCall;
        }// end function

        public function getItemNbCall(param1:Object) : int
        {
            var _loc_2:BalancedObject = null;
            for each (_loc_2 in this._balancedObjects)
            {
                
                if (param1 == _loc_2.item)
                {
                    return _loc_2.nbCall;
                }
            }
            return -1;
        }// end function

        public function setItemBalance(param1:Object, param2:uint) : void
        {
            var _loc_3:BalancedObject = null;
            for each (_loc_3 in this._balancedObjects)
            {
                
                if (param1 == _loc_3.item)
                {
                    _loc_3.nbCall = param2;
                    return;
                }
            }
            return;
        }// end function

        public function addItem(param1:Object, param2:Boolean = false) : void
        {
            this._balancedObjects.push(new BalancedObject(param1));
            if (param2)
            {
                this._nbCall = 0;
                this.resetBalance();
            }
            this.balanceItems();
            return;
        }// end function

        public function addItemWithBalance(param1:Object, param2:uint) : void
        {
            var _loc_3:* = new BalancedObject(param1);
            _loc_3.nbCall = param2;
            this._balancedObjects.push(_loc_3);
            this._nbCall = this._nbCall + param2;
            this.balanceItems();
            return;
        }// end function

        public function callItem() : Object
        {
            var _loc_4:BalancedObject = null;
            var _loc_1:* = Math.random() * 10000;
            var _loc_2:uint = 0;
            var _loc_3:Object = null;
            if (this._balancedObjects.length == 0)
            {
                return _loc_3;
            }
            _loc_4 = this._balancedObjects[0] as BalancedObject;
            if (_loc_1 < _loc_4.chanceToBeCall * 100)
            {
                _loc_4.increment();
                _loc_3 = _loc_4.item;
            }
            _loc_2 = _loc_2 + 1;
            var _loc_5:* = _loc_4.chanceToBeCall * 100;
            while (_loc_2 < this._balancedObjects.length)
            {
                
                _loc_4 = this._balancedObjects[_loc_2] as BalancedObject;
                if (_loc_3 != null)
                {
                }
                else
                {
                    if (this._balancedObjects.length == (_loc_2 + 1))
                    {
                        _loc_4.increment();
                        _loc_3 = _loc_4.item;
                        ;
                    }
                    else if (_loc_1 > _loc_5 && _loc_1 < _loc_5 + _loc_4.chanceToBeCall * 100)
                    {
                        _loc_4.increment();
                        _loc_3 = _loc_4.item;
                    }
                    _loc_5 = _loc_5 + _loc_4.chanceToBeCall * 100;
                }
                _loc_2 = _loc_2 + 1;
            }
            var _loc_6:String = this;
            var _loc_7:* = this._nbCall + 1;
            _loc_6._nbCall = _loc_7;
            this.balanceItems();
            return _loc_3;
        }// end function

        public function removeItem(param1:Object) : void
        {
            var _loc_2:BalancedObject = null;
            for each (_loc_2 in this._balancedObjects)
            {
                
                if (_loc_2.item == param1)
                {
                    this._balancedObjects.splice(this._balancedObjects.indexOf(_loc_2), 1);
                    continue;
                }
            }
            this.balanceItems();
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:BalancedObject = null;
            for each (_loc_1 in this._balancedObjects)
            {
                
                this.setItemBalance(_loc_1.item, 0);
            }
            this.balanceItems();
            return;
        }// end function

        private function balanceItems() : void
        {
            var _loc_1:BalancedObject = null;
            var _loc_2:BalancedObject = null;
            var _loc_3:Number = NaN;
            var _loc_4:BalancedObject = null;
            var _loc_5:BalancedObject = null;
            if (this._nbCall == 0)
            {
                for each (_loc_1 in this._balancedObjects)
                {
                    
                    _loc_1.chanceToBeCall = 1 / this._balancedObjects.length * 100;
                }
            }
            else
            {
                for each (_loc_2 in this._balancedObjects)
                {
                    
                    _loc_2.chanceToBeNonCall = (_loc_2.nbCall + 1) / (this._nbCall + this._balancedObjects.length) * 100;
                }
                _loc_3 = 0;
                for each (_loc_4 in this._balancedObjects)
                {
                    
                    _loc_3 = _loc_3 + 1 / _loc_4.chanceToBeNonCall;
                }
                for each (_loc_5 in this._balancedObjects)
                {
                    
                    _loc_5.chanceToBeCall = 1 / _loc_5.chanceToBeNonCall / _loc_3 * 100;
                }
            }
            return;
        }// end function

        private function init() : void
        {
            this._balancedObjects = new Vector.<BalancedObject>;
            return;
        }// end function

        private function resetBalance() : void
        {
            var _loc_1:BalancedObject = null;
            for each (_loc_1 in this._balancedObjects)
            {
                
                _loc_1.nbCall = 0;
            }
            return;
        }// end function

        private function onBalanceUpdate(event:BalanceEvent) : void
        {
            this._nbCall = this._nbCall + (event.newBalance - event.previousBalance);
            return;
        }// end function

    }
}
