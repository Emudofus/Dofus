package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.RoleplayApi;
    import flash.utils.Dictionary;
    import d2components.Grid;
    import d2components.ButtonContainer;
    import d2hooks.LeaveDialog;
    import d2enums.StatesEnum;
    import d2data.SpellWrapper;
    import d2actions.LeaveDialogRequest;
    import d2enums.SelectMethodEnum;
    import d2actions.ValidateSpellForget;
    import d2hooks.*;
    import d2actions.*;

    public class SpellForget 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var rpApi:RoleplayApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _componentsList:Dictionary;
        public var gd_spellToForget:Grid;
        public var btn_close:ButtonContainer;
        public var btn_validate:ButtonContainer;

        public function SpellForget()
        {
            this._componentsList = new Dictionary(true);
            super();
        }

        public function main(param:Array):void
        {
            this.sysApi.addHook(LeaveDialog, this.onLeaveDialog);
            this.refreshList();
        }

        public function unload():void
        {
        }

        public function updateSpellLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (!(this._componentsList[componentsRef.slot_icon.name]))
            {
                this.uiApi.addComponentHook(componentsRef.slot_icon, "onRollOut");
                this.uiApi.addComponentHook(componentsRef.slot_icon, "onRollOver");
            };
            this._componentsList[componentsRef.slot_icon.name] = data;
            if (data)
            {
                componentsRef.lbl_spellName.text = data.spell.name;
                componentsRef.lbl_spellLvl.text = ("" + data.spellLevel);
                componentsRef.slot_icon.data = data;
                componentsRef.slot_icon.selected = false;
                componentsRef.btn_spell.selected = selected;
                componentsRef.btn_spell.state = ((selected) ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL);
            }
            else
            {
                componentsRef.lbl_spellName.text = "";
                componentsRef.lbl_spellLvl.text = "";
                componentsRef.slot_icon.data = null;
                componentsRef.btn_spell.disabled = true;
            };
        }

        private function validateSpellChoice():void
        {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.spellForgetConfirm", this.dataApi.getSpell(this.gd_spellToForget.selectedItem.id).name), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onPopupValidateSpellForget, this.onPopupClose], this.onPopupValidateSpellForget, this.onPopupClose);
        }

        private function refreshList():void
        {
            var spell:SpellWrapper;
            var spells:Object = this.rpApi.getSpellToForgetList();
            var spellsToForget:Array = new Array();
            for each (spell in spells)
            {
                spellsToForget.push(spell);
            };
            this.gd_spellToForget.dataProvider = spellsToForget;
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_validate:
                    if (this.gd_spellToForget.dataProvider.length > 0)
                    {
                        this.validateSpellChoice();
                    }
                    else
                    {
                        this.sysApi.sendAction(new LeaveDialogRequest());
                    };
                    break;
                case this.btn_close:
                    this.sysApi.sendAction(new LeaveDialogRequest());
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var data:SpellWrapper;
            if (target.name.indexOf("slot_icon") != -1)
            {
                data = this._componentsList[target.name];
                this.uiApi.showTooltip(data, target, false, "standard", 8);
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (this.gd_spellToForget.dataProvider.length > 0)
                    {
                        this.validateSpellChoice();
                    }
                    else
                    {
                        this.sysApi.sendAction(new LeaveDialogRequest());
                    };
                    break;
            };
            return (false);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            if (selectMethod == SelectMethodEnum.DOUBLE_CLICK)
            {
                this.validateSpellChoice();
            };
        }

        public function onPopupClose():void
        {
        }

        public function onPopupValidateSpellForget():void
        {
            if (!(this.gd_spellToForget.selectedItem))
            {
                return;
            };
            var selectedSpell:Object = this.gd_spellToForget.selectedItem;
            this.sysApi.sendAction(new ValidateSpellForget(selectedSpell.id));
        }

        public function onLeaveDialog():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }


    }
}//package ui

