package com.ankamagames.jerakine.task
{
    import com.ankamagames.jerakine.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.tasking.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.events.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.utils.*;

    public class LangXmlParsingTask extends SplittedTask
    {
        private var _nCurrentIndex:uint;
        private var _aFiles:Array;
        private var _sUrlProvider:String;
        private var _parseReference:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LangXmlParsingTask));

        public function LangXmlParsingTask(param1:Array, param2:String, param3:Boolean = true)
        {
            this._nCurrentIndex = 0;
            this._aFiles = param1;
            this._sUrlProvider = param2;
            this._parseReference = param3;
            return;
        }// end function

        override public function step() : Boolean
        {
            var _loc_1:LangFile = null;
            if (this._aFiles.length)
            {
                _loc_1 = LangFile(this._aFiles.shift());
                this.parseXml(_loc_1.content, _loc_1.category);
                if (_loc_1.metaData && _loc_1.metaData.clearFile[_loc_1.url])
                {
                    LangManager.getInstance().setFileVersion(FileUtils.getFileStartName(this._sUrlProvider) + "." + _loc_1.url, _loc_1.metaData.clearFile[_loc_1.url]);
                }
                dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE, false, false, _loc_1.url, this._sUrlProvider));
            }
            if (!this._aFiles.length)
            {
                dispatchEvent(new LangFileEvent(LangFileEvent.ALL_COMPLETE, false, false, this._sUrlProvider, this._sUrlProvider));
            }
            return !this._aFiles.length;
        }// end function

        public function parseForReg() : Boolean
        {
            var _loc_1:LangFile = null;
            if (this._aFiles.length)
            {
                _loc_1 = LangFile(this._aFiles.shift());
                this.parseXml(_loc_1.content, _loc_1.category);
                if (_loc_1.metaData && _loc_1.metaData.clearFile[_loc_1.url])
                {
                    LangManager.getInstance().setFileVersion(FileUtils.getFileStartName(this._sUrlProvider) + "." + _loc_1.url, _loc_1.metaData.clearFile[_loc_1.url]);
                }
                dispatchEvent(new LangFileEvent(LangFileEvent.COMPLETE, false, false, _loc_1.url, this._sUrlProvider));
            }
            return !this._aFiles.length;
        }// end function

        override public function stepsPerFrame() : uint
        {
            return 1;
        }// end function

        private function parseXml(param1:String, param2:String) : void
        {
            var xml:XML;
            var sEntry:String;
            var entry:XML;
            var sXml:* = param1;
            var sCategory:* = param2;
            try
            {
                xml = new XML(sXml);
                LangManager.getInstance().category[sCategory] = true;
                StoreDataManager.getInstance().getSetData(JerakineConstants.DATASTORE_LANG, "langCategory", LangManager.getInstance().category);
                var _loc_4:int = 0;
                var _loc_5:* = xml..entry;
                while (_loc_5 in _loc_4)
                {
                    
                    entry = _loc_5[_loc_4];
                    if (this._parseReference)
                    {
                        sEntry = LangManager.getInstance().replaceKey(entry.toString());
                    }
                    else
                    {
                        sEntry = entry.toString();
                    }
                    LangManager.getInstance().setEntry(sCategory + "." + entry..@key, sEntry, entry..@type.toString().length ? (entry..@type) : (null));
                }
            }
            catch (e:TypeError)
            {
                _log.error("Parsing error on category " + sCategory);
            }
            return;
        }// end function

    }
}
