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
         for each(kj in PlayedCharacterManager.getInstance().jobs)
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
         for each(sd in jd.skills)
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
            default:
               this._log.warn("Unknown SkillActionDescription type : " + sd);
               return "unknown";
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
         for each(sd in jd.skills)
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
      
      public function getJobRecipes(job:Job, validSlotsCount:Array = null, skill:Skill = null, search:String = null) : Array {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
         for each(job in this.jobsFrame.settings)
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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
      
      public function getRecipesByJob(details:Array, jobMaxSlots:Array, jobId:int = 0, fromBank:Boolean = false, onlyRecipeWithXP:Boolean = false, onlyKnownJobs:Boolean = false, missingIngredientsTolerance:int = 0, sortCriteria:String = "level", sortDescending:Boolean = true, filterTypes:Array = null) : Vector.<Recipe> {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function sortRecipesByCriteria(recipes:Object, sortCriteria:String, sortDescending:Boolean) : Object {
         this.sortRecipes(recipes,sortCriteria,sortDescending?1:-1);
         return recipes;
      }
      
      private function sortRecipes(recipes:Object, criteria:String, way:int = 1) : void {
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
      
      private function compareIngredients(way:int = 1) : Function {
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
      
      private function compareLevel(way:int = 1) : Function {
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
      
      private function comparePrice(way:int = 1) : Function {
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
         for each(sd in jd.skills)
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
