package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ConfigApi;
    import d2api.DataApi;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2data.OptionalFeature;
    import enum.WebTabEnum;
    import d2enums.ShortcutHookListEnum;
    import flash.external.ExternalInterface;

    public class WebBase 
    {

        public static var currentTabUi:String;
        public static var isShopAvailable:Boolean = false;
        public static var isVetRewardsAvailable:Boolean = true;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var configApi:ConfigApi;
        public var dataApi:DataApi;
        public var uiCtr:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var btn_tabShop:ButtonContainer;
        public var btn_tabOgrines:ButtonContainer;
        public var btn_tabVeteranRewards:ButtonContainer;
        public var btn_tabLibrary:ButtonContainer;


        public function main(oParams:*=null):void
        {
            var lastTab:String;
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_tabOgrines, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabOgrines, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabOgrines, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabVeteranRewards, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabVeteranRewards, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabVeteranRewards, "onRollOut");
            this.uiApi.addComponentHook(this.btn_tabShop, "onRelease");
            this.uiApi.addComponentHook(this.btn_tabShop, "onRollOver");
            this.uiApi.addComponentHook(this.btn_tabShop, "onRollOut");
            this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
            var feature:OptionalFeature = this.dataApi.getOptionalFeatureByKeyword("biz.shopInClient");
            if (((feature) && (this.configApi.isOptionalFeatureActive(feature.id))))
            {
                isShopAvailable = true;
            };
            currentTabUi = null;
            if (isShopAvailable)
            {
                this.btn_tabShop.visible = true;
            };
            if (isVetRewardsAvailable)
            {
                this.btn_tabVeteranRewards.visible = true;
            };
            if (((((oParams) && ((oParams is Array)))) && (oParams[0])))
            {
                this.openTab(oParams[0], oParams[1]);
            }
            else
            {
                lastTab = this.sysApi.getSetData("shopLastOpenedTab", WebTabEnum.SHOP_TAB);
                if (((((!(isShopAvailable)) && ((lastTab == WebTabEnum.SHOP_TAB)))) || (((!(isVetRewardsAvailable)) && ((lastTab == WebTabEnum.VET_RWDS_TAB))))))
                {
                    lastTab = WebTabEnum.BAK_TAB;
                };
                this.openTab(lastTab);
            };
        }

        public function unload():void
        {
            if (currentTabUi == WebTabEnum.BAK_TAB)
            {
                this.closeWebModalWindow();
            };
            if (currentTabUi)
            {
                this.uiApi.unloadUi(currentTabUi);
            };
            currentTabUi = null;
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case ShortcutHookListEnum.CLOSE_UI:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_tabShop:
                    this.openTab(WebTabEnum.SHOP_TAB);
                    break;
                case this.btn_tabOgrines:
                    this.openTab(WebTabEnum.BAK_TAB);
                    break;
                case this.btn_tabVeteranRewards:
                    this.openTab(WebTabEnum.VET_RWDS_TAB);
                    break;
                case this.btn_tabLibrary:
                    this.openTab(WebTabEnum.LIBRARY_TAB);
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 8;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_tabOgrines:
                    tooltipText = this.uiApi.getText("ui.shop.BAK");
                    break;
                case this.btn_tabVeteranRewards:
                    tooltipText = this.uiApi.getText("ui.veteran.veteranRewards");
                    break;
                case this.btn_tabShop:
                    tooltipText = this.uiApi.getText("ui.shop.shop");
                    break;
            };
            var data:Object = this.uiApi.textTooltipInfo(tooltipText);
            this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function openTab(uiName:String=null, uiParams:Object=null):void
        {
            if (uiName == currentTabUi)
            {
                return;
            };
            if (currentTabUi == WebTabEnum.BAK_TAB)
            {
                this.closeWebModalWindow();
            };
            if (currentTabUi)
            {
                this.uiApi.unloadUi(currentTabUi);
            };
            currentTabUi = uiName;
            this.sysApi.setData("shopLastOpenedTab", currentTabUi);
            if (currentTabUi == WebTabEnum.SHOP_TAB)
            {
                this.btn_tabShop.selected = true;
            }
            else
            {
                if (currentTabUi == WebTabEnum.BAK_TAB)
                {
                    this.btn_tabOgrines.selected = true;
                }
                else
                {
                    if (currentTabUi == WebTabEnum.VET_RWDS_TAB)
                    {
                        this.btn_tabVeteranRewards.selected = true;
                    };
                };
            };
            this.uiApi.loadUiInside(currentTabUi, this.uiCtr, currentTabUi, uiParams);
        }

        private function closeWebModalWindow():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("closeModal");
            };
        }


    }
}//package ui

