package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2api.PlayedCharacterApi;
   import d2components.GraphicContainer;
   import d2components.Input;
   import d2components.Label;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2enums.ComponentHookList;
   import d2data.ItemWrapper;
   
   public class BasicItemCard extends Object
   {
      
      public function BasicItemCard() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var utilApi:UtilApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var modCommon:Object;
      
      protected var _currentObject:Object;
      
      protected var _currentPrice:uint = 0;
      
      public var mainCtr:Object;
      
      public var ctr_item:GraphicContainer;
      
      public var ctr_inputQty:GraphicContainer;
      
      public var ctr_inputPrice:GraphicContainer;
      
      public var input_quantity:Input;
      
      public var input_price:Input;
      
      public var lbl_price:Label;
      
      public var lbl_totalPrice:Label;
      
      public var btn_lbl_btn_valid:Label;
      
      public var btn_valid:ButtonContainer;
      
      public var btn_remove:ButtonContainer;
      
      public var btn_modify:ButtonContainer;
      
      public function main(param:Object = null) : void {
         this.btn_valid.soundId = SoundEnum.STORE_SELL_BUTTON;
         this.btn_remove.soundId = SoundEnum.STORE_SELL_BUTTON;
         this.btn_modify.soundId = SoundEnum.STORE_SELL_BUTTON;
         this.uiApi.addComponentHook(this.input_quantity,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.input_price,ComponentHookList.ON_CHANGE);
         this.hideCard();
         this.input_quantity.maxChars = 9;
         this.input_quantity.restrictChars = "0-9";
         this.input_price.maxChars = 13;
         this.input_price.numberMax = 2000000000;
         this.input_price.restrictChars = "0-9  ";
         this.btn_modify.visible = false;
         this.btn_remove.visible = false;
      }
      
      public function get uiVisible() : Boolean {
         return this.uiApi.me().visible;
      }
      
      public function onRelease(target:Object) : void {
      }
      
      public function unload() : void {
         this.uiApi.unloadUi("itemBox_" + this.uiApi.me().name);
      }
      
      public function onChange(target:GraphicContainer) : void {
         var value:* = 0;
         if(target == this.input_price)
         {
            value = this.utilApi.stringToKamas(this.input_price.text,"");
            this.input_price.text = this.utilApi.kamasToString(value,"");
         }
         else if(target == this.input_quantity)
         {
            value = this.utilApi.stringToKamas(this.input_quantity.text,"");
            this.input_quantity.text = this.utilApi.kamasToString(value,"");
         }
         
      }
      
      protected function checkPlayerFund(quantity:int, token:int = 0) : void {
         var inventory:Object = null;
         var item:ItemWrapper = null;
         var playerFunds:int = 0;
         if(token == 0)
         {
            playerFunds = this.playerApi.characteristics().kamas;
         }
         else
         {
            inventory = this.playerApi.getInventory();
            for each(item in inventory)
            {
               if(item.objectGID == token)
               {
                  playerFunds = item.quantity;
                  break;
               }
            }
         }
         if(this._currentPrice * quantity > playerFunds)
         {
            this.lbl_totalPrice.cssClass = "rightred";
            this.btn_valid.disabled = true;
         }
         else
         {
            this.lbl_totalPrice.cssClass = "right";
            this.btn_valid.disabled = false;
         }
      }
      
      public function onObjectSelected(pItem:Object = null) : void {
         var item:Object = null;
         if(pItem == null)
         {
            this.hideCard();
         }
         else
         {
            this.hideCard(false);
            this._currentObject = pItem;
            item = this.dataApi.getItem(pItem.objectGID);
            this.modCommon.createItemBox("itemBox_" + this.uiApi.me().name,this.ctr_item,this._currentObject);
            this.input_price.text = "0";
            this.input_price.setSelection(0,8388607);
            this.lbl_price.text = "0";
            this.input_quantity.text = "1";
         }
      }
      
      protected function hideCard(hide:Boolean = true) : void {
         this.mainCtr.visible = !hide;
      }
   }
}
