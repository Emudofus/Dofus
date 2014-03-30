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
      
      public static const MAX_FILE_NUM:uint = 1000;
      
      public static const MAX_FILE_SIZE:uint = Math.pow(2,20);
      
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
      
      public function initModuleFiles(moduleId:String) : void {
         if(this._moduleSizes[moduleId] != null)
         {
            return;
         }
         var module:UiModule = UiModuleManager.getInstance().getModule(moduleId);
         var folder:File = new Uri(module.storagePath).toFile();
         if(!folder.exists)
         {
            folder.createDirectory();
         }
         this.updateFolderSize(folder,moduleId);
      }
      
      public function updateModuleSize(moduleId:String, delta:int) : void {
         this.initModuleFiles(moduleId);
         this._moduleSizes[moduleId] = this._moduleSizes[moduleId] + delta;
      }
      
      public function updateModuleFileNum(moduleId:String, delta:int) : void {
         this.initModuleFiles(moduleId);
         this._moduleFilesNum[moduleId] = this._moduleFilesNum[moduleId] + delta;
      }
      
      public function canCreateFiles(moduleId:String, amount:uint=0) : Boolean {
         return this._moduleFilesNum[moduleId] < MAX_FILE_NUM;
      }
      
      public function canAddSize(moduleId:String, amount:uint=0) : Boolean {
         return this._moduleSizes[moduleId] < MAX_FILE_SIZE;
      }
      
      public function getAvaibleSpace(moduleId:String) : uint {
         return Math.max(MAX_FILE_SIZE - this._moduleSizes[moduleId],0);
      }
      
      public function getUsedSpace(moduleId:String) : uint {
         return this._moduleSizes[moduleId];
      }
      
      public function getMaxSpace(moduleId:String) : uint {
         return MAX_FILE_SIZE;
      }
      
      public function getMaxFileCount(moduleId:String) : uint {
         return MAX_FILE_NUM;
      }
      
      public function getUsedFileCount(moduleId:String) : uint {
         return this._moduleFilesNum[moduleId];
      }
      
      private function updateFolderSize(folder:File, moduleId:String) : void {
         var file:File = null;
         if(this._moduleSizes[moduleId] == null)
         {
            this._moduleSizes[moduleId] = 0;
            this._moduleFilesNum[moduleId] = 0;
         }
         var size:uint = 0;
         var files:Array = folder.getDirectoryListing();
         for each (file in files)
         {
            if(file.isDirectory)
            {
               this.updateFolderSize(file,moduleId);
            }
            else
            {
               size = size + file.size;
            }
         }
         this._moduleSizes[moduleId] = this._moduleSizes[moduleId] + size;
         this._moduleFilesNum[moduleId] = this._moduleFilesNum[moduleId] + files.length;
      }
   }
}
