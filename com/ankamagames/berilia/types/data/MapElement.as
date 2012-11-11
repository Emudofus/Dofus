package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.memory.*;
    import flash.errors.*;
    import flash.utils.*;

    public class MapElement extends Object implements Secure
    {
        private var _id:String;
        private var _owner:WeakReference;
        public var x:int;
        public var y:int;
        public var layer:String;
        public static var _elementRef:Dictionary = new Dictionary(true);

        public function MapElement(param1:String, param2:int, param3:int, param4:String, param5)
        {
            this.x = param2;
            this.y = param3;
            this.layer = param4;
            if (!_elementRef[param5])
            {
                _elementRef[param5] = new Dictionary();
            }
            this._owner = new WeakReference(param5);
            _elementRef[param5][param1] = this;
            this._id = param1;
            return;
        }// end function

        public function getObject(param1:Object)
        {
            if (param1 != SecureCenter.ACCESS_KEY)
            {
                throw new IllegalOperationError();
            }
            return this;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function remove() : void
        {
            if (this._owner.object && _elementRef[this._owner.object])
            {
                delete _elementRef[this._owner.object][this._id];
            }
            return;
        }// end function

        public static function getElementById(param1:String, param2) : MapElement
        {
            return _elementRef[param2] ? (_elementRef[param2][param1]) : (null);
        }// end function

        public static function removeElementById(param1:String, param2) : void
        {
            if (_elementRef[param2][param1])
            {
                _elementRef[param2][param1].remove();
            }
            delete _elementRef[param2][param1];
            return;
        }// end function

        public static function removeAllElements(param1) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            for (_loc_2 in _elementRef)
            {
                
                if (!param1 || _loc_2 == param1)
                {
                    for each (_loc_3 in _elementRef[_loc_2])
                    {
                        
                        _loc_3.remove();
                    }
                }
            }
            if (!param1)
            {
                _elementRef = new Dictionary(true);
            }
            else
            {
                _elementRef[param1] = new Dictionary(true);
            }
            return;
        }// end function

        public static function getOwnerElements(param1) : Dictionary
        {
            return _elementRef[param1];
        }// end function

    }
}
