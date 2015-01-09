package com.ankamagames.berilia.types.data
{
    import com.ankamagames.berilia.utils.errors.BeriliaError;

    public class Hook 
    {

        private static var _hookNameList:Array;

        private var _trusted:Boolean;
        private var _name:String;
        private var _nativeHook:Boolean;

        public function Hook(name:String, trusted:Boolean, nativeHook:Boolean=true)
        {
            if (!(_hookNameList))
            {
                _hookNameList = new Array();
            };
            _hookNameList[name] = this;
            this._name = name;
            this._trusted = trusted;
        }

        public static function create(name:String, trusted:Boolean, nativeHook:Boolean=true):Hook
        {
            var h:Hook = _hookNameList[name];
            if (h)
            {
                if (trusted)
                {
                    throw (new BeriliaError((("Hook name (" + name) + ") aleardy used, please rename it.")));
                };
                return (h);
            };
            return (new (Hook)(name, trusted, nativeHook));
        }

        public static function getHookByName(name:String):Hook
        {
            return (_hookNameList[name]);
        }


        public function get trusted():Boolean
        {
            return (this._trusted);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get nativeHook():Boolean
        {
            return (this._nativeHook);
        }


    }
}//package com.ankamagames.berilia.types.data

