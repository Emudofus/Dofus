package com.ankamagames.dofus.internalDatacenter.jobs
{
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class JobWrapper extends Proxy implements IDataCenter, ISlotData
    {
        private var _uri:Uri;
        private var _id:uint = 0;
        private var _gfxId:uint = 0;
        private static var _cache:Array = new Array();

        public function JobWrapper()
        {
            return;
        }// end function

        public function get iconUri() : Uri
        {
            if (!this._uri)
            {
                this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/jobs/").concat(this._id).concat(".png"));
            }
            return this._uri;
        }// end function

        public function get fullSizeIconUri() : Uri
        {
            return this.iconUri;
        }// end function

        public function get errorIconUri() : Uri
        {
            return null;
        }// end function

        public function get info1() : String
        {
            return null;
        }// end function

        public function get timer() : int
        {
            return 0;
        }// end function

        public function get active() : Boolean
        {
            return true;
        }// end function

        public function addHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function removeHolder(param1:ISlotDataHolder) : void
        {
            return;
        }// end function

        public function set jobId(param1:uint) : void
        {
            this._id = this.jobId;
            return;
        }// end function

        public function get jobId() : uint
        {
            return this._id;
        }// end function

        public function set gfxId(param1:uint) : void
        {
            this._gfxId = param1;
            return;
        }// end function

        public function get gfxId() : uint
        {
            return this._gfxId;
        }// end function

        public function get job() : Job
        {
            return Job.getJobById(this._id);
        }// end function

        override function getProperty(param1)
        {
            var l:*;
            var r:*;
            var name:* = param1;
            if (isAttribute(name))
            {
                return this[name];
            }
            l = this.job;
            if (!l)
            {
                r;
            }
            try
            {
                return l[name];
            }
            catch (e:Error)
            {
                return "Error_on_job_" + name;
            }
            return;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return isAttribute(param1);
        }// end function

        public static function create(param1:uint, param2:Boolean = true) : JobWrapper
        {
            var _loc_3:* = null;
            if (!_cache[param1] || !param2)
            {
                _loc_3 = new JobWrapper;
                _loc_3.jobId = param1;
                if (param2)
                {
                    _cache[param1] = _loc_3;
                }
            }
            else
            {
                _loc_3 = _cache[param1];
            }
            _loc_3.jobId = param1;
            _loc_3.gfxId = param1;
            return _loc_3;
        }// end function

    }
}
