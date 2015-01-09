package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2components.ButtonContainer;

    public class BetaMenu 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var btn_beta:ButtonContainer;


        public function main(... args):void
        {
            this.uiApi.addComponentHook(this.btn_beta, "onRelease");
            this.uiApi.addComponentHook(this.btn_beta, "onRollOver");
            this.uiApi.addComponentHook(this.btn_beta, "onRollOut");
        }

        public function onRelease(target:Object):void
        {
            this.sysApi.goToUrl(this.uiApi.getText("ui.link.betaReport"));
        }

        public function onRollOver(target:Object):void
        {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.bugReport")), target, false, "standard", 7, 1, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }


    }
}//package ui

