package com.ankamagames.dofus.datacenter.jobs
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Recipe extends Object implements IDataCenter
    {
        public var resultId:int;
        public var resultLevel:uint;
        public var ingredientIds:Vector.<int>;
        public var quantities:Vector.<uint>;
        private var _result:ItemWrapper;
        private var _ingredients:Vector.<ItemWrapper>;
        private static const MODULE:String = "Recipes";

        public function Recipe()
        {
            return;
        }// end function

        public function get result() : ItemWrapper
        {
            if (!this._result)
            {
                this._result = ItemWrapper.create(0, 0, this.resultId, 0, null, false);
            }
            return this._result;
        }// end function

        public function get ingredients() : Vector.<ItemWrapper>
        {
            var _loc_1:uint = 0;
            var _loc_2:uint = 0;
            if (!this._ingredients)
            {
                _loc_1 = this.ingredientIds.length;
                this._ingredients = new Vector.<ItemWrapper>(_loc_1, true);
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    this._ingredients[_loc_2] = ItemWrapper.create(0, 0, this.ingredientIds[_loc_2], this.quantities[_loc_2], null, false);
                    _loc_2 = _loc_2 + 1;
                }
            }
            return this._ingredients;
        }// end function

        public static function getRecipeByResultId(param1:int) : Recipe
        {
            return GameData.getObject(MODULE, param1) as Recipe;
        }// end function

        public static function getAllRecipesForSkillId(param1:uint, param2:uint) : Array
        {
            var _loc_5:int = 0;
            var _loc_6:Recipe = null;
            var _loc_7:uint = 0;
            var _loc_3:* = new Array();
            var _loc_4:* = Skill.getSkillById(param1).craftableItemIds;
            for each (_loc_5 in _loc_4)
            {
                
                _loc_6 = getRecipeByResultId(_loc_5);
                if (_loc_6)
                {
                    _loc_7 = _loc_6.ingredientIds.length;
                    if (_loc_7 <= param2)
                    {
                        _loc_3.push(new RecipeWithSkill(_loc_6, Skill.getSkillById(param1)));
                    }
                }
            }
            _loc_3 = _loc_3.sort(skillSortFunction);
            return _loc_3;
        }// end function

        private static function skillSortFunction(param1:RecipeWithSkill, param2:RecipeWithSkill) : Number
        {
            if (param1.recipe.quantities.length > param2.recipe.quantities.length)
            {
                return -1;
            }
            if (param1.recipe.quantities.length == param2.recipe.quantities.length)
            {
                return 0;
            }
            return 1;
        }// end function

    }
}
