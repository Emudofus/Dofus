package com.ankamagames.berilia.types.data
{
    import __AS3__.vec.*;

    public class TreeData extends Object
    {
        public var value:Object;
        public var label:String;
        public var expend:Boolean;
        public var children:Vector.<TreeData>;
        public var parent:TreeData;

        public function TreeData(param1, param2:String, param3:Boolean = false, param4:Vector.<TreeData> = null, param5:TreeData = null)
        {
            this.value = param1;
            this.label = param2;
            this.expend = param3;
            this.children = param4;
            this.parent = param5;
            return;
        }// end function

        public function get depth() : uint
        {
            if (this.parent)
            {
                return (this.parent.depth + 1);
            }
            return 0;
        }// end function

        public static function fromArray(param1:Object) : Vector.<TreeData>
        {
            var _loc_2:* = new TreeData(null, null, true);
            _loc_2.children = _fromArray(param1, _loc_2);
            return _loc_2.children;
        }// end function

        private static function _fromArray(param1:Object, param2:TreeData) : Vector.<TreeData>
        {
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_3:* = new Vector.<>;
            for each (_loc_6 in param1)
            {
                
                if (Object(_loc_6).hasOwnProperty("children"))
                {
                    _loc_5 = _loc_6.children;
                }
                else
                {
                    _loc_5 = null;
                }
                _loc_4 = new TreeData(_loc_6, _loc_6.label, Object(_loc_6).hasOwnProperty("expend") ? (Object(_loc_6).expend) : (false));
                _loc_4.parent = param2;
                _loc_4.children = _fromArray(_loc_5, _loc_4);
                _loc_3.push(_loc_4);
            }
            return _loc_3;
        }// end function

    }
}
