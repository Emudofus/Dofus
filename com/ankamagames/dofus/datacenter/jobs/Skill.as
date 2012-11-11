package com.ankamagames.dofus.datacenter.jobs
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.interactives.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Skill extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var parentJobId:int;
        public var isForgemagus:Boolean;
        public var modifiableItemType:int;
        public var gatheredRessourceItem:int;
        public var craftableItemIds:Vector.<int>;
        public var interactiveId:int;
        public var useAnimation:String;
        public var isRepair:Boolean;
        public var cursor:int;
        public var availableInHouse:Boolean;
        public var levelMin:uint;
        private var _name:String;
        private var _parentJob:Job;
        private var _interactive:Interactive;
        private static const MODULE:String = "Skills";

        public function Skill()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get parentJob() : Job
        {
            if (!this._parentJob)
            {
                this._parentJob = Job.getJobById(this.parentJobId);
            }
            return this._parentJob;
        }// end function

        public function get interactive() : Interactive
        {
            if (!this._interactive)
            {
                this._interactive = Interactive.getInteractiveById(this.interactiveId);
            }
            return this._interactive;
        }// end function

        public static function getSkillById(param1:int) : Skill
        {
            return GameData.getObject(MODULE, param1) as Skill;
        }// end function

        public static function getSkills() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
