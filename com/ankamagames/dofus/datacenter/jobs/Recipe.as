package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.internalDatacenter.jobs.RecipeWithSkill;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;


   public class Recipe extends Object implements IDataCenter
   {
         

      public function Recipe() {
         super();
      }

      public static const MODULE:String = "Recipes";

      public static function getRecipeByResultId(resultId:int) : Recipe {
         return GameData.getObject(MODULE,resultId) as Recipe;
      }

      public static function getAllRecipesForSkillId(pSkillId:uint, pMaxCase:uint) : Array {
         var result:* = 0;
         var recipe:Recipe = null;
         var recipeSlots:uint = 0;
         var recipes:Array = new Array();
         var craftables:Vector.<int> = Skill.getSkillById(pSkillId).craftableItemIds;
         for each (result in craftables)
         {
            recipe=getRecipeByResultId(result);
            if(recipe)
            {
               recipeSlots=recipe.ingredientIds.length;
               if(recipeSlots<=pMaxCase)
               {
                  recipes.push(new RecipeWithSkill(recipe,Skill.getSkillById(pSkillId)));
               }
            }
         }
         recipes=recipes.sort(skillSortFunction);
         return recipes;
      }

      private static function skillSortFunction(a:RecipeWithSkill, b:RecipeWithSkill) : Number {
         if(a.recipe.quantities.length>b.recipe.quantities.length)
         {
            return -1;
         }
         if(a.recipe.quantities.length==b.recipe.quantities.length)
         {
            return 0;
         }
         return 1;
      }

      public var resultId:int;

      public var resultLevel:uint;

      public var ingredientIds:Vector.<int>;

      public var quantities:Vector.<uint>;

      private var _result:ItemWrapper;

      private var _ingredients:Vector.<ItemWrapper>;

      public function get result() : ItemWrapper {
         if(!this._result)
         {
            this._result=ItemWrapper.create(0,0,this.resultId,0,null,false);
         }
         return this._result;
      }

      public function get ingredients() : Vector.<ItemWrapper> {
         var ingredientsCount:uint = 0;
         var i:uint = 0;
         if(!this._ingredients)
         {
            ingredientsCount=this.ingredientIds.length;
            this._ingredients=new Vector.<ItemWrapper>(ingredientsCount,true);
            i=0;
            while(i<ingredientsCount)
            {
               this._ingredients[i]=ItemWrapper.create(0,0,this.ingredientIds[i],this.quantities[i],null,false);
               i++;
            }
         }
         return this._ingredients;
      }
   }

}