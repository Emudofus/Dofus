package ui
{
    import d2api.DataApi;
    import d2api.SoundApi;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2hooks.*;
    import d2actions.*;

    public class ConfigCache extends ConfigUi 
    {

        public var dataApi:DataApi;
        public var soundApi:SoundApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var btnSelectiveClearCache:ButtonContainer;
        public var btnCompleteClearCache:ButtonContainer;
        public var lbl_SelectiveClearCacheExplicativeText:Label;
        public var lbl_CompleteClearCacheExplicativeText:Label;


        public function main(args:*):void
        {
            uiApi.addComponentHook(this.btnSelectiveClearCache, "onRelease");
            uiApi.addComponentHook(this.btnCompleteClearCache, "onRelease");
            showDefaultBtn(false);
        }

        public function unload():void
        {
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnSelectiveClearCache:
                    this.modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.popup.clearCache"), [uiApi.getText("ui.common.ok"), uiApi.getText("ui.common.cancel")], [this.onSelectiveClearCache, this.onPopupClose], this.onSelectiveClearCache, this.onPopupClose);
                    break;
                case this.btnCompleteClearCache:
                    this.modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.popup.clearCache"), [uiApi.getText("ui.common.ok"), uiApi.getText("ui.common.cancel")], [this.onCompleteClearCache, this.onPopupClose], this.onCompleteClearCache, this.onPopupClose);
                    break;
            };
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
        }

        public function onRollOver(target:Object):void
        {
        }

        public function onRollOut(target:Object):void
        {
            uiApi.hideTooltip();
        }

        public function onSelectiveClearCache():void
        {
            sysApi.clearCache(true);
        }

        public function onCompleteClearCache():void
        {
            sysApi.clearCache(false);
        }

        private function onPopupClose():void
        {
        }


    }
}//package ui

