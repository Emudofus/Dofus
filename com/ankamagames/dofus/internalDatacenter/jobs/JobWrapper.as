package com.ankamagames.dofus.internalDatacenter.jobs
{
   import flash.utils.Proxy;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   public class JobWrapper extends Proxy implements IDataCenter, ISlotData
   {
      
      public function JobWrapper() {
         super();
      }
      
      private static var _cache:Array = new Array();
      
      public static function create(param1:uint, param2:Boolean=true) : JobWrapper {
         var _loc3_:JobWrapper = null;
         if(!_cache[param1] || !param2)
         {
            _loc3_ = new JobWrapper();
            _loc3_.jobId = param1;
            if(param2)
            {
               _cache[param1] = _loc3_;
            }
         }
         else
         {
            _loc3_ = _cache[param1];
         }
         _loc3_.jobId = param1;
         _loc3_.gfxId = param1;
         return _loc3_;
      }
      
      private var _uri:Uri;
      
      private var _id:uint = 0;
      
      private var _gfxId:uint = 0;
      
      public function get iconUri() : Uri {
         if(!this._uri)
         {
            this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/jobs/").concat(this._id).concat(".png"));
         }
         return this._uri;
      }
      
      public function get fullSizeIconUri() : Uri {
         return this.iconUri;
      }
      
      public function get errorIconUri() : Uri {
         return null;
      }
      
      public function get info1() : String {
         return null;
      }
      
      public function get startTime() : int {
         return 0;
      }
      
      public function get endTime() : int {
         return 0;
      }
      
      public function set endTime(param1:int) : void {
      }
      
      public function get timer() : int {
         return 0;
      }
      
      public function get active() : Boolean {
         return true;
      }
      
      public function addHolder(param1:ISlotDataHolder) : void {
      }
      
      public function removeHolder(param1:ISlotDataHolder) : void {
      }
      
      public function set jobId(param1:uint) : void {
         this._id = this.jobId;
      }
      
      public function get jobId() : uint {
         return this._id;
      }
      
      public function set gfxId(param1:uint) : void {
         this._gfxId = param1;
      }
      
      public function get gfxId() : uint {
         return this._gfxId;
      }
      
      public function get job() : Job {
         return Job.getJobById(this._id);
      }
      
      override flash_proxy function getProperty(param1:*) : * {
         var l:* = undefined;
         var r:* = undefined;
         var name:* = param1;
         if(isAttribute(name))
         {
            return this[name];
         }
         l = this.job;
         if(!l)
         {
            r = "";
         }
         try
         {
            return l[name];
         }
         catch(e:Error)
         {
            return "Error_on_job_" + name;
         }
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean {
         return isAttribute(param1);
      }
   }
}
