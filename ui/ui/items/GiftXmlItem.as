package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2components.Label;
   import d2components.Texture;
   import d2hooks.*;
   
   public class GiftXmlItem extends Object
   {
      
      public function GiftXmlItem() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var lbl_giftName:Label;
      
      public var lbl_giftEffect:Label;
      
      public var tx_icon:Texture;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected:Boolean;
      
      public function main(oParam:Object = null) : void {
         this._grid = oParam.grid;
         this._data = oParam.data;
         this.update(this._data,this._selected);
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void {
         this._data = data;
         if(data)
         {
            this.lbl_giftName.text = data.giftName + " - " + this.uiApi.getText("ui.common.level") + " " + data.giftLevel;
            if(data.giftEffect)
            {
               if(data.param)
               {
                  this.lbl_giftEffect.text = data.giftEffect.split("#1").join(data.param);
               }
               else
               {
                  this.lbl_giftEffect.text = data.giftEffect;
               }
            }
            else
            {
               this.lbl_giftEffect.text = "";
            }
            this.tx_icon.uri = data.giftUri;
         }
         else
         {
            this.lbl_giftName.text = "";
            this.lbl_giftEffect.text = "";
            this.tx_icon.uri = null;
         }
      }
      
      public function select(b:Boolean) : void {
      }
      
      public function onRollOver(target:Object) : void {
      }
      
      public function onRollOut(target:Object) : void {
      }
   }
}
