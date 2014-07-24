package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.TooltipApi;
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.TextArea;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import d2hooks.*;
   import d2actions.*;
   import d2utils.ItemTooltipSettings;
   
   public class GiftMenu extends Object
   {
      
      public function GiftMenu() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var tooltipApi:TooltipApi;
      
      public var modCommon:Object;
      
      private var _currentGift:Object;
      
      private var _giftList:Array;
      
      private var _charaList:Array;
      
      private var _gd_page:uint = 0;
      
      public var ctr_item:GraphicContainer;
      
      public var tx_giftPicture:Object;
      
      public var tx_arrow:Texture;
      
      public var lbl_giftInfo:TextArea;
      
      public var lbl_giftName:Label;
      
      public var btn_assign_gift:ButtonContainer;
      
      public var btn_not_now:ButtonContainer;
      
      public var btn_left_arrow:ButtonContainer;
      
      public var btn_right_arrow:ButtonContainer;
      
      public var gd_items_slot:Grid;
      
      public var gd_character_select:Grid;
      
      public function main(g:Object) : void {
         var chara:* = undefined;
         var gift:* = undefined;
         this.sysApi.addHook(GiftAssigned,this.onGiftAssigned);
         this.uiApi.addComponentHook(this.btn_assign_gift,"onRelease");
         this.uiApi.addComponentHook(this.btn_not_now,"onRelease");
         this.uiApi.addComponentHook(this.btn_left_arrow,"onRelease");
         this.uiApi.addComponentHook(this.btn_right_arrow,"onRelease");
         this.uiApi.addComponentHook(this.gd_items_slot,"onItemRollOver");
         this.uiApi.addComponentHook(this.gd_items_slot,"onItemRollOut");
         this.uiApi.addComponentHook(this.gd_items_slot,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_character_select,"onSelectItem");
         this._charaList = new Array();
         for each(chara in g.chara)
         {
            this._charaList.push(chara);
         }
         this.gd_character_select.autoSelectMode = 0;
         this.gd_character_select.dataProvider = this._charaList;
         this._giftList = new Array();
         for each(gift in g.gift)
         {
            this._giftList.push(gift);
         }
         this._currentGift = this._giftList.pop();
         this.btn_assign_gift.disabled = true;
         this.updateGift();
      }
      
      public function unload() : void {
         this.uiApi.unloadUi("itemBox");
         this.uiApi.unloadUi("itemRecipes");
         this.uiApi.unloadUi("itemsSet");
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         this.sysApi.log(2,"onSelectItem " + target.name);
         switch(target)
         {
            case this.gd_items_slot:
               if(this.gd_items_slot.selectedItem)
               {
                  this.sysApi.log(2,"onSelectItem selectedItem != null");
                  this.modCommon.createItemBox("itemBox",this.ctr_item,this.gd_items_slot.selectedItem);
               }
               break;
            case this.gd_character_select:
               this.btn_assign_gift.disabled = false;
               if(selectMethod == 1)
               {
                  this.onRelease(this.btn_assign_gift);
               }
               break;
         }
      }
      
      private function updateGift() : void {
         this.lbl_giftName.text = this._currentGift.title;
         this.lbl_giftInfo.text = this._currentGift.text;
         this.gd_items_slot.scrollDisplay = "never";
         this.gd_items_slot.vertical = false;
         this.gd_items_slot.dataProvider = this._currentGift.items;
         if(this.gd_items_slot.dataProvider.length < 9)
         {
            this.btn_left_arrow.visible = false;
            this.btn_right_arrow.visible = false;
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_assign_gift:
               if(!this.btn_assign_gift.disabled)
               {
                  this.sysApi.sendAction(new GiftAssignRequest(this._currentGift.uid,this.gd_character_select.selectedItem.id));
               }
               break;
            case this.btn_not_now:
               this.sysApi.sendAction(new GiftAssignRequest(this._currentGift.uid,0));
               if(this._giftList.length)
               {
                  this._currentGift = this._giftList.pop();
                  this.updateGift();
               }
               else if(this.uiApi.getUi("giftMenu"))
               {
                  this.uiApi.unloadUi("giftMenu");
               }
               
               break;
            case this.btn_left_arrow:
               this._gd_page = this._gd_page > 0?this._gd_page - 1:0;
               this.gd_items_slot.moveToPage(this._gd_page);
               if(this.gd_items_slot.selectedIndex > 0)
               {
                  this.gd_items_slot.selectedIndex = this.gd_items_slot.selectedIndex - 1;
               }
               break;
            case this.btn_right_arrow:
               this._gd_page = this._gd_page < this.gd_items_slot.pagesCount?this._gd_page + 1:this._gd_page;
               this.gd_items_slot.moveToPage(this._gd_page);
               this.gd_items_slot.selectedIndex = this.gd_items_slot.selectedIndex + 1;
               break;
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:* = undefined;
         if(item.data)
         {
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",true) as ItemTooltipSettings;
            if(!itemTooltipSettings)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,true);
            }
            tooltipData = item.data;
            if((!itemTooltipSettings.header) && (!itemTooltipSettings.conditions) && (!itemTooltipSettings.effects) && (!itemTooltipSettings.description) && (!itemTooltipSettings.averagePrice))
            {
               tooltipData = item.data.name;
            }
            this.uiApi.showTooltip(item.data,item.container,false,"standard",8,0,0,"itemName",null,{},"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean {
         return true;
      }
      
      private function onGiftAssigned(giftId:uint) : void {
         if(this._giftList.length == 0)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         if(this._giftList.length)
         {
            this._currentGift = this._giftList.pop();
            this.updateGift();
         }
      }
   }
}
