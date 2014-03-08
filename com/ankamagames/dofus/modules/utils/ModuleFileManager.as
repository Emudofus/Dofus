package com.ankamagames.dofus.modules.utils
{
   import flash.utils.Dictionary;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.types.Uri;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class ModuleFileManager extends Object
   {
      
      public function ModuleFileManager() {
         this._moduleSizes = new Dictionary();
         this._moduleFilesNum = new Dictionary();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      private static const MAX_FILE_NUM:uint = 1000;
      
      private static const MAX_FILE_SIZE:uint = Math.pow(2,20);
      
      private static var _self:ModuleFileManager;
      
      public static function getInstance() : ModuleFileManager {
         if(!_self)
         {
            _self = new ModuleFileManager();
         }
         return _self;
      }
      
      private var _moduleSizes:Dictionary;
      
      private var _moduleFilesNum:Dictionary;
      
      public function initModuleFiles(param1:String) : void {
         if(this._moduleSizes[param1] != null)
         {
            return;
         }
         var _loc2_:UiModule = UiModuleManager.getInstance().getModule(param1);
         var _loc3_:File = new Uri(_loc2_.storagePath).toFile();
         if(!_loc3_.exists)
         {
            _loc3_.createDirectory();
         }
         this.updateFolderSize(_loc3_,param1);
      }
      
      public function updateModuleSize(param1:String, param2:int) : void {
         this.initModuleFiles(param1);
         this._moduleSizes[param1] = this._moduleSizes[param1] + param2;
      }
      
      public function updateModuleFileNum(param1:String, param2:int) : void {
         this.initModuleFiles(param1);
         this._moduleFilesNum[param1] = this._moduleFilesNum[param1] + param2;
      }
      
      public function canCreateFiles(param1:String, param2:uint=0) : Boolean {
         return this._moduleFilesNum[param1] < MAX_FILE_NUM;
      }
      
      public function canAddSize(param1:String, param2:uint=0) : Boolean {
         return this._moduleSizes[param1] < MAX_FILE_SIZE;
      }
      
      public function getAvaibleSpace(param1:String) : uint {
         return Math.max(MAX_FILE_SIZE - this._moduleSizes[param1],0);
      }
      
      public function getUsedSpace(param1:String) : uint {
         return this._moduleSizes[param1];
      }
      
      public function getMaxSpace(param1:String) : uint {
         return MAX_FILE_SIZE;
      }
      
      public function getMaxFileCount(param1:String) : uint {
         return MAX_FILE_NUM;
      }
      
      public function getUsedFileCount(param1:String) : uint {
         return this._moduleFilesNum[param1];
      }
      
      private function updateFolderSize(param1:File, param2:String) : void {
         var _loc5_:File = null;
         if(this._moduleSizes[param2] == null)
         {
            this._moduleSizes[param2] = 0;
            this._moduleFilesNum[param2] = 0;
         }
         var _loc3_:uint = 0;
         var _loc4_:Array = param1.getDirectoryListing();
         for each (_loc5_ in _loc4_)
         {
            if(_loc5_.isDirectory)
            {
               this.updateFolderSize(_loc5_,param2);
            }
            else
            {
               _loc3_ = _loc3_ + _loc5_.size;
            }
         }
         this._moduleSizes[param2] = this._moduleSizes[param2] + _loc3_;
         this._moduleFilesNum[param2] = this._moduleFilesNum[param2] + _loc4_.length;
      }
   }
}
