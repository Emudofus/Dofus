package com.ankamagames.jerakine.data
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class I18nFileAccessor extends Object
    {
        private var _stream:FileStream;
        private var _indexes:Dictionary;
        private var _textIndexes:Dictionary;
        private var _textIndexesOverride:Dictionary;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(I18nFileAccessor));
        private static var _self:I18nFileAccessor;

        public function I18nFileAccessor()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            return;
        }// end function

        public function init(param1:Uri) : void
        {
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_8:String = null;
            var _loc_2:* = param1.toFile();
            if (!_loc_2 || !_loc_2.exists)
            {
                throw new Error("I18n file not readable.");
            }
            this._stream = new FileStream();
            this._stream.endian = Endian.BIG_ENDIAN;
            this._stream.open(_loc_2, FileMode.READ);
            this._indexes = new Dictionary();
            this._textIndexes = new Dictionary();
            this._textIndexesOverride = new Dictionary();
            var _loc_3:* = this._stream.readInt();
            this._stream.position = _loc_3;
            var _loc_4:* = this._stream.readInt();
            var _loc_7:uint = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_5 = this._stream.readInt();
                _loc_6 = this._stream.readInt();
                this._indexes[_loc_5] = _loc_6;
                _loc_7 = _loc_7 + 8;
            }
            while (this._stream.bytesAvailable > 0)
            {
                
                _loc_8 = this._stream.readUTF();
                _loc_6 = this._stream.readInt();
                this._textIndexes[_loc_8] = _loc_6;
            }
            _log.debug("Initialized !");
            return;
        }// end function

        public function addOverrideFile(param1:Uri) : void
        {
            var rawContent:String;
            var f:File;
            var fs:FileStream;
            var content:XML;
            var override:XML;
            var file:* = param1;
            if (file.fileType == "xml")
            {
                try
                {
                    f = file.toFile();
                    if (!f.exists)
                    {
                        _log.fatal("Le fichier [" + file + "] utiliser lors de la surcharge du fichier i18n n\'existe pas");
                        return;
                    }
                    fs = new FileStream();
                    fs.open(f, FileMode.READ);
                    rawContent = fs.readUTFBytes(fs.bytesAvailable);
                }
                catch (e:Error)
                {
                    _log.fatal("Impossible de lire le fichier " + file + " lors de la surcharge du fichier i18n : \n" + e.getStackTrace());
                    return;
                    try
                    {
                    }
                    content = new XML(rawContent);
                    var _loc_3:int = 0;
                    var _loc_4:* = content..override;
                    while (_loc_4 in _loc_3)
                    {
                        
                        override = _loc_4[_loc_3];
                        if (override.@type.toString() == "" || override.@type.toString() == "ui")
                        {
                            this._textIndexesOverride[override.@target.toString()] = override.toString();
                            continue;
                        }
                        if (override.@type.toString() == "i18n")
                        {
                            I18n.addOverride(override.@target.toString(), override.toString());
                            continue;
                        }
                        GameData.addOverride(override.@type.toString(), override.@target.toString(), override.toString());
                    }
                }
                catch (e:Error)
                {
                    _log.fatal("Erreur lors de la lecture du fichier " + file + " pour la surcharge du fichier i18n : \n" + e.getStackTrace());
                }
                _log.debug("Override done !");
            }
            else
            {
                _log.error("Le fichier d\'override [" + file.fileName + "] n\'est pas un fichier xml.");
            }
            return;
        }// end function

        public function getText(param1:int) : String
        {
            if (!this._indexes)
            {
                return null;
            }
            var _loc_2:* = this._indexes[param1];
            if (!_loc_2)
            {
                return null;
            }
            this._stream.position = _loc_2;
            return this._stream.readUTF();
        }// end function

        public function hasText(param1:int) : Boolean
        {
            return this._indexes && this._indexes[param1];
        }// end function

        public function getNamedText(param1:String) : String
        {
            if (!this._textIndexes)
            {
                return null;
            }
            if (this._textIndexesOverride[param1])
            {
                param1 = this._textIndexesOverride[param1];
            }
            var _loc_2:* = this._textIndexes[param1];
            if (!_loc_2)
            {
                return null;
            }
            this._stream.position = _loc_2;
            return this._stream.readUTF();
        }// end function

        public function hasNamedText(param1:String) : Boolean
        {
            return this._textIndexes && this._textIndexes[param1];
        }// end function

        public function close() : void
        {
            if (this._stream)
            {
                try
                {
                    this._stream.close();
                }
                catch (e:Error)
                {
                }
                this._stream = null;
            }
            this._indexes = null;
            this._textIndexes = null;
            return;
        }// end function

        public static function getInstance() : I18nFileAccessor
        {
            if (!_self)
            {
                _self = new I18nFileAccessor;
            }
            return _self;
        }// end function

    }
}
