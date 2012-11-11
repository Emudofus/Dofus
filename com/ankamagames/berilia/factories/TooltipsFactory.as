package com.ankamagames.berilia.factories
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.tooltip.*;
    import flash.utils.*;

    public class TooltipsFactory extends Object
    {
        private static var _registeredMaker:Array = new Array();
        private static var _makerAssoc:Array = new Array();

        public function TooltipsFactory()
        {
            return;
        }// end function

        public static function registerMaker(param1:String, param2:Class, param3:Class = null) : void
        {
            _registeredMaker[param1] = new TooltipData(param2, param3);
            return;
        }// end function

        public static function registerAssoc(param1, param2:String) : void
        {
            _makerAssoc[getQualifiedClassName(param1)] = param2;
            return;
        }// end function

        public static function existRegisterMaker(param1:String) : Boolean
        {
            return _registeredMaker[param1] ? (true) : (false);
        }// end function

        public static function existMakerAssoc(param1) : Boolean
        {
            return _makerAssoc[getQualifiedClassName(param1)] ? (true) : (false);
        }// end function

        public static function unregister(param1:Class, param2:Class) : void
        {
            if (TooltipData(_registeredMaker[getQualifiedClassName(param1)]).maker === param2)
            {
                delete _registeredMaker[getQualifiedClassName(param1)];
            }
            return;
        }// end function

        public static function create(param1, param2:String = null, param3:Class = null, param4:Object = null) : Tooltip
        {
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!param2)
            {
                param2 = _makerAssoc[getQualifiedClassName(param1)];
            }
            var _loc_5:* = _registeredMaker[param2];
            if (_registeredMaker[param2])
            {
                _loc_6 = new _loc_5.maker;
                _loc_8 = _loc_6.createTooltip(SecureCenter.secure(param1), param4);
                if (_loc_8 == "")
                {
                    _loc_7 = new EmptyTooltip();
                    return _loc_7;
                }
                _loc_7 = _loc_8 as Tooltip;
                if (_loc_7 == null)
                {
                    return null;
                }
                if (TooltipManager.defaultTooltipUiScript == param3)
                {
                    _loc_7.scriptClass = _loc_5.scriptClass ? (_loc_5.scriptClass) : (param3);
                }
                else
                {
                    _loc_7.scriptClass = param3;
                }
                _loc_7.makerName = param2;
                return _loc_7;
            }
            return null;
        }// end function

    }
}

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.tooltip.*;

import flash.utils.*;

class TooltipData extends Object
{
    public var maker:Class;
    public var scriptClass:Class;

    function TooltipData(param1:Class, param2:Class)
    {
        this.maker = param1;
        this.scriptClass = param2;
        return;
    }// end function

}

