package com.ankamagames.dofus.modules.utils
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class ModuleFileManager extends Object
    {
        private var _moduleSizes:Dictionary;
        private var _moduleFilesNum:Dictionary;
        private static const MAX_FILE_NUM:uint = 1000;
        private static const MAX_FILE_SIZE:uint = Math.pow(2, 20);
        private static var _self:ModuleFileManager;

        public function ModuleFileManager()
        {
            this._moduleSizes = new Dictionary();
            this._moduleFilesNum = new Dictionary();
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function initModuleFiles(param1:String) : void
        {
            if (this._moduleSizes[param1] != null)
            {
                return;
            }
            var _loc_2:* = UiModuleManager.getInstance().getModule(param1);
            var _loc_3:* = new Uri(_loc_2.storagePath).toFile();
            if (!_loc_3.exists)
            {
                _loc_3.createDirectory();
            }
            this.updateFolderSize(_loc_3, param1);
            return;
        }// end function

        public function updateModuleSize(param1:String, param2:int) : void
        {
            this.initModuleFiles(param1);
            this._moduleSizes[param1] = this._moduleSizes[param1] + param2;
            return;
        }// end function

        public function updateModuleFileNum(param1:String, param2:int) : void
        {
            this.initModuleFiles(param1);
            this._moduleFilesNum[param1] = this._moduleFilesNum[param1] + param2;
            return;
        }// end function

        public function canCreateFiles(param1:String, param2:uint = 0) : Boolean
        {
            return this._moduleFilesNum[param1] < MAX_FILE_NUM;
        }// end function

        public function canAddSize(param1:String, param2:uint = 0) : Boolean
        {
            return this._moduleSizes[param1] < MAX_FILE_SIZE;
        }// end function

        public function getAvaibleSpace(param1:String) : uint
        {
            return Math.max(MAX_FILE_SIZE - this._moduleSizes[param1], 0);
        }// end function

        public function getUsedSpace(param1:String) : uint
        {
            return this._moduleSizes[param1];
        }// end function

        public function getMaxSpace(param1:String) : uint
        {
            return MAX_FILE_SIZE;
        }// end function

        public function getMaxFileCount(param1:String) : uint
        {
            return MAX_FILE_NUM;
        }// end function

        public function getUsedFileCount(param1:String) : uint
        {
            return this._moduleFilesNum[param1];
        }// end function

        private function updateFolderSize(param1:File, param2:String) : void
        {
            var _loc_5:File = null;
            if (this._moduleSizes[param2] == null)
            {
                this._moduleSizes[param2] = 0;
                this._moduleFilesNum[param2] = 0;
            }
            var _loc_3:uint = 0;
            var _loc_4:* = param1.getDirectoryListing();
            for each (_loc_5 in _loc_4)
            {
                
                if (_loc_5.isDirectory)
                {
                    _loc_3 = _loc_3 + this.updateFolderSize(_loc_5, param2);
                    continue;
                }
                _loc_3 = _loc_3 + _loc_5.size;
            }
            this._moduleSizes[param2] = this._moduleSizes[param2] + _loc_3;
            this._moduleFilesNum[param2] = this._moduleFilesNum[param2] + _loc_4.length;
            return;
        }// end function

        public static function getInstance() : ModuleFileManager
        {
            if (!_self)
            {
                _self = new ModuleFileManager;
            }
            return _self;
        }// end function

    }
}
