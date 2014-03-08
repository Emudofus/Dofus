package com.ankamagames.dofus.datacenter.jobs
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.data.I18n;
   
   public class Job extends Object implements IDataCenter
   {
      
      public function Job() {
         super();
      }
      
      public static const MODULE:String = "Jobs";
      
      public static function getJobById(param1:int) : Job {
         return GameData.getObject(MODULE,param1) as Job;
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
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(!this._tools)
         {
            _loc1_ = this.toolIds.length;
            this._tools = new Vector.<Item>(_loc1_,true);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._tools[_loc2_] = Item.getItemById(this.toolIds[_loc2_]);
               _loc2_++;
            }
         }
         return this._tools;
      }
   }
}
