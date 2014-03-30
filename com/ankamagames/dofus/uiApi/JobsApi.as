package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import flash.globalization.Collator;
   import com.ankamagames.dofus.logic.game.common.frames.JobsFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJob;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescription;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobDescription;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescriptionCollect;
   import com.ankamagames.dofus.network.types.game.interactive.skill.SkillActionDescriptionCraft;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.dofus.internalDatacenter.jobs.RecipeWithSkill;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class JobsApi extends Object implements IApi
   {
      
      public function JobsApi() {
         this._log = Log.getLogger(getQualifiedClassName(JobsApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      private var _stringSorter:Collator;
      
      public function set module(value:UiModule) : void {
         this._module = value;
      }
      
      private function get jobsFrame() : JobsFrame {
         return Kernel.getWorker().getFrame(JobsFrame) as JobsFrame;
      }
      
      private function get averagePricesFrame() : AveragePricesFrame {
         return Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getKnownJobs() : Array {
         var kj:KnownJob = null;
         var incr:uint = 0;
         var iJ:uint = 0;
         if(!PlayedCharacterManager.getInstance().jobs)
         {
            return null;
         }
         var knownJobs:Array = new Array();
         var result:Array = new Array();
         for each (kj in PlayedCharacterManager.getInstance().jobs)
         {
            if(kj != null)
            {
               knownJobs[kj.jobPosition] = Job.getJobById(kj.jobDescription.jobId);
            }
         }
         incr = 0;
         iJ = 0;
         while(iJ < 6)
         {
            if((knownJobs[iJ]) && (knownJobs[iJ].specializationOfId == 0))
            {
               result.push(knownJobs[iJ]);
            }
            iJ++;
         }
         var iJ2:uint = 0;
         while(iJ2 < 6)
         {
            if((knownJobs[iJ2]) && (knownJobs[iJ2].specializationOfId > 0))
            {
               result[3 + incr] = knownJobs[iJ2];
               incr++;
            }
            iJ2++;
         }
         return result;
      }
      
      public function getJobSkills(job:Job) : Array {
         var sd:SkillActionDescription = null;
         var jd:JobDescription = this.getJobDescription(job.id);
         if(!jd)
         {
            return null;
         }
         var jobSkills:Array = new Array(jd.skills.length);
         var index:uint = 0;
         for each (sd in jd.skills)
         {
            jobSkills[index++] = Skill.getSkillById(sd.skillId);
         }
         return jobSkills;
      }
      
      public function getJobSkillType(job:Job, skill:Skill) : String {
         var jd:JobDescription = this.getJobDescription(job.id);
         if(!jd)
         {
            return "unknown";
         }
         var sd:SkillActionDescription = this.getSkillActionDescription(jd,skill.id);
         if(!sd)
         {
            return "unknown";
         }
         switch(true)
         {
            case sd is SkillActionDescriptionCollect:
               return "collect";
            case sd is SkillActionDescriptionCraft:
               return "craft";
         }
      }
      
      public function getJobCollectSkillInfos(job:Job, skill:Skill) : Object {
         var jd:JobDescription = this.getJobDescription(job.id);
         if(!jd)
         {
            return null;
         }
         var sd:SkillActionDescription = this.getSkillActionDescription(jd,skill.id);
         if(!sd)
         {
            return null;
         }
         if(!(sd is SkillActionDescriptionCollect))
         {
            return null;
         }
         var sdc:SkillActionDescriptionCollect = sd as SkillActionDescriptionCollect;
         var infos:Object = new Object();
         infos.time = sdc.time / 10;
         infos.minResources = sdc.min;
         infos.maxResources = sdc.max;
         infos.resourceItem = Item.getItemById(skill.gatheredRessourceItem);
         return infos;
      }
      
      public function getMaxSlotsByJobId(jobId:int) : int {
         var sd:SkillActionDescription = null;
         var sdc:SkillActionDescriptionCraft = null;
         var jd:JobDescription = this.getJobDescription(jobId);
         var max:int = 0;
         if(!jd)
         {
            return 0;
         }
         for each (sd in jd.skills)
         {
            if(sd is SkillActionDescriptionCraft)
            {
               sdc = sd as SkillActionDescriptionCraft;
               if(sdc.maxSlots > max)
               {
                  max = sdc.maxSlots;
               }
            }
         }
         return max;
      }
      
      public function getJobCraftSkillInfos(job:Job, skill:Skill) : Object {
         var jd:JobDescription = this.getJobDescription(job.id);
         if(!jd)
         {
            return null;
         }
         var sd:SkillActionDescription = this.getSkillActionDescription(jd,skill.id);
         if(!sd)
         {
            return null;
         }
         if(!(sd is SkillActionDescriptionCraft))
         {
            return null;
         }
         var sdc:SkillActionDescriptionCraft = sd as SkillActionDescriptionCraft;
         var infos:Object = new Object();
         infos.maxSlots = sdc.maxSlots;
         infos.probability = sdc.probability;
         if(skill.modifiableItemType > -1)
         {
            infos.modifiableItemType = ItemType.getItemTypeById(skill.modifiableItemType);
         }
         return infos;
      }
      
      public function getJobExperience(job:Job) : Object {
         var je:JobExperience = this.getJobExp(job.id);
         if(!je)
         {
            return null;
         }
         var xp:Object = new Object();
         xp.currentLevel = je.jobLevel;
         xp.currentExperience = je.jobXP;
         xp.levelExperienceFloor = je.jobXpLevelFloor;
         xp.levelExperienceCeil = je.jobXpNextLevelFloor;
         return xp;
      }
      
      public function getSkillFromId(skillId:int) : Object {
         return Skill.getSkillById(skillId);
      }
      
      public function getJobRecipes(job:Job, validSlotsCount:Array=null, skill:Skill=null, search:String=null) : Array {
         var sd:SkillActionDescription = null;
         var vectoruint:Vector.<uint> = null;
         var tempSortedArray:Object = null;
         var recipeWithSkill:Object = null;
         var recipeId:uint = 0;
         var craftables:Vector.<int> = null;
         var result:* = 0;
         var recipe:Recipe = null;
         var recipeSlots:uint = 0;
         var allowed:* = false;
         var i:uint = 0;
         var allowedCount:uint = 0;
         var ingredient:ItemWrapper = null;
         var jd:JobDescription = this.getJobDescription(job.id);
         if(!jd)
         {
            return null;
         }
         if(search)
         {
            search = search.toLowerCase();
         }
         var recipes:Dictionary = new Dictionary(true);
         var recipesResult:Array = new Array();
         if(validSlotsCount)
         {
            validSlotsCount.sort(Array.NUMERIC);
         }
         for each (sd in jd.skills)
         {
            if(!((skill) && (!(sd.skillId == skill.id))))
            {
               craftables = Skill.getSkillById(sd.skillId).craftableItemIds;
               for each (result in craftables)
               {
                  recipe = Recipe.getRecipeByResultId(result);
                  if(recipe)
                  {
                     recipeSlots = recipe.ingredientIds.length;
                     allowed = false;
                     if(validSlotsCount)
                     {
                        i = 0;
                        while(i < validSlotsCount.length)
                        {
                           allowedCount = validSlotsCount[i];
                           if(allowedCount == recipeSlots)
                           {
                              allowed = true;
                           }
                           else
                           {
                              if(allowedCount > recipeSlots)
                              {
                                 break;
                              }
                           }
                           i++;
                        }
                     }
                     else
                     {
                        allowed = true;
                     }
                     if(allowed)
                     {
                        if(search)
                        {
                           if(StringUtils.noAccent(Item.getItemById(result).name).toLowerCase().indexOf(StringUtils.noAccent(search)) != -1)
                           {
                              recipes[recipe.resultId] = new RecipeWithSkill(recipe,Skill.getSkillById(sd.skillId));
                           }
                           else
                           {
                              for each (ingredient in recipe.ingredients)
                              {
                                 if(StringUtils.noAccent(ingredient.name).toLowerCase().indexOf(StringUtils.noAccent(search)) != -1)
                                 {
                                    recipes[recipe.resultId] = new RecipeWithSkill(recipe,Skill.getSkillById(sd.skillId));
                                 }
                              }
                           }
                        }
                        else
                        {
                           recipes[recipe.resultId] = new RecipeWithSkill(recipe,Skill.getSkillById(sd.skillId));
                        }
                     }
                  }
               }
            }
         }
         vectoruint = new Vector.<uint>();
         for each (recipeWithSkill in recipes)
         {
            if(recipeWithSkill)
            {
               vectoruint.push(recipeWithSkill.recipe.resultId);
            }
         }
         tempSortedArray = GameDataQuery.sort(Item,vectoruint,["recipeSlots","level","name"],[false,false,true]);
         for each (recipeId in tempSortedArray)
         {
            recipesResult.push(recipes[recipeId]);
         }
         return recipesResult;
      }
      
      public function getRecipe(objectId:uint) : Recipe {
         return Recipe.getRecipeByResultId(objectId);
      }
      
      public function getRecipesList(objectId:uint) : Array {
         var recipeList:Array = Item.getItemById(objectId).recipes;
         if(recipeList)
         {
            return recipeList;
         }
         return new Array();
      }
      
      public function getJobName(pJobId:uint) : String {
         return Job.getJobById(pJobId).name;
      }
      
      public function getJob(pJobId:uint) : Object {
         return Job.getJobById(pJobId);
      }
      
      public function getJobCrafterDirectorySettingsById(jobId:uint) : Object {
         var job:Object = null;
         for each (job in this.jobsFrame.settings)
         {
            if((job) && (jobId == job.jobId))
            {
               return job;
            }
         }
         return null;
      }
      
      public function getJobCrafterDirectorySettingsByIndex(jobIndex:uint) : Object {
         return this.jobsFrame.settings[jobIndex];
      }
      
      public function getUsableSkillsInMap(playerId:int) : Array {
         var hasSkill:* = false;
         var skillId:uint = 0;
         var ie:InteractiveElement = null;
         var interactiveSkill:InteractiveElementSkill = null;
         var interactiveSkill2:InteractiveElementSkill = null;
         var usableSkills:Array = new Array();
         var rpContextFrame:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         var ies:Vector.<InteractiveElement> = rpContextFrame.entitiesFrame.interactiveElements;
         var skills:Vector.<uint> = rpContextFrame.getMultiCraftSkills(playerId);
         for each (skillId in skills)
         {
            hasSkill = false;
            for each (ie in ies)
            {
               for each (interactiveSkill in ie.enabledSkills)
               {
                  if((skillId == interactiveSkill.skillId) && (usableSkills.indexOf(interactiveSkill.skillId) == -1))
                  {
                     hasSkill = true;
                     break;
                  }
               }
               for each (interactiveSkill2 in ie.disabledSkills)
               {
                  if((skillId == interactiveSkill2.skillId) && (usableSkills.indexOf(interactiveSkill2.skillId) == -1))
                  {
                     hasSkill = true;
                     break;
                  }
               }
               if(hasSkill)
               {
                  break;
               }
            }
            if(hasSkill)
            {
               usableSkills.push(Skill.getSkillById(skillId));
            }
         }
         return usableSkills;
      }
      
      public function getKnownJob(jobId:uint) : KnownJob {
         if(!PlayedCharacterManager.getInstance().jobs)
         {
            return null;
         }
         var kj:KnownJob = PlayedCharacterManager.getInstance().jobs[jobId] as KnownJob;
         if(!kj)
         {
            return null;
         }
         return kj;
      }
      
      public function getRecipesByJob(details:Array, jobMaxSlots:Array, jobId:int=0, fromBank:Boolean=false, onlyRecipeWithXP:Boolean=false, onlyKnownJobs:Boolean=false, missingIngredientsTolerance:int=0, sortCriteria:String="level", sortDescending:Boolean=true, filterTypes:Array=null) : Vector.<Recipe> {
         var allRecipes:Array = null;
         var knownJobIds:Array = null;
         var key:String = null;
         var resourceItems:Vector.<ItemWrapper> = null;
         var ingredient:ItemWrapper = null;
         var recipe:Recipe = null;
         var resultTypeId:* = 0;
         var knownJobId:* = 0;
         var slotMax:* = 0;
         var job:Job = null;
         var skills:Object = null;
         var skill:* = undefined;
         var slot:uint = 0;
         var bagItems:Vector.<ItemWrapper> = null;
         var totalIngredients:* = 0;
         var requiredQty:* = 0;
         var totalQty:* = 0;
         var foundIngredients:* = 0;
         var foundIngredientsQty:* = 0;
         var occurences:Array = null;
         var missingIngredients:* = 0;
         var j:* = 0;
         var xp:* = 0;
         var potentialMaxOccurence:uint = 0;
         var val:uint = 0;
         var recipes:Vector.<Recipe> = new Vector.<Recipe>();
         knownJobIds = new Array();
         var knownJobs:Array = PlayedCharacterManager.getInstance().jobs;
         for (key in knownJobs)
         {
            knownJobId = int(key);
            knownJobIds.push(knownJobId);
            slotMax = 0;
            job = this.getJob(knownJobId) as Job;
            skills = this.getJobSkills(job);
            for each (skill in skills)
            {
               if(this.getJobSkillType(job,skill) == "craft")
               {
                  slot = this.getJobCraftSkillInfos(job,skill).maxSlots;
                  if(slot > slotMax)
                  {
                     slotMax = slot;
                  }
               }
            }
            jobMaxSlots[knownJobId] = slotMax;
         }
         if(onlyKnownJobs)
         {
            if((jobId > 0) && (knownJobIds.indexOf(jobId) == -1))
            {
               return recipes;
            }
         }
         if(fromBank)
         {
            resourceItems = InventoryManager.getInstance().bankInventory.getView("bank").content;
         }
         else
         {
            resourceItems = InventoryManager.getInstance().inventory.getView("storage").content;
         }
         var l:int = resourceItems.length;
         var i:int = 0;
         while(i < l)
         {
            ingredient = resourceItems[i];
            if(!ingredient.linked)
            {
               if(!details[ingredient.objectGID])
               {
                  details[ingredient.objectGID] = 
                     {
                        "totalQuantity":ingredient.quantity,
                        "stackUidList":[ingredient.objectUID],
                        "stackQtyList":[ingredient.quantity],
                        "fromBag":[false],
                        "storageTotalQuantity":ingredient.quantity
                     };
               }
               else
               {
                  details[ingredient.objectGID].totalQuantity = details[ingredient.objectGID].totalQuantity + ingredient.quantity;
                  details[ingredient.objectGID].stackUidList.push(ingredient.objectUID);
                  details[ingredient.objectGID].stackQtyList.push(ingredient.quantity);
                  details[ingredient.objectGID].fromBag.push(false);
                  details[ingredient.objectGID].storageTotalQuantity = details[ingredient.objectGID].storageTotalQuantity + ingredient.quantity;
               }
            }
            i++;
         }
         if(fromBank)
         {
            bagItems = InventoryManager.getInstance().inventory.getView("storage").content;
            l = bagItems.length;
            i = 0;
            while(i < l)
            {
               ingredient = bagItems[i];
               if(!ingredient.linked)
               {
                  if(!details[ingredient.objectGID])
                  {
                     details[ingredient.objectGID] = 
                        {
                           "totalQuantity":ingredient.quantity,
                           "stackUidList":[ingredient.objectUID],
                           "stackQtyList":[ingredient.quantity],
                           "fromBag":[true]
                        };
                  }
                  else
                  {
                     details[ingredient.objectGID].totalQuantity = details[ingredient.objectGID].totalQuantity + ingredient.quantity;
                     details[ingredient.objectGID].stackUidList.push(ingredient.objectUID);
                     details[ingredient.objectGID].stackQtyList.push(ingredient.quantity);
                     details[ingredient.objectGID].fromBag.push(true);
                  }
               }
               i++;
            }
         }
         if(jobId == 0)
         {
            allRecipes = Recipe.getAllRecipes();
         }
         else
         {
            allRecipes = Recipe.getRecipesByJobId(jobId);
         }
         l = allRecipes.length;
         var resultTypes:Dictionary = new Dictionary(true);
         i = 0;
         for(;i < l;i++)
         {
            recipe = allRecipes[i];
            totalIngredients = recipe.ingredientIds.length;
            if(!((!recipe.job) || (recipe.jobId == 1) || (onlyKnownJobs) && (jobId == 0) && (knownJobIds.indexOf(recipe.jobId) == -1)))
            {
               if(onlyRecipeWithXP)
               {
                  xp = 0;
                  if((knownJobIds.indexOf(recipe.jobId) == -1) || (!jobMaxSlots[recipe.jobId]))
                  {
                     continue;
                  }
                  if(jobMaxSlots[recipe.jobId] - totalIngredients < 4)
                  {
                     switch(totalIngredients)
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
                     }
                  }
                  if(xp == 0)
                  {
                     continue;
                  }
               }
               requiredQty = 0;
               totalQty = 0;
               foundIngredients = 0;
               foundIngredientsQty = 0;
               occurences = new Array();
               missingIngredients = missingIngredientsTolerance;
               j = 0;
               while(j < totalIngredients)
               {
                  requiredQty = requiredQty + recipe.quantities[j];
                  if(details[recipe.ingredientIds[j]])
                  {
                     totalQty = details[recipe.ingredientIds[j]].totalQuantity;
                  }
                  else
                  {
                     totalQty = 0;
                  }
                  if(totalQty)
                  {
                     if(totalQty >= recipe.quantities[j])
                     {
                        occurences.push(int(totalQty / recipe.quantities[j]));
                        foundIngredientsQty = foundIngredientsQty + recipe.quantities[j];
                        foundIngredients++;
                     }
                     else
                     {
                        occurences.push(0);
                        missingIngredients--;
                     }
                  }
                  else
                  {
                     if(missingIngredients > 0)
                     {
                        occurences.push(0);
                        missingIngredients--;
                     }
                  }
                  j++;
               }
               if((foundIngredients == recipe.ingredientIds.length) && (foundIngredientsQty >= requiredQty) || (missingIngredientsTolerance > 0) && (foundIngredients >= 1) && (foundIngredients + missingIngredientsTolerance >= recipe.ingredientIds.length))
               {
                  recipes.push(recipe);
                  resultTypes[recipe.resultTypeId] = recipe.resultTypeId;
                  occurences.sort(Array.NUMERIC);
                  if(!details[recipe.resultId])
                  {
                     details[recipe.resultId] = {"actualMaxOccurence":occurences[0]};
                  }
                  else
                  {
                     details[recipe.resultId].actualMaxOccurence = occurences[0];
                  }
                  if(fromBank)
                  {
                     potentialMaxOccurence = 0;
                     for each (val in occurences)
                     {
                        if(val != 0)
                        {
                           potentialMaxOccurence = val;
                           break;
                        }
                     }
                     details[recipe.resultId].potentialMaxOccurence = potentialMaxOccurence;
                  }
                  continue;
               }
               continue;
            }
         }
         for each (resultTypeId in resultTypes)
         {
            filterTypes[resultTypeId] = ItemType.getItemTypeById(resultTypes[resultTypeId]);
         }
         recipes.fixed = true;
         this.sortRecipes(recipes,sortCriteria,sortDescending?1:-1);
         return recipes;
      }
      
      public function sortRecipesByCriteria(recipes:Object, sortCriteria:String, sortDescending:Boolean) : Object {
         this.sortRecipes(recipes,sortCriteria,sortDescending?1:-1);
         return recipes;
      }
      
      private function sortRecipes(recipes:Object, criteria:String, way:int=1) : void {
         if(!this._stringSorter)
         {
            this._stringSorter = new Collator(XmlConfig.getInstance().getEntry("config.lang.current"));
         }
         switch(criteria)
         {
            case "ingredients":
               recipes.sort(this.compareIngredients(way));
               break;
            case "level":
               recipes.sort(this.compareLevel(way));
               break;
            case "price":
               recipes.sort(this.comparePrice(way));
               break;
         }
      }
      
      private function compareIngredients(way:int=1) : Function {
         return function(a:Recipe, b:Recipe):Number
         {
            var aL:* = a.ingredientIds.length;
            var bL:* = b.ingredientIds.length;
            if(aL < bL)
            {
               return -way;
            }
            if(aL > bL)
            {
               return way;
            }
            return _stringSorter.compare(a.resultName,b.resultName);
         };
      }
      
      private function compareLevel(way:int=1) : Function {
         return function(a:Recipe, b:Recipe):Number
         {
            if(a.resultLevel < b.resultLevel)
            {
               return -way;
            }
            if(a.resultLevel > b.resultLevel)
            {
               return way;
            }
            return _stringSorter.compare(a.resultName,b.resultName);
         };
      }
      
      private function comparePrice(way:int=1) : Function {
         return function(a:Recipe, b:Recipe):Number
         {
            var aL:* = averagePricesFrame.pricesData.items["item" + a.resultId];
            var bL:* = averagePricesFrame.pricesData.items["item" + b.resultId];
            if(!aL)
            {
               aL = way == 1?int.MAX_VALUE:0;
            }
            if(!bL)
            {
               bL = way == 1?int.MAX_VALUE:0;
            }
            if(aL < bL)
            {
               return -way;
            }
            if(aL > bL)
            {
               return way;
            }
            return _stringSorter.compare(a.resultName,b.resultName);
         };
      }
      
      private function getJobDescription(jobId:uint) : JobDescription {
         var kj:KnownJob = this.getKnownJob(jobId);
         if(!kj)
         {
            return null;
         }
         return kj.jobDescription;
      }
      
      private function getJobExp(jobId:uint) : JobExperience {
         var kj:KnownJob = this.getKnownJob(jobId);
         if(!kj)
         {
            return null;
         }
         return kj.jobExperience;
      }
      
      private function getSkillActionDescription(jd:JobDescription, skillId:uint) : SkillActionDescription {
         var sd:SkillActionDescription = null;
         for each (sd in jd.skills)
         {
            if(sd.skillId == skillId)
            {
               return sd;
            }
         }
         return null;
      }
   }
}
