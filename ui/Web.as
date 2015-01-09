package 
{
    import flash.display.Sprite;
    import d2api.UiApi;
    import d2api.SystemApi;
    import ui.WebBase;
    import ui.WebShop;
    import ui.WebBak;
    import ui.WebVetRwds;
    import ui.WebLibrary;
    import ui.WebReader;
    import d2hooks.OpenWebService;
    import d2hooks.OpenComic;
    import d2enums.StrataEnum;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2hooks.*;
    import d2actions.*;

    public class Web extends Sprite 
    {

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var include_webBase:WebBase = null;
        private var include_webShop:WebShop = null;
        private var include_webBak:WebBak = null;
        private var include_webVetRwds:WebVetRwds = null;
        private var include_webLibrary:WebLibrary = null;
        private var include_webReader:WebReader = null;


        public function main():void
        {
            this.sysApi.addHook(OpenWebService, this.onOpenWebService);
            this.sysApi.addHook(OpenComic, this.onOpenComic);
        }

        private function onOpenWebService(uiName:String, uiParams:*):void
        {
            if (this.uiApi.getUi("webBase"))
            {
                if (((uiName) && (!((WebBase.currentTabUi == uiName)))))
                {
                    this.uiApi.getUi("webBase").uiClass.openTab(uiName, uiParams);
                }
                else
                {
                    this.uiApi.unloadUi("webBase");
                };
            }
            else
            {
                this.uiApi.loadUi("webBase", "webBase", [uiName, uiParams], StrataEnum.STRATA_HIGH);
                if (this.uiApi.getUi(UIEnum.GRIMOIRE))
                {
                    this.uiApi.unloadUi(UIEnum.GRIMOIRE);
                };
            };
        }

        private function onOpenComic(pComicRemoteId:String, pComicReaderUrl:String, pLanguage:String):void
        {
            var webReader:* = this.uiApi.getUi("webReader");
            var params:Object = {
                "remoteId":pComicRemoteId,
                "readerUrl":pComicReaderUrl,
                "language":pLanguage
            };
            if (webReader)
            {
                webReader.uiClass.main(params);
            }
            else
            {
                this.uiApi.loadUi("webReader", "webReader", params, StrataEnum.STRATA_TOP);
            };
        }


    }
}//package 

