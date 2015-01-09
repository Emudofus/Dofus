package ui
{
    import flash.utils.Dictionary;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.SystemApi;
    import d2api.UtilApi;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.Input;
    import d2components.ComboBox;
    import d2components.Grid;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import d2enums.ComponentHookList;
    import d2actions.OpenInventory;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2hooks.*;

    public class AdminSelectItem 
    {

        private static const RESOURCE_ITEM:uint = 0;
        private static const RESOURCE_MONSTER:uint = 1;
        private static const RESOURCE_LOOK:uint = 2;
        private static const RESOURCE_FIREWORKS:uint = 3;
        private static const RESOURCE_SPELL:uint = 4;
        private static var _itemsCached:Array = [];
        private static var _typesCached:Array = [];
        private static var _iconUri:Dictionary = new Dictionary();

        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var sysApi:SystemApi;
        public var utilApi:UtilApi;
        public var btnClose:ButtonContainer;
        public var btnSearch:ButtonContainer;
        public var searchCtr:GraphicContainer;
        public var lblTitle:Label;
        public var searchInput:Input;
        public var cbFilter:ComboBox;
        public var grid:Grid;
        private var _items:Array;
        private var _types:Array;
        private var _searchTimer:Timer;
        private var _nonFilteredDataProvider:Array;
        private var _callback:Function;
        private var _tmp:Object;
        private var _tmpTypes:Array;
        private var _parsedItems:uint;
        private var _title:String;
        private var _resourceType:uint;
        private var _iconBaseUri:String;
        private var _iconType:String = ".png";
        private var _openInventory:Boolean;
        private var _providerFct:Function;

        public function AdminSelectItem()
        {
            this._searchTimer = new Timer(200, 1);
            super();
        }

        public function main(args:Array):void
        {
            this._callback = args[0];
            this.lblTitle.text = args[1];
            this._title = args[1];
            this._openInventory = args[2];
            if (args[1].indexOf("#monster") != -1)
            {
                this._resourceType = RESOURCE_MONSTER;
            }
            else
            {
                if (args[1].indexOf("#item") != -1)
                {
                    this._resourceType = RESOURCE_ITEM;
                }
                else
                {
                    if (args[1].indexOf("#fireworks") != -1)
                    {
                        this._resourceType = RESOURCE_FIREWORKS;
                    }
                    else
                    {
                        if (args[1].indexOf("#look") != -1)
                        {
                            this._resourceType = RESOURCE_LOOK;
                        }
                        else
                        {
                            if (args[1].indexOf("#spell") != -1)
                            {
                                this._resourceType = RESOURCE_SPELL;
                            };
                        };
                    };
                };
            };
            switch (this._resourceType)
            {
                case RESOURCE_ITEM:
                case RESOURCE_FIREWORKS:
                    this._iconBaseUri = this.sysApi.getConfigKey("gfx.path.item.bitmap");
                    this._providerFct = this.dataApi.getItems;
                    break;
                case RESOURCE_SPELL:
                    this._iconBaseUri = this.sysApi.getConfigKey("content.path").concat("gfx/spells/all.swf|sort_");
                    this._providerFct = this.dataApi.getSpells;
                    this._iconType = "";
                    break;
                case RESOURCE_LOOK:
                case RESOURCE_MONSTER:
                    this._iconBaseUri = "pak://ui/Ankama_Admin/resources/monsterIcons.d2p|";
                    this._providerFct = this.dataApi.getMonsters;
                    break;
            };
            if (!(_iconUri[this._resourceType]))
            {
                _iconUri[this._resourceType] = new Dictionary();
            };
            this._items = _itemsCached[this._resourceType];
            this._types = _typesCached[this._resourceType];
            if (!(this._items))
            {
                this._types = (_typesCached[this._resourceType] = new Array());
                this._items = (_itemsCached[this._resourceType] = new Array());
                this._tmp = this._providerFct();
                this._tmpTypes = [];
                this.sysApi.addEventListener(this.parseItems, "parseItems");
                this.parseItems();
            }
            else
            {
                this.init();
            };
        }

        public function updateItemLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                if (!(_iconUri[this._resourceType][data.id]))
                {
                    _iconUri[this._resourceType][data.id] = this.uiApi.createUri(((this._iconBaseUri + data.iconId) + this._iconType));
                };
                componentsRef.itemIcon.uri = _iconUri[this._resourceType][data.id];
                componentsRef.itemName.text = data.name;
            }
            else
            {
                componentsRef.itemIcon.uri = null;
                componentsRef.itemName.text = "";
            };
        }

        private function init():void
        {
            this.cbFilter.dataProvider = this._types;
            this.cbFilter.selectedIndex = 0;
            this.grid.dataProvider = this._items;
            this._nonFilteredDataProvider = this._items;
            this._searchTimer.addEventListener(TimerEvent.TIMER, this.onTick);
            this.uiApi.addComponentHook(this.grid, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cbFilter, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.btnSearch, ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(this.searchInput, ComponentHookList.ON_CHANGE);
            if (this._openInventory)
            {
                this.sysApi.sendAction(new OpenInventory());
            };
        }

        private function parseItems(e:*=null):void
        {
            var o:Object;
            var skip:Boolean;
            var nameTypeField:String;
            var type:Object;
            var item:Object;
            var stepMaxIndex:uint = (this._parsedItems + 200);
            var max:uint = this._tmp.length;
            while ((((this._parsedItems < stepMaxIndex)) && ((this._parsedItems < max))))
            {
                nameTypeField = "name";
                skip = false;
                item = this._tmp[this._parsedItems];
                o = new Object();
                o.id = item.id;
                o.name = ((item.name + " - ") + o.id);
                o.lowerName = String(o.name).toLowerCase();
                o.typeId = item.type.id;
                switch (this._resourceType)
                {
                    case RESOURCE_FIREWORKS:
                        skip = !((o.typeId == 74));
                        o.iconId = item.iconId;
                        o.sortData = item.id;
                        o.returnData = o.id;
                        break;
                    case RESOURCE_ITEM:
                        o.iconId = item.iconId;
                        o.sortData = item.id;
                        o.returnData = o.id;
                        break;
                    case RESOURCE_MONSTER:
                        o.iconId = item.id;
                        o.sortData = o.lowerName;
                        o.returnData = o.id;
                        break;
                    case RESOURCE_LOOK:
                        o.iconId = item.id;
                        o.sortData = o.lowerName;
                        o.returnData = item.look;
                        break;
                    case RESOURCE_SPELL:
                        o.iconId = item.iconId;
                        o.sortData = o.lowerName;
                        o.returnData = item.id;
                        nameTypeField = "longName";
                        break;
                };
                if (skip)
                {
                }
                else
                {
                    this._items.push(o);
                    if (!(this._tmpTypes[o.typeId]))
                    {
                        this._tmpTypes[o.typeId] = item.type;
                    };
                };
                this._parsedItems++;
            };
            this.lblTitle.text = (Math.ceil(((this._parsedItems / max) * 100)) + " %");
            if (max != this._parsedItems)
            {
                return;
            };
            this.lblTitle.text = this._title;
            this.sysApi.removeEventListener(this.parseItems);
            for each (type in this._tmpTypes)
            {
                this._types.push({
                    "typeId":type.id,
                    "label":type[nameTypeField]
                });
            };
            this._types.sortOn("label");
            this._types.unshift({
                "typeId":null,
                "label":"Tous"
            });
            this._items.sortOn("sortData", (((o.sortData is String)) ? 0 : Array.NUMERIC));
            this.sysApi.setData("AdminCachedItemsList", this._items, true);
            this.sysApi.setData("AdminCachedItemTypesList", this._types, true);
            this.init();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnClose:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btnSearch:
                    this.searchCtr.visible = !(this.searchCtr.visible);
                    this.cbFilter.visible = !(this.cbFilter.visible);
                    if (this.searchCtr.visible)
                    {
                        this.searchInput.focus();
                    }
                    else
                    {
                        this.searchInput.blur();
                    };
                    break;
            };
        }

        public function onChange(target:Object):void
        {
            this._searchTimer.reset();
            this._searchTimer.start();
        }

        private function onTick(e:TimerEvent):void
        {
            var tmpDP:Array;
            var item:Object;
            var searchTerm:String = this.searchInput.text.toLowerCase();
            if (searchTerm.length)
            {
                tmpDP = [];
                for each (item in this._nonFilteredDataProvider)
                {
                    if (this.utilApi.noAccent(item.lowerName).indexOf(this.utilApi.noAccent(searchTerm)) != -1)
                    {
                        tmpDP.push(item);
                    };
                };
                this.grid.dataProvider = tmpDP;
            }
            else
            {
                this.grid.dataProvider = this._nonFilteredDataProvider;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var typeId:uint;
            var item:Object;
            switch (target)
            {
                case this.cbFilter:
                    if (target.value.typeId === null)
                    {
                        this.grid.dataProvider = this._items;
                        this._nonFilteredDataProvider = this._items;
                    }
                    else
                    {
                        this._nonFilteredDataProvider = [];
                        typeId = target.value.typeId;
                        for each (item in this._items)
                        {
                            if (item.typeId == typeId)
                            {
                                this._nonFilteredDataProvider.push(item);
                            };
                        };
                        this.grid.dataProvider = this._nonFilteredDataProvider;
                    };
                    break;
                case this.grid:
                    if (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
                    {
                        this._callback(this.grid.selectedItem.returnData, this._title);
                    };
                    break;
            };
        }


    }
}//package ui

