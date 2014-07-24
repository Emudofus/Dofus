package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.JobsApi;
   import d2api.ContextMenuApi;
   import d2data.Job;
   import d2components.Slot;
   import d2components.Label;
   import d2components.Texture;
   import d2components.GraphicContainer;
   import d2hooks.*;
   
   public class JobRecipeItem extends Object
   {
      
      public function JobRecipeItem() {
         super();
      }
      
      public var output:Object;
      
      public var modContextMenu:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var jobApi:JobsApi;
      
      public var menuApi:ContextMenuApi;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected:Boolean;
      
      private var _currentJob:Job;
      
      private var _slotMax:int;
      
      public var slotCraftedItem:Slot;
      
      public var slot3:Slot;
      
      public var slot2:Slot;
      
      public var slot1:Slot;
      
      public var slot8:Slot;
      
      public var slot7:Slot;
      
      public var slot6:Slot;
      
      public var slot5:Slot;
      
      public var slot4:Slot;
      
      public var lblName:Label;
      
      public var lblLevel:Label;
      
      public var lblAbility:Label;
      
      public var lblXp:Label;
      
      public var tx_background:Texture;
      
      public var mainCtr:GraphicContainer;
      
      public function main(oParam:Object = null) : void {
         this._grid = oParam.grid;
         this._data = oParam.data;
         this._selected = oParam.selected;
         var i:uint = 1;
         while(i < 9)
         {
            this.uiApi.addComponentHook(this["slot" + i],"onRollOver");
            this.uiApi.addComponentHook(this["slot" + i],"onRollOut");
            this.uiApi.addComponentHook(this["slot" + i],"onRightClick");
            this.uiApi.addComponentHook(this["slot" + i],"onRelease");
            i++;
         }
         this.uiApi.addComponentHook(this.slotCraftedItem,"onRollOver");
         this.uiApi.addComponentHook(this.slotCraftedItem,"onRollOut");
         this.uiApi.addComponentHook(this.slotCraftedItem,"onRelease");
         this.uiApi.addComponentHook(this.slotCraftedItem,"onRightClick");
         this.uiApi.addComponentHook(this.tx_background,"onRollOver");
         this.uiApi.addComponentHook(this.tx_background,"onRollOut");
         this.update(this._data,this._selected);
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void {
         var ingredients:Object = null;
         var xp:* = 0;
         var i:uint = 0;
         this._data = data;
         if(data)
         {
            this._currentJob = this._grid.getUi().uiClass.currentJob;
            this._slotMax = this._grid.getUi().uiClass.slotMax;
            if(this._data.recipe.ingredients.length > this.jobApi.getJobCraftSkillInfos(this._currentJob,this._data.skill).maxSlots)
            {
               this.mainCtr.greyedOut = true;
            }
            else
            {
               this.mainCtr.greyedOut = false;
            }
            this.lblName.text = this._data.recipe.result.name;
            this.lblAbility.text = "(" + this._data.skill.name + ")";
            this.lblLevel.text = this.uiApi.getText("ui.common.short.level") + " " + this._data.recipe.result.level.toString();
            ingredients = this._data.recipe.ingredients;
            xp = 0;
            if(this._slotMax - ingredients.length < 4)
            {
               switch(ingredients.length)
               {
                  case 2:
                     xp = 10;
                     break;
                  case 3:
                     xp = 25;
                     break;
                  case 4:
                     xp = 50;
                     break;
                  case 5:
                     xp = 100;
                     break;
                  case 6:
                     xp = 250;
                     break;
                  case 7:
                     xp = 500;
                     break;
                  case 8:
                     xp = 1000;
                     break;
                  default:
                     xp = 1;
               }
            }
            this.lblXp.text = this.uiApi.getText("ui.tooltip.monsterXpAlone",xp);
            if(xp == 0)
            {
               this.lblXp.cssClass = "rightdarkred";
            }
            else
            {
               this.lblXp.cssClass = "right";
            }
            this.slotCraftedItem.data = this._data.recipe.result;
            i = 0;
            while(i < ingredients.length)
            {
               this["slot" + (i + 1)].data = ingredients[i];
               i++;
            }
            while(i < 8)
            {
               this["slot" + (i + 1)].data = null;
               i++;
            }
         }
         else
         {
            this.slotCraftedItem.data = null;
            this.slot3.data = null;
            this.slot2.data = null;
            this.slot1.data = null;
            this.slot8.data = null;
            this.slot7.data = null;
            this.slot6.data = null;
            this.slot5.data = null;
            this.slot4.data = null;
            this.lblAbility.text = "";
            this.lblXp.text = "";
            this.lblLevel.text = "";
            this.lblName.text = "";
            this.mainCtr.softDisabled = false;
         }
      }
      
      public function select(b:Boolean) : void {
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         switch(target)
         {
            case this.slot3:
            case this.slot2:
            case this.slot1:
            case this.slot8:
            case this.slot7:
            case this.slot6:
            case this.slot5:
            case this.slot4:
               if(target.data)
               {
                  this.uiApi.showTooltip(target.data,target,false,"standard",6,2,3,"itemName",null,
                     {
                        "showEffects":true,
                        "header":true
                     },"ItemInfo");
               }
               return;
            case this.slotCraftedItem:
               if(target.data)
               {
                  this.uiApi.showTooltip(target.data,target,false,"standard",8,0,0,"itemName",null,
                     {
                        "showEffects":true,
                        "header":true
                     },"ItemInfo");
               }
               break;
            case this.tx_background:
               if((this._data) && (this._data.recipe))
               {
                  if(this._slotMax < this._data.recipe.ingredients.length)
                  {
                     text = this.uiApi.getText("ui.jobs.difficulty3");
                  }
                  else if(this._slotMax - this._data.recipe.ingredients.length >= 4)
                  {
                     text = this.uiApi.getText("ui.jobs.difficulty1");
                  }
                  else
                  {
                     text = this.uiApi.getText("ui.jobs.difficulty2");
                  }
                  
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               }
               break;
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:Object) : void {
         if(!this.sysApi.getOption("displayTooltips","dofus"))
         {
            this.sysApi.dispatchHook(ShowObjectLinked,target.data);
         }
      }
      
      public function onRightClick(target:Object) : void {
         var contextMenu:Object = null;
         if(target.data)
         {
            contextMenu = this.menuApi.create(target.data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
   }
}
