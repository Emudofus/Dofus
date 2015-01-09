package ui
{
    import d2api.TooltipApi;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import d2utils.SpellTooltipSettings;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2hooks.*;

    public class SpellBannerTooltipUi 
    {

        private static var _shortcutColor:String;

        public var tooltipApi:TooltipApi;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var lbl_content:Object;
        public var backgroundCtr:Object;
        private var _spellWrapper:Object;
        private var _shortcutKey:String;
        private var _timerShowSpellTooltip:Timer;


        public function main(oParam:Object=null):void
        {
            if (!(_shortcutColor))
            {
                _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            this._spellWrapper = oParam.data.spellWrapper;
            this._shortcutKey = oParam.data.shortcutKey;
            this.lbl_content.text = (((((this._spellWrapper.name + " <font color='") + _shortcutColor) + "'>(") + this._shortcutKey) + ")</font>");
            this.lbl_content.multiline = false;
            this.lbl_content.wordWrap = false;
            this.lbl_content.fullWidth();
            this.backgroundCtr.width = (this.lbl_content.textfield.width + 12);
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
            var delay:int = this.sysApi.getOption("largeTooltipDelay", "dofus");
            this._timerShowSpellTooltip = new Timer(delay, 1);
            this._timerShowSpellTooltip.addEventListener(TimerEvent.TIMER, this.onTimer);
            this._timerShowSpellTooltip.start();
        }

        private function onTimer(e:TimerEvent):void
        {
            var cacheCode:String;
            var setting:String;
            var ref:Object;
            var weapon:Object;
            if (this._timerShowSpellTooltip)
            {
                this._timerShowSpellTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowSpellTooltip.stop();
                this._timerShowSpellTooltip = null;
            };
            var criticalMiss:int = this._spellWrapper.playerCriticalFailureRate;
            if (this._spellWrapper.isSpellWeapon)
            {
                weapon = this.playerApi.getWeapon();
                if (weapon)
                {
                    cacheCode = ((((((((((((((("SpellBanner-" + this._spellWrapper.id) + "#") + this.tooltipApi.getSpellTooltipCache()) + ",") + this._shortcutKey) + ",") + this._spellWrapper.playerCriticalRate) + ",") + criticalMiss) + ",") + weapon.objectUID) + ",") + weapon.setCount) + ",") + this._spellWrapper.versionNum);
                }
                else
                {
                    cacheCode = ((((((((((("SpellBanner-" + this._spellWrapper.id) + "#-") + this._shortcutKey) + ",") + this._shortcutKey) + ",") + this._spellWrapper.playerCriticalRate) + ",") + criticalMiss) + ",") + this._spellWrapper.versionNum);
                };
            }
            else
            {
                cacheCode = ((((((((((((((("SpellBanner-" + this._spellWrapper.id) + ",") + this._spellWrapper.spellLevel) + "#") + this.tooltipApi.getSpellTooltipCache()) + ",") + this._spellWrapper.playerCriticalRate) + ",") + this._spellWrapper.maximalRangeWithBoosts) + ",") + this._shortcutKey) + ",") + criticalMiss) + ",") + this._spellWrapper.versionNum);
            };
            var spellTS:SpellTooltipSettings = (this.sysApi.getData("spellTooltipSettings", true) as SpellTooltipSettings);
            if (!(spellTS))
            {
                spellTS = this.tooltipApi.createSpellSettings();
                this.sysApi.setData("spellTooltipSettings", spellTS, true);
            };
            var settings:Object = new Object();
            for each (setting in this.sysApi.getObjectVariables(spellTS))
            {
                if (setting == "header")
                {
                    settings["name"] = spellTS[setting];
                }
                else
                {
                    settings[setting] = spellTS[setting];
                };
            };
            settings.smallSpell = true;
            settings.contextual = true;
            settings.noBg = false;
            settings.shortcutKey = this._shortcutKey;
            ref = this.uiApi.getUi(UIEnum.BANNER).getElement(((this.sysApi.isFightContext()) ? "tooltipFightPlacer" : "tooltipRoleplayPlacer"));
            this.uiApi.showTooltip(this._spellWrapper, ref, false, "spellBanner", 8, 2, 3, null, null, settings, cacheCode);
            this.uiApi.hideTooltip(this.uiApi.me().name);
        }

        public function unload():void
        {
            if (this._timerShowSpellTooltip)
            {
                this._timerShowSpellTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowSpellTooltip.stop();
                this._timerShowSpellTooltip = null;
            };
        }


    }
}//package ui

