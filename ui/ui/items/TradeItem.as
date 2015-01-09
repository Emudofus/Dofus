package ui.items
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.ContextMenuApi;
    import d2api.TooltipApi;
    import d2components.GraphicContainer;
    import d2components.Slot;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2hooks.AskExchangeMoveObject;
    import d2actions.ExchangeObjectMove;
    import d2utils.ItemTooltipSettings;
    import d2actions.*;
    import d2hooks.*;

    public class TradeItem 
    {

        public var output:Object;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var menuApi:ContextMenuApi;
        public var tooltipApi:TooltipApi;
        private var _grid:Object;
        private var _data;
        private var _selected:Boolean;
        private var _assetsUri:String;
        private var _objectToExchange:Object;
        public var mainCtr:GraphicContainer;
        public var slot_item:Slot;
        public var btn_item:ButtonContainer;
        public var lbl_ItemName:Label;
        public var tx_backgroundItem:Texture;


        public function main(oParam:Object=null):void
        {
            this._grid = oParam.grid;
            this._data = oParam.data;
            this._selected = oParam.selected;
            this._assetsUri = this.uiApi.me().uiModule.rootPath;
            if (this._grid.name == "gd_left")
            {
                this.slot_item.allowDrag = false;
            };
            var uiRoot:Object = this.uiApi.me();
            uiRoot.removeDropSource = this.removeDropSourceFunction;
            uiRoot.processDrop = this.processDropFunction;
            uiRoot.dropValidator = this.dropValidatorFunction;
            this.update(this._data, false);
        }

        public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object):Boolean
        {
            return (true);
        }

        public function removeDropSourceFunction(target:Object):void
        {
        }

        public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object):void
        {
            if (data.quantity > 1)
            {
                this._objectToExchange = data;
                this.modCommon.openQuantityPopup(1, data.quantity, data.quantity, this.onValidQty);
            }
            else
            {
                this.transfertObject(data.objectUID, 1);
            };
        }

        private function onValidQty(qty:Number):void
        {
            this.transfertObject(this._objectToExchange.objectUID, qty);
        }

        private function transfertObject(pObjectUID:uint, pQuantity:uint):void
        {
            this.sysApi.dispatchHook(AskExchangeMoveObject, pObjectUID, pQuantity);
            this.sysApi.sendAction(new ExchangeObjectMove(pObjectUID, pQuantity));
        }

        public function get data()
        {
            return (this._data);
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function update(data:*, selected:Boolean):void
        {
            var item:Object;
            if (data)
            {
                item = this.dataApi.getItem(data.objectGID);
                this.slot_item.data = data;
                this.btn_item.disabled = false;
                if (item.etheral)
                {
                    this.lbl_ItemName.cssClass = "itemetheral";
                };
                if (item.itemSetId != -1)
                {
                    this.lbl_ItemName.cssClass = "itemset";
                };
                this.lbl_ItemName.text = this.dataApi.getItemName(data.objectGID);
            }
            else
            {
                this.lbl_ItemName.text = "";
                this.slot_item.data = null;
                this.btn_item.disabled = true;
            };
            this._data = data;
        }

        public function select(b:Boolean):void
        {
        }

        public function onRollOver(target:Object):void
        {
            var _local_2:ItemTooltipSettings;
            switch (target)
            {
                case this.slot_item:
                    _local_2 = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
                    if (!(_local_2))
                    {
                        _local_2 = this.tooltipApi.createItemSettings();
                        this.sysApi.setData("itemTooltipSettings", _local_2, true);
                    };
                    this.uiApi.showTooltip(this._data, this.slot_item, false, "standard", 3, 3, 0, null, null, _local_2);
                    break;
            };
        }

        public function onRollOut(target:Object):void
        {
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target == this.slot_item)
            {
                data = target.data;
                contextMenu = this.menuApi.create(data);
                if (contextMenu.content.length > 0)
                {
                    this.modContextMenu.createContextMenu(contextMenu);
                };
            };
        }


    }
}//package ui.items

