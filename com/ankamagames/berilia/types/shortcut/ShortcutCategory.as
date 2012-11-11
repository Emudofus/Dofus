package com.ankamagames.berilia.types.shortcut
{

    public class ShortcutCategory extends Object
    {
        private var _name:String;
        private var _description:String;
        private static var _caterogies:Array = new Array();

        public function ShortcutCategory(param1:String, param2:String)
        {
            _caterogies[param1] = this;
            this._name = param1;
            this._description = param2;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get description() : String
        {
            return this._description;
        }// end function

        public function toString() : String
        {
            return this._name;
        }// end function

        public static function create(param1:String, param2:String) : ShortcutCategory
        {
            var _loc_3:* = _caterogies[param1];
            if (!_loc_3)
            {
                _loc_3 = new ShortcutCategory(param1, param2);
            }
            else if (!_caterogies[param1].description)
            {
                _caterogies[param1]._description = param2;
            }
            return _loc_3;
        }// end function

    }
}
