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
   import __AS3__.vec.Vector;
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
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
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
         var _loc3_:KnownJob = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(!PlayedCharacterManager.getInstance().jobs)
         {
            return null;
         }
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         for each (_loc3_ in PlayedCharacterManager.getInstance().jobs)
         {
            if(_loc3_ != null)
            {
               _loc1_[_loc3_.jobPosition] = Job.getJobById(_loc3_.jobDescription.jobId);
            }
         }
         _loc4_ = 0;
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            if((_loc1_[_loc5_]) && _loc1_[_loc5_].specializationOfId == 0)
            {
               _loc2_.push(_loc1_[_loc5_]);
            }
            _loc5_++;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < 6)
         {
            if((_loc1_[_loc6_]) && _loc1_[_loc6_].specializationOfId > 0)
            {
               _loc2_[3 + _loc4_] = _loc1_[_loc6_];
               _loc4_++;
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      public function getJobSkills(param1:Job) : Array {
         var _loc5_:SkillActionDescription = null;
         var _loc2_:JobDescription = this.getJobDescription(param1.id);
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Array = new Array(_loc2_.skills.length);
         var _loc4_:uint = 0;
         for each (_loc5_ in _loc2_.skills)
         {
            _loc3_[_loc4_++] = Skill.getSkillById(_loc5_.skillId);
         }
         return _loc3_;
      }
      
      public function getJobSkillType(param1:Job, param2:Skill) : String {
         var _loc3_:JobDescription = this.getJobDescription(param1.id);
         if(!_loc3_)
         {
            return "unknown";
         }
         var _loc4_:SkillActionDescription = this.getSkillActionDescription(_loc3_,param2.id);
         if(!_loc4_)
         {
            return "unknown";
         }
         switch(true)
         {
            case _loc4_ is SkillActionDescriptionCollect:
               return "collect";
            case _loc4_ is SkillActionDescriptionCraft:
               return "craft";
            default:
               this._log.warn("Unknown SkillActionDescription type : " + _loc4_);
               return "unknown";
         }
      }
      
      public function getJobCollectSkillInfos(param1:Job, param2:Skill) : Object {
         var _loc3_:JobDescription = this.getJobDescription(param1.id);
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:SkillActionDescription = this.getSkillActionDescription(_loc3_,param2.id);
         if(!_loc4_)
         {
            return null;
         }
         if(!(_loc4_ is SkillActionDescriptionCollect))
         {
            return null;
         }
         var _loc5_:SkillActionDescriptionCollect = _loc4_ as SkillActionDescriptionCollect;
         var _loc6_:Object = new Object();
         _loc6_.time = _loc5_.time / 10;
         _loc6_.minResources = _loc5_.min;
         _loc6_.maxResources = _loc5_.max;
         _loc6_.resourceItem = Item.getItemById(param2.gatheredRessourceItem);
         return _loc6_;
      }
      
      public function getMaxSlotsByJobId(param1:int) : int {
         var _loc4_:SkillActionDescription = null;
         var _loc5_:SkillActionDescriptionCraft = null;
         var _loc2_:JobDescription = this.getJobDescription(param1);
         var _loc3_:* = 0;
         if(!_loc2_)
         {
            return 0;
         }
         for each (_loc4_ in _loc2_.skills)
         {
            if(_loc4_ is SkillActionDescriptionCraft)
            {
               _loc5_ = _loc4_ as SkillActionDescriptionCraft;
               if(_loc5_.maxSlots > _loc3_)
               {
                  _loc3_ = _loc5_.maxSlots;
               }
            }
         }
         return _loc3_;
      }
      
      public function getJobCraftSkillInfos(param1:Job, param2:Skill) : Object {
         var _loc3_:JobDescription = this.getJobDescription(param1.id);
         if(!_loc3_)
         {
            return null;
         }
         var _loc4_:SkillActionDescription = this.getSkillActionDescription(_loc3_,param2.id);
         if(!_loc4_)
         {
            return null;
         }
         if(!(_loc4_ is SkillActionDescriptionCraft))
         {
            return null;
         }
         var _loc5_:SkillActionDescriptionCraft = _loc4_ as SkillActionDescriptionCraft;
         var _loc6_:Object = new Object();
         _loc6_.maxSlots = _loc5_.maxSlots;
         _loc6_.probability = _loc5_.probability;
         if(param2.modifiableItemType > -1)
         {
            _loc6_.modifiableItemType = ItemType.getItemTypeById(param2.modifiableItemType);
         }
         return _loc6_;
      }
      
      public function getJobExperience(param1:Job) : Object {
         var _loc2_:JobExperience = this.getJobExp(param1.id);
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Object = new Object();
         _loc3_.currentLevel = _loc2_.jobLevel;
         _loc3_.currentExperience = _loc2_.jobXP;
         _loc3_.levelExperienceFloor = _loc2_.jobXpLevelFloor;
         _loc3_.levelExperienceCeil = _loc2_.jobXpNextLevelFloor;
         return _loc3_;
      }
      
      public function getSkillFromId(param1:int) : Object {
         return Skill.getSkillById(param1);
      }
      
      public function getJobRecipes(param1:Job, param2:Array=null, param3:Skill=null, param4:String=null) : Array {
         var _loc8_:SkillActionDescription = null;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<int> = null;
         var _loc14_:* = 0;
         var _loc15_:Recipe = null;
         var _loc16_:uint = 0;
         var _loc17_:* = false;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:ItemWrapper = null;
         var _loc5_:JobDescription = this.getJobDescription(param1.id);
         if(!_loc5_)
         {
            return null;
         }
         if(param4)
         {
            param4 = param4.toLowerCase();
         }
         var _loc6_:Dictionary = new Dictionary(true);
         var _loc7_:Array = new Array();
         if(param2)
         {
            param2.sort(Array.NUMERIC);
         }
         for each (_loc8_ in _loc5_.skills)
         {
            if(!((param3) && !(_loc8_.skillId == param3.id)))
            {
               _loc13_ = Skill.getSkillById(_loc8_.skillId).craftableItemIds;
               for each (_loc14_ in _loc13_)
               {
                  _loc15_ = Recipe.getRecipeByResultId(_loc14_);
                  if(_loc15_)
                  {
                     _loc16_ = _loc15_.ingredientIds.length;
                     _loc17_ = false;
                     if(param2)
                     {
                        _loc18_ = 0;
                        while(_loc18_ < param2.length)
                        {
                           _loc19_ = param2[_loc18_];
                           if(_loc19_ == _loc16_)
                           {
                              _loc17_ = true;
                           }
                           else
                           {
                              if(_loc19_ > _loc16_)
                              {
                                 break;
                              }
                           }
                           _loc18_++;
                        }
                     }
                     else
                     {
                        _loc17_ = true;
                     }
                     if(_loc17_)
                     {
                        if(param4)
                        {
                           if(StringUtils.noAccent(Item.getItemById(_loc14_).name).toLowerCase().indexOf(StringUtils.noAccent(param4)) != -1)
                           {
                              _loc6_[_loc15_.resultId] = new RecipeWithSkill(_loc15_,Skill.getSkillById(_loc8_.skillId));
                           }
                           else
                           {
                              for each (_loc20_ in _loc15_.ingredients)
                              {
                                 if(StringUtils.noAccent(_loc20_.name).toLowerCase().indexOf(StringUtils.noAccent(param4)) != -1)
                                 {
                                    _loc6_[_loc15_.resultId] = new RecipeWithSkill(_loc15_,Skill.getSkillById(_loc8_.skillId));
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc6_[_loc15_.resultId] = new RecipeWithSkill(_loc15_,Skill.getSkillById(_loc8_.skillId));
                        }
                     }
                  }
               }
            }
         }
         _loc9_ = new Vector.<uint>();
         for each (_loc11_ in _loc6_)
         {
            if(_loc11_)
            {
               _loc9_.push(_loc11_.recipe.resultId);
            }
         }
         _loc10_ = GameDataQuery.sort(Item,_loc9_,["recipeSlots","level","name"],[false,false,true]);
         for each (_loc12_ in _loc10_)
         {
            _loc7_.push(_loc6_[_loc12_]);
         }
         return _loc7_;
      }
      
      public function getRecipe(param1:uint) : Recipe {
         return Recipe.getRecipeByResultId(param1);
      }
      
      public function getRecipesList(param1:uint) : Array {
         var _loc2_:Array = Item.getItemById(param1).recipes;
         if(_loc2_)
         {
            return _loc2_;
         }
         return new Array();
      }
      
      public function getJobName(param1:uint) : String {
         return Job.getJobById(param1).name;
      }
      
      public function getJob(param1:uint) : Object {
         return Job.getJobById(param1);
      }
      
      public function getJobCrafterDirectorySettingsById(param1:uint) : Object {
         var _loc2_:Object = null;
         for each (_loc2_ in this.jobsFrame.settings)
         {
            if((_loc2_) && param1 == _loc2_.jobId)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getJobCrafterDirectorySettingsByIndex(param1:uint) : Object {
         return this.jobsFrame.settings[param1];
      }
      
      public function getUsableSkillsInMap(param1:int) : Array {
         var _loc6_:* = false;
         var _loc7_:uint = 0;
         var _loc8_:InteractiveElement = null;
         var _loc9_:InteractiveElementSkill = null;
         var _loc10_:InteractiveElementSkill = null;
         var _loc2_:Array = new Array();
         var _loc3_:RoleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
         var _loc4_:Vector.<InteractiveElement> = _loc3_.entitiesFrame.interactiveElements;
         var _loc5_:Vector.<uint> = _loc3_.getMultiCraftSkills(param1);
         for each (_loc7_ in _loc5_)
         {
            _loc6_ = false;
            for each (_loc8_ in _loc4_)
            {
               for each (_loc9_ in _loc8_.enabledSkills)
               {
                  if(_loc7_ == _loc9_.skillId && _loc2_.indexOf(_loc9_.skillId) == -1)
                  {
                     _loc6_ = true;
                     break;
                  }
               }
               for each (_loc10_ in _loc8_.disabledSkills)
               {
                  if(_loc7_ == _loc10_.skillId && _loc2_.indexOf(_loc10_.skillId) == -1)
                  {
                     _loc6_ = true;
                     break;
                  }
               }
               if(_loc6_)
               {
                  break;
               }
            }
            if(_loc6_)
            {
               _loc2_.push(Skill.getSkillById(_loc7_));
            }
         }
         return _loc2_;
      }
      
      public function getKnownJob(param1:uint) : KnownJob {
         if(!PlayedCharacterManager.getInstance().jobs)
         {
            return null;
         }
         var _loc2_:KnownJob = PlayedCharacterManager.getInstance().jobs[param1] as KnownJob;
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_;
      }
      
      public function getRecipesByJob(param1:Array, param2:Array, param3:int=0, param4:Boolean=false, param5:Boolean=false, param6:Boolean=false, param7:int=0, param8:String="level", param9:Boolean=true, param10:Array=null) : Vector.<Recipe> {
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc15_:String = null;
         var _loc16_:Vector.<ItemWrapper> = null;
         var _loc18_:ItemWrapper = null;
         var _loc20_:Recipe = null;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:Job = null;
         var _loc26_:Object = null;
         var _loc27_:* = undefined;
         var _loc28_:uint = 0;
         var _loc29_:Vector.<ItemWrapper> = null;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc32_:* = 0;
         var _loc33_:* = 0;
         var _loc34_:* = 0;
         var _loc35_:Array = null;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc38_:* = 0;
         var _loc39_:uint = 0;
         var _loc40_:uint = 0;
         var _loc11_:Vector.<Recipe> = new Vector.<Recipe>();
         _loc13_ = new Array();
         var _loc14_:Array = PlayedCharacterManager.getInstance().jobs;
         for (_loc15_ in _loc14_)
         {
            _loc23_ = int(_loc15_);
            _loc13_.push(_loc23_);
            _loc24_ = 0;
            _loc25_ = this.getJob(_loc23_) as Job;
            _loc26_ = this.getJobSkills(_loc25_);
            for each (_loc27_ in _loc26_)
            {
               if(this.getJobSkillType(_loc25_,_loc27_) == "craft")
               {
                  _loc28_ = this.getJobCraftSkillInfos(_loc25_,_loc27_).maxSlots;
                  if(_loc28_ > _loc24_)
                  {
                     _loc24_ = _loc28_;
                  }
               }
            }
            param2[_loc23_] = _loc24_;
         }
         if(param6)
         {
            if(param3 > 0 && _loc13_.indexOf(param3) == -1)
            {
               return _loc11_;
            }
         }
         if(param4)
         {
            _loc16_ = InventoryManager.getInstance().bankInventory.getView("bank").content;
         }
         else
         {
            _loc16_ = InventoryManager.getInstance().inventory.getView("storage").content;
         }
         var _loc17_:int = _loc16_.length;
         var _loc19_:* = 0;
         while(_loc19_ < _loc17_)
         {
            _loc18_ = _loc16_[_loc19_];
            if(!_loc18_.linked)
            {
               if(!param1[_loc18_.objectGID])
               {
                  param1[_loc18_.objectGID] = 
                     {
                        "totalQuantity":_loc18_.quantity,
                        "stackUidList":[_loc18_.objectUID],
                        "stackQtyList":[_loc18_.quantity],
                        "fromBag":[false],
                        "storageTotalQuantity":_loc18_.quantity
                     };
               }
               else
               {
                  param1[_loc18_.objectGID].totalQuantity = param1[_loc18_.objectGID].totalQuantity + _loc18_.quantity;
                  param1[_loc18_.objectGID].stackUidList.push(_loc18_.objectUID);
                  param1[_loc18_.objectGID].stackQtyList.push(_loc18_.quantity);
                  param1[_loc18_.objectGID].fromBag.push(false);
                  param1[_loc18_.objectGID].storageTotalQuantity = param1[_loc18_.objectGID].storageTotalQuantity + _loc18_.quantity;
               }
            }
            _loc19_++;
         }
         if(param4)
         {
            _loc29_ = InventoryManager.getInstance().inventory.getView("storage").content;
            _loc17_ = _loc29_.length;
            _loc19_ = 0;
            while(_loc19_ < _loc17_)
            {
               _loc18_ = _loc29_[_loc19_];
               if(!_loc18_.linked)
               {
                  if(!param1[_loc18_.objectGID])
                  {
                     param1[_loc18_.objectGID] = 
                        {
                           "totalQuantity":_loc18_.quantity,
                           "stackUidList":[_loc18_.objectUID],
                           "stackQtyList":[_loc18_.quantity],
                           "fromBag":[true]
                        };
                  }
                  else
                  {
                     param1[_loc18_.objectGID].totalQuantity = param1[_loc18_.objectGID].totalQuantity + _loc18_.quantity;
                     param1[_loc18_.objectGID].stackUidList.push(_loc18_.objectUID);
                     param1[_loc18_.objectGID].stackQtyList.push(_loc18_.quantity);
                     param1[_loc18_.objectGID].fromBag.push(true);
                  }
               }
               _loc19_++;
            }
         }
         if(param3 == 0)
         {
            _loc12_ = Recipe.getAllRecipes();
         }
         else
         {
            _loc12_ = Recipe.getRecipesByJobId(param3);
         }
         _loc17_ = _loc12_.length;
         var _loc21_:Dictionary = new Dictionary(true);
         _loc19_ = 0;
         for(;_loc19_ < _loc17_;_loc19_++)
         {
            _loc20_ = _loc12_[_loc19_];
            _loc30_ = _loc20_.ingredientIds.length;
            if(!(!_loc20_.job || _loc20_.jobId == 1 || (param6) && param3 == 0 && _loc13_.indexOf(_loc20_.jobId) == -1))
            {
               if(param5)
               {
                  _loc38_ = 0;
                  if(_loc13_.indexOf(_loc20_.jobId) == -1 || !param2[_loc20_.jobId])
                  {
                     continue;
                  }
                  if(param2[_loc20_.jobId] - _loc30_ < 4)
                  {
                     switch(_loc30_)
                     {
                        case 2:
                           _loc38_ = 10;
                           break;
                        case 3:
                           _loc38_ = 25;
                           break;
                        case 4:
                           _loc38_ = 50;
                           break;
                        case 5:
                           _loc38_ = 100;
                           break;
                        case 6:
                           _loc38_ = 250;
                           break;
                        case 7:
                           _loc38_ = 500;
                           break;
                        case 8:
                           _loc38_ = 1000;
                           break;
                        default:
                           _loc38_ = 1;
                     }
                  }
                  if(_loc38_ == 0)
                  {
                     continue;
                  }
               }
               _loc31_ = 0;
               _loc32_ = 0;
               _loc33_ = 0;
               _loc34_ = 0;
               _loc35_ = new Array();
               _loc36_ = param7;
               _loc37_ = 0;
               while(_loc37_ < _loc30_)
               {
                  _loc31_ = _loc31_ + _loc20_.quantities[_loc37_];
                  if(param1[_loc20_.ingredientIds[_loc37_]])
                  {
                     _loc32_ = param1[_loc20_.ingredientIds[_loc37_]].totalQuantity;
                  }
                  else
                  {
                     _loc32_ = 0;
                  }
                  if(_loc32_)
                  {
                     if(_loc32_ >= _loc20_.quantities[_loc37_])
                     {
                        _loc35_.push(int(_loc32_ / _loc20_.quantities[_loc37_]));
                        _loc34_ = _loc34_ + _loc20_.quantities[_loc37_];
                        _loc33_++;
                     }
                     else
                     {
                        _loc35_.push(0);
                        _loc36_--;
                     }
                  }
                  else
                  {
                     if(_loc36_ > 0)
                     {
                        _loc35_.push(0);
                        _loc36_--;
                     }
                  }
                  _loc37_++;
               }
               if(_loc33_ == _loc20_.ingredientIds.length && _loc34_ >= _loc31_ || param7 > 0 && _loc33_ >= 1 && _loc33_ + param7 >= _loc20_.ingredientIds.length)
               {
                  _loc11_.push(_loc20_);
                  _loc21_[_loc20_.resultTypeId] = _loc20_.resultTypeId;
                  _loc35_.sort(Array.NUMERIC);
                  if(!param1[_loc20_.resultId])
                  {
                     param1[_loc20_.resultId] = {"actualMaxOccurence":_loc35_[0]};
                  }
                  else
                  {
                     param1[_loc20_.resultId].actualMaxOccurence = _loc35_[0];
                  }
                  if(param4)
                  {
                     _loc39_ = 0;
                     for each (_loc40_ in _loc35_)
                     {
                        if(_loc40_ != 0)
                        {
                           _loc39_ = _loc40_;
                           break;
                        }
                     }
                     param1[_loc20_.resultId].potentialMaxOccurence = _loc39_;
                  }
                  continue;
               }
               continue;
            }
         }
         for each (_loc22_ in _loc21_)
         {
            param10[_loc22_] = ItemType.getItemTypeById(_loc21_[_loc22_]);
         }
         _loc11_.fixed = true;
         this.sortRecipes(_loc11_,param8,param9?1:-1);
         return _loc11_;
      }
      
      public function sortRecipesByCriteria(param1:Object, param2:String, param3:Boolean) : Object {
         this.sortRecipes(param1,param2,param3?1:-1);
         return param1;
      }
      
      private function sortRecipes(param1:Object, param2:String, param3:int=1) : void {
         if(!this._stringSorter)
         {
            this._stringSorter = new Collator(XmlConfig.getInstance().getEntry("config.lang.current"));
         }
         switch(param2)
         {
            case "ingredients":
               param1.sort(this.compareIngredients(param3));
               break;
            case "level":
               param1.sort(this.compareLevel(param3));
               break;
            case "price":
               param1.sort(this.comparePrice(param3));
               break;
         }
      }
      
      private function compareIngredients(param1:int=1) : Function {
         var way:int = param1;
         return function(param1:Recipe, param2:Recipe):Number
         {
            var _loc3_:* = param1.ingredientIds.length;
            var _loc4_:* = param2.ingredientIds.length;
            if(_loc3_ < _loc4_)
            {
               return -way;
            }
            if(_loc3_ > _loc4_)
            {
               return way;
            }
            return _stringSorter.compare(param1.resultName,param2.resultName);
         };
      }
      
      private function compareLevel(param1:int=1) : Function {
         var way:int = param1;
         return function(param1:Recipe, param2:Recipe):Number
         {
            if(param1.resultLevel < param2.resultLevel)
            {
               return -way;
            }
            if(param1.resultLevel > param2.resultLevel)
            {
               return way;
            }
            return _stringSorter.compare(param1.resultName,param2.resultName);
         };
      }
      
      private function comparePrice(param1:int=1) : Function {
         var way:int = param1;
         return function(param1:Recipe, param2:Recipe):Number
         {
            var _loc3_:* = averagePricesFrame.pricesData.items["item" + param1.resultId];
            var _loc4_:* = averagePricesFrame.pricesData.items["item" + param2.resultId];
            if(!_loc3_)
            {
               _loc3_ = way == 1?int.MAX_VALUE:0;
            }
            if(!_loc4_)
            {
               _loc4_ = way == 1?int.MAX_VALUE:0;
            }
            if(_loc3_ < _loc4_)
            {
               return -way;
            }
            if(_loc3_ > _loc4_)
            {
               return way;
            }
            return _stringSorter.compare(param1.resultName,param2.resultName);
         };
      }
      
      private function getJobDescription(param1:uint) : JobDescription {
         var _loc2_:KnownJob = this.getKnownJob(param1);
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.jobDescription;
      }
      
      private function getJobExp(param1:uint) : JobExperience {
         var _loc2_:KnownJob = this.getKnownJob(param1);
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.jobExperience;
      }
      
      private function getSkillActionDescription(param1:JobDescription, param2:uint) : SkillActionDescription {
         var _loc3_:SkillActionDescription = null;
         for each (_loc3_ in param1.skills)
         {
            if(_loc3_.skillId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}
