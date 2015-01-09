package ui
{
    import d2api.BindsApi;
    import d2components.ButtonContainer;
    import d2components.ComboBox;
    import d2components.Label;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import types.ConfigProperty;
    import d2actions.*;
    import d2hooks.*;

    public class ConfigPerformance extends ConfigUi 
    {

        public var bindsApi:BindsApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _lastSelectedIndex:int;
        private var qualitiesName:Array;
        private var qualityBtns:Array;
        private var pointsDisplayType:Array;
        private var _creatureLimits:Array;
        private var _auraChoices:Array;
        private var _infinityText:String;
        public var btn_left:ButtonContainer;
        public var btn_right:ButtonContainer;
        public var btn_quality0:ButtonContainer;
        public var btn_quality1:ButtonContainer;
        public var btn_quality2:ButtonContainer;
        public var btn_quality3:ButtonContainer;
        public var btn_showAllMonsters:ButtonContainer;
        public var btn_allowAnimsFun:ButtonContainer;
        public var btn_allowUiShadows:ButtonContainer;
        public var btn_allowAnimatedGfx:ButtonContainer;
        public var btn_allowParticlesFx:ButtonContainer;
        public var btn_allowSpellEffects:ButtonContainer;
        public var btn_allowHitAnim:ButtonContainer;
        public var btn_optimizeMultiAccount:ButtonContainer;
        public var btn_fullScreen:ButtonContainer;
        public var btn_useLDSkin:ButtonContainer;
        public var cb_creatures:ComboBox;
        public var cb_flashQuality:ComboBox;
        public var cb_auras:ComboBox;
        public var cb_pointsOverHead:ComboBox;
        public var btn_groundCacheEnabled:ButtonContainer;
        public var btn_groundCacheQuality1:ButtonContainer;
        public var btn_groundCacheQuality2:ButtonContainer;
        public var btn_groundCacheQuality3:ButtonContainer;
        public var lbl_diskUsed:Label;
        public var btn_clearGroundCache:ButtonContainer;
        public var lbl_showPointsOverhead:Label;
        public var btn_showTurnPicture:ButtonContainer;
        public var btn_showAuraOnFront:ButtonContainer;


        public function main(args:*):void
        {
            this.btn_left.soundId = SoundEnum.SCROLL_DOWN;
            this.btn_right.soundId = SoundEnum.SCROLL_UP;
            this.btn_quality0.soundId = SoundEnum.SPEC_BUTTON;
            this.btn_quality1.soundId = SoundEnum.SPEC_BUTTON;
            this.btn_quality2.soundId = SoundEnum.SPEC_BUTTON;
            this.btn_quality3.soundId = SoundEnum.SPEC_BUTTON;
            var properties:Array = new Array();
            properties.push(new ConfigProperty("cb_flashQuality", "flashQuality", "dofus"));
            properties.push(new ConfigProperty("cb_creatures", "creaturesMode", "tiphon"));
            properties.push(new ConfigProperty("btn_showAllMonsters", "showEveryMonsters", "dofus"));
            properties.push(new ConfigProperty("btn_allowAnimsFun", "allowAnimsFun", "dofus"));
            properties.push(new ConfigProperty("btn_allowUiShadows", "uiShadows", "berilia"));
            properties.push(new ConfigProperty("btn_allowAnimatedGfx", "allowAnimatedGfx", "atouin"));
            properties.push(new ConfigProperty("btn_allowParticlesFx", "allowParticlesFx", "atouin"));
            properties.push(new ConfigProperty("btn_allowSpellEffects", "allowSpellEffects", "dofus"));
            properties.push(new ConfigProperty("btn_allowHitAnim", "allowHitAnim", "dofus"));
            properties.push(new ConfigProperty("", "dofusQuality", "dofus"));
            properties.push(new ConfigProperty("btn_groundCacheEnabled", "groundCacheMode", "atouin"));
            properties.push(new ConfigProperty("btn_showPointsOverhead", "pointsOverhead", "tiphon"));
            properties.push(new ConfigProperty("btn_showTurnPicture", "turnPicture", "dofus"));
            properties.push(new ConfigProperty("cb_auras", "auraMode", "tiphon"));
            properties.push(new ConfigProperty("btn_showAuraOnFront", "alwaysShowAuraOnFront", "tiphon"));
            properties.push(new ConfigProperty("btn_optimizeMultiAccount", "optimizeMultiAccount", "dofus"));
            properties.push(new ConfigProperty("btn_fullScreen", "fullScreen", "dofus"));
            properties.push(new ConfigProperty("btn_useLDSkin", "useLowDefSkin", "atouin"));
            init(properties);
            uiApi.addComponentHook(this.btn_quality0, "onRelease");
            uiApi.addComponentHook(this.btn_quality0, "onRollOver");
            uiApi.addComponentHook(this.btn_quality0, "onRollOut");
            uiApi.addComponentHook(this.btn_quality0, "onMouseUp");
            uiApi.addComponentHook(this.btn_quality1, "onRelease");
            uiApi.addComponentHook(this.btn_quality1, "onRollOver");
            uiApi.addComponentHook(this.btn_quality1, "onRollOut");
            uiApi.addComponentHook(this.btn_quality1, "onMouseUp");
            uiApi.addComponentHook(this.btn_quality2, "onRelease");
            uiApi.addComponentHook(this.btn_quality2, "onRollOver");
            uiApi.addComponentHook(this.btn_quality2, "onRollOut");
            uiApi.addComponentHook(this.btn_quality2, "onMouseUp");
            uiApi.addComponentHook(this.btn_quality3, "onRelease");
            uiApi.addComponentHook(this.btn_quality3, "onRollOver");
            uiApi.addComponentHook(this.btn_quality3, "onRollOut");
            uiApi.addComponentHook(this.btn_quality3, "onMouseUp");
            uiApi.addComponentHook(this.btn_groundCacheEnabled, "onRollOver");
            uiApi.addComponentHook(this.btn_groundCacheEnabled, "onRollOut");
            uiApi.addComponentHook(this.btn_groundCacheQuality1, "onRollOver");
            uiApi.addComponentHook(this.btn_groundCacheQuality1, "onRollOut");
            uiApi.addComponentHook(this.btn_groundCacheQuality2, "onRollOver");
            uiApi.addComponentHook(this.btn_groundCacheQuality2, "onRollOut");
            uiApi.addComponentHook(this.btn_groundCacheQuality3, "onRollOver");
            uiApi.addComponentHook(this.btn_groundCacheQuality3, "onRollOut");
            uiApi.addComponentHook(this.btn_left, "onRelease");
            uiApi.addComponentHook(this.btn_right, "onRelease");
            uiApi.addComponentHook(this.btn_showAllMonsters, "onRelease");
            uiApi.addComponentHook(this.btn_allowAnimsFun, "onRelease");
            uiApi.addComponentHook(this.btn_allowUiShadows, "onRelease");
            uiApi.addComponentHook(this.btn_allowAnimatedGfx, "onRelease");
            uiApi.addComponentHook(this.btn_allowParticlesFx, "onRelease");
            uiApi.addComponentHook(this.btn_allowSpellEffects, "onRelease");
            uiApi.addComponentHook(this.btn_allowHitAnim, "onRelease");
            uiApi.addComponentHook(this.btn_groundCacheEnabled, "onRelease");
            uiApi.addComponentHook(this.btn_groundCacheQuality1, "onRelease");
            uiApi.addComponentHook(this.btn_groundCacheQuality2, "onRelease");
            uiApi.addComponentHook(this.btn_groundCacheQuality3, "onRelease");
            uiApi.addComponentHook(this.lbl_showPointsOverhead, "onRollOver");
            uiApi.addComponentHook(this.lbl_showPointsOverhead, "onRollOut");
            uiApi.addComponentHook(this.btn_showAllMonsters, "onRollOver");
            uiApi.addComponentHook(this.btn_showAllMonsters, "onRollOut");
            uiApi.addComponentHook(this.btn_showAuraOnFront, "onRollOver");
            uiApi.addComponentHook(this.btn_showAuraOnFront, "onRollOut");
            uiApi.addComponentHook(this.btn_showTurnPicture, "onRelease");
            uiApi.addComponentHook(this.btn_showTurnPicture, "onRollOver");
            uiApi.addComponentHook(this.btn_showTurnPicture, "onRollOut");
            uiApi.addComponentHook(this.btn_optimizeMultiAccount, "onRelease");
            uiApi.addComponentHook(this.btn_optimizeMultiAccount, "onRollOver");
            uiApi.addComponentHook(this.btn_optimizeMultiAccount, "onRollOut");
            uiApi.addComponentHook(this.btn_fullScreen, "onRelease");
            uiApi.addComponentHook(this.btn_useLDSkin, "onRelease");
            this._infinityText = uiApi.getText("ui.common.infinit");
            this.qualityBtns = [this.btn_quality0, this.btn_quality1, this.btn_quality2, this.btn_quality3];
            this.qualitiesName = new Array(uiApi.getText("ui.common.none"), "2x", "4x");
            this.cb_flashQuality.dataProvider = this.qualitiesName;
            this.cb_flashQuality.value = ((sysApi.setQualityIsEnable()) ? this.qualitiesName[sysApi.getOption("flashQuality", "dofus")] : this.qualitiesName[2]);
            this.cb_flashQuality.disabled = !(sysApi.setQualityIsEnable());
            this.cb_flashQuality.dataNameField = "";
            this._creatureLimits = ["0", "10", "20", "40", this._infinityText];
            this.cb_creatures.dataProvider = this._creatureLimits;
            var index:int = this._creatureLimits.indexOf(sysApi.getOption("creaturesMode", "tiphon").toString());
            if (index == -1)
            {
                index = 4;
            };
            this.cb_creatures.value = this._creatureLimits[index];
            this.cb_creatures.dataNameField = "";
            this._auraChoices = [uiApi.getText("ui.option.aura.none"), uiApi.getText("ui.option.aura.rollover"), uiApi.getText("ui.option.aura.cycle"), uiApi.getText("ui.option.aura.all")];
            this.cb_auras.dataProvider = this._auraChoices;
            index = sysApi.getOption("auraMode", "tiphon");
            this.cb_auras.value = this._auraChoices[index];
            this.cb_auras.dataNameField = "";
            this.pointsDisplayType = [uiApi.getText("ui.option.pointsOverHead.none"), uiApi.getText("ui.option.pointsOverHead.normal"), uiApi.getText("ui.option.pointsOverHead.cartoon")];
            this.cb_pointsOverHead.dataProvider = this.pointsDisplayType;
            var indexp:uint = sysApi.getOption("pointsOverhead", "tiphon");
            this.cb_pointsOverHead.value = this.pointsDisplayType[indexp];
            this.cb_pointsOverHead.dataNameField = "";
            var quality:uint = sysApi.getOption("dofusQuality", "dofus");
            this.qualityBtns[quality].selected = true;
            this.selectQualityMode(quality);
            var currentValue:int = sysApi.getOption("groundCacheMode", "atouin");
            this.updateGroundCacheOption(currentValue);
            var value:Number = sysApi.getGroundCacheSize();
            value = (value / 0x100000);
            this.lbl_diskUsed.text = uiApi.getText("ui.option.performance.groundCacheSize", (int((value * 100)) / 100));
            if (sysApi.isStreaming())
            {
                setProperty("dofus", "fullScreen", uiApi.isFullScreen());
            };
        }

        override public function reset():void
        {
            super.reset();
            this.selectQualityMode(1);
            this.btn_quality1.selected = true;
        }

        private function updateGroundCacheOption(value:int):void
        {
            this.btn_groundCacheQuality1.selected = false;
            this.btn_groundCacheQuality2.selected = false;
            this.btn_groundCacheQuality3.selected = false;
            if (value == 0)
            {
                this.btn_groundCacheEnabled.selected = false;
                this.btn_groundCacheQuality1.disabled = true;
                this.btn_groundCacheQuality2.disabled = true;
                this.btn_groundCacheQuality3.disabled = true;
            }
            else
            {
                this.btn_groundCacheEnabled.selected = true;
                this.btn_groundCacheQuality1.disabled = false;
                this.btn_groundCacheQuality2.disabled = false;
                this.btn_groundCacheQuality3.disabled = false;
                this[("btn_groundCacheQuality" + value)].selected = true;
            };
        }

        private function selectQualityMode(mode:uint):void
        {
            if (mode == 0)
            {
                if (sysApi.setQualityIsEnable())
                {
                    this.cb_flashQuality.value = this.qualitiesName[0];
                };
                this.cb_creatures.value = this._creatureLimits[1];
                setProperty("dofus", "showEveryMonsters", false);
                setProperty("dofus", "allowAnimsFun", false);
                setProperty("atouin", "useLowDefSkin", true);
                this.cb_auras.value = this._auraChoices[0];
                setProperty("tiphon", "alwaysShowAuraOnFront", false);
                setProperty("berilia", "uiShadows", false);
                setProperty("tubul", "allowSoundEffects", false);
                this.cb_pointsOverHead.value = this.pointsDisplayType[1];
                setProperty("dofus", "turnPicture", false);
                setProperty("dofus", "allowSpellEffects", sysApi.setQualityIsEnable());
                setProperty("dofus", "allowHitAnim", sysApi.setQualityIsEnable());
                configApi.setConfigProperty("dofus", "cacheMapEnabled", false);
                setProperty("atouin", "allowAnimatedGfx", false);
                setProperty("atouin", "allowParticlesFx", false);
                setProperty("atouin", "groundCacheMode", 3);
                this.updateGroundCacheOption(3);
            }
            else
            {
                if (mode == 1)
                {
                    if (sysApi.setQualityIsEnable())
                    {
                        this.cb_flashQuality.value = this.qualitiesName[1];
                    };
                    this.cb_creatures.value = this._creatureLimits[2];
                    setProperty("atouin", "useLowDefSkin", true);
                    setProperty("dofus", "showEveryMonsters", false);
                    setProperty("dofus", "allowAnimsFun", false);
                    this.cb_auras.value = this._auraChoices[2];
                    setProperty("tiphon", "alwaysShowAuraOnFront", false);
                    setProperty("berilia", "uiShadows", false);
                    setProperty("tubul", "allowSoundEffects", true);
                    this.cb_pointsOverHead.value = this.pointsDisplayType[1];
                    setProperty("dofus", "turnPicture", true);
                    setProperty("dofus", "allowSpellEffects", true);
                    setProperty("dofus", "allowHitAnim", true);
                    configApi.setConfigProperty("dofus", "cacheMapEnabled", true);
                    setProperty("atouin", "allowAnimatedGfx", false);
                    setProperty("atouin", "allowParticlesFx", true);
                    setProperty("atouin", "groundCacheMode", 1);
                    this.updateGroundCacheOption(1);
                }
                else
                {
                    if (mode == 2)
                    {
                        if (sysApi.setQualityIsEnable())
                        {
                            this.cb_flashQuality.value = this.qualitiesName[2];
                        };
                        this.cb_creatures.value = this._creatureLimits[4];
                        setProperty("atouin", "useLowDefSkin", false);
                        setProperty("dofus", "showEveryMonsters", true);
                        setProperty("dofus", "allowAnimsFun", true);
                        this.cb_auras.value = this._auraChoices[3];
                        setProperty("tiphon", "alwaysShowAuraOnFront", true);
                        setProperty("berilia", "uiShadows", true);
                        setProperty("tubul", "allowSoundEffects", true);
                        this.cb_pointsOverHead.value = this.pointsDisplayType[1];
                        setProperty("dofus", "turnPicture", true);
                        setProperty("dofus", "allowSpellEffects", true);
                        setProperty("dofus", "allowHitAnim", true);
                        configApi.setConfigProperty("dofus", "cacheMapEnabled", true);
                        setProperty("atouin", "allowAnimatedGfx", true);
                        setProperty("atouin", "allowParticlesFx", true);
                        setProperty("atouin", "groundCacheMode", 1);
                        this.updateGroundCacheOption(1);
                    };
                };
            };
            setProperty("dofus", "dofusQuality", mode);
        }

        private function onConfirmClearGroundCache():void
        {
            sysApi.clearGroundCache();
            this.lbl_diskUsed.text = uiApi.getText("ui.option.performance.groundCacheSize", "0");
        }

        override public function onRelease(target:Object):void
        {
            sysApi.log(8, ((("onRelease sur " + target) + " : ") + target.name));
            switch (target)
            {
                case this.btn_groundCacheEnabled:
                    if (this.btn_groundCacheEnabled.selected)
                    {
                        setProperty("atouin", "groundCacheMode", 1);
                        this.updateGroundCacheOption(1);
                    }
                    else
                    {
                        setProperty("atouin", "groundCacheMode", 0);
                        this.updateGroundCacheOption(0);
                    };
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_groundCacheQuality1:
                    setProperty("atouin", "groundCacheMode", 1);
                    this.updateGroundCacheOption(1);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_groundCacheQuality2:
                    setProperty("atouin", "groundCacheMode", 2);
                    this.updateGroundCacheOption(2);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_groundCacheQuality3:
                    setProperty("atouin", "groundCacheMode", 3);
                    this.updateGroundCacheOption(3);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_clearGroundCache:
                    this.modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.option.performance.confirmClearGroundCache"), [uiApi.getText("ui.common.yes"), uiApi.getText("ui.common.no")], [this.onConfirmClearGroundCache, null], this.onConfirmClearGroundCache);
                    break;
                case this.btn_left:
                    if (this.btn_quality1.selected)
                    {
                        this.selectQualityMode(0);
                        this.btn_quality0.selected = true;
                    }
                    else
                    {
                        if (this.btn_quality2.selected)
                        {
                            this.selectQualityMode(1);
                            this.btn_quality1.selected = true;
                        }
                        else
                        {
                            if (this.btn_quality3.selected)
                            {
                                this.selectQualityMode(2);
                                this.btn_quality2.selected = true;
                            };
                        };
                    };
                    break;
                case this.btn_right:
                    if (this.btn_quality2.selected)
                    {
                        this.selectQualityMode(3);
                        this.btn_quality3.selected = true;
                    }
                    else
                    {
                        if (this.btn_quality1.selected)
                        {
                            this.selectQualityMode(2);
                            this.btn_quality2.selected = true;
                        }
                        else
                        {
                            if (this.btn_quality0.selected)
                            {
                                this.selectQualityMode(1);
                                this.btn_quality1.selected = true;
                            };
                        };
                    };
                    break;
                case this.btn_quality0:
                    this.selectQualityMode(0);
                    break;
                case this.btn_quality1:
                    this.selectQualityMode(1);
                    break;
                case this.btn_quality2:
                    this.selectQualityMode(2);
                    break;
                case this.btn_quality3:
                    this.selectQualityMode(3);
                    break;
                case this.btn_useLDSkin:
                    setProperty("atouin", "useLowDefSkin", this.btn_useLDSkin.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_showAllMonsters:
                    setProperty("dofus", "showEveryMonsters", this.btn_showAllMonsters.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_allowAnimsFun:
                    setProperty("dofus", "allowAnimsFun", this.btn_allowAnimsFun.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_allowAnimatedGfx:
                    setProperty("atouin", "allowAnimatedGfx", this.btn_allowAnimatedGfx.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_allowParticlesFx:
                    setProperty("atouin", "allowParticlesFx", this.btn_allowParticlesFx.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_allowSpellEffects:
                    setProperty("dofus", "allowSpellEffects", this.btn_allowSpellEffects.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_allowHitAnim:
                    setProperty("dofus", "allowHitAnim", this.btn_allowHitAnim.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_allowUiShadows:
                    setProperty("berilia", "uiShadows", this.btn_allowUiShadows.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_showTurnPicture:
                    setProperty("dofus", "turnPicture", this.btn_showTurnPicture.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_showAuraOnFront:
                    setProperty("tiphon", "alwaysShowAuraOnFront", this.btn_showAuraOnFront.selected);
                    this.btn_quality3.selected = true;
                    this.selectQualityMode(3);
                    break;
                case this.btn_optimizeMultiAccount:
                    setProperty("dofus", "optimizeMultiAccount", this.btn_optimizeMultiAccount.selected);
                    break;
                case this.btn_fullScreen:
                    if (((sysApi.isStreaming()) && (!(this.btn_fullScreen.selected))))
                    {
                        uiApi.setShortcutUsedToExitFullScreen(true);
                    };
                    setProperty("dofus", "fullScreen", this.btn_fullScreen.selected);
                    break;
            };
        }

        public function onMouseUp(target:Object):void
        {
            sysApi.log(8, ((("onMouseUp sur " + target) + " : ") + target.name));
            switch (target)
            {
                case this.btn_quality0:
                    this.selectQualityMode(0);
                    this.btn_quality0.selected = true;
                    break;
                case this.btn_quality1:
                    this.selectQualityMode(1);
                    this.btn_quality1.selected = true;
                    break;
                case this.btn_quality2:
                    this.selectQualityMode(2);
                    this.btn_quality2.selected = true;
                    break;
                case this.btn_quality3:
                    this.selectQualityMode(3);
                    this.btn_quality3.selected = true;
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var _local_4:int;
            switch (target)
            {
                case this.cb_creatures:
                    if (this._creatureLimits[this.cb_creatures.selectedIndex] == this._infinityText)
                    {
                        _local_4 = 100;
                    }
                    else
                    {
                        _local_4 = int(this._creatureLimits[this.cb_creatures.selectedIndex]);
                    };
                    setProperty("tiphon", "creaturesMode", _local_4);
                    break;
                case this.cb_pointsOverHead:
                    setProperty("tiphon", "pointsOverhead", this.cb_pointsOverHead.selectedIndex);
                    break;
                case this.cb_flashQuality:
                    setProperty("dofus", "flashQuality", this.cb_flashQuality.selectedIndex);
                    break;
                case this.cb_auras:
                    setProperty("tiphon", "auraMode", this.cb_auras.selectedIndex);
                    break;
            };
            if (((!((selectMethod == 2))) && (!((selectMethod == 7)))))
            {
                this.btn_quality3.selected = true;
                this.selectQualityMode(3);
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_quality0:
                    tooltipText = uiApi.getText("ui.option.quality.lowText");
                    break;
                case this.btn_quality1:
                    tooltipText = uiApi.getText("ui.option.quality.mediumText");
                    break;
                case this.btn_quality2:
                    tooltipText = uiApi.getText("ui.option.quality.highText");
                    break;
                case this.btn_quality3:
                    tooltipText = uiApi.getText("ui.option.quality.customText");
                    break;
                case this.btn_groundCacheEnabled:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltip");
                    break;
                case this.btn_groundCacheQuality1:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltipHigh");
                    break;
                case this.btn_groundCacheQuality2:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltipMedium");
                    break;
                case this.btn_groundCacheQuality3:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltipLow");
                    break;
                case this.lbl_showPointsOverhead:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.option.overHeadInfoTooltip");
                    break;
                case this.btn_showTurnPicture:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.option.showTurnPictureTooltip");
                    break;
                case this.btn_showAuraOnFront:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.option.showAuraOnFrontTooltip");
                    break;
                case this.btn_optimizeMultiAccount:
                    point = 5;
                    relPoint = 3;
                    tooltipText = uiApi.getText("ui.config.optimizeMultiAccountInfo");
                    break;
                case this.btn_showAllMonsters:
                    tooltipText = uiApi.getText("ui.option.creaturesTooltip");
                    break;
            };
            uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }


    }
}//package ui

