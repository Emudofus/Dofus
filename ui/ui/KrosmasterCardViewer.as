package ui
{
   import d2enums.StrataEnum;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.TooltipApi;
   import d2components.Texture;
   import d2enums.ComponentHookList;
   import flash.geom.Point;
   
   public class KrosmasterCardViewer extends Object
   {
      
      public function KrosmasterCardViewer() {
         super();
      }
      
      private static const UI_NAME:String = "krosmasterCardViewer";
      
      public static function show(cardId:uint, placeTarget:*) : void {
         var mainParams:Object = 
            {
               "cardId":cardId,
               "placeTarget":placeTarget
            };
         if(API.uiApi.getUi(UI_NAME))
         {
            API.uiApi.getUi(UI_NAME).uiClass.main(
               {
                  "cardId":cardId,
                  "placeTarget":placeTarget
               });
         }
         else
         {
            API.uiApi.loadUi(UI_NAME,null,
               {
                  "cardId":cardId,
                  "placeTarget":placeTarget
               },StrataEnum.STRATA_TOOLTIP);
         }
      }
      
      public static function hide(destroy:Boolean = false) : void {
         if(destroy)
         {
            API.uiApi.unloadUi(UI_NAME);
         }
         else
         {
            API.uiApi.getUi(UI_NAME).visible = false;
         }
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var tooltipApi:TooltipApi;
      
      public var card:Texture;
      
      private var _placeTarget;
      
      public function main(args:Object) : void {
         this._placeTarget = args.placeTarget;
         var cardFileName:String = args.cardId.toString();
         while(cardFileName.length < 3)
         {
            cardFileName = "0" + cardFileName;
         }
         this.uiApi.addComponentHook(this.card,ComponentHookList.ON_TEXTURE_READY);
         this.card.dispatchMessages = true;
         var lang:String = this.sysApi.getCurrentLanguage();
         this.card.uri = this.uiApi.createUri(this.sysApi.getConfigEntry("config.gfx.path") + "krosmaster/cards/" + lang + "/" + cardFileName + "_i18n_front.png");
      }
      
      private function updateFromWindowsSize() : void {
         var r:Number = 1 / this.uiApi.getWindowScale();
         this.uiApi.me().scaleX = r;
         this.uiApi.me().scaleY = r;
      }
      
      public function onTextureReady(target:Texture) : void {
         this.uiApi.me().visible = true;
         this.updateFromWindowsSize();
         var targetRealPos:* = this._placeTarget.localToGlobal(new Point(this._placeTarget.x,this._placeTarget.y));
         var newX:int = targetRealPos.x - this.uiApi.me().width - 10;
         if(newX < 0)
         {
            newX = targetRealPos.x + this._placeTarget.width + 10;
         }
         var newY:int = this._placeTarget.y;
         if(newY + this.uiApi.me().height > this.uiApi.getStageHeight())
         {
            newY = this.uiApi.getStageHeight() - this.uiApi.me().height;
         }
         this.uiApi.me().x = newX;
         this.uiApi.me().y = newY;
      }
   }
}
