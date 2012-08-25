package com.ankamagames.berilia.factories
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import flash.utils.*;

    public class MenusFactory extends Object
    {
        private static var _registeredMaker:Array = new Array();
        private static var _makerAssoc:Array = new Array();

        public function MenusFactory()
        {
            return;
        }// end function

        public static function registerMaker(param1:String, param2:Class, param3:Class = null) : void
        {
            _registeredMaker[param1] = new MenuData(param2, param3);
            return;
        }// end function

        public static function registerAssoc(param1, param2:String) : void
        {
            _makerAssoc[getQualifiedClassName(param1)] = param2;
            return;
        }// end function

        public static function unregister(param1:Class, param2:Class) : void
        {
            if (MenuData(_registeredMaker[getQualifiedClassName(param1)]).maker === param2)
            {
                delete _registeredMaker[getQualifiedClassName(param1)];
            }
            return;
        }// end function

        public static function create(param1, param2:String = null, param3:Object = null) : ContextMenuData
        {
            var _loc_4:MenuData = null;
            var _loc_5:* = undefined;
            var _loc_6:Array = null;
            if (!param2)
            {
                param2 = _makerAssoc[getQualifiedClassName(param1)];
            }
            if (param2)
            {
                _loc_4 = _registeredMaker[param2];
            }
            if (_loc_4)
            {
                _loc_5 = new _loc_4.maker;
                _loc_6 = _loc_5.createMenu(SecureCenter.secure(param1), SecureCenter.secure(param3));
                return new ContextMenuData(param1, param2, _loc_6);
            }
            if (param3 is Array)
            {
                return new ContextMenuData(param1, param2, param3 as Array);
            }
            return null;
        }// end function

        public static function getMenuMaker(param1:String) : Object
        {
            return _registeredMaker[param1];
        }// end function

        public static function existMakerAssoc(param1) : Boolean
        {
            return _makerAssoc[getQualifiedClassName(param1)] ? (true) : (false);
        }// end function

    }
}

class MenuData extends Object
{
    public var maker:Class;
    public var scriptClass:Class;

    function MenuData(param1:Class, param2:Class)
    {
        this.maker = param1;
        this.scriptClass = param2;
        return;
    }// end function

}

