package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.JobsApi;
   import d2api.ContextMenuApi;
   import d2api.InventoryApi;
   import d2api.UtilApi;
   import d2components.GraphicContainer;
   import d2components.Grid;
   import d2components.ComboBox;
   import d2components.ButtonContainer;
   import d2components.Input;
   import d2components.Label;
   import d2components.Slot;
   import d2components.Texture;
   import d2actions.*;
   import d2hooks.*;
   import d2enums.LocationEnum;
   
   public class ItemRecipes extends Object
   {
      
      public function ItemRecipes() {
         super();
      }
      
      private static var uriMissingIngredients:Object;
      
      private static var uriNoIngredients:Object;
      
      private static var uriMissingIngredientsSlot:Object;
      
      private static var uriNoIngredientsSlot:Object;
      
      public var modContextMenu:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var jobsApi:JobsApi;
      
      public var menuApi:ContextMenuApi;
      
      public var inventoryApi:InventoryApi;
      
      public var utilApi:UtilApi;
      
      private var _item:Object;
      
      private var _recipesList:Array;
      
      private var _filterType:int = -1;
      
      public var ctr_item:GraphicContainer;
      
      public var gd_recipes:Grid;
      
      public var cb_filter:ComboBox;
      
      public var ctr_search:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_search:ButtonContainer;
      
      public var btn_reset:ButtonContainer;
      
      public var lbl_input:Input;
      
      public var lbl_noRecipe:Label;
      
      public var slot_0:Slot;
      
      public var slot_1:Slot;
      
      public var slot_2:Slot;
      
      public var slot_3:Slot;
      
      public var slot_4:Slot;
      
      public var slot_5:Slot;
      
      public var slot_6:Slot;
      
      public var slot_7:Slot;
      
      public var tx_ingredientStateIcon0:Texture;
      
      public var tx_ingredientStateIcon1:Texture;
      
      public var tx_ingredientStateIcon2:Texture;
      
      public var tx_ingredientStateIcon3:Texture;
      
      public var tx_ingredientStateIcon4:Texture;
      
      public var tx_ingredientStateIcon5:Texture;
      
      public var tx_ingredientStateIcon6:Texture;
      
      public var tx_ingredientStateIcon7:Texture;
      
      public function main(param:Object) : void {
         var uriBase:String = null;
         var ingredients:Object = null;
         var num:* = 0;
         var i:* = 0;
         var ownedQty:uint = 0;
         var requiredQty:uint = 0;
         var uriSlot:Object = null;
         var uriIcon:Object = null;
         if(!uriMissingIngredients)
         {
            uriBase = this.uiApi.me().getConstant("assets");
            uriMissingIngredients = this.uiApi.createUri(uriBase + "tx_coloredWarning");
            uriNoIngredients = this.uiApi.createUri(uriBase + "tx_coloredCross");
            uriBase = this.uiApi.me().getConstant("bitmap");
            uriMissingIngredientsSlot = this.uiApi.createUri(uriBase + "warningSlot.png");
            uriNoIngredientsSlot = this.uiApi.createUri(uriBase + "refuseDrop.png");
         }
         this.sysApi.addHook(ObjectSelected,this.onObjectSelected);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._item = param.item;
         this.modCommon.createItemBox("itemBoxRecipe",this.ctr_item,this._item);
         this.btn_reset.visible = false;
         var recipe:Object = this.jobsApi.getRecipe(this._item.objectGID);
         if(recipe)
         {
            ingredients = recipe.ingredients;
            num = ingredients.length;
            i = 0;
            while(i < num)
            {
               this.uiApi.addComponentHook(this["slot_" + i],"onRollOver");
               this.uiApi.addComponentHook(this["slot_" + i],"onRollOut");
               this.uiApi.addComponentHook(this["slot_" + i],"onRightClick");
               this.uiApi.addComponentHook(this["slot_" + i],"onRelease");
               this.uiApi.addComponentHook(this["tx_ingredientStateIcon" + i],"onRollOver");
               this.uiApi.addComponentHook(this["tx_ingredientStateIcon" + i],"onRollOut");
               ownedQty = this.inventoryApi.getItemQty(ingredients[i].id);
               requiredQty = ingredients[i].quantity;
               uriSlot = null;
               uriIcon = null;
               if(ownedQty == 0)
               {
                  uriSlot = this.uiApi.createUri(this.uiApi.me().getConstant("bitmap") + "refuseDrop.png");
                  uriIcon = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tx_coloredCross");
               }
               else if(ownedQty < requiredQty)
               {
                  uriSlot = uriMissingIngredientsSlot;
                  uriIcon = uriMissingIngredients;
               }
               
               this["slot_" + i].data = ingredients[i];
               this["slot_" + i].customTexture = uriSlot;
               this["slot_" + i].selectedTexture = uriSlot;
               this["slot_" + i].highlightTexture = uriSlot;
               this["tx_ingredientStateIcon" + i].uri = uriIcon;
               i++;
            }
            i = i;
            while(i < num)
            {
               this["slot_" + i].data = null;
               this["slot_" + i].customTexture = null;
               this["slot_" + i].selectedTexture = null;
               this["slot_" + i].highlightTexture = null;
               this["tx_ingredientStateIcon" + i].uri = null;
               i++;
            }
         }
         else
         {
            if(!this._item.secretRecipe)
            {
               this.lbl_noRecipe.text = this.uiApi.getText("ui.item.secretReceipt");
            }
            else
            {
               this.lbl_noRecipe.text = this.uiApi.getText("ui.item.utilityNoReceipt");
            }
            this.lbl_noRecipe.visible = true;
         }
         this.getRecipes();
         this.gd_recipes.dataProvider = this.filteredRecipes();
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_search,"onRelease");
         this.uiApi.addComponentHook(this.btn_reset,"onRollOver");
         this.uiApi.addComponentHook(this.btn_reset,"onRollOut");
         this.uiApi.addComponentHook(this.btn_reset,"onRelease");
         this.uiApi.addComponentHook(this.cb_filter,"onSelectItem");
         this.sysApi.addHook(KeyUp,this.onKeyUp);
      }
      
      public function unload() : void {
         this.uiApi.unloadUi("itemBoxRecipe");
      }
      
      private function getRecipes() : void {
         var recipe:Object = null;
         var item:Object = null;
         var type:Object = null;
         this._recipesList = new Array();
         var typeList:Array = new Array();
         var recipeList:Object = this.jobsApi.getRecipesList(this._item.objectGID);
         var nb:int = recipeList.length;
         var i:int = 0;
         while(i < nb)
         {
            recipe = recipeList[i];
            item = recipe.result;
            this._recipesList.push(recipe);
            if(typeList.indexOf(item.type.id) == -1)
            {
               typeList.push(item.type,item.type.id);
            }
            i++;
         }
         var cbProvider:Array = new Array();
         var nbType:int = typeList.length;
         var k:int = 0;
         while(k < nbType)
         {
            type = typeList[k];
            cbProvider.push(
               {
                  "label":type.name,
                  "filterType":type.id
               });
            k = k + 2;
         }
         this.utilApi.sortOnString(cbProvider,"label");
         cbProvider.unshift(
            {
               "label":this.uiApi.getText("ui.common.allTypesForObject"),
               "filterType":-1
            });
         this.cb_filter.dataProvider = cbProvider;
      }
      
      private function filteredRecipes() : Array {
         var recipe:Object = null;
         var item:Object = null;
         var list:Array = new Array();
         var filterName:String = this.lbl_input.text.toLowerCase();
         var filter:Boolean = !(filterName == "");
         var nb:int = this._recipesList.length;
         var i:int = 0;
         for(;i < nb;i++)
         {
            recipe = this._recipesList[i];
            item = recipe.result;
            if(filter)
            {
               if(this.utilApi.noAccent(item.name).toLowerCase().indexOf(this.utilApi.noAccent(filterName)) == -1)
               {
                  continue;
               }
            }
            if(this._filterType != -1)
            {
               if(item.type.id != this._filterType)
               {
                  continue;
               }
            }
            list.push(recipe);
         }
         return list;
      }
      
      public function onObjectSelected(item:Object) : void {
         this.btn_reset.visible = true;
         this.modCommon.createItemBox("itemBoxRecipe",this.ctr_item,item.data);
      }
      
      public function onRollOver(target:Object) : void {
         var txt:String = null;
         switch(target)
         {
            case this.slot_0:
            case this.slot_1:
            case this.slot_2:
            case this.slot_3:
            case this.slot_4:
            case this.slot_5:
            case this.slot_6:
            case this.slot_7:
               if(target.data)
               {
                  this.uiApi.showTooltip(target.data,target,false,"standard",8,0,0,"itemName",null,
                     {
                        "showEffects":true,
                        "header":true
                     },"ItemInfo");
               }
               break;
            case this.tx_ingredientStateIcon0:
            case this.tx_ingredientStateIcon1:
            case this.tx_ingredientStateIcon2:
            case this.tx_ingredientStateIcon3:
            case this.tx_ingredientStateIcon4:
            case this.tx_ingredientStateIcon5:
            case this.tx_ingredientStateIcon6:
            case this.tx_ingredientStateIcon7:
               if(target.uri)
               {
                  if(target.uri.fileName == uriNoIngredients.fileName)
                  {
                     txt = this.uiApi.getText("ui.craft.noIngredient");
                  }
                  else if(target.uri.fileName == uriMissingIngredients.fileName)
                  {
                     txt = this.uiApi.getText("ui.craft.ingredientNotEnough");
                  }
                  
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_BOTTOMRIGHT,6);
               }
               break;
            case this.btn_reset:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.item.reinitInformations")),target,false,"standard",6,2,3,null,null,null,"TextInfo");
               break;
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_close)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         else if(target == this.btn_search)
         {
            if(this.ctr_search.visible)
            {
               this.ctr_search.visible = false;
               this.cb_filter.visible = true;
               this.lbl_input.text = "";
               this.gd_recipes.dataProvider = this.filteredRecipes();
            }
            else
            {
               this.ctr_search.visible = true;
               this.cb_filter.visible = false;
               this.lbl_input.text = "";
               this.lbl_input.focus();
            }
         }
         else if(target == this.btn_reset)
         {
            this.modCommon.createItemBox("itemBoxRecipe",this.ctr_item,this._item);
            this.btn_reset.visible = false;
         }
         else if(!this.sysApi.getOption("displayTooltips","dofus"))
         {
            this.modCommon.createItemBox("itemBoxRecipe",this.ctr_item,target.data);
            this.btn_reset.visible = true;
         }
         
         
         
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(target == this.cb_filter)
         {
            if((isNewSelection) && (!(selectMethod == 2)))
            {
               this._filterType = this.cb_filter.value.filterType;
               this.gd_recipes.dataProvider = this.filteredRecipes();
            }
         }
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if((this.ctr_search.visible) && (this.lbl_input.haveFocus))
         {
            this.gd_recipes.dataProvider = this.filteredRecipes();
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
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target.data)
         {
            data = target.data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
   }
}
