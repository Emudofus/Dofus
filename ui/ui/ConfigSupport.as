package ui
{
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2enums.ComponentHookList;
    import types.ConfigProperty;

    public class ConfigSupport extends ConfigUi 
    {

        public var btnGotoSupport:ButtonContainer;
        public var btnBugReport:ButtonContainer;
        public var btn_allowLog:ButtonContainer;
        public var btn_allowDebug:ButtonContainer;
        public var lbl_infoDebug:Label;


        public function main(arg:*):void
        {
            uiApi.addComponentHook(this.btnGotoSupport, ComponentHookList.ON_RELEASE);
            if (sysApi.getCurrentLanguage() == "fr")
            {
                uiApi.addComponentHook(this.btnBugReport, ComponentHookList.ON_RELEASE);
            }
            else
            {
                this.btnBugReport.disabled = true;
            };
            var properties:Array = new Array();
            properties.push(new ConfigProperty("btn_allowLog", "allowLog", "dofus"));
            properties.push(new ConfigProperty("btn_allowDebug", "allowDebug", "dofus"));
            init(properties);
            showDefaultBtn(false);
            var os:String = sysApi.getOs();
            var bugReportKey:String = (((os == "Mac OS")) ? "F1" : "F11");
            var isInDebugMode:Boolean = configApi.getDebugMode();
            this.lbl_infoDebug.text = uiApi.getText("ui.option.debugMode.info", bugReportKey);
            setProperty("dofus", "allowDebug", isInDebugMode);
            this.btn_allowDebug.selected = isInDebugMode;
            uiApi.addComponentHook(this.btn_allowDebug, ComponentHookList.ON_RELEASE);
            if (configApi.debugFileExists())
            {
                this.btn_allowDebug.softDisabled = true;
                uiApi.addComponentHook(this.btn_allowDebug, ComponentHookList.ON_ROLL_OVER);
                uiApi.addComponentHook(this.btn_allowDebug, ComponentHookList.ON_ROLL_OUT);
            };
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnGotoSupport:
                    sysApi.goToUrl(uiApi.getText("ui.link.support"));
                    break;
                case this.btnBugReport:
                    sysApi.goToUrl(uiApi.getText("ui.link.betaReport"));
                    break;
                case this.btn_allowDebug:
                    configApi.setConfigProperty("dofus", "allowDebug", this.btn_allowDebug.selected);
                    configApi.setDebugMode(this.btn_allowDebug.selected);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.option.debugMode.hasFile")), target, false, "standard", 5, 3, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }


    }
}//package ui

