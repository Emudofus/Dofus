package 
{
    import flash.display.Sprite;
    import ui.ConfigGeneral;
    import ui.ConfigChat;
    import ui.ConfigTheme;
    import ui.ConfigModules;
    import ui.ConfigPerformance;
    import ui.ConfigShortcut;
    import ui.ConfigShortcutPopup;
    import ui.item.ChannelColorizedItem;
    import ui.ConfigAudio;
    import ui.ConfigCache;
    import ui.ConfigSupport;
    import ui.ConfigCompatibility;
    import ui.ConfigNotification;
    import ui.QualitySelection;
    import ui.ModuleInfo;
    import ui.ModuleMarketplace;
    import ui.item.ModuleItem;
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.ConfigApi;
    import d2hooks.AuthentificationStart;
    import d2hooks.ServersList;
    import d2hooks.CharacterSelectionStart;
    import d2hooks.GameStart;
    import d2hooks.QualitySelectionRequired;
    import d2hooks.SetDofusQuality;
    import d2enums.BuildTypeEnum;
    import d2hooks.ActivateSound;
    import d2hooks.*;

    public class Config extends Sprite 
    {

        private var include_ConfigGeneral:ConfigGeneral = null;
        private var include_ConfigChat:ConfigChat = null;
        private var include_ConfigTheme:ConfigTheme = null;
        private var include_ConfigModules:ConfigModules = null;
        private var include_ConfigPerformance:ConfigPerformance = null;
        private var include_ConfigShortcut:ConfigShortcut = null;
        private var include_ConfigShortcutPopup:ConfigShortcutPopup = null;
        private var include_ChannelColorizedItem:ChannelColorizedItem = null;
        private var include_ConfigAudio:ConfigAudio = null;
        private var include_ConfigCache:ConfigCache;
        private var include_ConfigSupport:ConfigSupport;
        private var include_ConfigCompatibility:ConfigCompatibility;
        private var include_ConfigNotification:ConfigNotification;
        private var include_QualitySelection:QualitySelection;
        private var include_ModuleInfo:ModuleInfo;
        private var include_ModuleMarketplace:ModuleMarketplace;
        private var include_ModuleItem:ModuleItem;
        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var commonMod:Object;
        public var configApi:ConfigApi;


        public function main():void
        {
            ConfigItem.uiApi = this.uiApi;
            this.defineItems();
            this.sysApi.addHook(AuthentificationStart, this.onAuthentificationStart);
            this.sysApi.addHook(ServersList, this.onServersList);
            this.sysApi.addHook(CharacterSelectionStart, this.onCharacterSelectionStart);
            this.sysApi.addHook(GameStart, this.onGameStart);
            this.sysApi.addHook(QualitySelectionRequired, this.onQualitySelectionRequired);
            this.sysApi.addHook(SetDofusQuality, this.onSetDofusQuality);
            this.uiApi.addShortcutHook("muteSound", this.onShortcut);
            var quality:uint = this.sysApi.getOption("dofusQuality", "dofus");
            if (quality == 0)
            {
                this.configApi.setConfigProperty("atouin", "groundCacheMode", 0);
            };
        }

        private function defineItems():void
        {
            ConfigItem.register("performance", "ui.option.performance", "ui.option.performanceSubtitle", "Ankama_Config::configPerformance");
            ConfigItem.register("theme", "ui.option.theme", "ui.option.themeSubtitle", "Ankama_Config::configTheme");
            ConfigItem.register("sound", "ui.option.audio", "ui.option.audioSubtitle", "Ankama_Config::configAudio");
            ConfigItem.register("compatibility", "ui.option.compatibility", "ui.option.compatibilitySubtitle", "Ankama_Config::configCompatibility");
            ConfigItem.register("notification", "ui.option.notifications", "ui.option.notificationsSubtitle", "Ankama_Config::configNotification");
            ConfigItem.register("cache", "ui.option.cache", "ui.option.cacheSubtitle", "Ankama_Config::configCache");
            ConfigItem.register("support", "ui.option.support", "ui.option.supportSubtitle", "Ankama_Config::configSupport");
            ConfigItem.register("modules", "ui.option.modules", "ui.option.modulesSubtitle", "Ankama_Config::configModules");
            ConfigItem.register("ui", "ui.option.interface", "ui.option.interfaceSubtitle", "Ankama_Config::configChat");
            ConfigItem.register("general", "ui.option.feature", "ui.option.featureSubtitle", "Ankama_Config::configGeneral");
            ConfigItem.register("shortcut", "ui.option.shortcut", "ui.option.shortcutSubtitle", "Ankama_Config::configShortcut");
        }

        private function addItem(name:String, condition:Boolean=true):void
        {
            var ci:ConfigItem;
            if (condition)
            {
                ci = ConfigItem.getItem(name);
                this.commonMod.addOptionItem(ci.id, ci.name, ci.description, ci.ui);
            };
        }

        private function onGameStart():void
        {
            this.addItem("performance");
            this.addItem("ui");
            this.addItem("theme", this.sysApi.hasAir());
            this.addItem("general");
            this.addItem("shortcut");
            this.addItem("sound");
            this.addItem("notification", this.sysApi.hasAir());
            this.addItem("cache");
            this.addItem("support");
            if ((((this.sysApi.getBuildType() == BuildTypeEnum.DEBUG)) || (((!((this.sysApi.getBuildType() == BuildTypeEnum.RELEASE))) && (this.sysApi.getConfigEntry("config.dev.mode"))))))
            {
                this.addItem("modules", this.sysApi.hasAir());
            };
        }

        private function gameApproachInit():void
        {
            this.addItem("performance");
            this.addItem("theme", this.sysApi.hasAir());
            this.addItem("sound");
            this.addItem("cache");
            this.addItem("support");
            if ((((this.sysApi.getBuildType() == BuildTypeEnum.DEBUG)) || (((!((this.sysApi.getBuildType() == BuildTypeEnum.RELEASE))) && (this.sysApi.getConfigEntry("config.dev.mode"))))))
            {
                this.addItem("modules", this.sysApi.hasAir());
            };
        }

        private function onAuthentificationStart():void
        {
            this.gameApproachInit();
        }

        private function onServersList(serverList:Object):void
        {
            this.gameApproachInit();
        }

        private function onCharacterSelectionStart(characterList:Object):void
        {
            this.gameApproachInit();
        }

        private function onQualitySelectionRequired():void
        {
            if (this.configApi.getConfigProperty("dofus", "askForQualitySelection"))
            {
                this.uiApi.loadUi("qualitySelection");
            };
        }

        private function onSetDofusQuality(qualityLevel:uint):void
        {
            if (qualityLevel == 0)
            {
                this.configApi.setConfigProperty("dofus", "showEveryMonsters", false);
                this.configApi.setConfigProperty("dofus", "allowAnimsFun", false);
                this.configApi.setConfigProperty("tiphon", "alwaysShowAuraOnFront", false);
                this.configApi.setConfigProperty("berilia", "uiShadows", false);
                this.configApi.setConfigProperty("tubul", "allowSoundEffects", false);
                this.configApi.setConfigProperty("dofus", "turnPicture", false);
                this.configApi.setConfigProperty("dofus", "allowSpellEffects", this.sysApi.setQualityIsEnable());
                this.configApi.setConfigProperty("dofus", "allowHitAnim", this.sysApi.setQualityIsEnable());
                this.configApi.setConfigProperty("dofus", "cacheMapEnabled", false);
                this.configApi.setConfigProperty("atouin", "allowAnimatedGfx", false);
                this.configApi.setConfigProperty("atouin", "allowParticlesFx", false);
                this.configApi.setConfigProperty("atouin", "groundCacheMode", 0);
            }
            else
            {
                if (qualityLevel == 1)
                {
                    this.configApi.setConfigProperty("dofus", "showEveryMonsters", false);
                    this.configApi.setConfigProperty("dofus", "allowAnimsFun", false);
                    this.configApi.setConfigProperty("tiphon", "alwaysShowAuraOnFront", false);
                    this.configApi.setConfigProperty("berilia", "uiShadows", false);
                    this.configApi.setConfigProperty("tubul", "allowSoundEffects", true);
                    this.configApi.setConfigProperty("dofus", "turnPicture", true);
                    this.configApi.setConfigProperty("dofus", "allowSpellEffects", true);
                    this.configApi.setConfigProperty("dofus", "allowHitAnim", true);
                    this.configApi.setConfigProperty("dofus", "cacheMapEnabled", true);
                    this.configApi.setConfigProperty("atouin", "allowAnimatedGfx", false);
                    this.configApi.setConfigProperty("atouin", "allowParticlesFx", true);
                    this.configApi.setConfigProperty("atouin", "groundCacheMode", 1);
                }
                else
                {
                    if (qualityLevel == 2)
                    {
                        this.configApi.setConfigProperty("dofus", "showEveryMonsters", true);
                        this.configApi.setConfigProperty("dofus", "allowAnimsFun", true);
                        this.configApi.setConfigProperty("tiphon", "alwaysShowAuraOnFront", true);
                        this.configApi.setConfigProperty("berilia", "uiShadows", true);
                        this.configApi.setConfigProperty("tubul", "allowSoundEffects", true);
                        this.configApi.setConfigProperty("dofus", "turnPicture", true);
                        this.configApi.setConfigProperty("dofus", "allowSpellEffects", true);
                        this.configApi.setConfigProperty("dofus", "allowHitAnim", true);
                        this.configApi.setConfigProperty("dofus", "cacheMapEnabled", true);
                        this.configApi.setConfigProperty("atouin", "allowAnimatedGfx", true);
                        this.configApi.setConfigProperty("atouin", "allowParticlesFx", true);
                        this.configApi.setConfigProperty("atouin", "groundCacheMode", 1);
                    }
                    else
                    {
                        return;
                    };
                };
            };
            this.configApi.setConfigProperty("dofus", "dofusQuality", qualityLevel);
        }

        public function onShortcut(s:String):Boolean
        {
            var _local_2:Boolean;
            switch (s)
            {
                case "muteSound":
                    _local_2 = false;
                    if (this.configApi.getConfigProperty("tubul", "tubulIsDesactivated"))
                    {
                        _local_2 = true;
                    };
                    this.configApi.setConfigProperty("tubul", "tubulIsDesactivated", !(_local_2));
                    this.sysApi.dispatchHook(ActivateSound, !(_local_2));
                    return (true);
            };
            return (false);
        }

        public function unload():void
        {
            ConfigItem.uiApi = null;
        }


    }
}//package 

import d2api.UiApi;

class ConfigItem 
{

    /*private*/ static var _items:Array = [];
    public static var uiApi:UiApi;

    public var id:String;
    public var name:String;
    public var description:String;
    public var ui:String;


    public static function getItem(name:String):ConfigItem
    {
        return (_items[name]);
    }

    public static function register(id:String, name:String, description:String, ui:String):void
    {
        var o:ConfigItem = new (ConfigItem)();
        o.id = id;
        o.name = uiApi.getText(name);
        o.description = uiApi.getText(description);
        o.ui = ui;
        _items[id] = o;
    }


}

