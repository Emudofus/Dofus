package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SoundApi;
   import d2api.StorageApi;
   import d2api.TooltipApi;
   import d2api.UtilApi;
   import d2data.ItemWrapper;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Input;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import d2utils.ItemTooltipSettings;
   
   public class FeedUi extends Object
   {
      
      public function FeedUi() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var soundApi:SoundApi;
      
      public var storageApi:StorageApi;
      
      public var tooltipApi:TooltipApi;
      
      public var utilApi:UtilApi;
      
      public var modCommon:Object;
      
      private var _foodList:Object;
      
      private var _typeToFeed:int = 0;
      
      private var _item:ItemWrapper;
      
      private var _mountId:int;
      
      private var _mountLocation:int;
      
      public var btn_closeFeed:ButtonContainer;
      
      public var btn_feedOk:ButtonContainer;
      
      public var grid_food:Grid;
      
      public var ctr_item:GraphicContainer;
      
      public var lbl_selectItem:Label;
      
      public var ctr_quantity:GraphicContainer;
      
      public var inp_quantity:Input;
      
      public var btn_min:ButtonContainer;
      
      public var btn_max:ButtonContainer;
      
      public function main(param:Object) : void {
         this.btn_closeFeed.soundId = SoundEnum.WINDOW_CLOSE;
         this.sysApi.addHook(ObjectQuantity,this.onObjectQuantity);
         this.sysApi.addHook(ObjectDeleted,this.onObjectDeleted);
         this.uiApi.addComponentHook(this.btn_closeFeed,"onRelease");
         this.uiApi.addComponentHook(this.btn_feedOk,"onRelease");
         this.uiApi.addComponentHook(this.grid_food,"onSelectItem");
         this.ctr_quantity.visible = false;
         this.inp_quantity.text = "" + Common.getInstance().lastFoodQuantity;
         this._typeToFeed = param.type;
         if(this._typeToFeed == 3)
         {
            this._mountId = param.mountId;
            this._mountLocation = param.mountLocation;
            this._foodList = param.foodList;
         }
         else
         {
            this._item = param.item;
            if(this._item.type.superTypeId == 12)
            {
               this._foodList = this.storageApi.getPetFood(this._item.objectGID);
               this._typeToFeed = 1;
            }
            else
            {
               this._foodList = this.storageApi.getLivingObjectFood(this._item.type.id);
               this._typeToFeed = 2;
               this.inp_quantity.text = "1";
            }
         }
         if((this._foodList) && (this._foodList.length))
         {
            this.grid_food.dataProvider = this._foodList;
            this.btn_feedOk.disabled = true;
            this.grid_food.selectedIndex = -1;
         }
         else
         {
            this.grid_food.dataProvider = new Array();
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.item.errorNoFoodLivingItem",this._item.name),[this.uiApi.getText("ui.common.ok")],[this.uiApi.unloadUi(this.uiApi.me().name)]);
         }
      }
      
      public function unload() : void {
         this.uiApi.hideTooltip();
         this.uiApi.unloadUi("itemBoxFood");
      }
      
      private function onConfirmFeed(qty:Number = 1) : void {
         if(this._typeToFeed == 3)
         {
            qty = this.utilApi.stringToKamas(this.inp_quantity.text,"");
            this.sysApi.sendAction(new MountFeedRequest(this._mountId,this._mountLocation,this.grid_food.selectedItem.objectUID,qty));
         }
         else
         {
            this.sysApi.sendAction(new LivingObjectFeed(this._item.objectUID,this.grid_food.selectedItem.objectUID,qty));
         }
         Common.getInstance().lastFoodQuantity = qty;
      }
      
      public function onRelease(target:Object) : void {
         var qty:* = 0;
         if(target == this.btn_closeFeed)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         else if(target == this.btn_feedOk)
         {
            qty = this.utilApi.stringToKamas(this.inp_quantity.text,"");
            if(this._typeToFeed == 2)
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.item.confirmFoodLivingItem"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmFeed,null],this.onConfirmFeed);
            }
            else if(this._typeToFeed == 3)
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.item.confirmFoodMount",this.inp_quantity.text,this.grid_food.selectedItem.name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmFeed,null],this.onConfirmFeed);
            }
            else if(this.grid_food.selectedItem.quantity < qty)
            {
               this.onConfirmFeed(this.grid_food.selectedItem.quantity);
            }
            else
            {
               this.onConfirmFeed(qty);
            }
            
            
         }
         else if(target == this.btn_max)
         {
            if(this.grid_food.selectedIndex > -1)
            {
               this.inp_quantity.text = this.utilApi.kamasToString(this.grid_food.dataProvider[this.grid_food.selectedIndex].quantity,"");
            }
         }
         else if(target == this.btn_min)
         {
            this.inp_quantity.text = "1";
         }
         
         
         
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.grid_food)
         {
            if(this.grid_food.selectedItem)
            {
               this.modCommon.createItemBox("itemBoxFood",this.ctr_item,this.grid_food.selectedItem);
               this.lbl_selectItem.visible = false;
               this.btn_feedOk.disabled = false;
               this.ctr_quantity.visible = true;
               if(this._typeToFeed == 2)
               {
                  this.ctr_quantity.disabled = true;
               }
               if(int(this.inp_quantity.text) > this.grid_food.selectedItem.quantity)
               {
                  this.inp_quantity.text = this.utilApi.kamasToString(this.grid_food.selectedItem.quantity,"");
               }
               if(selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
               {
                  this.onConfirmFeed(1);
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:Object = null;
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
               tooltipData = item.data;
            }
            this.uiApi.showTooltip(tooltipData,item.container,false,"standard",8,0,0,"itemName",null,
               {
                  "showEffects":true,
                  "header":true
               },"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onObjectQuantity(item:ItemWrapper, quantity:int, oldQuantity:int) : void {
         if((item) && (this._foodList))
         {
            if(this._typeToFeed == 3)
            {
               this._foodList = this.storageApi.getRideFoods();
            }
            else if(this._typeToFeed == 1)
            {
               this._foodList = this.storageApi.getPetFood(this._item.objectGID);
            }
            else
            {
               this._foodList = this.storageApi.getLivingObjectFood(this._item.type.id);
            }
            
            this.grid_food.dataProvider = this._foodList;
            this.btn_feedOk.disabled = true;
         }
      }
      
      private function onObjectDeleted(item:Object) : void {
         if((item) && (this._foodList))
         {
            if(this._typeToFeed == 3)
            {
               this._foodList = this.storageApi.getRideFoods();
            }
            else if(this._typeToFeed == 1)
            {
               this._foodList = this.storageApi.getPetFood(this._item.objectGID);
            }
            else
            {
               this._foodList = this.storageApi.getLivingObjectFood(this._item.type.id);
            }
            
            this.grid_food.dataProvider = this._foodList;
            this.btn_feedOk.disabled = true;
            if((this._foodList) && (this._foodList.length))
            {
               this.grid_food.selectedIndex = 0;
               this.inp_quantity.text = "1";
            }
            else
            {
               this.ctr_quantity.visible = false;
               this.uiApi.unloadUi("itemBoxFood");
            }
         }
      }
   }
}
