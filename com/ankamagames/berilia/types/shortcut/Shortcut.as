package com.ankamagames.berilia.types.shortcut
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.types.DataStoreType;
    import com.ankamagames.jerakine.types.enums.DataStoreEnum;
    import com.ankamagames.berilia.utils.errors.BeriliaError;
    import com.ankamagames.berilia.managers.BindsManager;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.managers.StoreDataManager;

    public class Shortcut implements IDataCenter 
    {

        private static var _shortcuts:Array = new Array();
        private static var _idCount:uint = 0;
        private static var _datastoreType:DataStoreType = new DataStoreType("Module_Ankama_Config", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);

        private var _name:String;
        private var _description:String;
        private var _tooltipContent:String;
        private var _textfieldEnabled:Boolean;
        private var _bindable:Boolean;
        private var _category:ShortcutCategory;
        private var _unicID:uint = 0;
        private var _visible:Boolean;
        private var _disable:Boolean;
        private var _required:Boolean;
        private var _holdKeys:Boolean;
        public var defaultBind:Bind;

        public function Shortcut(name:String, textfieldEnabled:Boolean=false, description:String=null, category:ShortcutCategory=null, bindable:Boolean=true, pVisible:Boolean=true, pRequired:Boolean=false, pHoldKeys:Boolean=false, tooltipContent:String=null)
        {
            if (_shortcuts[name])
            {
                throw (new BeriliaError((("Shortcut name [" + name) + "] is already use")));
            };
            _shortcuts[name] = this;
            this._name = name;
            this._description = description;
            this._textfieldEnabled = textfieldEnabled;
            this._category = category;
            this._unicID = _idCount++;
            this._bindable = bindable;
            this._visible = pVisible;
            this._required = pRequired;
            this._holdKeys = pHoldKeys;
            this._tooltipContent = tooltipContent;
            this._disable = false;
            BindsManager.getInstance().newShortcut(this);
        }

        public static function reset():void
        {
            BindsManager.destroy();
            _shortcuts = [];
            _idCount = 0;
        }

        public static function loadSavedData():void
        {
            var sc:Shortcut;
            var newData:Dictionary;
            var s:Shortcut;
            var copy:Array;
            var lastCat:String;
            var i:uint;
            var len:int;
            var a:Array;
            var copy2:Array;
            var len3:int;
            var catIndex:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var disabled:Boolean;
            var savedData:Object = StoreDataManager.getInstance().getData(_datastoreType, "openShortcutsCategory");
            if (savedData)
            {
                if ((savedData is Array))
                {
                    newData = new Dictionary();
                    copy = new Array();
                    for each (s in _shortcuts)
                    {
                        if (s.visible)
                        {
                            copy.push(s);
                        };
                    };
                    copy.sortOn("unicID", Array.NUMERIC);
                    i = 0;
                    len = copy.length;
                    a = (savedData as Array);
                    copy2 = new Array();
                    i = 0;
                    while (i < len)
                    {
                        s = copy[i];
                        if (s.category.name != lastCat)
                        {
                            catIndex = copy2.indexOf(s.category.name);
                            if (catIndex == -1)
                            {
                                copy2.push(s.category.name);
                                copy2.push(s);
                                lastCat = s.category.name;
                            }
                            else
                            {
                                _local_13 = 0;
                                _local_14 = catIndex;
                                _local_15 = copy2.length;
                                while (++_local_14 < _local_15)
                                {
                                    if (!((copy2[_local_14] is String)))
                                    {
                                        _local_13++;
                                    }
                                    else
                                    {
                                        break;
                                    };
                                };
                                copy2.splice(((catIndex + _local_13) + 1), 0, s);
                            };
                        }
                        else
                        {
                            copy2.push(s);
                        };
                        i++;
                    };
                    len3 = copy2.length;
                    i = 0;
                    while (i < len3)
                    {
                        if ((copy2[i] is String))
                        {
                            if (a[i] != undefined)
                            {
                                newData[copy2[i]] = a[i];
                            }
                            else
                            {
                                newData[copy2[i]] = true;
                            };
                        };
                        i++;
                    };
                    savedData = newData;
                    StoreDataManager.getInstance().setData(_datastoreType, "openShortcutsCategory", savedData);
                };
                for each (sc in _shortcuts)
                {
                    if (sc.visible)
                    {
                        if (savedData[sc.category.name] != undefined)
                        {
                            disabled = !(savedData[sc.category.name]);
                        }
                        else
                        {
                            savedData[sc.category.name] = true;
                            disabled = false;
                        };
                        sc.disable = disabled;
                    };
                };
            };
        }

        public static function getShortcutByName(name:String):Shortcut
        {
            return (_shortcuts[name]);
        }

        public static function getShortcuts():Array
        {
            return (_shortcuts);
        }


        public function get unicID():uint
        {
            return (this._unicID);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get description():String
        {
            return (this._description);
        }

        public function get tooltipContent():String
        {
            return (this._tooltipContent);
        }

        public function get textfieldEnabled():Boolean
        {
            return (this._textfieldEnabled);
        }

        public function get bindable():Boolean
        {
            return (this._bindable);
        }

        public function get category():ShortcutCategory
        {
            return (this._category);
        }

        public function get visible():Boolean
        {
            return (this._visible);
        }

        public function set visible(value:Boolean):void
        {
            this._visible = value;
        }

        public function get required():Boolean
        {
            return (this._required);
        }

        public function get holdKeys():Boolean
        {
            return (this._holdKeys);
        }

        public function get disable():Boolean
        {
            return (this._disable);
        }

        public function set disable(value:Boolean):void
        {
            this._disable = value;
        }


    }
}//package com.ankamagames.berilia.types.shortcut

