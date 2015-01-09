package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.TooltipApi;
    import d2api.DataApi;
    import d2data.SpellPair;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Texture;
    import d2hooks.AreaFightModificatorUpdate;
    import d2hooks.FoldAll;
    import d2utils.SpellTooltipSettings;
    import d2enums.LocationEnum;
    import d2hooks.*;
    import d2actions.*;

    public class FightModificatorUi 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var tooltipApi:TooltipApi;
        public var dataApi:DataApi;
        private var _hidden:Boolean = false;
        private var _foldStatus:Boolean;
        private var _spellPair:SpellPair;
        public var ctr_ui:GraphicContainer;
        public var btn_minimArrow:ButtonContainer;
        public var btn_minimArrow_small:ButtonContainer;
        public var tx_slot:Texture;


        public function main(param:Object):void
        {
            this.sysApi.addHook(AreaFightModificatorUpdate, this.onAreaFightModificatorUpdate);
            this.uiApi.addComponentHook(this.tx_slot, "onRollOver");
            this.uiApi.addComponentHook(this.tx_slot, "onRollOut");
            this.sysApi.addHook(FoldAll, this.onFoldAll);
            this._hidden = false;
            this.btn_minimArrow_small.visible = false;
            this.ctr_ui.visible = true;
            if (param)
            {
                this._spellPair = this.dataApi.getSpellPair(param.pairId);
                if (this._spellPair)
                {
                    this.update();
                }
                else
                {
                    this.sysApi.log(2, (("La paire " + param.pairId) + " n'existe pas"));
                };
            };
        }

        public function unload():void
        {
            this.uiApi.hideTooltip();
        }

        public function update():void
        {
            this.tx_slot.uri = this.uiApi.createUri((this.uiApi.me().getConstant("spells_uri") + this._spellPair.iconId));
            this.uiApi.me().render();
        }

        private function onAreaFightModificatorUpdate(spellPairId:int):void
        {
            if (spellPairId == -1)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            }
            else
            {
                this._spellPair = this.dataApi.getSpellPair(spellPairId);
                this.update();
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_minimArrow:
                    this._hidden = true;
                    this.btn_minimArrow_small.visible = true;
                    this.ctr_ui.visible = false;
                    break;
                case this.btn_minimArrow_small:
                    this._hidden = false;
                    this.btn_minimArrow_small.visible = false;
                    this.ctr_ui.visible = true;
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var spellTooltipSettings:SpellTooltipSettings;
            if (this._spellPair)
            {
                spellTooltipSettings = this.tooltipApi.createSpellSettings();
                spellTooltipSettings.header = false;
                spellTooltipSettings.effects = false;
                spellTooltipSettings.CC_EC = false;
                this.uiApi.showTooltip(this._spellPair, this.tx_slot, false, "standard", LocationEnum.POINT_TOPLEFT, LocationEnum.POINT_BOTTOMRIGHT, 0, null, null, spellTooltipSettings);
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        private function onFoldAll(fold:Boolean):void
        {
            if (fold)
            {
                this._foldStatus = !(this._hidden);
                this._hidden = true;
                this.btn_minimArrow_small.visible = true;
                this.ctr_ui.visible = false;
            }
            else
            {
                this._hidden = !(this._foldStatus);
                this.btn_minimArrow_small.visible = !(this._foldStatus);
                this.ctr_ui.visible = this._foldStatus;
            };
        }


    }
}//package ui

