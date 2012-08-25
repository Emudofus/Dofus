package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.dofus.network.types.game.interactive.skill.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.utils.*;

    public class JobsApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function JobsApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(JobsApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        private function get jobsFrame() : JobsFrame
        {
            return Kernel.getWorker().getFrame(JobsFrame) as JobsFrame;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getKnownJobs() : Array
        {
            var _loc_3:KnownJob = null;
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            if (!PlayedCharacterManager.getInstance().jobs)
            {
                return null;
            }
            var _loc_1:* = new Array();
            var _loc_2:* = new Array();
            for each (_loc_3 in PlayedCharacterManager.getInstance().jobs)
            {
                
                if (_loc_3 == null)
                {
                    continue;
                }
                _loc_1[_loc_3.jobPosition] = Job.getJobById(_loc_3.jobDescription.jobId);
            }
            _loc_4 = 0;
            _loc_5 = 0;
            while (_loc_5 < 6)
            {
                
                if (_loc_1[_loc_5] && _loc_1[_loc_5].specializationOfId == 0)
                {
                    _loc_2.push(_loc_1[_loc_5]);
                }
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:uint = 0;
            while (_loc_6 < 6)
            {
                
                if (_loc_1[_loc_6] && _loc_1[_loc_6].specializationOfId > 0)
                {
                    _loc_2[3 + _loc_4] = _loc_1[_loc_6];
                    _loc_4 = _loc_4 + 1;
                }
                _loc_6 = _loc_6 + 1;
            }
            return _loc_2;
        }// end function

        public function getJobSkills(param1:Job) : Array
        {
            var _loc_5:SkillActionDescription = null;
            var _loc_2:* = this.getJobDescription(param1.id);
            if (!_loc_2)
            {
                return null;
            }
            var _loc_3:* = new Array(_loc_2.skills.length);
            var _loc_4:uint = 0;
            for each (_loc_5 in _loc_2.skills)
            {
                
                _loc_3[++_loc_4] = Skill.getSkillById(_loc_5.skillId);
            }
            return _loc_3;
        }// end function

        public function getJobSkillType(param1:Job, param2:Skill) : String
        {
            var _loc_3:* = this.getJobDescription(param1.id);
            if (!_loc_3)
            {
                return "unknown";
            }
            var _loc_4:* = this.getSkillActionDescription(_loc_3, param2.id);
            if (!this.getSkillActionDescription(_loc_3, param2.id))
            {
                return "unknown";
            }
            switch(true)
            {
                case _loc_4 is SkillActionDescriptionCollect:
                {
                    return "collect";
                }
                case _loc_4 is SkillActionDescriptionCraft:
                {
                    return "craft";
                }
                default:
                {
                    break;
                }
            }
            this._log.warn("Unknown SkillActionDescription type : " + _loc_4);
            return "unknown";
        }// end function

        public function getJobCollectSkillInfos(param1:Job, param2:Skill) : Object
        {
            var _loc_3:* = this.getJobDescription(param1.id);
            if (!_loc_3)
            {
                return null;
            }
            var _loc_4:* = this.getSkillActionDescription(_loc_3, param2.id);
            if (!this.getSkillActionDescription(_loc_3, param2.id))
            {
                return null;
            }
            if (!(_loc_4 is SkillActionDescriptionCollect))
            {
                return null;
            }
            var _loc_5:* = _loc_4 as SkillActionDescriptionCollect;
            var _loc_6:* = new Object();
            new Object().time = _loc_5.time / 10;
            _loc_6.minResources = _loc_5.min;
            _loc_6.maxResources = _loc_5.max;
            _loc_6.resourceItem = Item.getItemById(param2.gatheredRessourceItem);
            return _loc_6;
        }// end function

        public function getMaxSlotsByJobId(param1:int) : int
        {
            var _loc_4:SkillActionDescription = null;
            var _loc_5:SkillActionDescriptionCraft = null;
            var _loc_2:* = this.getJobDescription(param1);
            var _loc_3:int = 0;
            if (!_loc_2)
            {
                return 0;
            }
            for each (_loc_4 in _loc_2.skills)
            {
                
                if (_loc_4 is SkillActionDescriptionCraft)
                {
                    _loc_5 = _loc_4 as SkillActionDescriptionCraft;
                    if (_loc_5.maxSlots > _loc_3)
                    {
                        _loc_3 = _loc_5.maxSlots;
                    }
                }
            }
            return _loc_3;
        }// end function

        public function getJobCraftSkillInfos(param1:Job, param2:Skill) : Object
        {
            var _loc_8:SkillActionDescriptionCraftExtended = null;
            var _loc_3:* = this.getJobDescription(param1.id);
            if (!_loc_3)
            {
                return null;
            }
            var _loc_4:* = this.getSkillActionDescription(_loc_3, param2.id);
            if (!this.getSkillActionDescription(_loc_3, param2.id))
            {
                return null;
            }
            if (!(_loc_4 is SkillActionDescriptionCraft))
            {
                return null;
            }
            var _loc_5:* = _loc_4 as SkillActionDescriptionCraft;
            var _loc_6:* = new Object();
            new Object().maxSlots = _loc_5.maxSlots;
            _loc_6.probability = _loc_5.probability;
            if (_loc_4 is SkillActionDescriptionCraftExtended)
            {
                _loc_8 = _loc_4 as SkillActionDescriptionCraftExtended;
                _loc_6.thresholdSlots = _loc_8.thresholdSlots;
            }
            if (param2.modifiableItemType > -1)
            {
                _loc_6.modifiableItemType = ItemType.getItemTypeById(param2.modifiableItemType);
            }
            if (!(_loc_5 is SkillActionDescriptionCraftExtended))
            {
                return _loc_6;
            }
            var _loc_7:* = _loc_5 as SkillActionDescriptionCraftExtended;
            _loc_6.thresholdSlots = _loc_7.thresholdSlots;
            return _loc_6;
        }// end function

        public function getJobExperience(param1:Job) : Object
        {
            var _loc_2:* = this.getJobExp(param1.id);
            if (!_loc_2)
            {
                return null;
            }
            var _loc_3:* = new Object();
            _loc_3.currentLevel = _loc_2.jobLevel;
            _loc_3.currentExperience = _loc_2.jobXP;
            _loc_3.levelExperienceFloor = _loc_2.jobXpLevelFloor;
            _loc_3.levelExperienceCeil = _loc_2.jobXpNextLevelFloor;
            return _loc_3;
        }// end function

        public function getSkillFromId(param1:int) : Object
        {
            return Skill.getSkillById(param1);
        }// end function

        public function getJobRecipes(param1:Job, param2:Array = null, param3:Skill = null, param4:String = null) : Array
        {
            var _loc_7:SkillActionDescription = null;
            var _loc_8:Vector.<int> = null;
            var _loc_9:int = 0;
            var _loc_10:Recipe = null;
            var _loc_11:uint = 0;
            var _loc_12:Boolean = false;
            var _loc_13:uint = 0;
            var _loc_14:uint = 0;
            var _loc_15:ItemWrapper = null;
            var _loc_5:* = this.getJobDescription(param1.id);
            if (!this.getJobDescription(param1.id))
            {
                return null;
            }
            if (param4)
            {
                param4 = param4.toLowerCase();
            }
            var _loc_6:* = new Array();
            if (param2)
            {
                param2.sort(Array.NUMERIC);
            }
            for each (_loc_7 in _loc_5.skills)
            {
                
                if (param3 && _loc_7.skillId != param3.id)
                {
                    continue;
                }
                _loc_8 = Skill.getSkillById(_loc_7.skillId).craftableItemIds;
                for each (_loc_9 in _loc_8)
                {
                    
                    _loc_10 = Recipe.getRecipeByResultId(_loc_9);
                    if (!_loc_10)
                    {
                        continue;
                    }
                    _loc_11 = _loc_10.ingredientIds.length;
                    _loc_12 = false;
                    if (param2)
                    {
                        _loc_13 = 0;
                        while (_loc_13 < param2.length)
                        {
                            
                            _loc_14 = param2[_loc_13];
                            if (_loc_14 == _loc_11)
                            {
                                _loc_12 = true;
                            }
                            else if (_loc_14 > _loc_11)
                            {
                                break;
                            }
                            _loc_13 = _loc_13 + 1;
                        }
                    }
                    else
                    {
                        _loc_12 = true;
                    }
                    if (_loc_12)
                    {
                        if (param4)
                        {
                            if (StringUtils.noAccent(Item.getItemById(_loc_9).name).toLowerCase().indexOf(StringUtils.noAccent(param4)) != -1)
                            {
                                _loc_6.push(new RecipeWithSkill(_loc_10, Skill.getSkillById(_loc_7.skillId)));
                            }
                            else
                            {
                                for each (_loc_15 in _loc_10.ingredients)
                                {
                                    
                                    if (StringUtils.noAccent(_loc_15.name).toLowerCase().indexOf(StringUtils.noAccent(param4)) != -1)
                                    {
                                        _loc_6.push(new RecipeWithSkill(_loc_10, Skill.getSkillById(_loc_7.skillId)));
                                    }
                                }
                            }
                            continue;
                        }
                        _loc_6.push(new RecipeWithSkill(_loc_10, Skill.getSkillById(_loc_7.skillId)));
                    }
                }
            }
            _loc_6.sort(this.skillSortFunction);
            return _loc_6;
        }// end function

        public function getRecipe(param1:uint) : Recipe
        {
            return Recipe.getRecipeByResultId(param1);
        }// end function

        public function getRecipesList(param1:uint) : Array
        {
            var _loc_2:* = Item.getItemById(param1).recipes;
            if (_loc_2)
            {
                return _loc_2;
            }
            return new Array();
        }// end function

        public function getJobName(param1:uint) : String
        {
            return Job.getJobById(param1).name;
        }// end function

        public function getJob(param1:uint) : Object
        {
            return Job.getJobById(param1);
        }// end function

        public function getJobCrafterDirectorySettingsById(param1:uint) : Object
        {
            var _loc_2:Object = null;
            for each (_loc_2 in this.jobsFrame.settings)
            {
                
                if (_loc_2 && param1 == _loc_2.jobId)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getJobCrafterDirectorySettingsByIndex(param1:uint) : Object
        {
            return this.jobsFrame.settings[param1];
        }// end function

        public function getUsableSkillsInMap(param1:int) : Array
        {
            var _loc_6:Boolean = false;
            var _loc_7:uint = 0;
            var _loc_8:InteractiveElement = null;
            var _loc_9:InteractiveElementSkill = null;
            var _loc_2:* = new Array();
            var _loc_3:* = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            var _loc_4:* = _loc_3.entitiesFrame.interactiveElements;
            var _loc_5:* = _loc_3.getMultiCraftSkills(param1);
            for each (_loc_7 in _loc_5)
            {
                
                _loc_6 = false;
                for each (_loc_8 in _loc_4)
                {
                    
                    for each (_loc_9 in _loc_8.enabledSkills)
                    {
                        
                        if (_loc_7 == _loc_9.skillId && _loc_2.indexOf(_loc_9.skillId) == -1)
                        {
                            _loc_6 = true;
                            break;
                        }
                    }
                    if (_loc_6)
                    {
                        break;
                    }
                }
                if (_loc_6)
                {
                    _loc_2.push(Skill.getSkillById(_loc_7));
                }
            }
            return _loc_2;
        }// end function

        public function getKnownJob(param1:uint) : KnownJob
        {
            if (!PlayedCharacterManager.getInstance().jobs)
            {
                return null;
            }
            var _loc_2:* = PlayedCharacterManager.getInstance().jobs[param1] as KnownJob;
            if (!_loc_2)
            {
                return null;
            }
            return _loc_2;
        }// end function

        private function skillSortFunction(param1:RecipeWithSkill, param2:RecipeWithSkill) : Number
        {
            var _loc_5:uint = 0;
            var _loc_6:uint = 0;
            var _loc_3:* = param1.recipe.quantities.length;
            var _loc_4:* = param2.recipe.quantities.length;
            if (_loc_3 > _loc_4)
            {
                return -1;
            }
            if (_loc_3 == _loc_4)
            {
                _loc_5 = param1.recipe.resultLevel;
                _loc_6 = param2.recipe.resultLevel;
                if (_loc_5 > _loc_6)
                {
                    return -1;
                }
                if (_loc_5 == _loc_6)
                {
                    return 0;
                }
                return 1;
            }
            return 1;
        }// end function

        private function getJobDescription(param1:uint) : JobDescription
        {
            var _loc_2:* = this.getKnownJob(param1);
            if (!_loc_2)
            {
                return null;
            }
            return _loc_2.jobDescription;
        }// end function

        private function getJobExp(param1:uint) : JobExperience
        {
            var _loc_2:* = this.getKnownJob(param1);
            if (!_loc_2)
            {
                return null;
            }
            return _loc_2.jobExperience;
        }// end function

        private function getSkillActionDescription(param1:JobDescription, param2:uint) : SkillActionDescription
        {
            var _loc_3:SkillActionDescription = null;
            for each (_loc_3 in param1.skills)
            {
                
                if (_loc_3.skillId == param2)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

    }
}
