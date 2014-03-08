package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.data.I18n;
   import __AS3__.vec.*;
   
   public class Job extends Object implements IDataCenter
   {
      
      public function Job() {
         super();
      }
      
      public static const MODULE:String = "Jobs";
      
      public static function getJobById(id:int) : Job {
         return GameData.getObject(MODULE,id) as Job;
      }
      
      public static function getJobs() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      public var specializationOfId:int;
      
      public var iconId:int;
      
      public var toolIds:Vector.<int>;
      
      private var _name:String;
      
      private var _specializationOf:Job;
      
      private var _tools:Vector.<Item>;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get specializationOf() : Job {
         if(!this._specializationOf)
         {
            if(this.specializationOfId != 0)
            {
               this._specializationOf = Job.getJobById(this.specializationOfId);
            }
         }
         return this._specializationOf;
      }
      
      public function get tools() : Vector.<Item> {
         var toolsCount:uint = 0;
         var i:uint = 0;
         if(!this._tools)
         {
            toolsCount = this.toolIds.length;
            this._tools = new Vector.<Item>(toolsCount,true);
            i = 0;
            while(i < toolsCount)
            {
               this._tools[i] = Item.getItemById(this.toolIds[i]);
               i++;
            }
         }
         return this._tools;
      }
   }
}
