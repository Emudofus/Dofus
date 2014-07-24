package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.ContextMenuApi;
   import d2api.TooltipApi;
   import d2api.MountApi;
   import d2components.Slot;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2hooks.*;
   import d2utils.ItemTooltipSettings;
   
   public class InventoryItem extends Object
   {
      
      public function InventoryItem() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var menuApi:ContextMenuApi;
      
      public var tooltipApi:TooltipApi;
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      public var mountApi:MountApi;
      
      public var slot_icon:Slot;
      
      public var lbl_name:Label;
      
      public var btn_item:ButtonContainer;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected:Boolean;
      
      private var _item:Object;
      
      public function main(oParam:Object = null) : void {
         this.uiApi.addComponentHook(this.btn_item,"onRollOver");
         this.uiApi.addComponentHook(this.btn_item,"onRollOut");
         this.uiApi.addComponentHook(this.btn_item,"onRightClick");
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
            this.btn_item.selected = selected;
            this.btn_item.mouseEnabled = true;
            this.btn_item.visible = true;
            this._item = data;
            this.slot_icon.data = data;
            this.lbl_name.text = data.name;
            if(this.mountApi.isCertificateValid(data))
            {
               this.lbl_name.cssClass = "p";
            }
            else
            {
               this.lbl_name.cssClass = "malus";
            }
            this.slot_icon.visible = true;
         }
         else
         {
            this.btn_item.mouseEnabled = false;
            this.btn_item.selected = false;
            this.btn_item.visible = false;
            this.lbl_name.text = "";
            this.slot_icon.visible = false;
            this._item = null;
         }
      }
      
      public function select(b:Boolean) : void {
      }
      
      public function onRollOver(target:Object) : void {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var settings:Object = null;
         var setting:String = null;
         if((this.data) && (target == this.btn_item))
         {
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",true) as ItemTooltipSettings;
            if(!itemTooltipSettings)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,true);
            }
            settings = new Object();
            for(setting in itemTooltipSettings)
            {
               if(!settings.hasOwnProperty(setting))
               {
                  settings[setting] = itemTooltipSettings[setting];
               }
            }
            settings.ref = this.slot_icon;
            this.uiApi.showTooltip(this._item,this.slot_icon,false,"standard",6,0,0,"itemName",null,settings,"ItemInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target == this.btn_item)
         {
            data = this._data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
   }
}
