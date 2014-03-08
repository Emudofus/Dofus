package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.TiphonConstants;
   
   public final class TiphonMultiBonesManager extends Object
   {
      
      public function TiphonMultiBonesManager() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonMultiBonesManager));
      
      private static var _instance:TiphonMultiBonesManager;
      
      public static function getInstance() : TiphonMultiBonesManager {
         if(!_instance)
         {
            _instance = new TiphonMultiBonesManager();
         }
         return _instance;
      }
      
      private var _nbBonesToLoad:int;
      
      private var _nbBonesLoaded:int;
      
      public function getAllBonesFromLook(param1:TiphonEntityLook, param2:Array=null) : Array {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(!param2)
         {
            param2 = new Array();
         }
         param2.push(param1.getBone());
         for each (_loc3_ in param1.getSubEntities())
         {
            for each (_loc4_ in _loc3_)
            {
               this.getAllBonesFromLook(_loc4_,param2);
            }
         }
         return param2;
      }
      
      public function onLoadedBone(param1:uint, param2:Callback=null) : void {
         this._nbBonesLoaded++;
         if(this._nbBonesLoaded == this._nbBonesToLoad)
         {
            if(param2 != null)
            {
               param2.exec();
            }
         }
      }
      
      public function forceBonesLoading(param1:Array, param2:Callback=null) : void {
         var _loc3_:uint = 0;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:Uri = null;
         this._nbBonesLoaded = 0;
         this._nbBonesToLoad = param1.length;
         for each (_loc3_ in param1)
         {
            _loc4_ = BoneIndexManager.getInstance().hasCustomBone(_loc3_);
            _loc5_ = Tiphon.skullLibrary.hasResource(_loc3_);
            if((_loc4_) || (_loc5_))
            {
               this.onLoadedBone(_loc3_,param2);
            }
            else
            {
               _loc6_ = new Uri(TiphonConstants.SWF_SKULL_PATH + _loc3_ + ".swl");
               Tiphon.skullLibrary.addResource(_loc3_,_loc6_);
               Tiphon.skullLibrary.askResource(_loc3_,null,new Callback(this.onLoadedBone,_loc3_,param2));
            }
         }
      }
   }
}
