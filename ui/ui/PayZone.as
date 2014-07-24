package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2hooks.*;
   import d2actions.*;
   
   public class PayZone extends Object
   {
      
      public function PayZone() {
         super();
      }
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var popupSubscrCtr:GraphicContainer;
      
      public var btn_padlock:ButtonContainer;
      
      public var btn_subscription:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var tx_bg:GraphicContainer;
      
      public function main(... args) : void {
         this.sysApi.addHook(NonSubscriberPopup,this.onNonSubscriberPopup);
         this.sysApi.addHook(SubscriptionZone,this.onSubscriptionZone);
         this.sysApi.log(8,"go payzone");
         this.uiApi.addComponentHook(this.tx_bg,"onRollOver");
         this.uiApi.addComponentHook(this.tx_bg,"onRollOut");
         this.uiApi.addComponentHook(this.tx_bg,"onRelease");
         if(args[0])
         {
            this.showPopup(true);
            this.btn_padlock.visible = false;
         }
      }
      
      public function unload() : void {
      }
      
      private function showPopup(show:Boolean) : void {
         if(show)
         {
            this.popupSubscrCtr.visible = true;
         }
         else
         {
            this.popupSubscrCtr.visible = false;
         }
         this.uiApi.me().render();
      }
      
      public function onRelease(target:Object) : void {
         this.sysApi.log(8,"release sur " + target + " : " + target.name);
         switch(target)
         {
            case this.btn_close:
               this.popupSubscrCtr.visible = false;
               break;
            case this.btn_subscription:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.members"));
               this.popupSubscrCtr.visible = false;
               break;
            case this.btn_padlock:
               this.popupSubscrCtr.visible = true;
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
      }
      
      public function onRollOut(target:Object) : void {
      }
      
      public function onNonSubscriberPopup() : void {
         this.popupSubscrCtr.visible = true;
      }
      
      private function onSubscriptionZone(active:Boolean) : void {
         if(active)
         {
            this.btn_padlock.visible = true;
            this.popupSubscrCtr.visible = true;
         }
         else if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         
      }
   }
}
