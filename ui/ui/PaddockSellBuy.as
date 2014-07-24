package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.MountApi;
   import d2api.PlayedCharacterApi;
   import d2api.UtilApi;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2components.TextArea;
   import d2components.Input;
   import d2enums.ShortcutHookListEnum;
   import d2hooks.*;
   import d2actions.*;
   
   public class PaddockSellBuy extends Object
   {
      
      public function PaddockSellBuy() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var mountApi:MountApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var utilApi:UtilApi;
      
      public var modCommon:Object;
      
      private var _buyMode:Boolean;
      
      private var _price:uint;
      
      public var btn_close:ButtonContainer;
      
      public var btn_cancelSell:ButtonContainer;
      
      public var btn_ok:ButtonContainer;
      
      public var btn_lbl_btn_cancelSell:Label;
      
      public var lbl_title:Label;
      
      public var lbl_info:TextArea;
      
      public var lbl_input:Input;
      
      public var tx_input:Object;
      
      public function main(param:Object) : void {
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_ok,"onRelease");
         this.uiApi.addComponentHook(this.btn_cancelSell,"onRelease");
         this.sysApi.addHook(LeaveDialog,this.onLeaveDialog);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.lbl_input.restrictChars = "0-9";
         this.lbl_input.maxChars = 13;
         this._price = param.price;
         this._buyMode = !param.sellMode;
         if(this._buyMode)
         {
            this.lbl_title.text = this.uiApi.getText("ui.mount.paddockPurchase");
            this.lbl_input.text = this._price.toString();
            this.lbl_input.mouseChildren = false;
            this.btn_lbl_btn_cancelSell.text = this.uiApi.getText("ui.common.cancel");
         }
         else
         {
            this.lbl_title.text = this.uiApi.getText("ui.mount.paddockSell");
            this.lbl_input.text = this._price.toString();
            this.lbl_input.focus();
            this.btn_cancelSell.visible = true;
            this.btn_lbl_btn_cancelSell.text = this.uiApi.getText("ui.common.cancelTheSale");
         }
         var infos:Object = this.mountApi.getCurrentPaddock();
         this.lbl_info.text = this.uiApi.getText("ui.mount.paddockDescription",infos.maxOutdoorMount,infos.maxItems);
      }
      
      public function unload() : void {
      }
      
      private function onConfirmBuy() : void {
         this.sysApi.sendAction(new PaddockBuyRequest());
      }
      
      private function onConfirmSell() : void {
         this.sysApi.sendAction(new PaddockSellRequest(this.utilApi.stringToKamas(this.lbl_input.text,"")));
      }
      
      private function onCancelBuy() : void {
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_close)
         {
            this.sysApi.sendAction(new LeaveExchangeMount());
         }
         else if(target == this.btn_ok)
         {
            if(this._buyMode)
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.mount.paddockPurchase"),this.uiApi.getText("ui.mount.doUBuyPaddock",this.utilApi.kamasToString(this._price)),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmBuy,this.onCancelBuy],this.onConfirmBuy,this.onCancelBuy);
            }
            else
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.mount.paddockSell"),this.uiApi.getText("ui.mount.doUSellPaddock",this.utilApi.kamasToString(this.utilApi.stringToKamas(this.lbl_input.text,""))),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmSell,this.onCancelBuy],this.onConfirmSell,this.onCancelBuy);
            }
         }
         else if(target == this.btn_cancelSell)
         {
            if(this._buyMode)
            {
               this.sysApi.sendAction(new LeaveExchangeMount());
            }
            else
            {
               this.sysApi.sendAction(new PaddockSellRequest(0));
            }
         }
         
         
      }
      
      private function onShortCut(s:String) : Boolean {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            this.sysApi.sendAction(new LeaveExchangeMount());
            return true;
         }
         return false;
      }
      
      private function onLeaveDialog() : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
