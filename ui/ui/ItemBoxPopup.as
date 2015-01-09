package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2hooks.ShowObjectLinked;
    import d2enums.ShortcutHookListEnum;
    import d2hooks.*;
    import d2actions.*;

    public class ItemBoxPopup 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _item:Object;
        public var ctr_item:GraphicContainer;
        public var btn_close:ButtonContainer;


        public function main(pParam:Object=null):void
        {
            this.sysApi.addHook(ShowObjectLinked, this.onShowObjectLinked);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.updateItemBox(pParam.item);
        }

        public function unload():void
        {
            this.uiApi.unloadUi("itemBoxPop");
        }

        private function updateItemBox(item:Object=null):void
        {
            if (item != this._item)
            {
                this.modCommon.createItemBox("itemBoxPop", this.ctr_item, item);
                this._item = item;
            }
            else
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function onShowObjectLinked(pItem:Object=null):void
        {
            this.updateItemBox(pItem);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case ShortcutHookListEnum.CLOSE_UI:
                case ShortcutHookListEnum.VALID_UI:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    return (true);
            };
            return (false);
        }


    }
}//package ui

