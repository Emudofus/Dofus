package com.ankamagames.jerakine.replay
{
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;

    public class LogFrame extends Object implements Frame
    {
        private var _logStream:FileStream;
        private var _buffer:ByteArray;
        private var _sendBuffer:ByteArray;
        private var _stringRef:Dictionary;
        private var _reverseStringRef:Array;
        private var _classRef:Dictionary;
        private var _classIndex:Dictionary;
        private var _classCount:uint;
        private var _stringCount:uint;
        private var _arrayDef:Dictionary;
        private var _sendindLc:LocalConnection;
        private var _sendReplayInfo:Boolean;
        private var _logFile:File;
        public static const UINT:int = -1;
        public static const INT:int = -2;
        public static const NUMBER:int = -3;
        public static const BOOLEAN:int = -4;
        public static const STRING:int = -5;
        public static const NULL_IDENTIFIER:int = -1.43166e+009;
        private static const NO_LOG_STRING:String = "NoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLog";
        public static const REPLAY_LC_NAME:String = "_Dofus2ReplayInfo";
        private static var _self:LogFrame;
        private static var _logEnable:Boolean;

        public function LogFrame(param1:Boolean)
        {
            var maxFile:File;
            var date:Date;
            var log_files:Array;
            var deleteFile:File;
            var today:Date;
            var twoDay:Number;
            var mega:uint;
            var sizeLimit:uint;
            var maxSize:uint;
            var allowLogUpload:* = param1;
            date = new Date();
            this._logFile = new File(CustomSharedObject.getCustomSharedObjectDirectory() + "/logs/log_" + date.fullYear + "-" + date.month + "-" + date.day + "_" + date.hours + "h" + date.minutes + "m" + date.seconds + "s" + date.milliseconds + ".d2l");
            this._logFile.parent.createDirectory();
            this._logStream = new FileStream();
            this._logStream.open(this._logFile, FileMode.WRITE);
            log_files = this._logFile.parent.getDirectoryListing();
            log_files.sortOn("creationDate", Array.DESCENDING);
            today = new Date();
            twoDay = 1000 * 60 * 60 * 24 * 2;
            mega = Math.pow(2, 20) * 0 + 1024 * 250;
            sizeLimit = Math.pow(2, 20) * 8 * 4;
            try
            {
                var _loc_3:* = 0;
                var _loc_4:* = log_files;
                while (_loc_4 in _loc_3)
                {
                    
                    deleteFile = _loc_4[_loc_3];
                    if (today.getTime() - deleteFile.modificationDate.getTime() > twoDay && deleteFile.url.indexOf("log_") != -1 && deleteFile.extension == "d2l")
                    {
                        deleteFile.deleteFile();
                        continue;
                    }
                    if (deleteFile.size > mega && deleteFile.size > maxSize && deleteFile.size < sizeLimit && !LogUploadManager.getInstance().hasBeenAlreadySend(deleteFile.name))
                    {
                        maxFile = deleteFile;
                        maxSize = deleteFile.size;
                    }
                }
            }
            catch (e:Error)
            {
            }
            ;
            var _loc_3:* = new catch1;
            allowLogUpload;
            trace("Error IO lors de la tentation de la création du fichier de log");
            this._buffer = new ByteArray();
            this._classRef = new Dictionary();
            this._stringRef = new Dictionary();
            this._classIndex = new Dictionary();
            this._reverseStringRef = new Array();
            this._classIndex["uint"] = UINT;
            this._classIndex["int"] = INT;
            this._classIndex["Boolean"] = BOOLEAN;
            this._classIndex["Number"] = NUMBER;
            this._classIndex["String"] = STRING;
            if (maxFile && allowLogUpload)
            {
                LogUploadManager.getInstance().askForUpload(maxFile);
            }
            return;
        }// end function

        public function pushed() : Boolean
        {
            _logEnable = true;
            return true;
        }// end function

        public function get priority() : int
        {
            return Priority.LOG;
        }// end function

        public function pulled() : Boolean
        {
            _logEnable = false;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            if (!_logEnable)
            {
                return false;
            }
            try
            {
                switch(true)
                {
                    case param1 is INetworkMessage:
                    {
                        this._log(LogTypeEnum.NETWORK_IN, param1);
                        break;
                    }
                    case param1 is ILogableMessage:
                    {
                        this._log(LogTypeEnum.MESSAGE, param1);
                        break;
                    }
                    case param1 is MouseMessage:
                    {
                        if (MouseMessage(param1).target is ICustomUnicNameGetter)
                        {
                            this._log(LogTypeEnum.MOUSE, new MouseInteraction(ICustomUnicNameGetter(MouseMessage(param1).target).customUnicName, getQualifiedClassName(param1), MouseMessage(param1).mouseEvent.stageX, MouseMessage(param1).mouseEvent.stageY));
                        }
                        else
                        {
                            _loc_2 = MouseMessage(param1).target;
                            if (_loc_2 != null)
                            {
                                while (_loc_2.parent && !(_loc_2 is ICustomUnicNameGetter))
                                {
                                    
                                    _loc_2 = _loc_2.parent;
                                }
                                if (_loc_2 is ICustomUnicNameGetter)
                                {
                                    this._log(LogTypeEnum.MOUSE, new MouseInteraction(ICustomUnicNameGetter(_loc_2).customUnicName, getQualifiedClassName(param1), MouseMessage(param1).mouseEvent.stageX, MouseMessage(param1).mouseEvent.stageY));
                                }
                            }
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            catch (e:Error)
            {
            }
            return false;
        }// end function

        public function duplicateLogFile() : File
        {
            if (!enabled)
            {
                return null;
            }
            this._logStream.close();
            this._logStream.open(this._logFile, FileMode.READ);
            var _loc_1:* = new File(this._logFile.nativePath + ".copy");
            var _loc_2:* = new FileStream();
            _loc_2.open(_loc_1, FileMode.WRITE);
            var _loc_3:* = new ByteArray();
            this._logStream.position = 0;
            this._logStream.readBytes(_loc_3);
            _loc_2.writeBytes(_loc_3);
            _loc_2.close();
            this._logStream.close();
            this._logStream.open(this._logFile, FileMode.APPEND);
            return _loc_1;
        }// end function

        private function _log(param1:uint, param2) : void
        {
            var objectEncodingLen:uint;
            var logType:* = param1;
            var o:* = param2;
            if (!_logEnable || o is IDontLogThisMessage)
            {
                return;
            }
            try
            {
                this._arrayDef = new Dictionary(true);
                objectEncodingLen = this.writeObject(this._buffer, o);
                this._logStream.writeShort(0);
                this._logStream.writeDouble(getTimer());
                this._logStream.writeShort(logType);
                this._logStream.writeInt(objectEncodingLen);
                this._logStream.writeBytes(this._buffer);
                this._buffer.clear();
            }
            catch (e:Error)
            {
                _logEnable = false;
                _self = null;
                trace("Erreur lors de l\'encodage d\'un objet dans le fichier de log, arret des log.");
            }
            if (this._sendReplayInfo)
            {
                if (o is INetworkMessage || o is Action)
                {
                    this._sendindLc.send(REPLAY_LC_NAME, "process", "message", getQualifiedClassName(o));
                    trace("Log " + getQualifiedClassName(o));
                }
            }
            return;
        }// end function

        private function writeObject(param1:ByteArray, param2) : uint
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param2 == null)
            {
                param1.writeInt(NULL_IDENTIFIER);
                return param1.length;
            }
            var _loc_3:* = this.getClassField(param2);
            if (param2 is Array || param2 is Dictionary || param2 is Vector.<null> || param2 is Vector.<uint> || param2 is Vector.<Boolean> || param2 is Vector.<int> || param2 is Vector.<Number>)
            {
                param1.writeInt(this._arrayDef[param2]);
            }
            else
            {
                param1.writeInt(this.getClassIndex(getQualifiedClassName(param2)));
            }
            for each (_loc_5 in _loc_3)
            {
                
                _loc_4 = this._reverseStringRef[_loc_5.fieldNameId];
                switch(_loc_5.type)
                {
                    case INT:
                    {
                        if (!_loc_5.transient)
                        {
                            param1.writeInt(param2[_loc_4]);
                        }
                        else
                        {
                            param1.writeInt(0);
                        }
                        break;
                    }
                    case UINT:
                    {
                        if (!_loc_5.transient)
                        {
                            param1.writeUnsignedInt(param2[_loc_4]);
                        }
                        else
                        {
                            param1.writeUnsignedInt(0);
                        }
                        break;
                    }
                    case NUMBER:
                    {
                        if (!_loc_5.transient)
                        {
                            param1.writeDouble(param2[_loc_4]);
                        }
                        else
                        {
                            param1.writeDouble(param2[_loc_4]);
                        }
                        break;
                    }
                    case BOOLEAN:
                    {
                        param1.writeBoolean(param2[_loc_4]);
                        break;
                    }
                    case STRING:
                    {
                        param1.writeBoolean(param2[_loc_4] == null);
                        if (param2[_loc_4] != null)
                        {
                            if (!_loc_5.transient)
                            {
                                param1.writeUnsignedInt(this.getStringIndex(param2[_loc_4]));
                            }
                            else
                            {
                                param1.writeUnsignedInt(this.getStringIndex(NO_LOG_STRING.substr(0, param2[_loc_4].length)));
                            }
                        }
                        break;
                    }
                    default:
                    {
                        this.writeObject(param1, param2[_loc_4]);
                        break;
                        break;
                    }
                }
            }
            return param1.length;
        }// end function

        private function getClassField(param1) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = getQualifiedClassName(param1);
            if (param1 is Array || param1 is Dictionary || param1 is Vector.<null> || param1 is Vector.<uint> || param1 is Vector.<Boolean> || param1 is Vector.<int> || param1 is Vector.<Number>)
            {
                _loc_3 = new Array();
                _loc_4 = 0;
                for (_loc_5 in param1)
                {
                    
                    _loc_4 = _loc_4 + 1;
                    if (param1[_loc_5] != null)
                    {
                        _loc_3[_loc_3.length] = new LogClassField(this.getStringIndex(_loc_5), this.getClassIndex(getQualifiedClassName(param1[_loc_5])), false);
                        continue;
                    }
                    _loc_3[_loc_3.length] = new LogClassField(NULL_IDENTIFIER, this.getClassIndex(getQualifiedClassName(param1[_loc_5])), false);
                }
                var _loc_6:* = this;
                _loc_6._classCount = this._classCount + 1;
                this.writeClassDefinition(++this._classCount, _loc_2, _loc_4, _loc_3);
                this._arrayDef[param1] = this._classCount;
                return _loc_3;
            }
            if (!this._classRef[_loc_2])
            {
                this.getClassIndex(_loc_2);
            }
            return this._classRef[_loc_2];
        }// end function

        private function getClassIndex(param1:String) : int
        {
            var varCount:uint;
            var variable:XML;
            var className:* = param1;
            if (this._classIndex[className])
            {
                return this._classIndex[className];
            }
            var fieldList:* = new Array();
            var desc:* = DescribeTypeCache.typeDescription(getDefinitionByName(className) as Class);
            var _loc_3:* = 0;
            var _loc_4:* = desc..factory..variable;
            while (_loc_4 in _loc_3)
            {
                
                variable = _loc_4[_loc_3];
                var _loc_6:* = 0;
                var _loc_7:* = variable..metadata;
                var _loc_5:* = new XMLList("");
                for each (_loc_8 in _loc_7)
                {
                    
                    var _loc_9:* = _loc_7[_loc_6];
                    with (_loc_7[_loc_6])
                    {
                        if (@name == "Transient")
                        {
                            _loc_5[_loc_6] = _loc_8;
                        }
                    }
                }
                fieldList[varCount] = new LogClassField(this.getStringIndex(variable.@name.toString()), this.getClassIndex(variable.@type.toString()), XMLList(_loc_5).length());
                varCount = (varCount + 1);
            }
            var _loc_3:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = desc..accessor;
            var _loc_5:* = new XMLList("");
            for each (_loc_8 in _loc_7)
            {
                
                var _loc_9:* = _loc_7[_loc_6];
                with (_loc_7[_loc_6])
                {
                    if (@access == "readwrite")
                    {
                        _loc_5[_loc_6] = _loc_8;
                    }
                }
            }
            var _loc_4:* = _loc_5;
            while (_loc_4 in _loc_3)
            {
                
                variable = _loc_4[_loc_3];
                var _loc_6:* = 0;
                var _loc_7:* = variable..metadata;
                var _loc_5:* = new XMLList("");
                for each (_loc_8 in _loc_7)
                {
                    
                    var _loc_9:* = _loc_7[_loc_6];
                    with (_loc_7[_loc_6])
                    {
                        if (@name == "Transient")
                        {
                            _loc_5[_loc_6] = _loc_8;
                        }
                    }
                }
                fieldList[varCount] = new LogClassField(this.getStringIndex(variable.@name.toString()), this.getClassIndex(variable.@type.toString()), XMLList(_loc_5).length());
                varCount = (varCount + 1);
            }
            this._classRef[className] = fieldList;
            var _loc_3:* = this;
            _loc_3._classCount = this._classCount + 1;
            this._classIndex[className] = this._classCount + 1;
            this.writeClassDefinition(this._classCount, className, varCount, fieldList);
            return this._classCount;
        }// end function

        private function writeClassDefinition(param1:int, param2:String, param3:uint, param4:Array) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = this.getStringIndex(param2);
            this._logStream.writeShort(1);
            this._logStream.writeUnsignedInt(param1);
            this._logStream.writeUnsignedInt(_loc_6);
            this._logStream.writeShort(param3);
            for each (_loc_5 in param4)
            {
                
                this._logStream.writeUnsignedInt(_loc_5.fieldNameId);
                this._logStream.writeShort(_loc_5.type);
            }
            return;
        }// end function

        private function getStringIndex(param1:String) : uint
        {
            if (this._stringRef[param1])
            {
                return this._stringRef[param1];
            }
            var _loc_3:* = this;
            _loc_3._stringCount = this._stringCount + 1;
            var _loc_2:* = this._stringCount + 1;
            this._stringRef[param1] = _loc_2;
            this._reverseStringRef[this._stringCount] = param1;
            this._logStream.writeShort(2);
            this._logStream.writeUnsignedInt(_loc_2);
            this._logStream.writeUTF(param1);
            return _loc_2;
        }// end function

        public static function set sendReplayInfo(param1:Boolean) : void
        {
            getInstance();
            _self._sendReplayInfo = param1;
            _self._sendindLc = new LocalConnection();
            return;
        }// end function

        public static function get enabled() : Boolean
        {
            return _logEnable;
        }// end function

        public static function getInstance(param1:Boolean = false) : LogFrame
        {
            if (!_self)
            {
                _self = new LogFrame(param1);
            }
            return _self;
        }// end function

        public static function log(param1:uint, param2) : void
        {
            if (!_self)
            {
                return;
            }
            _self._log(param1, param2);
            return;
        }// end function

        public static function sendAck() : void
        {
            _self._sendindLc.send(REPLAY_LC_NAME, "process", "ack");
            return;
        }// end function

    }
}
