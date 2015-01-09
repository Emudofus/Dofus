package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2components.ButtonContainer;
    import d2components.WebBrowser;
    import d2components.GraphicContainer;
    import d2enums.ShortcutHookListEnum;
    import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;
    import d2hooks.NumericWhoIs;
    import d2actions.*;
    import d2hooks.*;

    public class WebPortal 
    {

        private static var _lastDomain:int = -1;

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        public var btnClose:ButtonContainer;
        public var btnBigClose:ButtonContainer;
        public var browser:WebBrowser;
        public var mainCtr:GraphicContainer;
        public var bgCtr:GraphicContainer;
        public var bigCloseCtr:GraphicContainer;
        private var _domain:int = -1;
        private var _args:Object;
        private var _showBigClose:Boolean;


        public function main(arg:*):void
        {
            var accountId:uint;
            this.uiApi.addComponentHook(this.btnClose, "onRelease");
            this.uiApi.addComponentHook(this.browser, "onBrowserSessionTimeout");
            this.uiApi.addComponentHook(this.browser, "onBrowserDomReady");
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortcut);
            this.bgCtr.visible = false;
            this._domain = arg[0];
            this._showBigClose = arg[1];
            _lastDomain = this._domain;
            this._args = arg[2];
            if ((((((((((this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE)) && (this._args))) && ((this._args.length > 1)))) && ((this._args[0] == 0)))) && (this._args[1])))
            {
                accountId = this.sysApi.getAccountId(this._args[1]);
                if (!(accountId))
                {
                    this._args = [0, this._args[1]];
                    this.sysApi.addHook(NumericWhoIs, this.onAccountInfo);
                };
            };
            this.refreshPortal();
        }

        public function goTo(domain:int, showBigClose:Boolean, args:Array):void
        {
            this._domain = domain;
            this._showBigClose = showBigClose;
            _lastDomain = this._domain;
            this._args = args;
            this.refreshPortal();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btnClose:
                case this.btnBigClose:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            if (s == "closeUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
            if (s == "validUi")
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
            return (true);
        }

        public function onBrowserSessionTimeout(target:*):void
        {
            this.sysApi.refreshUrl(this.browser, this._domain);
        }

        public function onBrowserDomReady(target:*):void
        {
        }

        public function onAccountInfo(playerId:uint, accountId:uint):void
        {
            this._args[0] = accountId;
            this.refreshPortal();
        }

        private function refreshPortal():void
        {
            var webBrowser:WebBrowser = ((this.sysApi.isStreaming()) ? null : this.browser);
            if (this._showBigClose)
            {
                this.bigCloseCtr.visible = true;
            }
            else
            {
                this.bigCloseCtr.visible = false;
            };
            if (this._domain == WebLocationEnum.WEB_LOCATION_OGRINE)
            {
                this.sysApi.goToOgrinePortal(webBrowser);
            }
            else
            {
                if (this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX)
                {
                    this.sysApi.goToAnkaBoxPortal(webBrowser);
                }
                else
                {
                    if (this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_LAST_UNREAD)
                    {
                        this.sysApi.goToAnkaBoxLastMessage(webBrowser);
                    }
                    else
                    {
                        if (this._domain == WebLocationEnum.WEB_LOCATION_ANKABOX_SEND_MESSAGE)
                        {
                            if (this._args)
                            {
                                if (this._args[0])
                                {
                                    this.sysApi.goToAnkaBoxSend(webBrowser, uint(this._args[0]));
                                }
                                else
                                {
                                    this.sysApi.goToAnkaBoxPortal(webBrowser);
                                };
                            };
                        };
                    };
                };
            };
            if (!(webBrowser))
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }


    }
}//package ui

