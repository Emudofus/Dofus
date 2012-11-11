package com.ankamagames.dofus.internalDatacenter.jobs
{
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class RecipeWithSkill extends Object implements IDataCenter
    {
        private var _recipe:Recipe;
        private var _skill:Skill;

        public function RecipeWithSkill(param1:Recipe, param2:Skill)
        {
            this._recipe = param1;
            this._skill = param2;
            return;
        }// end function

        public function get recipe() : Recipe
        {
            return this._recipe;
        }// end function

        public function get skill() : Skill
        {
            return this._skill;
        }// end function

    }
}
