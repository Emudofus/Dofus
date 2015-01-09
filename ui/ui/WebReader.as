package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ConfigApi;
    import d2components.WebBrowser;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2enums.ComponentHookList;
    import d2hooks.ComicLoaded;
    import d2enums.ShortcutHookListEnum;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.net.URLRequest;
    import d2actions.LeaveDialogRequest;
    import d2actions.GetComicRequest;

    public class WebReader 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var configApi:ConfigApi;
        public var browser_reader:WebBrowser;
        public var ctr_fullscreenBg:GraphicContainer;
        public var ctr_main:GraphicContainer;
        public var ctr_btns:GraphicContainer;
        public var ctr_loading:GraphicContainer;
        public var btn_close:ButtonContainer;
        public var btn_fullScreen:ButtonContainer;
        public var lbl_title:Label;
        public var tx_btnsZone:Texture;
        private var _comicRemoteId:String;
        private var _comicLanguage:String;
        private var _callback:Function;


        public function main(oParam:Object=null):void
        {
            var bgColor:uint;
            this.uiApi.addComponentHook(this.browser_reader, "onBrowserDomReady");
            this.uiApi.addComponentHook(this.tx_btnsZone, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_btnsZone, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_fullScreen, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_fullScreen, ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_close, ComponentHookList.ON_ROLL_OUT);
            this.sysApi.showWorld(false);
            this.sysApi.addHook(ComicLoaded, this.onComicLoaded);
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.uiApi.addShortcutHook("toggleFullscreen", this.onShortcut);
            switch (this.configApi.getCurrentTheme())
            {
                case "dofus1":
                    bgColor = 14012330;
                    break;
                case "black":
                    bgColor = 3682348;
                    break;
            };
            var bgBmp:Bitmap = new Bitmap(new BitmapData(this.uiApi.getStageWidth(), this.uiApi.getStageHeight(), false, bgColor));
            this.ctr_fullscreenBg.addChild(bgBmp);
            this.ctr_fullscreenBg.visible = false;
            this.lbl_title.text = "";
            this.browser_reader.visible = false;
            this.ctr_loading.visible = true;
            if (oParam)
            {
                this._comicRemoteId = oParam.remoteId;
                this._comicLanguage = oParam.language;
                this.browser_reader.load(new URLRequest(oParam.readerUrl));
                this.browser_reader.focus();
            };
        }

        public function unload():void
        {
            if (!(this.ctr_main.visible))
            {
                this.toggleFullScreen();
            };
            this.sysApi.showWorld(true);
        }

        public function onRollOver(target:Object):void
        {
            if (!(this.ctr_main.visible))
            {
                this.ctr_btns.visible = true;
            };
        }

        public function onRollOut(target:Object):void
        {
            if (((!(this.ctr_main.visible)) && ((target == this.tx_btnsZone))))
            {
                this.ctr_btns.visible = false;
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_fullScreen:
                    this.toggleFullScreen();
                    break;
                case this.btn_close:
                    this.close();
                    break;
            };
        }

        public function close():void
        {
            this.sysApi.sendAction(new LeaveDialogRequest());
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        private function toggleFullScreen():void
        {
            if (this.ctr_main.visible)
            {
                this.ctr_fullscreenBg.visible = true;
                this.ctr_main.visible = false;
                this.browser_reader.x = 0;
                this.browser_reader.y = 0;
                this.browser_reader.height = this.uiApi.getStageHeight();
                this.browser_reader.width = this.uiApi.getStageWidth();
            }
            else
            {
                this.ctr_fullscreenBg.visible = false;
                this.ctr_main.visible = true;
                this.ctr_btns.visible = true;
                this.browser_reader.x = 12;
                this.browser_reader.y = 80;
                this.browser_reader.height = 788;
                this.browser_reader.width = 1258;
            };
            this.browser_reader.finalize();
        }

        public function onShortcut(pShortcut:String):Boolean
        {
            var _local_2:Boolean;
            switch (pShortcut)
            {
                case "closeUi":
                    this.close();
                    return (true);
                case "toggleFullscreen":
                    _local_2 = this.configApi.getConfigProperty("dofus", "fullScreen");
                    if (((this.sysApi.isStreaming()) && (_local_2)))
                    {
                        this.uiApi.setShortcutUsedToExitFullScreen(true);
                    };
                    this.configApi.setConfigProperty("dofus", "fullScreen", !(_local_2));
                    return (true);
            };
            return (false);
        }

        public function onBrowserDomReady(target:Object):void
        {
            this.browser_reader.javascriptSetVar("comicHost", {});
            this.browser_reader.javascriptSetVar("comicHost.getComic", this.getComic);
            this.browser_reader.javascriptSetVar("comicHost.logWrite", this.logWrite);
            this.browser_reader.javascriptCall("comicReader.setupLogger");
            this.browser_reader.javascriptCall("comicReader.setupReader", this.sysApi.getCurrentLanguage());
            if (this._comicRemoteId)
            {
                this.browser_reader.javascriptCall("comicReader.open", this._comicRemoteId, this._comicLanguage, "0", "0");
            };
        }

        public function onComicLoaded(pComicData:Object):void
        {
            this._callback(null, pComicData);
            this.lbl_title.text = ((pComicData.title + " - ") + pComicData.subtitle);
            this.ctr_loading.visible = false;
            this.browser_reader.visible = true;
        }

        private function getComic(comicId:String, language:String, previewOnly:Boolean, callback:Function):void
        {
            if (this._callback != null)
            {
                this._callback = callback;
                this.sysApi.sendAction(new GetComicRequest(comicId, language, previewOnly));
            };
        }

        private function logWrite(logLevel:String, logString:String):void
        {
        }


    }
}//package ui

