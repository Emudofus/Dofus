package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.JobsApi;
   import d2api.PlayedCharacterApi;
   import d2api.ContextMenuApi;
   import d2api.InventoryApi;
   import d2api.SoundApi;
   import d2api.StorageApi;
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.Slot;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.EntityDisplayer;
   import flash.utils.Timer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import flash.events.TimerEvent;
   import d2hooks.*;
   import d2actions.*;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2data.ItemWrapper;
   
   public class Craft extends Object
   {
      
      public function Craft() {
         this._recipes = new Array();
         super();
      }
      
      public static const SIGNATURE_RUNE_ID:int = 7508;
      
      public static const STEP_READY_TO_CRAFT:int = 0;
      
      public static const STEP_RECIPE_KNOWN:int = 1;
      
      public static const STEP_RECIPE_UNKNOWN:int = 2;
      
      public static const STEP_CRAFTING:int = 3;
      
      public static const STEP_ONE_ITEM_CRAFTED:int = 4;
      
      public static const STEP_CRAFT_ENDED:int = 5;
      
      public static const STEP_CRAFT_STOPPED:int = 6;
      
      public static const BUTTON_STATE_MERGE:int = 0;
      
      public static const BUTTON_STATE_STOP:int = 1;
      
      private static const CRAFT_IMPOSSIBLE:int = 0;
      
      private static const CRAFT_FAILED:int = 1;
      
      private static const CRAFT_SUCCESS:int = 2;
      
      private static const STOPPED_REASON_OK:int = 1;
      
      private static const STOPPED_REASON_USER:int = 2;
      
      private static const STOPPED_REASON_MISSING_RESSOURCE:int = 3;
      
      private static const STOPPED_REASON_IMPOSSIBLE_CRAFT:int = 4;
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var jobsApi:JobsApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var menuApi:ContextMenuApi;
      
      public var inventoryApi:InventoryApi;
      
      public var soundApi:SoundApi;
      
      public var storageApi:StorageApi;
      
      public var subRecipesCtr:GraphicContainer;
      
      public var arrowDownCtr:GraphicContainer;
      
      public var objectCtr:GraphicContainer;
      
      public var ctr_item:GraphicContainer;
      
      public var tx_ingredients_selected:Texture;
      
      public var tx_quantity_selected:Texture;
      
      public var tx_payment_selected:Object;
      
      public var slot_ingredient_1:Slot;
      
      public var slot_ingredient_2:Slot;
      
      public var slot_ingredient_3:Slot;
      
      public var slot_ingredient_4:Slot;
      
      public var slot_ingredient_5:Slot;
      
      public var slot_ingredient_6:Slot;
      
      public var slot_ingredient_7:Slot;
      
      public var slot_ingredient_8:Slot;
      
      public var slot_signature:Slot;
      
      public var slot_item_crafting:Slot;
      
      public var tx_arrow_down_enable:Texture;
      
      public var lbl_quantity:Label;
      
      public var lbl_item_crafting:Label;
      
      public var btn_quantity_up:ButtonContainer;
      
      public var btn_quantity_down:ButtonContainer;
      
      public var lbl_playerInfos:Label;
      
      public var lbl_item_crafting_progress:Label;
      
      public var lbl_item_crafting_success:Label;
      
      public var lbl_item_crafting_failure:Label;
      
      public var btn_ok:ButtonContainer;
      
      public var btn_lbl_btn_ok:Label;
      
      public var btn_stop:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var ed_player:EntityDisplayer;
      
      protected var _step:uint;
      
      protected var _skill:Object;
      
      protected var _jobId:uint;
      
      protected var _recipesUi:Object;
      
      protected var _recipes:Array;
      
      protected var _slotMax:uint;
      
      protected var _recipe:Object;
      
      protected var _itemToCraft:Object = null;
      
      protected var _textItemToCraft:String;
      
      protected var _nbItemCrafted:uint = 0;
      
      protected var _nbItemToCraft:uint;
      
      protected var _nbItemFailed:uint = 0;
      
      protected var _nbItemSuccess:uint = 0;
      
      protected var _slotsIngredients:Array;
      
      protected var _waitingData:Object;
      
      protected var _waitingSlot:Object;
      
      protected var _isInAutoCraft:Boolean;
      
      protected var _isRecipeKnown:Boolean;
      
      protected var _okButtonState:int;
      
      protected var showRecipes:Boolean = true;
      
      private var _updateTimer:Timer;
      
      private var _timerBuffer_componentList:Object;
      
      private var _timerBuffer_slotsIngredients:Object;
      
      private var _timerBuffer_slotSignature:Object;
      
      private var _disableRecipiesTimer:Timer;
      
      public function get skill() : Object {
         return this._skill;
      }
      
      public function get slotMax() : int {
         return this._slotMax;
      }
      
      public function set slotMax(val:int) : void {
         this._slotMax = val;
      }
      
      public function main(params:Object) : void {
         var recipeWithSkill:Object = null;
         var slot:* = undefined;
         this.sysApi.disableWorldInteraction();
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_ok.soundId = SoundEnum.OK_BUTTON;
         this.btn_quantity_down.soundId = SoundEnum.SCROLL_DOWN;
         this.btn_quantity_up.soundId = SoundEnum.SCROLL_UP;
         this.sysApi.addHook(PlayerListUpdate,this.onPlayerListUpdate);
         this.sysApi.addHook(ExchangeCraftResult,this.onExchangeCraftResult);
         this.sysApi.addHook(ExchangeItemAutoCraftStoped,this.onExchangeItemAutoCraftStoped);
         this.sysApi.addHook(DropStart,this.onDropStart);
         this.sysApi.addHook(DropEnd,this.onDropEnd);
         this.sysApi.addHook(ExchangeReplayCountModified,this.onExchangeReplayCountModified);
         this.sysApi.addHook(ExchangeItemAutoCraftRemaining,this.onExchangeItemAutoCraftRemaining);
         this.sysApi.addHook(ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(RecipeSelected,this.onRecipeSelected);
         this.sysApi.addHook(MouseAltDoubleClick,this.onMouseAltDoubleClick);
         this.sysApi.addHook(MouseCtrlDoubleClick,this.onMouseCtrlDoubleClick);
         this.sysApi.addHook(ExchangeCraftSlotCountIncreased,this.onExchangeCraftSlotCountIncreased);
         this.sysApi.addHook(ObjectSelected,this.onObjectSelected);
         this.sysApi.addHook(ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.uiApi.addComponentHook(this.lbl_quantity,"onRelease");
         this.uiApi.addComponentHook(this.btn_quantity_up,"onRelease");
         this.uiApi.addComponentHook(this.btn_quantity_down,"onRelease");
         this.uiApi.addComponentHook(this.btn_ok,"onRelease");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.slot_item_crafting,"onRollOver");
         this.uiApi.addComponentHook(this.slot_item_crafting,"onRollOut");
         this.uiApi.addComponentHook(this.slot_item_crafting,"onRightClick");
         this.uiApi.addComponentHook(this.ed_player,"onRelease");
         this.uiApi.addComponentHook(this.ed_player,"onRightClick");
         this.ed_player.mouseEnabled = true;
         this.ed_player.handCursor = true;
         this.objectCtr.visible = false;
         this._updateTimer = new Timer(150,1);
         this._updateTimer.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
         this._disableRecipiesTimer = new Timer(300,1);
         this._disableRecipiesTimer.addEventListener(TimerEvent.TIMER,this.onDisableRecipiesTimer);
         this._skill = this.jobsApi.getSkillFromId(params.skillId);
         this._jobId = this._skill.parentJobId;
         for each(recipeWithSkill in params.recipes)
         {
            this._recipes.push(recipeWithSkill.recipe);
         }
         this._slotsIngredients = new Array(this.slot_ingredient_1,this.slot_ingredient_2,this.slot_ingredient_3,this.slot_ingredient_4,this.slot_ingredient_5,this.slot_ingredient_6,this.slot_ingredient_7,this.slot_ingredient_8);
         for each(slot in this._slotsIngredients)
         {
            this.registerSlot(slot);
         }
         this.registerSlot(this.slot_signature);
         this.setQuantity(1);
         this.setQuantityItem(null);
         if(this.showRecipes)
         {
            this._recipesUi = this.modCommon.createRecipesObject("recipes",this.subRecipesCtr,this.subRecipesCtr,params.recipes,params.nbCase);
         }
         this.setMaxSlotAvailable(params.nbCase);
         this.switchUI(STEP_READY_TO_CRAFT,true);
         this.displayPlayerEntity(this.playerApi.getPlayedCharacterInfo().entityLook,this.ed_player,3);
         this.lbl_playerInfos.text = "{player," + this.playerApi.getPlayedCharacterInfo().name + "::" + this.playerApi.getPlayedCharacterInfo().name + "}";
      }
      
      public function unload() : void {
         this.uiApi.unloadUi("recipes");
         this.uiApi.unloadUi("itemBoxCraft");
         this.storageApi.removeAllItemMasks("craft");
         this.storageApi.releaseHooks();
         this.sysApi.sendAction(new LeaveDialogRequest());
         this.sysApi.sendAction(new CloseInventory());
         this.sysApi.enableWorldInteraction();
      }
      
      public function get itemQuantity() : int {
         return parseInt(this.lbl_quantity.text);
      }
      
      protected function registerSlot(slot:Slot) : void {
         slot.dropValidator = this.dropValidatorFunction as Function;
         slot.processDrop = this.processDropFunction as Function;
         this.uiApi.addComponentHook(slot,"onRollOver");
         this.uiApi.addComponentHook(slot,"onRollOut");
         this.uiApi.addComponentHook(slot,"onDoubleClick");
         this.uiApi.addComponentHook(slot,"onRightClick");
         this.uiApi.addComponentHook(slot,"onRelease");
      }
      
      protected function setQuantity(quantity:int) : void {
         var slot:Slot = null;
         this.storageApi.removeAllItemMasks("craft");
         for each(slot in this._slotsIngredients)
         {
            if(slot.data)
            {
               this.storageApi.addItemMask(slot.data.objectUID,"craft",slot.data.quantity * quantity);
            }
         }
         this.storageApi.releaseHooks();
         this.lbl_quantity.text = quantity.toString();
      }
      
      protected function setQuantityItem(item:Object) : void {
         if(item)
         {
            this.tx_quantity_selected.visible = true;
            this.slot_item_crafting.data = item;
            this.lbl_item_crafting.text = item.name;
         }
         else
         {
            this.tx_quantity_selected.visible = false;
            this.slot_item_crafting.data = null;
            this.lbl_item_crafting.text = "";
         }
      }
      
      protected function setResultItem(item:Object, transparent:Boolean = false) : void {
         if(item)
         {
            this.arrowDownCtr.visible = true;
            if(transparent)
            {
               this.tx_arrow_down_enable.visible = false;
               this.lbl_item_crafting_progress.text = "";
               this.lbl_item_crafting_success.text = "";
               this.lbl_item_crafting_failure.text = "";
            }
            else
            {
               this.tx_arrow_down_enable.visible = true;
               this.lbl_item_crafting_progress.text = this.uiApi.getText("ui.craft.progress") + this.uiApi.getText("ui.common.colon") + this._nbItemCrafted + "/" + this._nbItemToCraft;
               this.lbl_item_crafting_success.text = this.uiApi.getText("ui.craft.success") + this.uiApi.getText("ui.common.colon") + this._nbItemSuccess;
               this.lbl_item_crafting_failure.text = this.uiApi.processText(this.uiApi.getText("ui.craft.failure"),"m",this._nbItemFailed < 2) + this.uiApi.getText("ui.common.colon") + this._nbItemFailed;
            }
            this.modCommon.createItemBox("itemBoxCraft",this.ctr_item,item);
            this.objectCtr.visible = true;
         }
         else
         {
            this.arrowDownCtr.visible = false;
            this.lbl_item_crafting_progress.text = "";
            this.lbl_item_crafting_success.text = this.uiApi.getText("ui.craft.success") + this.uiApi.getText("ui.common.colon") + "-";
            this.lbl_item_crafting_failure.text = this.uiApi.processText(this.uiApi.getText("ui.craft.failure"),"m",true) + this.uiApi.getText("ui.common.colon") + "-";
         }
      }
      
      protected function setQuantityDisabled(disabled:Boolean) : void {
         this.lbl_quantity.disabled = disabled;
         this.btn_quantity_up.disabled = disabled;
         this.btn_quantity_down.disabled = disabled;
      }
      
      public function processDropToInventory(target:Object, d:Object, source:Object) : void {
         if(d.info1 > 1)
         {
            this.modCommon.openQuantityPopup(1,d.quantity,d.quantity,this.onValidQtyDropToInventory);
         }
         else
         {
            this.unfillSlot(this._waitingSlot,-1);
         }
      }
      
      protected function onValidQtyDropToInventory(qty:Number) : void {
         this.unfillSlot(this._waitingSlot,qty);
      }
      
      public function fillAutoSlot(item:Object, quantity:int, force:Boolean = false) : void {
         var job:* = undefined;
         var jobInfo:Object = null;
         var slot:Object = null;
         if(item.id == SIGNATURE_RUNE_ID)
         {
            if(this.dropValidatorFunction(this.slot_signature,item,null))
            {
               job = this._getJob(this._jobId);
               if(!job)
               {
                  return;
               }
               jobInfo = this.jobsApi.getJobExperience(job);
               if(jobInfo.currentLevel < 100)
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.craft.jobLevelLowForSignature"),[this.uiApi.getText("ui.common.ok")]);
                  return;
               }
               this.fillSlot(this.slot_signature,item,1);
            }
         }
         else
         {
            slot = null;
            for each(slot in this._slotsIngredients)
            {
               if((slot.data) && (slot.data.objectGID == item.objectGID))
               {
                  this.fillSlot(null,item,quantity);
                  return;
               }
               if(slot.data == null)
               {
                  this.fillSlot(slot,item,quantity);
                  return;
               }
            }
            if(force)
            {
               this.fillSlot(null,item,quantity);
            }
         }
      }
      
      protected function setMaxSlotAvailable(quantity:int) : void {
         if(quantity == 9)
         {
            quantity = 8;
         }
         this._slotMax = quantity;
         var i:int = 0;
         while(i < 8)
         {
            if(i < quantity)
            {
               this._slotsIngredients[i].emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tx_slot");
            }
            else
            {
               this._slotsIngredients[i].emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tx_SlotVerrouille");
            }
            this._slotsIngredients[i].refresh();
            i++;
         }
         if(this._slotMax >= 8)
         {
            this.slot_signature.visible = true;
         }
         else
         {
            this.slot_signature.visible = false;
         }
      }
      
      protected function switchOkButtonState(buttonState:int, disabled:Boolean = false) : void {
         this._okButtonState = buttonState;
         this.btn_ok.disabled = disabled;
         switch(buttonState)
         {
            case BUTTON_STATE_MERGE:
               this.btn_ok.disabled = false;
               this.btn_stop.disabled = true;
               break;
            case BUTTON_STATE_STOP:
               this.btn_ok.disabled = true;
               this.btn_stop.disabled = false;
               break;
         }
      }
      
      protected function get okButtonState() : int {
         return this._okButtonState;
      }
      
      protected function switchUI(step:uint, force:Boolean = false) : void {
         if((this._step == step) && (!force))
         {
            return;
         }
         this._step = step;
         switch(step)
         {
            case STEP_READY_TO_CRAFT:
               this.sysApi.log(2,"STEP_READY_TO_CRAFT");
               this.tx_ingredients_selected.visible = false;
               this.setQuantityItem(null);
               this.setQuantityDisabled(false);
               this.setResultItem(null);
               this.switchOkButtonState(BUTTON_STATE_MERGE,true);
               break;
            case STEP_RECIPE_KNOWN:
               this.sysApi.log(2,"STEP_RECIPE_KNOWN");
               this.soundApi.playSound(SoundTypeEnum.RECIPE_MATCH);
               this.tx_ingredients_selected.visible = true;
               this.setQuantityItem(this._itemToCraft);
               this.setQuantityDisabled(false);
               this.setResultItem(null);
               this.objectCtr.visible = false;
               this.switchOkButtonState(BUTTON_STATE_MERGE,false);
               break;
            case STEP_RECIPE_UNKNOWN:
               this.sysApi.log(2,"STEP_RECIPE_UNKNOWN");
               this.tx_ingredients_selected.visible = false;
               this.setQuantityItem(null);
               this.setQuantityDisabled(false);
               this.switchOkButtonState(BUTTON_STATE_MERGE,false);
               break;
            case STEP_CRAFTING:
               this.sysApi.log(2,"STEP_CRAFTING");
               this.setQuantityDisabled(true);
               if(this.itemQuantity > 1)
               {
                  this.switchOkButtonState(BUTTON_STATE_STOP,false);
               }
               else
               {
                  this.switchOkButtonState(BUTTON_STATE_MERGE,true);
               }
               break;
            case STEP_ONE_ITEM_CRAFTED:
               this.sysApi.log(2,"STEP_ONE_ITEM_CRAFTED " + (this._nbItemToCraft - this._nbItemCrafted));
               this.setQuantityItem(this._itemToCraft);
               this.setQuantityDisabled(true);
               this.setResultItem(this._itemToCraft);
               if(this.itemQuantity > 1)
               {
                  this.switchOkButtonState(BUTTON_STATE_STOP,false);
               }
               else
               {
                  this.switchOkButtonState(BUTTON_STATE_MERGE,true);
               }
               break;
            case STEP_CRAFT_ENDED:
               this.sysApi.log(2,"STEP_CRAFT_ENDED");
               if(this._skill.id != 209)
               {
                  this.cleanAllItems();
               }
               this.tx_ingredients_selected.visible = false;
               this.setQuantityItem(null);
               this.setQuantityDisabled(false);
               this.setResultItem(this._itemToCraft);
               this.switchOkButtonState(BUTTON_STATE_MERGE,true);
               break;
            case STEP_CRAFT_STOPPED:
               this.sysApi.log(2,"STEP_CRAFT_STOPPED");
               this.setQuantityDisabled(false);
               this.setResultItem(this._itemToCraft);
               this.switchOkButtonState(BUTTON_STATE_MERGE,true);
               break;
         }
      }
      
      protected function isValidContent(slot:Object, item:Object) : Boolean {
         switch(slot)
         {
            case this.slot_signature:
               if(item.id == SIGNATURE_RUNE_ID)
               {
                  return true;
               }
               return false;
            case this.slot_ingredient_1:
            case this.slot_ingredient_2:
            case this.slot_ingredient_3:
            case this.slot_ingredient_4:
            case this.slot_ingredient_5:
            case this.slot_ingredient_6:
            case this.slot_ingredient_7:
            case this.slot_ingredient_8:
               if(item.id == SIGNATURE_RUNE_ID)
               {
                  return false;
               }
               if(this._slotsIngredients.indexOf(slot) < this._slotMax)
               {
                  return true;
               }
               return false;
            default:
               return false;
         }
      }
      
      private function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean {
         return this.isValidContent(target,data);
      }
      
      private function processDropFunction(target:Object, d:Object, source:Object) : void {
         if(this.dropValidatorFunction(target,d,source))
         {
            switch(target)
            {
               case this.slot_signature:
                  this.fillAutoSlot(d,1);
                  break;
               default:
                  if(d.quantity > 1)
                  {
                     this._waitingData = d;
                     this.modCommon.openQuantityPopup(1,d.quantity,d.quantity,this.onValidQtyDrop);
                  }
                  else
                  {
                     this.fillAutoSlot(d,1);
                  }
            }
         }
      }
      
      private function onValidQtyDrop(qty:Number) : void {
         this.fillAutoSlot(this._waitingData,qty);
      }
      
      private function onValidCraftItemQty(qty:Number) : void {
         this.sysApi.sendAction(new ExchangeReplay(qty));
      }
      
      private function fillSlot(slot:Object, item:Object, quantity:int) : void {
         if((!(slot == null)) && (!(slot.data == null)))
         {
            this.unfillSlot(slot,-1);
         }
         this.sysApi.sendAction(new ExchangeObjectMove(item.objectUID,quantity));
      }
      
      private function unfillSlot(slot:Object, quantity:int) : void {
         if((slot == null) || (slot.data == null))
         {
            return;
         }
         if(quantity == -1)
         {
            quantity = slot.data.quantity;
         }
         this.sysApi.sendAction(new ExchangeObjectMove(slot.data.objectUID,-quantity));
      }
      
      protected function cleanAllItems() : void {
         var slot:Object = null;
         for each(slot in this._slotsIngredients)
         {
            slot.data = null;
         }
         this.slot_signature.data = null;
      }
      
      protected function removeAllItems() : void {
         var slot:Object = null;
         for each(slot in this._slotsIngredients)
         {
            if(slot.data)
            {
               this.sysApi.sendAction(new ExchangeObjectMove(slot.data.objectUID,-slot.data.quantity));
            }
         }
         if(this.slot_signature.data)
         {
            this.sysApi.sendAction(new ExchangeObjectMove(this.slot_signature.data.objectUID,-this.slot_signature.data.quantity));
         }
      }
      
      private function getFirstEmptySlot(slotsIngredients:Object) : Object {
         var slot:Object = null;
         for each(slot in slotsIngredients)
         {
            if(slot.data == null)
            {
               return slot;
            }
         }
         return null;
      }
      
      protected function getFilledSlots() : Array {
         var slot:Object = null;
         var filledSlots:Array = new Array();
         for each(slot in this._slotsIngredients)
         {
            if(slot.data != null)
            {
               filledSlots.push(
                  {
                     "objectUID":slot.data.objectUID,
                     "objectGID":slot.data.objectGID,
                     "quantity":slot.data.quantity,
                     "type":this.dataApi.getItem(slot.data.objectGID).typeId
                  });
            }
         }
         return filledSlots;
      }
      
      protected function checkRecipe() : Boolean {
         var matchingRecipes:Array = null;
         this._isRecipeKnown = false;
         var slotsIngredients:Array = this.getFilledSlots();
         matchingRecipes = this._getRecipesWithItems(slotsIngredients,slotsIngredients.length);
         if(matchingRecipes.length == 1)
         {
            this._itemToCraft = matchingRecipes[0].result;
            this._isRecipeKnown = true;
         }
         else if(this._skill.id == 209)
         {
            this._isRecipeKnown = true;
         }
         
         return this._isRecipeKnown;
      }
      
      private function _getRecipesWithItems(pComponents:Object, pNbSlots:int = -1) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function _getRecipeBySlots(pNbSlots:uint) : Array {
         var recipe:Object = null;
         var recipeComponents:uint = 0;
         var recipes:Array = new Array();
         for each(recipe in this._recipes)
         {
            recipeComponents = recipe.ingredientIds.length;
            if(pNbSlots == recipeComponents)
            {
               recipes.push(recipe);
            }
         }
         return recipes;
      }
      
      private function _getJob(jobId:uint) : Object {
         var job:Object = null;
         var jobs:Object = this.jobsApi.getKnownJobs();
         for each(job in jobs)
         {
            if(job.id == jobId)
            {
               return job;
            }
         }
         return null;
      }
      
      private function getMaxQuantity() : uint {
         var item:ItemWrapper = null;
         var ingredient:Object = null;
         var quantities:Array = new Array();
         var ingredients:Array = this.getFilledSlots();
         for each(item in this.storageApi.getViewContent("storage"))
         {
            for each(ingredient in ingredients)
            {
               if(item.objectUID == ingredient.objectUID)
               {
                  quantities.push(Math.floor((item.quantity + this.storageApi.getItemMaskCount(item.objectUID,"craft")) / ingredient.quantity));
               }
            }
         }
         if(quantities.length < ingredients.length)
         {
            return 1;
         }
         quantities.sort(Array.DESCENDING | Array.NUMERIC);
         return quantities[quantities.length - 1];
      }
      
      protected function onConfirmCraftRecipe() : void {
         this._nbItemCrafted = 0;
         this._nbItemToCraft = this.itemQuantity;
         this._nbItemSuccess = 0;
         this._nbItemFailed = 0;
         this.switchUI(STEP_CRAFTING);
         if(this.itemQuantity > 1)
         {
            this._isInAutoCraft = true;
         }
         else
         {
            this._isInAutoCraft = false;
         }
         this.sysApi.sendAction(new ExchangeReady(true));
      }
      
      protected function onCancelCraftRecipe() : void {
      }
      
      private function onPlayerListUpdate(playerList:Object) : void {
         this._isInAutoCraft = false;
         var componentList:Object = playerList.componentList;
         this.fillComponents(componentList,this._slotsIngredients,this.slot_signature,true);
      }
      
      protected function fillComponents(componentList:Object, slotsIngredients:Object, slotSignature:Object, delay:Boolean = false) : void {
         this._updateTimer.reset();
         this._timerBuffer_componentList = componentList;
         this._timerBuffer_slotsIngredients = slotsIngredients;
         this._timerBuffer_slotSignature = slotSignature;
         this.onTimerEvent(null);
      }
      
      protected function onTimerEvent(e:TimerEvent) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onExchangeCraftResult(result:uint, item:Object) : void {
         this._nbItemCrafted++;
         switch(result)
         {
            case CRAFT_IMPOSSIBLE:
               this._nbItemFailed++;
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.craft.noResult"),[this.uiApi.getText("ui.common.ok")]);
               return;
            case CRAFT_FAILED:
               this._nbItemFailed++;
               if(!this._isInAutoCraft)
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.craft.failed"),[this.uiApi.getText("ui.common.ok")]);
               }
               break;
            case CRAFT_SUCCESS:
               this._nbItemSuccess++;
               this._itemToCraft = item;
               break;
         }
         if(this._isInAutoCraft)
         {
            this.switchUI(STEP_ONE_ITEM_CRAFTED,true);
         }
         else
         {
            this.switchUI(STEP_CRAFT_ENDED);
         }
      }
      
      private function onExchangeItemAutoCraftStoped(reason:uint) : void {
         switch(reason)
         {
            case STOPPED_REASON_OK:
               this._isInAutoCraft = false;
               this.switchUI(STEP_CRAFT_ENDED);
               break;
            case STOPPED_REASON_USER:
               this._isInAutoCraft = false;
               this.switchUI(STEP_CRAFT_STOPPED);
               break;
            case STOPPED_REASON_MISSING_RESSOURCE:
               this._isInAutoCraft = false;
               this.switchUI(STEP_CRAFT_ENDED);
               break;
            case STOPPED_REASON_IMPOSSIBLE_CRAFT:
               this._isInAutoCraft = false;
               this.switchUI(STEP_CRAFT_STOPPED);
               break;
         }
      }
      
      private function onExchangeItemAutoCraftRemaining(pCount:int) : void {
         this.setQuantity(pCount);
      }
      
      private function onExchangeReplayCountModified(pCount:int) : void {
         this.setQuantity(pCount);
      }
      
      private function onExchangeLeave(success:Boolean) : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      protected function onRecipeSelected(pRecipe:Object) : void {
         this.fillRecipeIngredients(pRecipe);
      }
      
      protected function fillRecipeIngredients(recipe:Object) : void {
         var genericObj:Object = null;
         var obj:Object = null;
         var recipesComponents:Array = new Array();
         var recipeFull:Boolean = this.isRecipeFull(recipe,recipesComponents);
         this._recipesUi.uiClass.disabled = true;
         this._disableRecipiesTimer.delay = 300 * recipesComponents.length;
         this._disableRecipiesTimer.start();
         this.removeAllItems();
         if(!recipeFull)
         {
            for each(genericObj in recipesComponents)
            {
               for each(obj in genericObj)
               {
                  this.sysApi.sendAction(new ExchangeObjectMove(obj.objectUID,obj.quantity));
               }
            }
         }
         else
         {
            this.sysApi.sendAction(new ExchangeSetCraftRecipe(recipe.resultId));
         }
      }
      
      protected function isRecipeFull(recipe:Object, recipesComponents:Array) : Boolean {
         var component:Object = null;
         var storageItems:Object = null;
         var recipeFull:Boolean = true;
         for each(component in recipe.ingredients)
         {
            storageItems = this.inventoryApi.getStorageObjectGID(component.objectGID,component.quantity);
            if(storageItems == null)
            {
               recipeFull = false;
            }
            else
            {
               recipesComponents.push(storageItems);
            }
         }
         if(!recipeFull)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.craft.dontHaveAllIngredient"),[this.uiApi.getText("ui.common.ok")]);
         }
         return recipeFull;
      }
      
      private function onDisableRecipiesTimer(e:TimerEvent) : void {
         this._recipesUi.uiClass.disabled = false;
      }
      
      private function onExchangeObjectAdded(item:Object) : void {
         if(!this._isInAutoCraft)
         {
            if(this.checkRecipe())
            {
               this.switchUI(STEP_RECIPE_KNOWN,true);
            }
            else
            {
               this.switchUI(STEP_RECIPE_UNKNOWN,true);
            }
         }
      }
      
      public function onObjectSelected(item:Object) : void {
         if(!this.sysApi.getOption("displayTooltips","dofus"))
         {
            this.modCommon.createItemBox("itemBoxCraft",this.ctr_item,item.data);
            this.arrowDownCtr.visible = false;
            this.objectCtr.visible = true;
         }
      }
      
      private function onValidQty(qty:Number) : void {
         this.unfillSlot(this._waitingSlot,qty);
      }
      
      private function onExchangeCraftSlotCountIncreased(newMaxSlot:int, recipes:Object) : void {
         var recipeWithSkill:Object = null;
         if((this._slotMax == 0) || (!(this._slotMax == newMaxSlot)))
         {
            this._recipes = new Array();
            for each(recipeWithSkill in recipes)
            {
               this._recipes.push(recipeWithSkill.recipe);
            }
            this.setMaxSlotAvailable(newMaxSlot);
            this._recipesUi.uiClass.updateRecipes(newMaxSlot,this._recipes);
         }
      }
      
      protected function displayPlayerEntity(look:Object, entityDisplayer:Object, direction:int) : void {
         entityDisplayer.yOffset = 30;
         entityDisplayer.scale = 1.5;
         entityDisplayer.direction = direction;
         entityDisplayer.look = look;
      }
      
      public function onRelease(target:Object) : void {
         var quantity:* = 0;
         var maxQuantity:* = 0;
         switch(target)
         {
            case this.lbl_quantity:
               maxQuantity = this.getMaxQuantity();
               this.modCommon.openQuantityPopup(1,maxQuantity,maxQuantity,this.onValidCraftItemQty);
               break;
            case this.btn_quantity_up:
               maxQuantity = this.getMaxQuantity();
               quantity = parseInt(this.lbl_quantity.text);
               if((quantity < maxQuantity) || (maxQuantity == 0))
               {
                  quantity++;
               }
               this.setQuantity(quantity);
               this.sysApi.sendAction(new ExchangeReplay(quantity));
               break;
            case this.btn_quantity_down:
               quantity = parseInt(this.lbl_quantity.text);
               if(quantity > 1)
               {
                  quantity--;
               }
               this.setQuantity(quantity);
               this.sysApi.sendAction(new ExchangeReplay(quantity));
               break;
            case this.btn_ok:
               if(this.getFilledSlots().length > 0)
               {
                  this.onConfirmCraftRecipe();
               }
               break;
            case this.btn_stop:
               this.sysApi.sendAction(new ExchangeReplayStop());
               break;
            case this.btn_close:
               this.sysApi.sendAction(new LeaveDialogRequest());
               break;
            case this.ed_player:
               this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
               break;
            default:
               if((!(target.name.indexOf("slot") == -1)) && (target.data))
               {
                  this.onObjectSelected(target);
               }
         }
      }
      
      public function onRollOver(target:Object) : void {
         if(target.data)
         {
            this.uiApi.showTooltip(target.data,target,false,"standard",8,0,0,"itemName",null,
               {
                  "showEffects":true,
                  "header":true
               },"ItemInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onDoubleClick(target:Object) : void {
         if(target.data)
         {
            this.unfillSlot(target,1);
         }
      }
      
      private function onMouseCtrlDoubleClick(target:Object) : void {
         var slotClicked:* = false;
         var slot:Object = null;
         if(target.data)
         {
            slotClicked = false;
            for each(slot in this._slotsIngredients)
            {
               if(slot == target)
               {
                  slotClicked = true;
               }
            }
            if(!slotClicked)
            {
               return;
            }
            this.unfillSlot(target,-1);
         }
      }
      
      private function onMouseAltDoubleClick(target:Object) : void {
         var slotClicked:* = false;
         var slot:Object = null;
         if(target.data)
         {
            slotClicked = false;
            for each(slot in this._slotsIngredients)
            {
               if(slot == target)
               {
                  slotClicked = true;
               }
            }
            if(!slotClicked)
            {
               return;
            }
            this._waitingSlot = target;
            this.modCommon.openQuantityPopup(1,target.data.quantity,target.data.quantity,this.onValidQty);
         }
      }
      
      public function onRightClick(target:Object) : void {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target == this.ed_player)
         {
            this.sysApi.sendAction(new DisplayContextualMenu(this.playerApi.id()));
         }
         else if(target.data)
         {
            data = target.data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
         
      }
      
      private function onDropStart(src:Object) : void {
         var slot:Object = null;
         this._waitingSlot = src;
         if(this.dropValidatorFunction(this.slot_signature,src.data,null))
         {
            this.slot_signature.selected = true;
         }
         else
         {
            for each(slot in this._slotsIngredients)
            {
               if(this.dropValidatorFunction(slot,src.data,null))
               {
                  slot.selected = true;
               }
            }
         }
      }
      
      private function onDropEnd(src:Object) : void {
         var slot:Object = null;
         for each(slot in this._slotsIngredients)
         {
            slot.selected = false;
         }
         this.slot_signature.selected = false;
      }
      
      public function set slotsIngredients(value:Array) : void {
         this._slotsIngredients = value;
      }
   }
}
