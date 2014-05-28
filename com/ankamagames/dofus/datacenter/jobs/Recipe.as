package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.dofus.internalDatacenter.jobs.RecipeWithSkill;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Recipe extends Object implements IDataCenter
   {
      
      public function Recipe() {
         super();
      }
      
      public static const MODULE:String = "Recipes";
      
      private static var _jobRecipes:Array;
      
      public static function getRecipeByResultId(resultId:int) : Recipe {
         return GameData.getObject(MODULE,resultId) as Recipe;
      }
      
      public static function getAllRecipesForSkillId(pSkillId:uint, pMaxCase:uint) : Array {
         var result:* = 0;
         var recipe:Recipe = null;
         var recipeSlots:uint = 0;
         var recipes:Array = new Array();
         var craftables:Vector.<int> = Skill.getSkillById(pSkillId).craftableItemIds;
         for each(result in craftables)
         {
            recipe = getRecipeByResultId(result);
            if(recipe)
            {
               recipeSlots = recipe.ingredientIds.length;
               if(recipeSlots <= pMaxCase)
               {
                  recipes.push(new RecipeWithSkill(recipe,Skill.getSkillById(pSkillId)));
               }
            }
         }
         recipes = recipes.sort(skillSortFunction);
         return recipes;
      }
      
      public static function getAllRecipes() : Array {
         return GameData.getObjects(MODULE) as Array;
      }
      
      public static function getRecipesByJobId(jobId:uint) : Array {
         if(jobId == 1)
         {
            return null;
         }
         if(!_jobRecipes)
         {
            _jobRecipes = new Array();
         }
         if(_jobRecipes[jobId])
         {
            return _jobRecipes[jobId];
         }
         var results:Array = new Array();
         var recipeIds:Vector.<uint> = GameDataQuery.queryEquals(Recipe,"jobId",jobId);
         var l:int = recipeIds.length;
         var i:int = 0;
         while(i < recipeIds.length)
         {
            results.push(GameData.getObject(MODULE,recipeIds[i]) as Recipe);
            i++;
         }
         _jobRecipes[jobId] = results;
         return results;
      }
      
      private static function skillSortFunction(a:RecipeWithSkill, b:RecipeWithSkill) : Number {
         if(a.recipe.quantities.length > b.recipe.quantities.length)
         {
            return -1;
         }
         if(a.recipe.quantities.length == b.recipe.quantities.length)
         {
            return 0;
         }
         return 1;
      }
      
      public var resultId:int;
      
      public var resultNameId:uint;
      
      public var resultTypeId:uint;
      
      public var resultLevel:uint;
      
      public var ingredientIds:Vector.<int>;
      
      public var quantities:Vector.<uint>;
      
      public var jobId:int;
      
      public var skillId:int;
      
      private var _result:ItemWrapper;
      
      private var _resultName:String;
      
      private var _ingredients:Vector.<ItemWrapper>;
      
      private var _job:Job;
      
      private var _skill:Skill;
      
      public function get result() : ItemWrapper {
         if(!this._result)
         {
            this._result = ItemWrapper.create(0,0,this.resultId,0,null,false);
         }
         return this._result;
      }
      
      public function get resultName() : String {
         if(!this._resultName)
         {
            this._resultName = I18n.getText(this.resultNameId);
         }
         return this._resultName;
      }
      
      public function get ingredients() : Vector.<ItemWrapper> {
         var ingredientsCount:uint = 0;
         var i:uint = 0;
         if(!this._ingredients)
         {
            ingredientsCount = this.ingredientIds.length;
            this._ingredients = new Vector.<ItemWrapper>(ingredientsCount,true);
            i = 0;
            while(i < ingredientsCount)
            {
               this._ingredients[i] = ItemWrapper.create(0,0,this.ingredientIds[i],this.quantities[i],null,false);
               i++;
            }
         }
         return this._ingredients;
      }
      
      public function get job() : Job {
         if(!this._job)
         {
            this._job = Job.getJobById(this.jobId);
         }
         return this._job;
      }
      
      public function get skill() : Skill {
         if(!this._skill)
         {
            this._skill = Skill.getSkillById(this.skillId);
         }
         return this._skill;
      }
   }
}
