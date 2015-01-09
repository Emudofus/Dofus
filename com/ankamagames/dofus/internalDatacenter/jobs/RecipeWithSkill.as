package com.ankamagames.dofus.internalDatacenter.jobs
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.datacenter.jobs.Recipe;
    import com.ankamagames.dofus.datacenter.jobs.Skill;

    public class RecipeWithSkill implements IDataCenter 
    {

        private var _recipe:Recipe;
        private var _skill:Skill;

        public function RecipeWithSkill(recipe:Recipe, skill:Skill)
        {
            this._recipe = recipe;
            this._skill = skill;
        }

        public function get recipe():Recipe
        {
            return (this._recipe);
        }

        public function get skill():Skill
        {
            return (this._skill);
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.jobs

