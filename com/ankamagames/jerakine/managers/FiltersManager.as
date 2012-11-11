package com.ankamagames.jerakine.managers
{
    import flash.display.*;
    import flash.filters.*;
    import flash.utils.*;

    public class FiltersManager extends Object
    {
        private var dFilters:Dictionary;
        private static var _self:FiltersManager;

        public function FiltersManager(param1:PrivateClass) : void
        {
            this.dFilters = new Dictionary(true);
            return;
        }// end function

        public function addEffect(param1:DisplayObject, param2:BitmapFilter) : void
        {
            var _loc_3:* = this.dFilters[param1] as Array;
            if (_loc_3 == null)
            {
                var _loc_4:* = param1.filters;
                this.dFilters[param1] = param1.filters;
                _loc_3 = _loc_4;
            }
            _loc_3.push(param2);
            param1.filters = _loc_3;
            return;
        }// end function

        public function removeEffect(param1:DisplayObject, param2:BitmapFilter) : void
        {
            var _loc_3:* = this.dFilters[param1] as Array;
            if (_loc_3 == null)
            {
                var _loc_5:* = param1.filters;
                this.dFilters[param1] = param1.filters;
                _loc_3 = _loc_5;
            }
            var _loc_4:* = this.indexOf(_loc_3, param2);
            if (this.indexOf(_loc_3, param2) != -1)
            {
                _loc_3.splice(_loc_4, 1);
                param1.filters = _loc_3;
            }
            return;
        }// end function

        public function indexOf(param1:Array, param2:BitmapFilter) : int
        {
            var _loc_4:* = null;
            var _loc_3:* = param1.length;
            while (_loc_3--)
            {
                
                _loc_4 = param1[_loc_3];
                if (_loc_4 == param2)
                {
                    return _loc_3;
                }
            }
            return -1;
        }// end function

        public static function getInstance() : FiltersManager
        {
            if (_self == null)
            {
                _self = new FiltersManager(new PrivateClass());
            }
            return _self;
        }// end function

    }
}

import flash.display.*;

import flash.filters.*;

import flash.utils.*;

class PrivateClass extends Object
{

    function PrivateClass()
    {
        return;
    }// end function

}

