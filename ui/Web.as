package 
{
   import flash.display.Sprite;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.PlayedCharacterApi;
   import ui.WebShop;
   import d2enums.DofusShopEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.StrataEnum;
   
   public class Web extends Sprite
   {
      
      public function Web() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var modCommon:Object;
      
      public var playerApi:PlayedCharacterApi;
      
      private var include_webShop:WebShop = null;
      
      private var _ogrins:int = -1;
      
      private var _krozs:int = -1;
      
      public function main() : void {
         this.sysApi.addHook(DofusShopMoney,this.onDofusShopMoney);
         this.sysApi.addHook(DofusShopHome,this.onDofusShopHome);
         this.sysApi.addHook(DofusShopError,this.onDofusShopError);
      }
      
      private function onDofusShopError(errorId:String) : void {
         if("error_" + errorId == DofusShopEnum.ERROR_AUTHENTICATION_FAILED)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),"Impossible de se connecter au shop. (ted)",[this.uiApi.getText("ui.common.ok")]);
         }
         else if("error_" + errorId == DofusShopEnum.ERROR_REQUEST_TIMED_OUT)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),"Le shop met trop de temps à répondre. (ted)",[this.uiApi.getText("ui.common.ok")]);
         }
         
      }
      
      private function onDofusShopMoney(ogrins:int, krozs:int) : void {
         this._ogrins = ogrins;
         this._krozs = krozs;
      }
      
      private function onDofusShopHome(categories:Object, gondolahead_article:Object, gondolahead_main:Object, highlight_carousel:Object, highlight_image:Object) : void {
         if(!this.uiApi.getUi("webShop"))
         {
            this.uiApi.loadUi("webShop","webShop",
               {
                  "ogrins":this._ogrins,
                  "krozs":this._krozs,
                  "categories":categories,
                  "frontDisplayArticles":gondolahead_article,
                  "frontDisplayMains":gondolahead_main,
                  "highlightCarousels":highlight_carousel,
                  "highlightImages":highlight_image
               },StrataEnum.STRATA_HIGH);
         }
      }
   }
}
