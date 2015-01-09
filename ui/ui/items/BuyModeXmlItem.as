package ui.items
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.ContextMenuApi;
    import d2api.TooltipApi;
    import d2components.Slot;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2utils.ItemTooltipSettings;

    public class BuyModeXmlItem 
    {

        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        public var menuApi:ContextMenuApi;
        public var tooltipApi:TooltipApi;
        private var _grid:Object;
        private var _data;
        private var _item:Object;
        private var _selectedQuantity:int = 1;
        public var slot_icon:Slot;
        public var btn_q1:ButtonContainer;
        public var btn_q2:ButtonContainer;
        public var btn_q3:ButtonContainer;
        public var lbl_q1:Label;
        public var lbl_q2:Label;
        public var lbl_q3:Label;


        public function main(oParam:Object=null):void
        {
            this._grid = oParam.grid;
            this._data = oParam.data;
            this.slot_icon.allowDrag = false;
            this.uiApi.addComponentHook(this.btn_q1, "onRelease");
            this.uiApi.addComponentHook(this.btn_q2, "onRelease");
            this.uiApi.addComponentHook(this.btn_q3, "onRelease");
            this.uiApi.addComponentHook(this.slot_icon, "onRelease");
            this.update(this._data, false);
        }

        public function unload():void
        {
        }

        public function get data()
        {
            return (this._data);
        }

        public function update(data:*, selected:Boolean):void
        {
            var currentCase:int;
            this._data = data;
            if (data != null)
            {
                this._item = data.itemWrapper;
                this.slot_icon.data = this._item;
                if ((((data.prices.length == 0)) || ((data.prices[0] <= 0))))
                {
                    this.lbl_q1.text = "-";
                    this.btn_q1.disabled = true;
                    this.btn_q1.selected = false;
                    this.lbl_q1.cssClass = "center";
                }
                else
                {
                    this.lbl_q1.text = this.utilApi.kamasToString(data.prices[0]);
                    this.btn_q1.disabled = false;
                };
                if ((((data.prices.length < 2)) || ((data.prices[1] <= 0))))
                {
                    this.lbl_q2.text = "-";
                    this.btn_q2.disabled = true;
                    this.btn_q2.selected = false;
                    this.lbl_q2.cssClass = "center";
                }
                else
                {
                    this.lbl_q2.text = this.utilApi.kamasToString(data.prices[1]);
                    this.btn_q2.disabled = false;
                };
                if ((((data.prices.length < 3)) || ((data.prices[2] <= 0))))
                {
                    this.lbl_q3.text = "-";
                    this.btn_q3.disabled = true;
                    this.btn_q3.selected = false;
                    this.lbl_q3.cssClass = "center";
                }
                else
                {
                    this.lbl_q3.text = this.utilApi.kamasToString(data.prices[2]);
                    this.btn_q3.disabled = false;
                };
                if (selected)
                {
                    currentCase = this.uiApi.getUi("itemBidHouseBuy").uiClass.currentCase;
                    if (currentCase >= 0)
                    {
                        this.onSelectedItem(this[("btn_q" + (currentCase + 1))]);
                    };
                }
                else
                {
                    this.btn_q1.selected = false;
                    this.btn_q2.selected = false;
                    this.btn_q3.selected = false;
                    this.lbl_q1.cssClass = "center";
                    this.lbl_q2.cssClass = "center";
                    this.lbl_q3.cssClass = "center";
                };
            }
            else
            {
                this.btn_q1.selected = false;
                this.btn_q2.selected = false;
                this.btn_q3.selected = false;
                this.btn_q1.disabled = true;
                this.btn_q2.disabled = true;
                this.btn_q3.disabled = true;
                this.slot_icon.data = null;
                this.lbl_q1.text = "";
                this.lbl_q2.text = "";
                this.lbl_q3.text = "";
                this.lbl_q1.cssClass = "center";
                this.lbl_q2.cssClass = "center";
                this.lbl_q3.cssClass = "center";
            };
        }

        private function onSelectedItem(target:Object):void
        {
            if (target == this.btn_q1)
            {
                this._selectedQuantity = 1;
                this.btn_q1.selected = true;
                this.btn_q2.selected = false;
                this.btn_q3.selected = false;
                this.btn_q1.state = this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED;
                this.lbl_q1.cssClass = "darkcenter";
                this.lbl_q2.cssClass = "center";
                this.lbl_q3.cssClass = "center";
                this.uiApi.getUi("itemBidHouseBuy").uiClass.currentCase = 0;
                this.uiApi.getUi("itemBidHouseBuy").uiClass.btn_buy.disabled = false;
            }
            else
            {
                if (target == this.btn_q2)
                {
                    this._selectedQuantity = 2;
                    this.btn_q1.selected = false;
                    this.btn_q2.selected = true;
                    this.btn_q3.selected = false;
                    this.btn_q2.state = this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED;
                    this.lbl_q1.cssClass = "center";
                    this.lbl_q2.cssClass = "darkcenter";
                    this.lbl_q3.cssClass = "center";
                    this.uiApi.getUi("itemBidHouseBuy").uiClass.currentCase = 1;
                    this.uiApi.getUi("itemBidHouseBuy").uiClass.btn_buy.disabled = false;
                }
                else
                {
                    if (target == this.btn_q3)
                    {
                        this._selectedQuantity = 3;
                        this.btn_q1.selected = false;
                        this.btn_q2.selected = false;
                        this.btn_q3.selected = true;
                        this.btn_q3.state = this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED;
                        this.lbl_q1.cssClass = "center";
                        this.lbl_q2.cssClass = "center";
                        this.lbl_q3.cssClass = "darkcenter";
                        this.uiApi.getUi("itemBidHouseBuy").uiClass.currentCase = 2;
                        this.uiApi.getUi("itemBidHouseBuy").uiClass.btn_buy.disabled = false;
                    }
                    else
                    {
                        this.uiApi.getUi("itemBidHouseBuy").uiClass.btn_buy.disabled = true;
                    };
                };
            };
        }

        public function onRelease(target:Object):void
        {
            if ((((target == this.slot_icon)) && ((this.data.prices.length > 0))))
            {
                if (this.data.prices[0] > 0)
                {
                    target = this.btn_q1;
                }
                else
                {
                    if (this.data.prices[1] > 0)
                    {
                        target = this.btn_q2;
                    }
                    else
                    {
                        if (this.data.prices[2] > 0)
                        {
                            target = this.btn_q3;
                        };
                    };
                };
            };
            this.onSelectedItem(target);
        }

        public function onRollOver(target:Object):void
        {
            var itemTooltipSettings:ItemTooltipSettings;
            if (target == this.slot_icon)
            {
                if (this.sysApi.getOption("displayTooltips", "dofus"))
                {
                    itemTooltipSettings = (this.sysApi.getData("itemTooltipSettings", true) as ItemTooltipSettings);
                    if (!(itemTooltipSettings))
                    {
                        itemTooltipSettings = this.tooltipApi.createItemSettings();
                        this.sysApi.setData("itemTooltipSettings", itemTooltipSettings, true);
                    };
                    this.uiApi.showTooltip(this._item, this.slot_icon, false, "standard", 8, 0, 0, null, null, itemTooltipSettings);
                };
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRightClick(target:Object):void
        {
            var data:Object;
            var contextMenu:Object;
            if (target == this.slot_icon)
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

