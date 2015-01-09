package ui
{
    import flash.utils.Timer;
    import d2api.SystemApi;
    import d2api.TooltipApi;
    import d2api.ContextMenuApi;
    import d2api.UiApi;
    import d2api.AveragePricesApi;
    import d2api.UtilApi;
    import d2data.Item;
    import flash.events.TimerEvent;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.tooltip.LocationEnum;
    import d2hooks.*;

    public class ItemNameTooltipUi 
    {

        private static var _shortcutColor:String;

        private var _timerHide:Timer;
        private var _skip:Boolean = true;
        [Module(name="Ankama_ContextMenu")]
        public var modContextMenu:Object;
        public var sysApi:SystemApi;
        public var tooltipApi:TooltipApi;
        public var menuApi:ContextMenuApi;
        public var uiApi:UiApi;
        public var averagePricesApi:AveragePricesApi;
        public var utilApi:UtilApi;
        public var backgroundCtr:Object;
        public var lbl_content:Object;
        private var _itemWrapper:Object;
        private var _shortcutKey:String;
        private var _timerShowItemTooltip:Timer;
        private var _param:Object;
        private var _alwaysShowTooltipModuleException:Array;

        public function ItemNameTooltipUi()
        {
            this._alwaysShowTooltipModuleException = ["giftMenu"];
            super();
        }

        public function main(oParam:Object=null):void
        {
            var item:Object;
            var delay:int;
            if (!(_shortcutColor))
            {
                _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                _shortcutColor = _shortcutColor.replace("0x", "#");
            };
            if (((!((oParam.data == null))) && ((oParam.data is Item))))
            {
                this._itemWrapper = oParam.data;
                item = Api.data.getItem(this._itemWrapper.objectGID);
                this.lbl_content.text = this._itemWrapper.name;
            }
            else
            {
                this._itemWrapper = oParam.data.itemWrapper;
                this._shortcutKey = oParam.data.shortcutKey;
                this.lbl_content.text = (((((this._itemWrapper.name + " <font color='") + _shortcutColor) + "'>(") + this._shortcutKey) + ")</font>");
            };
            this._param = oParam;
            var displayItemToolTip:Boolean = ((((oParam.makerParam.hasOwnProperty("nameOnly")) && (!(oParam.makerParam.nameOnly)))) || (((((!(oParam.makerParam.hasOwnProperty("nameOnly"))) && (Api.system.getOption("displayTooltips", "dofus")))) || (!((this._alwaysShowTooltipModuleException.indexOf(oParam.tooltip.uiModuleName) == -1))))));
            if (((((this.sysApi.isInGame()) && (!(displayItemToolTip)))) && (this._itemWrapper.exchangeable)))
            {
                this.lbl_content.appendText(this.averagePricesApi.getItemAveragePriceString(this._itemWrapper));
            };
            this.lbl_content.multiline = true;
            this.lbl_content.wordWrap = false;
            this.lbl_content.fullWidth();
            this.backgroundCtr.width = (this.lbl_content.textfield.width + 12);
            this.backgroundCtr.height = this.lbl_content.textfield.height;
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
            if (displayItemToolTip)
            {
                delay = this.sysApi.getOption("largeTooltipDelay", "dofus");
                this._timerShowItemTooltip = new Timer(delay, 1);
                this._timerShowItemTooltip.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowItemTooltip.start();
            };
        }

        private function onTimer(e:TimerEvent):void
        {
            if (!(this._timerShowItemTooltip))
            {
                return;
            };
            this._timerShowItemTooltip.stop();
            this._timerShowItemTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this._timerShowItemTooltip = null;
            this.uiApi.showTooltip(this._itemWrapper, ((!((this._param.makerParam.ref == null))) ? this._param.makerParam.ref : this._param.position), false, "standard", LocationEnum.POINT_BOTTOMLEFT, LocationEnum.POINT_BOTTOMRIGHT, 3, null, null, this._param.makerParam);
        }

        public function unload():void
        {
            if (this._timerShowItemTooltip)
            {
                this._timerShowItemTooltip.stop();
                this._timerShowItemTooltip.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerShowItemTooltip = null;
            };
        }


    }
}//package ui

