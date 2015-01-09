package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.ConfigApi;
    import d2components.WebBrowser;
    import com.ankamagames.dofusModuleLibrary.enum.WebLocationEnum;

    public class WebBak 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var configApi:ConfigApi;
        private var _domain:int = -1;
        public var wb_ogrineBrowser:WebBrowser;


        public function main(oParam:Object=null):void
        {
            if (!(this.sysApi.isStreaming()))
            {
                this.uiApi.addComponentHook(this.wb_ogrineBrowser, "onBrowserSessionTimeout");
                this.uiApi.addComponentHook(this.wb_ogrineBrowser, "onBrowserDomReady");
                this._domain = WebLocationEnum.WEB_LOCATION_OGRINE;
                this.sysApi.goToOgrinePortal(this.wb_ogrineBrowser);
            }
            else
            {
                this.uiApi.setFullScreen(false);
                this.configApi.setConfigProperty("dofus", "fullScreen", false);
                this.sysApi.openWebModalOgrinePortal(this.goToShopArticle);
            };
        }

        public function goToShopArticle(pArticleId:uint=0, pCategoryId:uint=0, pPage:uint=0):String
        {
            try
            {
                if (((((!(pArticleId)) || (!(pCategoryId)))) || (!(pPage))))
                {
                    this.sysApi.log(4, "goToShopArticle() is missing at least one valid argument");
                    return ("invalid argument(s)");
                };
                this.uiApi.getUi("webBase").uiClass.openTab("webShop", {
                    "articleId":pArticleId,
                    "categoryId":pCategoryId,
                    "page":pPage
                });
                return ("success");
            }
            catch(error:Error)
            {
                return (error.message);
            };
            return ("unknown error");
        }

        public function onBrowserDomReady(target:*):void
        {
            this.wb_ogrineBrowser.javascriptSetVar("window.goToShopArticle", this.goToShopArticle);
        }

        public function onBrowserSessionTimeout(target:*):void
        {
            this.sysApi.refreshUrl(this.wb_ogrineBrowser, this._domain);
        }


    }
}//package ui

