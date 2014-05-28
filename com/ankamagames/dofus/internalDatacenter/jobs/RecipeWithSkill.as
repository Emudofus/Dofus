package com.ankamagames.dofus.internalDatacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   
   public class RecipeWithSkill extends Object implements IDataCenter
   {
      
      public function RecipeWithSkill(recipe:Recipe, skill:Skill) {
         super();
         this._recipe = recipe;
         this._skill = skill;
      }
      
      private var _recipe:Recipe;
      
      private var _skill:Skill;
      
      public function get recipe() : Recipe {
         return this._recipe;
      }
      
      public function get skill() : Skill {
         return this._skill;
      }
   }
}
