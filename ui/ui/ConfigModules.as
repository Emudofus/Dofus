package ui
{
    import flash.utils.Dictionary;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import d2enums.ComponentHookList;
    import d2hooks.ModuleInstallationProgress;
    import d2hooks.InstalledModuleList;
    import types.ConfigProperty;
    import d2utils.UiModule;
    import d2actions.InstalledModuleListRequest;
    import d2actions.ModuleDeleteRequest;
    import d2actions.ResetGame;
    import d2enums.StrataEnum;
    import d2enums.SelectMethodEnum;
    import d2hooks.*;
    import d2actions.*;

    public class ConfigModules extends ConfigUi 
    {

        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _modules:Array;
        private var _modulesBtnList:Dictionary;
        private var _lastCheckBoxClicked:ButtonContainer;
        private var _activePopupName:String;
        private var _moduleBeingDeleted:Object;
        public var gd_modules:Grid;
        public var btn_hideAnkamaModules:ButtonContainer;
        public var btn_marketplace:ButtonContainer;

        public function ConfigModules()
        {
            this._modulesBtnList = new Dictionary(true);
            super();
        }

        public function main(args:*):void
        {
            uiApi.addComponentHook(this.gd_modules, "onItemRollOver");
            uiApi.addComponentHook(this.gd_modules, "onItemRollOut");
            uiApi.addComponentHook(this.gd_modules, ComponentHookList.ON_SELECT_ITEM);
            uiApi.addComponentHook(this.btn_hideAnkamaModules, ComponentHookList.ON_RELEASE);
            sysApi.toggleModuleInstaller();
            sysApi.addHook(ModuleInstallationProgress, this.onModuleInstallationProgress);
            sysApi.addHook(InstalledModuleList, this.onInstalledModuleList);
            this.btn_hideAnkamaModules.selected = true;
            var properties:Array = new Array();
            properties.push(new ConfigProperty("grid_theme", "switchUiSkin", "dofus"));
            init(properties);
            this.updateDataProvider();
            showDefaultBtn(false);
        }

        public function unload():void
        {
            sysApi.toggleModuleInstaller();
            this._modules = null;
            this._lastCheckBoxClicked = null;
        }

        public function update():void
        {
            this.updateDataProvider();
        }

        public function updateModuleLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._modulesBtnList[componentsRef.btn_activate.name]))
            {
                uiApi.addComponentHook(componentsRef.btn_activate, "onRelease");
                uiApi.addComponentHook(componentsRef.btn_delete, "onRelease");
            };
            this._modulesBtnList[componentsRef.btn_activate.name] = data;
            if (data)
            {
                componentsRef.btn_module.selected = selected;
                componentsRef.btn_module.softDisabled = false;
                if (data.trusted)
                {
                    componentsRef.lbl_author.cssClass = "p0right";
                }
                else
                {
                    componentsRef.lbl_author.cssClass = "right";
                };
                componentsRef.btn_delete.visible = !(data.trusted);
                componentsRef.btn_activate.visible = true;
                componentsRef.btn_activate.disabled = ((data.trusted) && (data.enable));
                if (!(data.name))
                {
                    componentsRef.lbl_name.text = data.id;
                }
                else
                {
                    componentsRef.lbl_name.text = data.name;
                };
                componentsRef.lbl_author.text = data.author;
                if (((data.shortDescription) && ((data.shortDescription.indexOf("ui.module.") == 0))))
                {
                    componentsRef.lbl_shortDesc.text = uiApi.getText(data.shortDescription);
                }
                else
                {
                    componentsRef.lbl_shortDesc.text = data.shortDescription;
                };
                try
                {
                    if (((data.iconUri) && (data.iconUri.path)))
                    {
                        componentsRef.tx_icon.uri = data.iconUri;
                    }
                    else
                    {
                        componentsRef.tx_icon.uri = null;
                    };
                }
                catch(error:Error)
                {
                    componentsRef.tx_icon.uri = null;
                };
                componentsRef.btn_activate.selected = data.enable;
            }
            else
            {
                componentsRef.lbl_name.text = "";
                componentsRef.lbl_author.text = "";
                componentsRef.lbl_shortDesc.text = "";
                componentsRef.tx_icon.uri = null;
                componentsRef.btn_activate.selected = false;
                componentsRef.btn_activate.visible = false;
                componentsRef.btn_module.selected = false;
                componentsRef.btn_module.softDisabled = true;
                componentsRef.btn_delete.visible = false;
            };
        }

        private function updateDataProvider():void
        {
            var module:UiModule;
            sysApi.sendAction(new InstalledModuleListRequest());
            return;
        }

        private function onDeleteOk():void
        {
            this._activePopupName = this.modCommon.openNoButtonPopup(uiApi.getText("ui.module.marketplace.uninstallmodule"), ((uiApi.getText("ui.module.marketplace.uninstallmodulemsg", this._moduleBeingDeleted.name) + "\n") + uiApi.getText("ui.queue.wait")));
            uiApi.setModuleEnable(this._moduleBeingDeleted.id, false);
            sysApi.sendAction(new ModuleDeleteRequest(this._moduleBeingDeleted.id));
        }

        private function onRestartOk():void
        {
            sysApi.sendAction(new ResetGame());
        }

        private function onModuleInstallationProgress(percent:Number):void
        {
            if (percent == -1)
            {
                uiApi.unloadUi(this._activePopupName);
                this.updateDataProvider();
            };
        }

        private function onInstalledModuleList(moduleXmlString:*):void
        {
            var trusted:Boolean;
            var child:*;
            var showAnkamaMod:Boolean = !(this.btn_hideAnkamaModules.selected);
            var xmlData:XML = new XML(moduleXmlString);
            var installedModuleData:Array = new Array();
            for each (child in xmlData.children())
            {
                trusted = (((child.isTrusted.toString() == "true")) ? true : false);
                if (((showAnkamaMod) || (!(trusted))))
                {
                    installedModuleData.push({
                        "name":child.name.toString(),
                        "author":child.author.toString(),
                        "id":((child.author.toString() + "_") + child.name.toString()),
                        "trusted":trusted,
                        "enable":(((child.isEnabled.toString() == "true")) ? true : false),
                        "shortDescription":child.shortDescription.toString(),
                        "iconUri":uiApi.createUri(child.iconUri.toString()),
                        "description":child.description.toString(),
                        "version":child.version.toString(),
                        "dofusVersion":child.dofusVersion.toString()
                    });
                };
            };
            this.gd_modules.dataProvider = installedModuleData;
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_marketplace:
                    uiApi.loadUi("moduleMarketplace", null, {}, StrataEnum.STRATA_TOP);
                    break;
                case this.btn_hideAnkamaModules:
                    this.updateDataProvider();
                    break;
                default:
                    if (target.name.indexOf("btn_activate") != -1)
                    {
                        this._lastCheckBoxClicked = (target as ButtonContainer);
                        if (!(target.selected))
                        {
                            uiApi.setModuleEnable(this._modulesBtnList[target.name].id, true);
                            if (sysApi.isInGame())
                            {
                                this.modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.module.marketplace.reboot"), [uiApi.getText("ui.common.yes"), uiApi.getText("ui.common.no")], [this.onRestartOk]);
                            };
                        }
                        else
                        {
                            uiApi.setModuleEnable(this._modulesBtnList[target.name].id, false);
                        };
                        this.updateDataProvider();
                    }
                    else
                    {
                        if (target.name.indexOf("btn_delete") != -1)
                        {
                            this._lastCheckBoxClicked = (target as ButtonContainer);
                            this._moduleBeingDeleted = this._modulesBtnList[target.name.replace("btn_delete", "btn_activate")];
                            this.modCommon.openPopup(uiApi.getText("ui.module.marketplace.uninstallmodule"), uiApi.getText("ui.module.marketplace.uninstallmodulewarning", this._moduleBeingDeleted.name), [uiApi.getText("ui.common.ok"), uiApi.getText("ui.common.cancel")], [this.onDeleteOk]);
                        };
                    };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var text:String;
            if (((item.data) && (item.data.description)))
            {
                text = "";
                if (item.data.version)
                {
                    text = (("v " + item.data.version) + "\n");
                };
                if (item.data.description.indexOf("ui.module.") == 0)
                {
                    text = (text + uiApi.getText(item.data.description));
                }
                else
                {
                    text = (text + item.data.description);
                };
                uiApi.showTooltip(uiApi.textTooltipInfo(text), item.container, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            uiApi.hideTooltip();
        }

        public function onRollOver(target:Object):void
        {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.option.modulesSwitch")), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if ((((selectMethod == SelectMethodEnum.AUTO)) || (!(isNewSelection))))
            {
                return;
            };
            if (this._lastCheckBoxClicked)
            {
                this._lastCheckBoxClicked = null;
                return;
            };
            uiApi.loadUi("moduleInfo", null, {
                "module":Grid(target).selectedItem,
                "details":null,
                "visibleBtns":false,
                "activationCallback":null,
                "isUpdate":false
            }, StrataEnum.STRATA_TOP);
        }


    }
}//package ui

