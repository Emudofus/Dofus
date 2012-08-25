package com.ankamagames.jerakine.types
{
    import com.ankamagames.jerakine.utils.files.*;

    public class LangMetaData extends Object
    {
        private var _nFileCount:uint = 0;
        public var loadAllFile:Boolean = false;
        public var clearAllFile:Boolean = false;
        public var clearOnlyNotUpToDate:Boolean = true;
        public var clearFile:Array;

        public function LangMetaData()
        {
            this.clearFile = new Array();
            return;
        }// end function

        public function addFile(param1:String, param2:String) : void
        {
            var _loc_3:String = this;
            var _loc_4:* = this._nFileCount + 1;
            _loc_3._nFileCount = _loc_4;
            this.clearFile[param1] = param2;
            return;
        }// end function

        public function get clearFileCount() : uint
        {
            return this._nFileCount;
        }// end function

        public static function fromXml(param1:String, param2:String, param3:Function) : LangMetaData
        {
            var _loc_7:XML = null;
            var _loc_4:* = new XML(param1);
            var _loc_5:* = new LangMetaData;
            var _loc_6:Boolean = false;
            if (_loc_4..filesActions..clearOnlyNotUpToDate.toString() == "true")
            {
                _loc_5.clearOnlyNotUpToDate = true;
            }
            if (_loc_4..filesActions..clearOnlyNotUpToDate.toString() == "false")
            {
                _loc_5.clearOnlyNotUpToDate = false;
            }
            if (_loc_4..filesActions..loadAllFile.toString() == "true")
            {
                _loc_5.loadAllFile = true;
            }
            if (_loc_4..filesActions..loadAllFile.toString() == "false")
            {
                _loc_5.loadAllFile = false;
            }
            if (_loc_4..filesActions..clearAllFile.toString() == "true")
            {
                _loc_5.clearAllFile = true;
            }
            if (_loc_4..filesActions..clearAllFile.toString() == "false")
            {
                _loc_5.clearAllFile = false;
            }
            for each (_loc_7 in _loc_4..filesVersions..file)
            {
                
                _loc_6 = true;
                if (_loc_5.clearAllFile || !_loc_5.clearOnlyNotUpToDate || !LangMetaData.param3(FileUtils.getFileStartName(param2) + "." + _loc_7..@name, _loc_7.toString()))
                {
                    _loc_5.addFile(_loc_7..@name, _loc_7.toString());
                }
            }
            if (!_loc_6)
            {
                _loc_5.loadAllFile = true;
            }
            return _loc_5;
        }// end function

    }
}
