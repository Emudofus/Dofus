package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.TooltipApi;
    import flash.utils.Dictionary;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import d2hooks.GiftAssigned;
    import d2enums.ComponentHookList;
    import d2actions.GiftAssignRequest;
    import d2enums.LocationEnum;
    import d2utils.ItemTooltipSettings;
    import d2hooks.*;
    import d2actions.*;

    public class GiftMenu 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var tooltipApi:TooltipApi;
        private var _giftsObjectsList:Dictionary;
        private var _btnAcceptGiftList:Dictionary;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _giftList:Array;
        private var _charaList:Array;
        private var _characterSelected:Boolean = false;
        public var btn_assignAllgifts:ButtonContainer;
        public var btn_not_now:ButtonContainer;
        public var gd_gifts:Grid;
        public var gd_character_select:Grid;

        public function GiftMenu()
        {
            this._giftsObjectsList = new Dictionary(true);
            this._btnAcceptGiftList = new Dictionary(true);
            super();
        }

        public function main(g:Object):void
        {
            var chara:*;
            var gift:*;
            this.sysApi.addHook(GiftAssigned, this.onGiftAssigned);
            this.uiApi.addComponentHook(this.btn_assignAllgifts, "onRelease");
            this.uiApi.addComponentHook(this.btn_not_now, "onRelease");
            this.uiApi.addComponentHook(this.gd_character_select, "onSelectItem");
            this._charaList = new Array();
            for each (chara in g.chara)
            {
                this._charaList.push(chara);
            };
            this.gd_character_select.autoSelectMode = 0;
            this.gd_character_select.dataProvider = this._charaList;
            this._giftList = new Array();
            for each (gift in g.gift)
            {
                this._giftList.push(gift);
            };
            this.btn_assignAllgifts.disabled = true;
            this.updateGifts();
        }

        public function unload():void
        {
            this.uiApi.unloadUi("itemBox");
            this.uiApi.unloadUi("itemRecipes");
            this.uiApi.unloadUi("itemsSet");
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var buttonArray:Array;
            this.sysApi.log(2, ("onSelectItem " + target.name));
            switch (target)
            {
                case this.gd_character_select:
                    this._characterSelected = true;
                    for each (buttonArray in this._btnAcceptGiftList)
                    {
                        buttonArray[0].softDisabled = false;
                    };
                    this.btn_assignAllgifts.disabled = false;
                    break;
            };
        }

        private function updateGifts():void
        {
            if ((((this._giftList.length == 0)) && (this.uiApi.getUi("giftMenu"))))
            {
                this.uiApi.unloadUi("giftMenu");
            };
            this.gd_gifts.dataProvider = this._giftList;
        }

        public function updateGiftLine(data:*, compRef:*, selected:Boolean):void
        {
            if (data)
            {
                compRef.lbl_giftName.text = data.title;
                compRef.gd_items_slot.dataProvider = data.items;
                if (!(this._btnAcceptGiftList[compRef.btn_acceptOne.name]))
                {
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_RELEASE);
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_ROLL_OVER);
                    this.uiApi.addComponentHook(compRef.btn_acceptOne, ComponentHookList.ON_ROLL_OUT);
                };
                this._btnAcceptGiftList[compRef.btn_acceptOne.name] = [compRef.btn_acceptOne, data.uid];
                compRef.btn_acceptOne.softDisabled = !(this._characterSelected);
                compRef.ctr_gift.visible = true;
            }
            else
            {
                compRef.ctr_gift.visible = false;
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_assignAllgifts:
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.connection.assignAllGiftConfirmationPopupText", this.gd_character_select.selectedItem.name), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirm]);
                    break;
                case this.btn_not_now:
                    if (this.uiApi.getUi("giftMenu"))
                    {
                        this.uiApi.unloadUi(this.uiApi.me().name);
                    };
                    break;
                default:
                    if (target.name.indexOf("btn_acceptOne") != -1)
                    {
                        this.sysApi.sendAction(new GiftAssignRequest(this._btnAcceptGiftList[target.name][1], this.gd_character_select.selectedItem.id));
                    };
            };
        }

        public function onRollOver(target:Object):void
        {
            var text:String;
            var pos:Object = {
                "point":LocationEnum.POINT_BOTTOM,
                "relativePoint":LocationEnum.POINT_TOP
            };
            if (target.name.indexOf("btn_acceptOne") != -1)
            {
                if (this.gd_character_select.selectedIndex)
                {
                    text = this.uiApi.getText("ui.connection.getGift", this.gd_character_select.selectedItem.name);
                }
                else
                {
                    text = this.uiApi.getText("ui.connection.selectedCharacterNeeded");
                };
            };
            if (text)
            {
                this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text), target, false, "standard", pos.point, pos.relativePoint, 3, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            var itemTooltipSettings:ItemTooltipSettings;
            var tooltipData:*;
            if (item.data)
            {
                itemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
                if (!(itemTooltipSettings))
                {
                    itemTooltipSettings = this.tooltipApi.createItemSettings();
                    this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, true);
                };
                tooltipData = item.data;
                if (((((((((!(itemTooltipSettings.header)) && (!(itemTooltipSettings.conditions)))) && (!(itemTooltipSettings.effects)))) && (!(itemTooltipSettings.description)))) && (!(itemTooltipSettings.averagePrice))))
                {
                    tooltipData = item.data.name;
                };
                this.uiApi.showTooltip(item.data, item.container, false, "standard", 8, 0, 0, "itemName", null, {}, "ItemInfo", false, 4, 1, "giftMenu");
            };
        }

        public function onShortcut(s:String):Boolean
        {
            return (true);
        }

        public function onConfirm():void
        {
            var gift:Object;
            for each (gift in this._giftList)
            {
                this.sysApi.sendAction(new GiftAssignRequest(gift.uid, this.gd_character_select.selectedItem.id));
            };
        }

        private function onGiftAssigned(giftId:uint):void
        {
            var indexToDelete:int;
            var gift:Object;
            for each (gift in this._giftList)
            {
                if (gift.uid == giftId)
                {
                    indexToDelete = this._giftList.indexOf(gift);
                    break;
                };
            };
            this._giftList.splice(indexToDelete, 1);
            if (this._giftList.length == 0)
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            }
            else
            {
                this.updateGifts();
            };
        }


    }
}//package ui

