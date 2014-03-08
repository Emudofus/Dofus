package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Skill extends Object implements IDataCenter
   {
      
      public function Skill() {
         super();
      }
      
      public static const MODULE:String = "Skills";
      
      public static function getSkillById(param1:int) : Skill {
         return GameData.getObject(MODULE,param1) as Skill;
      }
      
      public static function getSkills() : Array {
         return GameData.getObjects(MODULE);
      }
      
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
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get parentJob() : Job {
         if(!this._parentJob)
         {
            this._parentJob = Job.getJobById(this.parentJobId);
         }
         return this._parentJob;
      }
      
      public function get interactive() : Interactive {
         if(!this._interactive)
         {
            this._interactive = Interactive.getInteractiveById(this.interactiveId);
         }
         return this._interactive;
      }
   }
}
