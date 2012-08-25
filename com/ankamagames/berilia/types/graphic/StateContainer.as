package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.jerakine.utils.misc.*;

    public class StateContainer extends GraphicContainer implements UIComponent
    {
        protected var _state:Object;
        protected var _snapshot:Array;
        protected var _describeType:Function;
        protected var _lockedProperties:Array;
        protected var _lockedPropertiesStr:String;
        private var _changingStateData:Array;

        public function StateContainer()
        {
            this._describeType = DescribeTypeCache.typeDescription;
            this._state = StatesEnum.STATE_NORMAL;
            this._snapshot = new Array();
            this._lockedProperties = new Array();
            this._lockedPropertiesStr = "";
            this.lockedProperties = "x,y,width,height,selected";
            return;
        }// end function

        public function get changingStateData() : Array
        {
            return this._changingStateData;
        }// end function

        public function set changingStateData(param1:Array) : void
        {
            this._changingStateData = param1;
            return;
        }// end function

        public function set state(param1) : void
        {
            if (this._state == param1)
            {
                return;
            }
            if (param1 == null)
            {
                param1 = StatesEnum.STATE_NORMAL;
            }
            this.changeState(param1);
            this._state = param1;
            return;
        }// end function

        public function get state()
        {
            return this._state;
        }// end function

        override public function free() : void
        {
            super.free();
            this._state = null;
            this._snapshot = null;
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            this._snapshot = null;
            this._state = null;
            return;
        }// end function

        public function get lockedProperties() : String
        {
            return this._lockedPropertiesStr;
        }// end function

        public function set lockedProperties(param1:String) : void
        {
            var _loc_2:Array = null;
            var _loc_3:String = null;
            this._lockedPropertiesStr = param1;
            this._lockedProperties = [];
            if (this._lockedPropertiesStr)
            {
                _loc_2 = param1.split(",");
                for each (_loc_3 in _loc_2)
                {
                    
                    this._lockedProperties[_loc_3] = true;
                }
            }
            return;
        }// end function

        protected function changeState(param1) : void
        {
            var _loc_2:GraphicContainer = null;
            var _loc_3:Array = null;
            var _loc_4:UiRootContainer = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            if (!this._snapshot)
            {
                return;
            }
            if (param1 == StatesEnum.STATE_NORMAL)
            {
                this._state = param1;
                this.restoreSnapshot(StatesEnum.STATE_NORMAL);
            }
            else if (this.changingStateData[param1])
            {
                this._snapshot[this._state] = new Array();
                if (this._state != StatesEnum.STATE_NORMAL)
                {
                    this.restoreSnapshot(StatesEnum.STATE_NORMAL);
                }
                for (_loc_5 in this.changingStateData[param1])
                {
                    
                    _loc_4 = getUi();
                    if (!_loc_4)
                    {
                        break;
                    }
                    _loc_2 = _loc_4.getElement(_loc_5);
                    if (_loc_2)
                    {
                        if (this._state == StatesEnum.STATE_NORMAL)
                        {
                            this.makeSnapshot(StatesEnum.STATE_NORMAL, _loc_2);
                        }
                        _loc_3 = this.changingStateData[param1][_loc_5];
                        for (_loc_6 in _loc_3)
                        {
                            
                            _loc_2[_loc_6] = _loc_3[_loc_6];
                        }
                        this.makeSnapshot(this._state, _loc_2);
                    }
                }
            }
            return;
        }// end function

        protected function makeSnapshot(param1, param2:GraphicContainer) : void
        {
            var _loc_4:String = null;
            var _loc_5:XML = null;
            if (!this._snapshot[param1])
            {
                this._snapshot[param1] = new Object();
            }
            if (!this._snapshot[param1][param2.name])
            {
                this._snapshot[param1][param2.name] = new Object();
            }
            else
            {
                return;
            }
            var _loc_3:* = this._describeType(param2);
            for each (_loc_5 in _loc_3..accessor)
            {
                
                if (_loc_5.@access != "readwrite")
                {
                    continue;
                }
                _loc_4 = _loc_5.@name;
                if (this._lockedProperties[_loc_4])
                {
                    continue;
                }
                switch(true)
                {
                    case param2[_loc_4] is Boolean:
                    case param2[_loc_4] is uint:
                    case param2[_loc_4] is int:
                    case param2[_loc_4] is Number:
                    case param2[_loc_4] is String:
                    case param2[_loc_4] == null:
                    {
                        this._snapshot[param1][param2.name][_loc_4] = param2[_loc_4];
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        protected function restoreSnapshot(param1) : void
        {
            var _loc_2:GraphicContainer = null;
            var _loc_3:UiRootContainer = null;
            var _loc_4:String = null;
            var _loc_5:String = null;
            if (!this._snapshot)
            {
                return;
            }
            for (_loc_4 in this._snapshot[param1])
            {
                
                _loc_3 = getUi();
                if (!_loc_3)
                {
                    break;
                }
                _loc_2 = _loc_3.getElement(_loc_4);
                if (!_loc_2)
                {
                    continue;
                }
                for (_loc_5 in this._snapshot[param1][_loc_4])
                {
                    
                    if (_loc_2[_loc_5] !== this._snapshot[param1][_loc_4][_loc_5])
                    {
                        if (!(_loc_2 is ButtonContainer) || _loc_5 != "selected")
                        {
                            if (this._lockedProperties[_loc_5])
                            {
                                continue;
                            }
                        }
                        _loc_2[_loc_5] = this._snapshot[param1][_loc_4][_loc_5];
                    }
                }
            }
            return;
        }// end function

    }
}
