package ui
{
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.SystemApi;
    import d2api.UtilApi;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.InputComboBox;
    import d2components.Grid;
    import d2components.Texture;
    import d2components.ComboBox;
    import d2components.Input;
    import flash.utils.Dictionary;
    import d2enums.ComponentHookList;
    import d2hooks.ModuleList;
    import d2hooks.ModuleInstallationProgress;
    import d2hooks.ModuleInstallationError;
    import d2hooks.ApisHooksActionsList;
    import d2hooks.KeyUp;
    import d2actions.ModuleListRequest;
    import d2actions.ModuleInstallRequest;
    import d2actions.ModuleDeleteRequest;
    import __AS3__.vec.Vector;
    import d2enums.StrataEnum;
    import d2actions.ResetGame;
    import d2hooks.*;
    import d2actions.*;
    import __AS3__.vec.*;

    public class ModuleMarketplace 
    {

        private static const ERROR_JSON_URL_INVALID:int = 1;
        private static const ERROR_JSON_NOT_FOUND:int = 2;
        private static const ERROR_MODULE_ARCHIVE_INVALID:int = 3;
        private static const ERROR_MODULE_UPATE:int = 4;
        private static const ERROR_MODULE_DELETE:int = 5;
        private static const ERROR_MODULE_INSTALL:int = 6;
        private static const ERROR_MODULE_DM_NOT_FOUND:int = 7;
        private static const ERROR_MODULE_URL_INVALID:int = 8;
        private static const URL_REGEX:RegExp = /^http(s)?:\/\/((\d+\.\d+\.\d+\.\d+)|(([\w-]+\.)+([a-z,A-Z][\w-]*)))(:[1-9][0-9]*)?(\/([\w-.\/:%+@&=]+[\w- .\/?:%+@&=]*)?)?(#(.*))?$/i;
        private static const WHITESPACE_TRIM_REGEX:RegExp = /^\s*(.*?)\s*$/g;

        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var sysApi:SystemApi;
        public var utilApi:UtilApi;
        public var mainCtr:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var lbl_title:Label;
        public var icb_url:InputComboBox;
        public var gdModules:Grid;
        public var tx_bg:Texture;
        public var tx_bg1:Texture;
        public var tx_inputUrl:Texture;
        public var btn_fetch:ButtonContainer;
        public var cbx_categories:ComboBox;
        public var searchCtr:GraphicContainer;
        public var tx_search:Texture;
        public var input_search:Input;
        public var lbl_infos:Label;
        public var lbl_moduleName:Label;
        public var lbl_moduleAuthor:Label;
        public var lbl_moduleVersion:Label;
        public var lbl_moduleDofusVersion:Label;
        public var lbl_moduleCategory:Label;
        public var lbl_moduleDescription:Label;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _componentsList:Dictionary;
        private var _currentUrl:String;
        private var _activePopupName:String;
        private var _lastSelection:int;
        private var _activateModuleAfterInstall:Boolean;
        private var _isUpdating:Boolean;
        private var _moduleList:Array;
        private var _filteredModuleList:Array;
        private var _categories:Array;
        private var _lastSearchCriteria:String;

        public function ModuleMarketplace()
        {
            this._componentsList = new Dictionary(true);
            super();
        }

        public function main(params:Object):void
        {
            this.uiApi.addComponentHook(this.btn_fetch, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_fetch, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.icb_url, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(this.cbx_categories, ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.sysApi.addHook(ModuleList, this.onModuleList);
            this.sysApi.addHook(ModuleInstallationProgress, this.onModuleInstallationProgress);
            this.sysApi.addHook(ModuleInstallationError, this.onModuleInstallationError);
            this.sysApi.addHook(ApisHooksActionsList, this.onApisHooksActionsList);
            this.sysApi.addHook(KeyUp, this.onKeyUp);
            var lastUrls:* = this.sysApi.getData("LastModuleDepotUrls", true);
            if (((lastUrls) && ((lastUrls.length > 0))))
            {
                this.icb_url.input.text = lastUrls[0];
                this.icb_url.dataProvider = lastUrls;
                this.btn_fetch.focus();
            };
        }

        public function unload():void
        {
            this._moduleList = null;
            this._categories = null;
            var subConfigUi:Object = this.uiApi.getUi("subConfigUi");
            if (((subConfigUi) && (subConfigUi.uiClass)))
            {
                subConfigUi.uiClass.update();
            };
        }

        public function update():void
        {
            this._lastSelection = this.gdModules.selectedIndex;
            this.sysApi.sendAction(new ModuleListRequest(this._currentUrl));
        }

        public function showModuleDetails(data:Object):void
        {
            this._lastSelection = this.gdModules.selectedIndex;
            if (data)
            {
                this.lbl_moduleName.text = data.name;
                this.lbl_moduleAuthor.text = data.author;
                this.lbl_moduleVersion.text = ((this.uiApi.getText("ui.common.version") + this.uiApi.getText("ui.common.colon")) + data.version);
                this.lbl_moduleDofusVersion.text = this.uiApi.getText("ui.module.marketplace.dofusversion", data.dofusVersion);
                if (((data.category) && (!((data.category.indexOf(",") == -1)))))
                {
                    this.lbl_moduleCategory.text = ((this.uiApi.getText("ui.common.categories") + this.uiApi.getText("ui.common.colon")) + data.category);
                }
                else
                {
                    this.lbl_moduleCategory.text = ((this.uiApi.getText("ui.common.category") + this.uiApi.getText("ui.common.colon")) + data.category);
                };
                this.lbl_moduleDescription.text = (((this.uiApi.getText("ui.common.description") + this.uiApi.getText("ui.common.colon")) + "\n") + data.description);
            }
            else
            {
                this.lbl_moduleName.text = "";
                this.lbl_moduleAuthor.text = "";
                this.lbl_moduleVersion.text = "";
                this.lbl_moduleDofusVersion.text = "";
                this.lbl_moduleCategory.text = "";
                this.lbl_moduleDescription.text = "";
            };
        }

        public function startInstall(data:Object, update:Boolean=false):void
        {
            this._isUpdating = update;
            if (this._isUpdating)
            {
                this._activePopupName = this.modCommon.openNoButtonPopup(this.uiApi.getText("ui.module.marketplace.updatemodule"), ((this.uiApi.getText("ui.module.marketplace.updatemodulemsg", data.name, data.version) + "\n") + this.uiApi.getText("ui.queue.wait")));
            }
            else
            {
                this._activePopupName = this.modCommon.openNoButtonPopup(this.uiApi.getText("ui.module.marketplace.installmodule"), ((this.uiApi.getText("ui.module.marketplace.installmodulemsg", data.name) + "\n") + this.uiApi.getText("ui.queue.wait")));
            };
            this.sysApi.sendAction(new ModuleInstallRequest(data.url));
        }

        public function startUninstall(data:Object):void
        {
            this._activePopupName = this.modCommon.openNoButtonPopup(this.uiApi.getText("ui.module.marketplace.uninstallmodule"), ((this.uiApi.getText("ui.module.marketplace.uninstallmodulemsg", data.name) + "\n") + this.uiApi.getText("ui.queue.wait")));
            this.uiApi.setModuleEnable(data.id, false);
            this.sysApi.sendAction(new ModuleDeleteRequest(data.id));
            this._lastSelection = this.gdModules.selectedIndex;
        }

        public function onRelease(target:Object):void
        {
            var _local_2:String;
            var urlToDelete:String;
            var oldUrls:*;
            var urls:Vector.<String>;
            var oldUrl:String;
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_fetch:
                    _local_2 = this.icb_url.input.text;
                    if (URL_REGEX.test(_local_2))
                    {
                        this.sysApi.sendAction(new ModuleListRequest(_local_2));
                    }
                    else
                    {
                        this.onModuleInstallationError(ERROR_JSON_URL_INVALID);
                    };
                    break;
                default:
                    if (target.name.indexOf("btn_removeUrl") != -1)
                    {
                        urlToDelete = this._componentsList[target.name];
                        oldUrls = this.sysApi.getData("LastModuleDepotUrls", true);
                        urls = new Vector.<String>();
                        for each (oldUrl in oldUrls)
                        {
                            if (oldUrl != urlToDelete)
                            {
                                urls.push(oldUrl);
                            };
                        };
                        this.sysApi.setData("LastModuleDepotUrls", urls, true);
                        this.icb_url.dataProvider = urls;
                        this.icb_url.selectedIndex = 0;
                    };
            };
        }

        public function updateUrlLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._componentsList[componentsRef.btn_removeUrl.name]))
            {
                this.uiApi.addComponentHook(componentsRef.btn_removeUrl, "onRelease");
                this.uiApi.addComponentHook(componentsRef.btn_removeUrl, "onRollOut");
                this.uiApi.addComponentHook(componentsRef.btn_removeUrl, "onRollOver");
            };
            this._componentsList[componentsRef.btn_removeUrl.name] = data;
            if (data)
            {
                componentsRef.lbl_url.text = data;
                componentsRef.btn_removeUrl.visible = true;
                componentsRef.btn_url.selected = selected;
            }
            else
            {
                componentsRef.lbl_url.text = "";
                componentsRef.btn_removeUrl.visible = false;
                componentsRef.btn_url.selected = false;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var selectedCategory:String;
            var categories:String;
            var module:Object;
            if (((isNewSelection) && ((target == this.cbx_categories))))
            {
                if (target.selectedIndex > 0)
                {
                    this._filteredModuleList = new Array();
                    selectedCategory = target.selectedItem;
                    for each (module in this._moduleList)
                    {
                        if (module["category"])
                        {
                            categories = module.category;
                        }
                        else
                        {
                            if (module["categories"])
                            {
                                categories = module.categories;
                            };
                        };
                        if (categories.indexOf(selectedCategory) != -1)
                        {
                            this._filteredModuleList.push(module);
                        };
                    };
                    this.gdModules.dataProvider = this._filteredModuleList;
                }
                else
                {
                    this.gdModules.dataProvider = this._moduleList;
                    this._filteredModuleList = null;
                };
                this.showModuleDetails(null);
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            switch (target)
            {
                case this.btn_fetch:
                    tooltipText = this.uiApi.getText("ui.module.marketplace.fetch");
                    break;
                default:
                    if (target.name.indexOf("btn_removeUrl") != -1)
                    {
                        tooltipText = this.uiApi.getText("ui.module.marketplace.tooltip.uninstall");
                        this.icb_url.closeOnClick = false;
                    };
            };
            if (((tooltipText) && ((tooltipText.length > 1))))
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", 6, 1, 0, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
            if (target.name.indexOf("btn_removeUrl") != -1)
            {
                this.icb_url.closeOnClick = true;
            };
        }

        public function onKeyUp(target:Object, keyCode:uint):void
        {
            if (((this.searchCtr.visible) && (this.input_search.haveFocus)))
            {
                this.filterModules(this.input_search.text.toLowerCase());
            };
        }

        public function onModuleList(modules:*):void
        {
            this.updateModuleList(modules);
            this._currentUrl = this.icb_url.input.text;
            if (this.icb_url.dataProvider.indexOf(this._currentUrl) == -1)
            {
                this.icb_url.dataProvider.push(this._currentUrl);
            };
            this.sysApi.setData("LastModuleDepotUrls", this.icb_url.dataProvider, true);
        }

        public function onModuleInstallationProgress(percent:Number):void
        {
            if ((((percent == 1)) || ((percent == -1))))
            {
                this.uiApi.unloadUi(this._activePopupName);
                if ((((percent == 1)) && (this._activateModuleAfterInstall)))
                {
                    this.uiApi.setModuleEnable(this.gdModules.selectedItem.id, true);
                    if (this.sysApi.isInGame())
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.module.marketplace.reboot"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onRestartOk]);
                    };
                };
                this.sysApi.sendAction(new ModuleListRequest(this._currentUrl));
            };
        }

        public function onModuleInstallationError(errorId:int):void
        {
            var errorMsg:String;
            var errorTitle:String = this.uiApi.getText("ui.common.error");
            switch (errorId)
            {
                case ERROR_JSON_URL_INVALID:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error.invalidurl");
                    this.updateModuleList([]);
                    break;
                case ERROR_JSON_NOT_FOUND:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error.missingjson");
                    this.updateModuleList([]);
                    break;
                case ERROR_MODULE_ARCHIVE_INVALID:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error.invalidzip");
                    this.uiApi.unloadUi(this._activePopupName);
                    break;
                case ERROR_MODULE_UPATE:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error.update");
                    this.uiApi.unloadUi(this._activePopupName);
                    break;
                case ERROR_MODULE_DELETE:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error.uninstall");
                    this.uiApi.unloadUi(this._activePopupName);
                    break;
                case ERROR_MODULE_INSTALL:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error.install");
                    this.uiApi.unloadUi(this._activePopupName);
                    break;
                case ERROR_MODULE_URL_INVALID:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error.invalidurl2");
                    this.uiApi.unloadUi(this._activePopupName);
                    break;
                default:
                    errorMsg = this.uiApi.getText("ui.module.marketplace.error");
            };
            this.modCommon.openPopup(errorTitle, errorMsg, [this.uiApi.getText("ui.common.ok")]);
        }

        public function onApisHooksActionsList(moduleDetails:Object):void
        {
            this.uiApi.loadUi("moduleInfo", null, {
                "module":this.gdModules.selectedItem,
                "details":moduleDetails,
                "visibleBtns":true,
                "activationCallback":this.activationCallbackFunction,
                "isUpdate":this._isUpdating
            }, StrataEnum.STRATA_TOP);
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "optionMenu1":
                case "closeUi":
                    if (!(this.uiApi.getUi(this._activePopupName)))
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    };
                    break;
            };
            return (true);
        }

        private function updateModuleList(dp:*):void
        {
            var securedObject:Object;
            var module:Object;
            var key:String;
            var categories:Array;
            var cat:String;
            this.lbl_moduleName.text = "";
            this.lbl_moduleAuthor.text = "";
            this._categories = new Array();
            this._moduleList = new Array();
            for each (securedObject in dp)
            {
                module = new Object();
                this._moduleList.push(module);
                for (key in securedObject)
                {
                    module[key] = securedObject[key];
                };
                module.id = ((module.author + "_") + module.name);
                if (((module["category"]) || (module["categories"])))
                {
                    categories = module.category.split(",");
                    for each (cat in categories)
                    {
                        cat = cat.replace(WHITESPACE_TRIM_REGEX, "$1");
                        if (this._categories.indexOf(cat) == -1)
                        {
                            this._categories.push(cat);
                        };
                    };
                };
            };
            if (this._moduleList.length == 0)
            {
                this.showModuleDetails(null);
                this.gdModules.visible = false;
                this.lbl_infos.visible = true;
                this.lbl_infos.text = this.uiApi.getText("ui.module.marketplace.nomodule");
                return;
            };
            this.lbl_infos.visible = false;
            this.gdModules.visible = true;
            this._moduleList.sortOn(["upToDate", "exist", "name"]);
            this.gdModules.dataProvider = this._moduleList;
            this.gdModules.selectedIndex = this._lastSelection;
            this.showModuleDetails(this.gdModules.selectedItem);
            this._categories.sort();
            this._categories.unshift(this.uiApi.getText("ui.common.allTypesForObject"));
            this.cbx_categories.dataProvider = this._categories;
            this.cbx_categories.selectedIndex = 0;
            this.cbx_categories.visible = (this.searchCtr.visible = (this._moduleList.length > 0));
            this.input_search.text = "";
        }

        private function activationCallbackFunction():void
        {
            this._activateModuleAfterInstall = true;
        }

        private function onRestartOk():void
        {
            this.sysApi.sendAction(new ResetGame());
        }

        private function filterModules(searchCriteria:String):void
        {
            var reusingDataProvider:Boolean;
            var moduleList:Object;
            var filteredModuleList:Array;
            var module:Object;
            if (searchCriteria)
            {
                reusingDataProvider = ((((this._lastSearchCriteria) && ((this._lastSearchCriteria.length < searchCriteria.length)))) && (!((searchCriteria.indexOf(this._lastSearchCriteria) == -1))));
                moduleList = ((reusingDataProvider) ? this.gdModules.dataProvider : ((this._filteredModuleList) ? this._filteredModuleList : this._moduleList));
                filteredModuleList = new Array();
                for each (module in moduleList)
                {
                    if (module.name.toLowerCase().indexOf(searchCriteria) != -1)
                    {
                        filteredModuleList.push(module);
                    };
                };
                this.gdModules.dataProvider = filteredModuleList;
                this._lastSearchCriteria = searchCriteria;
                this.showModuleDetails(null);
            }
            else
            {
                this.gdModules.dataProvider = ((this._filteredModuleList) ? this._filteredModuleList : this._moduleList);
                this.gdModules.selectedIndex = this._lastSelection;
                this.showModuleDetails(this.gdModules.selectedItem);
            };
        }


    }
}//package ui

