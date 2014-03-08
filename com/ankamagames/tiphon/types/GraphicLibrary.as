package com.ankamagames.tiphon.types
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.events.SwlEvent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.engine.BoneIndexManager;
   import com.ankamagames.tiphon.TiphonConstants;
   
   public class GraphicLibrary extends EventDispatcher
   {
      
      public function GraphicLibrary(param1:uint, param2:Boolean=false) {
         this._swl = new Dictionary();
         this._waitingSwl = new Dictionary();
         super();
         this.gfxId = param1;
         this._isBone = param2;
      }
      
      private var _swl:Dictionary;
      
      public var gfxId:uint;
      
      private var _swlCount:uint = 0;
      
      private var _isBone:Boolean;
      
      private var _waitingSwl:Dictionary;
      
      public function addSwl(param1:Swl, param2:String) : void {
         if(!this._swl[param2])
         {
            this._swlCount++;
         }
         this._swl[param2] = param1;
         if(this._waitingSwl[param2])
         {
            this._waitingSwl[param2] = false;
            delete this._waitingSwl[[param2]];
            dispatchEvent(new SwlEvent(SwlEvent.SWL_LOADED,param2));
         }
      }
      
      public function updateSwfState(param1:Uri) : void {
         if(!this._swl[param1.toString()])
         {
            this._swlCount++;
         }
         this._swl[param1.toString()] = false;
      }
      
      public function hasClass(param1:String) : Boolean {
         var _loc2_:Uri = this._isBone?BoneIndexManager.getInstance().getBoneFile(this.gfxId,param1):new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl");
         return !(this._swl[_loc2_.toString()] == null);
      }
      
      public function hasClassAvaible(param1:String=null) : Boolean {
         if(this.isSingleFile)
         {
            return !(this.getSwl(param1) == null);
         }
         var _loc2_:Uri = this._isBone?BoneIndexManager.getInstance().getBoneFile(this.gfxId,param1):new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl");
         return !(this._swl[_loc2_.toString()] == null) && !(this._swl[_loc2_.toString()] == false);
      }
      
      public function hasSwl(param1:Uri=null) : Boolean {
         if(!param1)
         {
            return !(this._swlCount == 0);
         }
         return !(this._swl[param1.toString()] == null);
      }
      
      public function getSwl(param1:String=null, param2:Boolean=false) : Swl {
         var _loc3_:* = undefined;
         var _loc4_:Uri = null;
         if((param1) || !this._isBone)
         {
            _loc4_ = this._isBone?BoneIndexManager.getInstance().getBoneFile(this.gfxId,param1):new Uri(TiphonConstants.SWF_SKIN_PATH + this.gfxId + ".swl");
            if(this._swl[_loc4_.toString()] != false)
            {
               return this._swl[_loc4_.toString()];
            }
            if(param2)
            {
               this._waitingSwl[_loc4_.toString()] = true;
               return null;
            }
         }
         for each (_loc3_ in this._swl)
         {
            if(_loc3_ != false)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get isSingleFile() : Boolean {
         return !this._isBone || !BoneIndexManager.getInstance().hasCustomBone(this.gfxId);
      }
   }
}
