package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.ContextMenuApi;
   import d2components.ButtonContainer;
   import d2components.Label;
   
   public class BuyModeDetailXmlItem extends Object
   {
      
      public function BuyModeDetailXmlItem() {
         super();
      }
      
      public var modContextMenu:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var menuApi:ContextMenuApi;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _item:Object;
      
      private var _selectedQuantity:int = 1;
      
      public var btn_item:ButtonContainer;
      
      public var lbl_name:Label;
      
      public var lbl_size:Label;
      
      public var lbl_price:Label;
      
      public function main(oParam:Object = null) : void {
         this._grid = oParam.grid;
         this._data = oParam.data;
         this.uiApi.addComponentHook(this.btn_item,"onRelease");
         this.update(this._data,false);
      }
      
      public function unload() : void {
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function update(data:*, selected:Boolean) : void {
         this._data = data;
         if(data != null)
         {
            this._item = data.itemWrapper;
            if((data.prices.length == 0) || (data.prices[0] <= 0))
            {
               this.sysApi.log(8,"Erreur : utilisation d\'un hotel de ventes à effets détaillés sans objet en lot par 1");
            }
            this.lbl_name.text = data.itemWrapper.shortName;
            this.lbl_name.cssClass = "left";
            this.lbl_size.text = data.size;
            this.lbl_price.text = this.utilApi.kamasToString(data.prices[0]);
            this.btn_item.selected = selected;
         }
         else
         {
            this.btn_item.selected = false;
            this.lbl_name.text = "";
            this.lbl_price.text = "";
            this.lbl_size.text = "";
            this.lbl_name.cssClass = "left";
         }
      }
      
      private function onSelectedItem(target:Object) : void {
         if(this.data)
         {
            if(target == this.btn_item)
            {
               this._selectedQuantity = 1;
               this.btn_item.state = this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED;
               this.lbl_name.cssClass = "dark";
               this.btn_item.selected = true;
               this.uiApi.getUi("itemBidHouseBuy").uiClass.currentCase = 0;
               this.uiApi.getUi("itemBidHouseBuy").uiClass.btn_buy.disabled = false;
            }
            else
            {
               this.lbl_name.cssClass = "left";
               this.btn_item.selected = false;
               this.uiApi.getUi("itemBidHouseBuy").uiClass.btn_buy.disabled = true;
            }
         }
      }
      
      public function onRelease(target:Object) : void {
         this.onSelectedItem(target);
      }
   }
}
