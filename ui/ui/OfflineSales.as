package ui
{
    import d2api.SystemApi;
    import d2api.SoundApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2components.Grid;
    import flash.utils.Dictionary;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2enums.ShortcutHookListEnum;
    import d2data.OfflineSaleWrapper;

    public class OfflineSales 
    {

        public var sysApi:SystemApi;
        public var soundApi:SoundApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        public var lbl_title:Label;
        public var btn_close:ButtonContainer;
        public var gd_sales:Grid;
        public var btn_sortItemIndex:ButtonContainer;
        public var lbl_sortItemIndex:Label;
        public var btn_sortItemName:ButtonContainer;
        public var lbl_sortItemName:Label;
        public var btn_sortItemQuantity:ButtonContainer;
        public var lbl_sortItemQuantity:Label;
        public var btn_sortItemKamas:ButtonContainer;
        public var lbl_sortItemKamas:Label;
        public var btn_sortSaleType:ButtonContainer;
        public var lbl_sortSaleType:Label;
        public var lbl_total_quantity:Label;
        public var lbl_total_sales:Label;
        public var lbl_total_kamas:Label;
        public var lbl_total_kamas_value:Label;
        private var _sales:Object;
        private var _salesDescending:Object;
        private var _ascendingSort:Boolean;
        private var _sortFieldAssoc:Dictionary;
        private var _lastSortType:String;

        public function OfflineSales()
        {
            this._sortFieldAssoc = new Dictionary();
            super();
        }

        public function main(pParams:Object):void
        {
            var totalQuantity:uint;
            var offlineSale:Object;
            this.lbl_title.text = this.uiApi.getText("ui.sell.offlineSales.title");
            this.lbl_sortItemIndex.text = this.uiApi.getText("ui.sell.offlineSales.order");
            this.lbl_sortItemName.text = this.uiApi.getText("ui.sell.offlineSales.itemName");
            this.lbl_sortItemQuantity.text = this.uiApi.getText("ui.common.quantity");
            this.lbl_sortItemKamas.text = this.uiApi.getText("ui.common.kamas");
            this.lbl_sortSaleType.text = this.uiApi.getText("ui.sell.offlineSales.saleType");
            this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
            this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
            this._sortFieldAssoc[this.btn_sortItemName] = "itemName";
            this._sortFieldAssoc[this.btn_sortItemQuantity] = "quantity";
            this._sortFieldAssoc[this.btn_sortItemKamas] = "kamas";
            this._sortFieldAssoc[this.btn_sortSaleType] = "type";
            this._ascendingSort = true;
            this._sales = pParams;
            this._salesDescending = this._sales.concat().reverse();
            this.gd_sales.dataProvider = this._sales;
            var totalSales:uint = this._sales.length;
            var totalKamas:Number = 0;
            for each (offlineSale in this._sales)
            {
                totalQuantity = (totalQuantity + offlineSale.quantity);
                totalKamas = (totalKamas + offlineSale.kamas);
            };
            this.lbl_total_quantity.text = this.uiApi.getText("ui.sell.offlineSales.nbSoldItems", totalQuantity);
            this.lbl_total_sales.text = this.uiApi.getText("ui.sell.offlineSales.nbSoldLots", totalSales);
            this.lbl_total_kamas.text = this.uiApi.getText("ui.sell.offlineSales.nbTotalKamas");
            this.lbl_total_kamas_value.text = this.utilApi.kamasToString(totalKamas, "");
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onCloseUi);
        }

        public function updateSaleLine(offlineSale:OfflineSaleWrapper, components:*, selected:Boolean):void
        {
            if (offlineSale)
            {
                components.lbl_item_index.text = (this.utilApi.getSecureObjectIndex(this._sales, offlineSale) + 1);
                components.lbl_item_name.text = (((("{item," + offlineSale.itemId) + "::") + offlineSale.itemName) + "}");
                components.lbl_item_quantity.text = offlineSale.quantity;
                components.lbl_kamas.text = this.utilApi.kamasToString(offlineSale.kamas, "");
                components.lbl_sale_type.text = (((offlineSale.type == 1)) ? this.uiApi.getText("ui.sell.offlineSales.bidHouse") : this.uiApi.getText("ui.common.shop"));
            }
            else
            {
                components.lbl_item_index.text = "";
                components.lbl_item_name.text = "";
                components.lbl_item_quantity.text = "";
                components.lbl_kamas.text = "";
                components.lbl_sale_type.text = "";
            };
        }

        public function onRelease(pTarget:Object):void
        {
            var sortType:String;
            switch (pTarget)
            {
                case this.btn_close:
                    this.onCloseUi(null);
                    break;
                case this.btn_sortItemIndex:
                    sortType = "itemIndex";
                    this._ascendingSort = ((((this._lastSortType) && (!((sortType == this._lastSortType))))) ? true : !(this._ascendingSort));
                    this.gd_sales.dataProvider = ((this._ascendingSort) ? this._sales : this._salesDescending);
                    this._lastSortType = sortType;
                    break;
                case this.btn_sortItemName:
                case this.btn_sortItemQuantity:
                case this.btn_sortItemKamas:
                case this.btn_sortSaleType:
                    sortType = this._sortFieldAssoc[pTarget];
                    this._ascendingSort = ((!((sortType == this._lastSortType))) ? true : !(this._ascendingSort));
                    this.gd_sales.dataProvider = this.utilApi.sort(this.gd_sales.dataProvider, sortType, this._ascendingSort, !((sortType == "itemName")));
                    this._lastSortType = sortType;
                    break;
            };
        }

        public function onCloseUi(pShortCut:String):Boolean
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return (true);
        }

        public function unload():void
        {
        }


    }
}//package ui

