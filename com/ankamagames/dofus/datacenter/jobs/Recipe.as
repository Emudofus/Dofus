package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
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
      
      public static function getRecipeByResultId(param1:int) : Recipe {
         return GameData.getObject(MODULE,param1) as Recipe;
      }
      
      public static function getAllRecipesForSkillId(param1:uint, param2:uint) : Array {
         var _loc5_:* = 0;
         var _loc6_:Recipe = null;
         var _loc7_:uint = 0;
         var _loc3_:Array = new Array();
         var _loc4_:Vector.<int> = Skill.getSkillById(param1).craftableItemIds;
         for each (_loc5_ in _loc4_)
         {
            _loc6_ = getRecipeByResultId(_loc5_);
            if(_loc6_)
            {
               _loc7_ = _loc6_.ingredientIds.length;
               if(_loc7_ <= param2)
               {
                  _loc3_.push(new RecipeWithSkill(_loc6_,Skill.getSkillById(param1)));
               }
            }
         }
         _loc3_ = _loc3_.sort(skillSortFunction);
         return _loc3_;
      }
      
      public static function getAllRecipes() : Array {
         return GameData.getObjects(MODULE) as Array;
      }
      
      public static function getRecipesByJobId(param1:uint) : Array {
         if(param1 == 1)
         {
            return null;
         }
         if(!_jobRecipes)
         {
            _jobRecipes = new Array();
         }
         if(_jobRecipes[param1])
         {
            return _jobRecipes[param1];
         }
         var _loc2_:Array = new Array();
         var _loc3_:Vector.<uint> = GameDataQuery.queryEquals(Recipe,"jobId",param1);
         var _loc4_:int = _loc3_.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_.push(GameData.getObject(MODULE,_loc3_[_loc5_]) as Recipe);
            _loc5_++;
         }
         _jobRecipes[param1] = _loc2_;
         return _loc2_;
      }
      
      private static function skillSortFunction(param1:RecipeWithSkill, param2:RecipeWithSkill) : Number {
         if(param1.recipe.quantities.length > param2.recipe.quantities.length)
         {
            return -1;
         }
         if(param1.recipe.quantities.length == param2.recipe.quantities.length)
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
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(!this._ingredients)
         {
            _loc1_ = this.ingredientIds.length;
            this._ingredients = new Vector.<ItemWrapper>(_loc1_,true);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._ingredients[_loc2_] = ItemWrapper.create(0,0,this.ingredientIds[_loc2_],this.quantities[_loc2_],null,false);
               _loc2_++;
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
