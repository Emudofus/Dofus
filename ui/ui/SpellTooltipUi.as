package ui
{
    import d2api.SystemApi;
    import d2api.TooltipApi;
    import d2api.UiApi;
    import flash.utils.Timer;
    import d2components.GraphicContainer;
    import d2components.Label;
    import flash.events.TimerEvent;
    import makers.SpellTooltipMaker;
    import flash.filters.GlowFilter;
    import d2hooks.*;

    public class SpellTooltipUi 
    {

        public var sysApi:SystemApi;
        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        private var _skip:Boolean = true;
        private var _timerHide:Timer;
        public var backgroundCtr:GraphicContainer;
        public var mainCtr:GraphicContainer;
        public var lbl_text:Label;


        public function main(oParam:Object=null):void
        {
            if (oParam.autoHide)
            {
                this._timerHide = new Timer(2500);
                this._timerHide.addEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.start();
            };
            if (SpellTooltipMaker.SPELL_TAB_MODE)
            {
                SpellTooltipMaker.SPELL_TAB_MODE = false;
                if (this.uiApi.getUi("spellTab"))
                {
                    this.uiApi.getUi("spellTab").getElement("toolTipContainer").addContent(this.uiApi.me());
                }
                else
                {
                    if (this.uiApi.getUi("companionTab"))
                    {
                        this.uiApi.getUi("companionTab").getElement("ctr_spellTooltip").addContent(this.uiApi.me());
                    };
                };
            };
            if (this.uiApi.me().name == "tooltip_Hyperlink")
            {
                this.uiApi.addComponentHook(this.mainCtr, "onRelease");
                this.uiApi.addComponentHook(this.mainCtr, "onRollOver");
                this.uiApi.addComponentHook(this.mainCtr, "onRollOut");
                this.mainCtr.buttonMode = true;
                this.mainCtr.useHandCursor = true;
            };
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
        }

        public function onRelease(target:Object):void
        {
            this.uiApi.hideTooltip("close_tooltip");
            this.uiApi.hideTooltip(this.uiApi.me().name);
        }

        public function onRollOver(target:Object):void
        {
            this.backgroundCtr.filters = new Array(new GlowFilter(15822352, 1, 5, 5, 2, 3));
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.close")), target, false, "close_tooltip", 7, 1, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.backgroundCtr.filters = new Array();
            this.uiApi.hideTooltip("close_tooltip");
        }

        private function onTimer(e:TimerEvent):void
        {
            this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this.uiApi.hideTooltip(this.uiApi.me().name);
        }

        public function unload():void
        {
            if (this._timerHide)
            {
                this._timerHide.removeEventListener(TimerEvent.TIMER, this.onTimer);
                this._timerHide.stop();
                this._timerHide = null;
            };
        }


    }
}//package ui

