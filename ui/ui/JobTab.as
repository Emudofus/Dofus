package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.JobsApi;
   import d2api.PlayedCharacterApi;
   import d2api.SoundApi;
   import d2api.UtilApi;
   import d2data.Job;
   import d2components.Label;
   import d2components.Input;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.Grid;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2hooks.*;
   import d2actions.*;
   import flash.geom.ColorTransform;
   
   public class JobTab extends Object
   {
      
      public function JobTab() {
         this._btnJobAssoc = new Array();
         super();
      }
      
      private static var _currentJobIndexSelected:int = 0;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var jobsApi:JobsApi;
      
      public var pcApi:PlayedCharacterApi;
      
      public var soundApi:SoundApi;
      
      public var utilApi:UtilApi;
      
      private var _currentJob:Job;
      
      private var _searchCriteria:String;
      
      private var _recipes:Object;
      
      private var _btnJobAssoc:Array;
      
      private var _slotMax:int;
      
      public var lblIconJobLvl3:Label;
      
      public var lblIconJobLvl2:Label;
      
      public var lblIconJobLvl1:Label;
      
      public var lblCurrentLvl:Label;
      
      public var lblCurrentJob:Label;
      
      public var lblRecipes:Label;
      
      public var searchInput:Input;
      
      public var chk8:ButtonContainer;
      
      public var chk7:ButtonContainer;
      
      public var chk6:ButtonContainer;
      
      public var chk5:ButtonContainer;
      
      public var chk4:ButtonContainer;
      
      public var chk3:ButtonContainer;
      
      public var chk2:ButtonContainer;
      
      public var chk1:ButtonContainer;
      
      public var jobIcon1:Texture;
      
      public var jobIcon2:Texture;
      
      public var jobIcon3:Texture;
      
      public var subjobIcon1:Texture;
      
      public var subjobIcon2:Texture;
      
      public var subjobIcon3:Texture;
      
      public var jobIconOver:Texture;
      
      public var txProgressBar:Texture;
      
      public var txProgressBarBackground:Texture;
      
      public var gdRecipes:Grid;
      
      public var gdSkills:Grid;
      
      public var btn_options:ButtonContainer;
      
      public function main(oParam:Object = null) : void {
         var ind:* = 0;
         var job:Job = null;
         var jobXp:Object = null;
         this.sysApi.addHook(JobsExpUpdated,this.onJobsExpUpdated);
         this.sysApi.addHook(JobsListUpdated,this.onJobsListUpdated);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         var jobs:Object = this.jobsApi.getKnownJobs();
         if(!jobs)
         {
            return;
         }
         var jobIndex:uint = 0;
         var subJobIndex:uint = 0;
         var jI:int = 0;
         while(jI < 6)
         {
            ind = jI;
            job = jobs[ind];
            if(job)
            {
               if(!job.specializationOfId)
               {
                  jobIndex++;
                  this["jobIcon" + jobIndex].uri = this.uiApi.createUri(this.uiApi.me().getConstant("jobIconPath") + job.iconId + ".swf");
                  jobXp = this.jobsApi.getJobExperience(job);
                  if(jobXp)
                  {
                     this["lblIconJobLvl" + jobIndex].text = this.uiApi.getText("ui.common.short.level") + " " + jobXp.currentLevel;
                  }
                  this._btnJobAssoc["jobIcon" + jobIndex] = ind;
               }
               else
               {
                  subJobIndex++;
                  this["subjobIcon" + subJobIndex].uri = this.uiApi.createUri(this.uiApi.me().getConstant("jobIconPath") + job.iconId + ".swf");
                  this._btnJobAssoc["subjobIcon" + subJobIndex] = ind;
               }
            }
            jI++;
         }
         this.lblRecipes.text = this.uiApi.processText(this.uiApi.getText("ui.common.recipes"),"",false);
         var i:uint = 1;
         while(i < 4)
         {
            this.uiApi.addComponentHook(this["jobIcon" + i],"onRelease");
            this.uiApi.addComponentHook(this["subjobIcon" + i],"onRelease");
            this.uiApi.addComponentHook(this["jobIcon" + i],"onRollOver");
            this.uiApi.addComponentHook(this["subjobIcon" + i],"onRollOver");
            this.uiApi.addComponentHook(this["jobIcon" + i],"onRollOut");
            this.uiApi.addComponentHook(this["subjobIcon" + i],"onRollOut");
            i++;
         }
         var chkChecked:int = Grimoire.getInstance().recipeSlotsNumber;
         var j:uint = 1;
         while(j < 9)
         {
            this.uiApi.addComponentHook(this["chk" + j],"onRelease");
            this.uiApi.addComponentHook(this["chk" + j],"onRollOver");
            this.uiApi.addComponentHook(this["chk" + j],"onRollOut");
            if(chkChecked >> j & 1)
            {
               this["chk" + j].selected = true;
            }
            j++;
         }
         this.uiApi.addComponentHook(this.txProgressBarBackground,"onRollOver");
         this.uiApi.addComponentHook(this.txProgressBarBackground,"onRollOut");
         this.uiApi.addComponentHook(this.txProgressBar,"onRollOver");
         this.uiApi.addComponentHook(this.txProgressBar,"onRollOut");
         this.uiApi.addComponentHook(this.searchInput,"onRollOver");
         this.uiApi.addComponentHook(this.searchInput,"onRollOut");
         this.uiApi.addComponentHook(this.searchInput,"onRelease");
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         var colorT:ColorTransform = new ColorTransform(0.298,0.545,0.706);
         this.txProgressBar.transform.colorTransform = colorT;
         if(oParam != null)
         {
            _currentJobIndexSelected = int(oParam) - 1;
         }
         this.switchJob(_currentJobIndexSelected);
      }
      
      public function unload() : void {
         this.uiApi.unloadUi("jobCraftOptions");
      }
      
      public function get currentJob() : Object {
         return this._currentJob;
      }
      
      public function get slotMax() : int {
         return this._slotMax;
      }
      
      private function switchJob(index:uint) : void {
         var btnName:String = null;
         var skills:Object = null;
         var skill:* = undefined;
         var jobIndex:uint = 0;
         var slot:uint = 0;
         var i:uint = 0;
         _currentJobIndexSelected = index;
         var jobs:Object = this.jobsApi.getKnownJobs();
         if(index >= jobs.length)
         {
            return;
         }
         if(jobs[index] == this._currentJob)
         {
            return;
         }
         this._currentJob = jobs[index];
         var jobInfo:Object = this.jobsApi.getJobExperience(this._currentJob);
         if(jobInfo.currentLevel != 100)
         {
            this.txProgressBar.scaleX = (jobInfo.currentExperience - jobInfo.levelExperienceFloor) / (jobInfo.levelExperienceCeil - jobInfo.levelExperienceFloor);
            if(this.txProgressBar.scaleX > 1)
            {
               this.txProgressBar.scaleX = 1;
            }
         }
         else
         {
            this.txProgressBar.scaleX = 1;
         }
         for(btnName in this._btnJobAssoc)
         {
            jobIndex = this._btnJobAssoc[btnName];
            if(jobIndex == index)
            {
               this.jobIconOver.visible = true;
               this.jobIconOver.x = this[btnName].x;
               this.jobIconOver.y = this[btnName].y;
               this.jobIconOver.width = this[btnName].width;
               this.jobIconOver.height = this[btnName].height;
            }
         }
         this.lblCurrentJob.text = this._currentJob.name;
         this.lblCurrentLvl.text = this.uiApi.getText("ui.common.level") + " " + jobInfo.currentLevel;
         this._slotMax = 0;
         skills = this.jobsApi.getJobSkills(this._currentJob);
         for each(skill in skills)
         {
            if(this.jobsApi.getJobSkillType(this._currentJob,skill) == "craft")
            {
               slot = this.jobsApi.getJobCraftSkillInfos(this._currentJob,skill).maxSlots;
               if(slot > this._slotMax)
               {
                  this._slotMax = slot;
               }
            }
         }
         if(Grimoire.getInstance().recipeSlotsNumber == 0)
         {
            i = 1;
            while(i < 9)
            {
               this["chk" + i].selected = i <= this._slotMax;
               i++;
            }
         }
         this.gdSkills.dataProvider = this.jobsApi.getJobSkills(this._currentJob);
         this._searchCriteria = null;
         this.updateRecipes();
      }
      
      private function updateRecipes() : void {
         var total:* = 0;
         var filter:Array = new Array();
         if(this.chk1.selected)
         {
            filter.push(1);
            total = total + Math.pow(2,1);
         }
         if(this.chk2.selected)
         {
            filter.push(2);
            total = total + Math.pow(2,2);
         }
         if(this.chk3.selected)
         {
            filter.push(3);
            total = total + Math.pow(2,3);
         }
         if(this.chk4.selected)
         {
            filter.push(4);
            total = total + Math.pow(2,4);
         }
         if(this.chk5.selected)
         {
            filter.push(5);
            total = total + Math.pow(2,5);
         }
         if(this.chk6.selected)
         {
            filter.push(6);
            total = total + Math.pow(2,6);
         }
         if(this.chk7.selected)
         {
            filter.push(7);
            total = total + Math.pow(2,7);
         }
         if(this.chk8.selected)
         {
            filter.push(8);
            total = total + Math.pow(2,8);
         }
         Grimoire.getInstance().recipeSlotsNumber = total;
         this._recipes = this.jobsApi.getJobRecipes(this._currentJob,filter,null,this._searchCriteria);
         this.gdRecipes.dataProvider = this._recipes;
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.jobIcon1:
            case this.jobIcon2:
            case this.jobIcon3:
            case this.subjobIcon1:
            case this.subjobIcon2:
            case this.subjobIcon3:
               this.switchJob(this._btnJobAssoc[target.name]);
               break;
            case this.searchInput:
               if(this.searchInput.text == this.uiApi.getText("ui.common.search.input"))
               {
                  this.searchInput.text = "";
               }
               break;
            case this.chk8:
            case this.chk7:
            case this.chk6:
            case this.chk5:
            case this.chk4:
            case this.chk3:
            case this.chk2:
            case this.chk1:
               this.updateRecipes();
               break;
            case this.btn_options:
               if(!this.uiApi.getUi("jobCraftOptions"))
               {
                  this.uiApi.loadUi("jobCraftOptions","jobCraftOptions",[this._currentJob]);
               }
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var ttData:* = undefined;
         var num:uint = 0;
         var job:Object = null;
         var jobInfo:Object = null;
         switch(target)
         {
            case this.chk8:
            case this.chk7:
            case this.chk6:
            case this.chk5:
            case this.chk4:
            case this.chk3:
            case this.chk2:
            case this.chk1:
               num = parseInt(target.name.substr(3,1));
               ttData = this.uiApi.processText(this.uiApi.getText("ui.common.hideShowRicepies",num),"",num == 1);
               break;
            case this.jobIcon1:
            case this.jobIcon2:
            case this.jobIcon3:
            case this.subjobIcon1:
            case this.subjobIcon2:
            case this.subjobIcon3:
               job = this.jobsApi.getKnownJobs()[this._btnJobAssoc[target.name]];
               if(job)
               {
                  ttData = job.name;
               }
               break;
            case this.txProgressBar:
            case this.txProgressBarBackground:
               if(this._currentJob != null)
               {
                  jobInfo = this.jobsApi.getJobExperience(this._currentJob);
                  if(jobInfo)
                  {
                     if(jobInfo.currentLevel != 100)
                     {
                        ttData = Math.floor((jobInfo.currentExperience - jobInfo.levelExperienceFloor) / (jobInfo.levelExperienceCeil - jobInfo.levelExperienceFloor) * 100) + " % (" + jobInfo.currentExperience + " / " + jobInfo.levelExperienceCeil + ")";
                     }
                     else
                     {
                        ttData = "100 % (" + jobInfo.currentExperience + ")";
                     }
                  }
               }
               break;
            case this.searchInput:
               ttData = this.uiApi.getText("ui.common.searchFilterTooltip");
               break;
         }
         if(ttData)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(ttData),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         if(this.searchInput.haveFocus)
         {
            this._searchCriteria = this.searchInput.text.toLowerCase();
            if(!this._searchCriteria.length)
            {
               this._searchCriteria = null;
            }
            this.updateRecipes();
            return true;
         }
         return false;
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if(this.searchInput.haveFocus)
         {
            if(this.searchInput.text.length > 2)
            {
               this._searchCriteria = this.searchInput.text.toLowerCase();
               this.updateRecipes();
            }
            else
            {
               if(this._searchCriteria)
               {
                  this._searchCriteria = null;
               }
               if(this.searchInput.text == "")
               {
                  this.updateRecipes();
               }
               else
               {
                  this.gdRecipes.dataProvider = new Array();
               }
            }
         }
      }
      
      private function onJobsExpUpdated(jobId:uint) : void {
         var jobInfo:Object = null;
         if((jobId == this._currentJob.id) || (jobId == 0))
         {
            jobInfo = this.jobsApi.getJobExperience(this._currentJob);
            this.lblCurrentLvl.text = this.uiApi.getText("ui.common.level") + " " + jobInfo.currentLevel;
            if((jobInfo) && (!(jobInfo.currentLevel == 100)))
            {
               this.txProgressBar.scaleX = (jobInfo.currentExperience - jobInfo.levelExperienceFloor) / (jobInfo.levelExperienceCeil - jobInfo.levelExperienceFloor);
               if(this.txProgressBar.scaleX > 1)
               {
                  this.txProgressBar.scaleX = 1;
               }
            }
            else
            {
               this.txProgressBar.scaleX = 1;
            }
         }
      }
      
      public function onJobsListUpdated() : void {
         var ind:* = 0;
         var job:Job = null;
         var jobXp:Object = null;
         var jobs:Object = this.jobsApi.getKnownJobs();
         if((!jobs) || (jobs.length == 0))
         {
            this.sysApi.sendAction(new OpenBook("spellTab"));
            return;
         }
         var ji:int = 1;
         while(ji <= 3)
         {
            this["jobIcon" + ji].uri = null;
            this["lblIconJobLvl" + ji].text = "";
            ji++;
         }
         var sji:int = 1;
         while(sji <= 3)
         {
            this["subjobIcon" + sji].uri = null;
            sji++;
         }
         this._btnJobAssoc = new Array();
         var showjob:uint = 0;
         var jobIndex:uint = 0;
         var subJobIndex:uint = 0;
         var j:int = 0;
         while(j < 6)
         {
            ind = j;
            job = jobs[ind];
            if(job)
            {
               if(!job.specializationOfId)
               {
                  jobIndex++;
                  this["jobIcon" + jobIndex].uri = this.uiApi.createUri(this.uiApi.me().getConstant("jobIconPath") + job.iconId + ".swf");
                  jobXp = this.jobsApi.getJobExperience(job);
                  if(jobXp)
                  {
                     this["lblIconJobLvl" + jobIndex].text = this.uiApi.getText("ui.common.short.level") + " " + jobXp.currentLevel;
                  }
                  this._btnJobAssoc["jobIcon" + jobIndex] = ind;
               }
               else
               {
                  subJobIndex++;
                  this["subjobIcon" + subJobIndex].uri = this.uiApi.createUri(this.uiApi.me().getConstant("jobIconPath") + job.iconId + ".swf");
                  this._btnJobAssoc["subjobIcon" + subJobIndex] = ind;
               }
            }
            j++;
         }
         if(jobs[_currentJobIndexSelected] == null)
         {
            _currentJobIndexSelected = 0;
         }
         this.switchJob(_currentJobIndexSelected);
      }
   }
}
