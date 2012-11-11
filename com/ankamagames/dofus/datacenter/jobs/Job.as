package com.ankamagames.dofus.datacenter.jobs
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Job extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var specializationOfId:int;
        public var iconId:int;
        public var toolIds:Vector.<int>;
        private var _name:String;
        private var _specializationOf:Job;
        private var _tools:Vector.<Item>;
        private static const MODULE:String = "Jobs";

        public function Job()
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

        public function get specializationOf() : Job
        {
            if (!this._specializationOf)
            {
                if (this.specializationOfId != 0)
                {
                    this._specializationOf = Job.getJobById(this.specializationOfId);
                }
            }
            return this._specializationOf;
        }// end function

        public function get tools() : Vector.<Item>
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (!this._tools)
            {
                _loc_1 = this.toolIds.length;
                this._tools = new Vector.<Item>(_loc_1, true);
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    this._tools[_loc_2] = Item.getItemById(this.toolIds[_loc_2]);
                    _loc_2 = _loc_2 + 1;
                }
            }
            return this._tools;
        }// end function

        public static function getJobById(param1:int) : Job
        {
            return GameData.getObject(MODULE, param1) as Job;
        }// end function

        public static function getJobs() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
