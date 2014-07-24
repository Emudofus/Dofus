package ui
{
   import d2data.Job;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.JobsApi;
   import d2api.StorageApi;
   import d2api.UtilApi;
   import d2components.ButtonContainer;
   import d2components.GraphicContainer;
   import d2components.ComboBox;
   import d2components.Grid;
   import d2components.Label;
   import d2components.Input;
   import d2data.Recipe;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.KeyUp;
   import d2hooks.InventoryContent;
   import d2actions.ExchangeObjectTransfertListWithQuantityToInv;
   
   public class CheckCraft extends Object
   {
      
      public function CheckCraft() {
         super();
      }
      
      public static const SORT_CRITERIA_INGREDIENTS:String = "ingredients";
      
      public static const SORT_CRITERIA_LEVEL:String = "level";
      
      public static const SORT_CRITERIA_PRICE:String = "price";
      
      private static const MISSING_INGREDIENTS_TOLERANCE:Array;
      
      private static const DATA_ONLYKNOWNJOBS_SELECTED:String = "onlyKnownJobs";
      
      private static const DATA_ONLRECIPESXP_SELECTED:String = "onlyRecipesXP";
      
      private static var _defaultSortBtnY:Number;
      
      private static var _defaultTotalRecipesY:Number;
      
      private static var _jobs:Vector.<Job>;
      
      private static var _jobNames:Array;
      
      private static var _myJobNames:Array;
      
      public var modCommon:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var jobsApi:JobsApi;
      
      public var storageApi:StorageApi;
      
      public var utilApi:UtilApi;
      
      public var btn_close:ButtonContainer;
      
      public var checkRecipesCtr:GraphicContainer;
      
      public var combo_job:ComboBox;
      
      public var gdRecipes:Grid;
      
      public var btn_onlyKnownJobs:ButtonContainer;
      
      public var btn_onlyRecipesXP:ButtonContainer;
      
      public var lbl_ingredientsTolerance:Label;
      
      public var combo_ingredientsTolerance:ComboBox;
      
      public var btn_sortIngredients:ButtonContainer;
      
      public var btn_sortLvl:ButtonContainer;
      
      public var btn_sortPrice:ButtonContainer;
      
      public var btn_sortIngredientsTxt:ButtonContainer;
      
      public var btn_sortLvlTxt:ButtonContainer;
      
      public var btn_sortPriceTxt:ButtonContainer;
      
      public var lbl_sortByIngredients:Label;
      
      public var lbl_sortByLvl:Label;
      
      public var lbl_sortByPrice:Label;
      
      public var lbl_totalRecipes:Label;
      
      public var combo_filter:ComboBox;
      
      public var searchCtr:GraphicContainer;
      
      public var btn_search:ButtonContainer;
      
      public var input_search:Input;
      
      private var _details:Array;
      
      private var _recipes:Object;
      
      private var _currentJob:Job;
      
      private var _currentRecipe:Recipe;
      
      private var _jobMaxSlots:Array;
      
      private var _canTransfertItems:Boolean;
      
      private var _filterTypes:Array;
      
      private var _filterCriteria:int;
      
      private var _searchCriteria:String;
      
      private var _sortCriteria:String;
      
      private var _sortDescending:Boolean;
      
      private var _storage:String;
      
      public function main(oParam:Object = null) : void {
         var job:Job = null;
         var allJobs:Object = null;
         var l:* = 0;
         var j:* = 0;
         var i:* = 0;
         this.btn_close.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_sortIngredients.alpha = this.btn_sortPrice.alpha = 0.5;
         this.btn_sortLvl.alpha = 1;
         this._sortCriteria = SORT_CRITERIA_LEVEL;
         this._sortDescending = true;
         this._filterCriteria = -1;
         if(!_defaultTotalRecipesY)
         {
            _defaultTotalRecipesY = this.lbl_totalRecipes.y;
            _defaultSortBtnY = this.btn_sortLvl.y;
         }
         if(!_jobs)
         {
            _jobs = new Vector.<Job>();
            allJobs = this.dataApi.getJobs();
            l = allJobs.length;
            j = 0;
            while(j < l)
            {
               if(!((allJobs[j].id == 1) || (allJobs[j].specializationOf)))
               {
                  _jobs.push(allJobs[j]);
               }
               j++;
            }
            _jobs.fixed = true;
            _jobNames = new Array();
            l = _jobs.length;
            i = 0;
            while(i < l)
            {
               _jobNames.push(_jobs[i].name);
               i++;
            }
            this.utilApi.sortOnString(_jobNames);
            _jobNames.unshift(this.uiApi.getText("ui.craft.allJobs"));
         }
         var knownJobs:Object = this.jobsApi.getKnownJobs();
         _myJobNames = new Array();
         for each(job in knownJobs)
         {
            if(!job.specializationOf)
            {
               _myJobNames.push(job.name);
            }
         }
         this.utilApi.sortOnString(_myJobNames);
         _myJobNames.unshift(this.uiApi.getText("ui.craft.allMyJobs"));
         this._storage = oParam.storage;
         this._canTransfertItems = this._storage == "bankUi";
         this.btn_onlyKnownJobs.selected = this.sysApi.getSetData(DATA_ONLYKNOWNJOBS_SELECTED,false);
         this.btn_onlyRecipesXP.selected = this.sysApi.getSetData(DATA_ONLRECIPESXP_SELECTED,false);
         if(!this.btn_onlyKnownJobs.selected)
         {
            this.btn_onlyRecipesXP.softDisabled = true;
            this.combo_job.dataProvider = _jobNames;
         }
         else
         {
            this.combo_job.dataProvider = _myJobNames;
         }
         this.combo_job.value = this.combo_job.dataProvider[0];
         this.combo_ingredientsTolerance.dataProvider = MISSING_INGREDIENTS_TOLERANCE;
         this.combo_ingredientsTolerance.value = MISSING_INGREDIENTS_TOLERANCE[0];
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_onlyKnownJobs,"onRelease");
         this.uiApi.addComponentHook(this.btn_onlyRecipesXP,"onRelease");
         this.uiApi.addComponentHook(this.btn_search,"onRelease");
         this.uiApi.addComponentHook(this.btn_search,"onDoubleClick");
         this.uiApi.addComponentHook(this.combo_job,"onSelectItem");
         this.uiApi.addComponentHook(this.combo_ingredientsTolerance,"onSelectItem");
         this.uiApi.addComponentHook(this.combo_filter,"onSelectItem");
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.sysApi.addHook(InventoryContent,this.onInventoryUpdate);
         this.updateRecipes();
      }
      
      public function unload() : void {
         this._details = null;
         this._recipes = null;
         this._currentJob = null;
         this._currentRecipe = null;
         this._jobMaxSlots = null;
         this._storage = null;
         _myJobNames = null;
         this._filterTypes = null;
         if(this.uiApi.getUi("quantityPopup"))
         {
            this.uiApi.unloadUi("quantityPopup");
         }
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_search:
               this.onReleaseSearchBtn();
               break;
            case this.btn_close:
               this.uiApi.unloadUi("checkCraft");
               break;
            case this.btn_onlyKnownJobs:
               this.sysApi.setData(DATA_ONLYKNOWNJOBS_SELECTED,this.btn_onlyKnownJobs.selected);
               this.btn_onlyRecipesXP.softDisabled = !this.btn_onlyKnownJobs.selected;
               if(this.btn_onlyKnownJobs.selected)
               {
                  this.combo_job.dataProvider = _myJobNames;
               }
               else
               {
                  this.combo_job.dataProvider = _jobNames;
               }
               if(this.combo_job.selectedIndex != 0)
               {
                  this.combo_job.selectedIndex = 0;
               }
               else
               {
                  this.updateRecipes();
               }
               break;
            case this.btn_onlyRecipesXP:
               this.sysApi.setData(DATA_ONLRECIPESXP_SELECTED,this.btn_onlyRecipesXP.selected);
               this.updateRecipes();
               break;
            case this.btn_sortIngredients:
            case this.btn_sortIngredientsTxt:
               this.toggleSortBtns(this.btn_sortIngredients as ButtonContainer);
               this._sortDescending = this.btn_sortIngredients.scaleY > 0;
               this._sortCriteria = SORT_CRITERIA_INGREDIENTS;
               this.gdRecipes.dataProvider = this.jobsApi.sortRecipesByCriteria(this.gdRecipes.dataProvider,this._sortCriteria,this._sortDescending);
               break;
            case this.btn_sortLvl:
            case this.btn_sortLvlTxt:
               this.toggleSortBtns(this.btn_sortLvl as ButtonContainer);
               this._sortDescending = this.btn_sortLvl.scaleY > 0;
               this._sortCriteria = SORT_CRITERIA_LEVEL;
               this.gdRecipes.dataProvider = this.jobsApi.sortRecipesByCriteria(this.gdRecipes.dataProvider,this._sortCriteria,this._sortDescending);
               break;
            case this.btn_sortPrice:
            case this.btn_sortPriceTxt:
               this.toggleSortBtns(this.btn_sortPrice as ButtonContainer);
               this._sortDescending = this.btn_sortPrice.scaleY > 0;
               this._sortCriteria = SORT_CRITERIA_PRICE;
               this.gdRecipes.dataProvider = this.jobsApi.sortRecipesByCriteria(this.gdRecipes.dataProvider,this._sortCriteria,this._sortDescending);
               break;
         }
      }
      
      public function onDoubleClick(target:Object) : void {
         switch(target)
         {
            case this.btn_search:
               this.onReleaseSearchBtn();
               break;
         }
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if((this.searchCtr.visible) && (this.input_search.haveFocus))
         {
            if(this.input_search.text.length > 2)
            {
               this._searchCriteria = this.utilApi.noAccent(this.input_search.text).toLowerCase();
               this.filterRecipes(this._searchCriteria);
            }
            else
            {
               if(this._searchCriteria)
               {
                  this._searchCriteria = null;
               }
               this.updateRecipes([]);
            }
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var i:* = 0;
         var jName:String = null;
         var sItem:* = undefined;
         if(!isNewSelection)
         {
            return;
         }
         switch(target)
         {
            case this.combo_job:
               if(this.combo_job.selectedIndex > 0)
               {
                  this._currentJob = null;
                  i = 0;
                  while(i < _jobs.length)
                  {
                     jName = _jobs[i].name;
                     sItem = this.combo_job.selectedItem;
                     if(jName == sItem)
                     {
                        this._currentJob = _jobs[i];
                        break;
                     }
                     i++;
                  }
                  this.btn_onlyRecipesXP.softDisabled = _myJobNames.indexOf(this._currentJob.name) == -1;
               }
               else
               {
                  this._currentJob = null;
               }
               this.updateRecipes();
               break;
            case this.combo_ingredientsTolerance:
               this.updateRecipes();
               break;
            case this.combo_filter:
               this._filterCriteria = target.value.filterType;
               this.filterRecipes(this._filterCriteria);
               break;
         }
      }
      
      public function get canTransfertItems() : Boolean {
         return this._canTransfertItems;
      }
      
      public function get storage() : String {
         return this._storage;
      }
      
      public function getMaxSlotsForJob(jobId:int) : int {
         return this._jobMaxSlots[jobId];
      }
      
      public function itemIsInBag(itemGID:int) : Boolean {
         var itemDetails:Object = this._details[itemGID];
         if((!itemDetails) || (!itemDetails.fromBag))
         {
            return false;
         }
         var i:int = 0;
         while(i < itemDetails.fromBag.length)
         {
            if(!itemDetails.fromBag[i])
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function getActualMaxOccurence(resultId:int) : uint {
         var maxOccurence:int = 0;
         if(this._details[resultId])
         {
            maxOccurence = this._details[resultId].actualMaxOccurence;
         }
         return maxOccurence;
      }
      
      public function getPotentialMaxOccurence(resultId:int) : uint {
         var maxOccurence:int = 0;
         if(this._details[resultId])
         {
            maxOccurence = this._details[resultId].potentialMaxOccurence;
         }
         return maxOccurence;
      }
      
      public function getPossibleMaxOccurence(resultId:int) : uint {
         var recipe:Recipe = null;
         var occurences:Array = null;
         var stackTotalQty:* = 0;
         var ingredientDetails:Object = null;
         var i:* = 0;
         var j:* = 0;
         var maxOccurence:int = 0;
         if(this._details[resultId])
         {
            recipe = this.jobsApi.getRecipe(resultId);
            occurences = new Array();
            stackTotalQty = 0;
            i = 0;
            while(i < recipe.ingredientIds.length)
            {
               ingredientDetails = this._details[recipe.ingredientIds[i]];
               stackTotalQty = 0;
               if((ingredientDetails) && (ingredientDetails.stackQtyList))
               {
                  j = 0;
                  while(j < ingredientDetails.stackQtyList.length)
                  {
                     if(!(ingredientDetails.fromBag[j]))
                     {
                        stackTotalQty = stackTotalQty + ingredientDetails.stackQtyList[j];
                     }
                     j++;
                  }
                  occurences.push(int(stackTotalQty / recipe.quantities[i]));
               }
               else
               {
                  occurences.push(0);
               }
               i++;
            }
            occurences.sort(Array.NUMERIC);
            maxOccurence = occurences[occurences.length - 1];
         }
         if(maxOccurence == 0)
         {
            maxOccurence = 1;
         }
         return maxOccurence;
      }
      
      public function getItemTotalQty(itemGID:int) : int {
         var totalQty:int = 0;
         if(this._details[itemGID])
         {
            totalQty = this._details[itemGID].totalQuantity;
         }
         return totalQty;
      }
      
      public function requestIngredientsTransfert(recipe:Recipe) : void {
         this._currentRecipe = recipe;
         var maxValue:uint = this.getPossibleMaxOccurence(recipe.resultId);
         var defaultValue:uint = this.getPotentialMaxOccurence(recipe.resultId);
         this.modCommon.openQuantityPopup(1,maxValue,defaultValue,this.onValidRecipeMax);
      }
      
      private function toggleSortBtns(activeSortBtn:ButtonContainer) : void {
         this.btn_sortIngredients.alpha = this.btn_sortLvl.alpha = this.btn_sortPrice.alpha = 0.4;
         activeSortBtn.alpha = 1;
         activeSortBtn.scaleY = -activeSortBtn.scaleY;
         if(activeSortBtn.scaleY < 0)
         {
            activeSortBtn.y = activeSortBtn.y - activeSortBtn.height;
         }
         else
         {
            activeSortBtn.y = _defaultSortBtnY;
         }
      }
      
      private function onValidRecipeMax(qty:Number) : void {
         var ingredientDetails:Object = null;
         var foundQty:* = 0;
         var ingredientQty:* = 0;
         var ll:* = 0;
         var j:* = 0;
         var ingredients:Vector.<uint> = new Vector.<uint>();
         var quantities:Vector.<uint> = new Vector.<uint>();
         var requiredQuantities:Vector.<uint> = new Vector.<uint>();
         var l:int = this._currentRecipe.ingredientIds.length;
         var i:int = 0;
         while(i < l)
         {
            requiredQuantities.push(this._currentRecipe.quantities[i] * qty);
            ingredientDetails = this._details[this._currentRecipe.ingredientIds[i]];
            if(!((!ingredientDetails) || (!ingredientDetails.totalQuantity)))
            {
               foundQty = 0;
               ingredientQty = 0;
               ll = ingredientDetails.stackUidList.length;
               j = 0;
               while(j < ll)
               {
                  if(!(ingredientDetails.fromBag[j]))
                  {
                     ingredients.push(ingredientDetails.stackUidList[j]);
                     ingredientQty = ingredientDetails.stackQtyList[j];
                     if((!foundQty) && (ingredientQty >= requiredQuantities[i]))
                     {
                        quantities.push(requiredQuantities[i]);
                        break;
                     }
                     if(foundQty + ingredientQty < requiredQuantities[i])
                     {
                        foundQty = foundQty + ingredientQty;
                        requiredQuantities[i] = requiredQuantities[i] - foundQty;
                        quantities.push(foundQty);
                     }
                     else
                     {
                        foundQty = foundQty + (requiredQuantities[i] - ingredientQty);
                        quantities.push(foundQty);
                        break;
                     }
                  }
                  j++;
               }
            }
            i++;
         }
         this.sysApi.sendAction(new ExchangeObjectTransfertListWithQuantityToInv(ingredients,quantities));
      }
      
      private function onInventoryUpdate(items:Object, kama:uint) : void {
         this.updateRecipes();
      }
      
      private function updateRecipes(recipes:* = null) : void {
         var jobId:* = 0;
         if(recipes)
         {
            this.gdRecipes.dataProvider = recipes;
            if(this._recipes == recipes)
            {
               this.combo_filter.selectedIndex = 0;
            }
         }
         else
         {
            jobId = 0;
            if(this._currentJob)
            {
               jobId = this._currentJob.id;
            }
            this._details = new Array();
            this._jobMaxSlots = new Array();
            this._filterTypes = new Array();
            this._recipes = this.jobsApi.getRecipesByJob(this._details,this._jobMaxSlots,jobId,this._canTransfertItems,(this.btn_onlyRecipesXP.selected) && (!this.btn_onlyRecipesXP.softDisabled),this.btn_onlyKnownJobs.selected,int(this.combo_ingredientsTolerance.selectedItem),this._sortCriteria,this._sortDescending,this._filterTypes);
            this.gdRecipes.dataProvider = this._recipes;
            this.updateTypeFilter();
            if(this._searchCriteria)
            {
               this.filterRecipes(this._searchCriteria);
            }
            else if(this._filterCriteria != -1)
            {
               this.filterRecipes(this._filterCriteria);
            }
            
         }
         this.lbl_totalRecipes.y = _defaultTotalRecipesY;
         this.lbl_totalRecipes.cssClass = "left";
         this.gdRecipes.alpha = 1;
         var totalRecipes:String = this.gdRecipes.dataProvider.length.toString();
         if(totalRecipes == "0")
         {
            this.lbl_totalRecipes.text = this.uiApi.getText("ui.craft.noRecipeFound");
            this.lbl_totalRecipes.y = 494;
            this.lbl_totalRecipes.cssClass = "center";
            this.gdRecipes.alpha = 0.2;
         }
         else if(totalRecipes == "1")
         {
            this.lbl_totalRecipes.text = this.uiApi.getText("ui.craft.oneRecipeFound",1);
         }
         else
         {
            this.lbl_totalRecipes.text = this.uiApi.getText("ui.craft.recipesFound",totalRecipes);
         }
         
      }
      
      private function filterRecipes(criteria:*) : void {
         var recipe:* = undefined;
         var filteredRecipes:Vector.<Recipe> = new Vector.<Recipe>();
         if(criteria is String)
         {
            for each(recipe in this._recipes)
            {
               if(this.utilApi.noAccent(recipe.resultName).toLowerCase().indexOf(criteria) != -1)
               {
                  filteredRecipes.push(recipe);
               }
            }
         }
         else if(criteria is Number)
         {
            if(criteria == -1)
            {
               this.updateRecipes(this._recipes);
               return;
            }
            for each(recipe in this._recipes)
            {
               if(recipe.resultTypeId == criteria)
               {
                  filteredRecipes.push(recipe);
               }
            }
         }
         
         this.updateRecipes(filteredRecipes);
      }
      
      private function onReleaseSearchBtn() : void {
         this.searchCtr.visible = !this.searchCtr.visible;
         this.combo_filter.visible = !this.searchCtr.visible;
         if(this.searchCtr.visible)
         {
            this.input_search.focus();
            if((this._searchCriteria) && (this._searchCriteria.length < 3))
            {
               this.updateRecipes([]);
            }
            else
            {
               this.filterRecipes(this._searchCriteria);
            }
         }
         else
         {
            this._searchCriteria = null;
            this.input_search.text = "";
            this.updateRecipes(this._recipes);
         }
      }
      
      private function updateTypeFilter() : void {
         var selectedItem:Object = null;
         var typeObj:Object = null;
         var type:Object = null;
         var cbProvider:Array = new Array();
         for each(type in this._filterTypes)
         {
            if(type)
            {
               typeObj = 
                  {
                     "label":type.name,
                     "filterType":type.id
                  };
               cbProvider.push(typeObj);
               if(this._filterCriteria == type.id)
               {
                  selectedItem = typeObj;
               }
            }
         }
         this.utilApi.sortOnString(cbProvider,"label");
         cbProvider.unshift(
            {
               "label":this.uiApi.getText("ui.common.allTypesForObject"),
               "filterType":-1
            });
         if((!selectedItem) || (this._filterCriteria == -1))
         {
            selectedItem = cbProvider[0];
         }
         this.combo_filter.dataProvider = cbProvider;
         if(this.combo_filter.value != selectedItem)
         {
            this.combo_filter.value = selectedItem;
         }
      }
   }
}
