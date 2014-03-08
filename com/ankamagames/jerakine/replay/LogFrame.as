package com.ankamagames.jerakine.replay
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.net.LocalConnection;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.messages.ILogableMessage;
   import flash.filesystem.FileMode;
   import com.ankamagames.jerakine.messages.IDontLogThisMessage;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.jerakine.utils.misc.LogUploadManager;
   
   public class LogFrame extends Object implements Frame
   {
      
      public function LogFrame(param1:Boolean) {
         var maxFile:File = null;
         var date:Date = null;
         var log_files:Array = null;
         var deleteFile:File = null;
         var today:Date = null;
         var twoDay:Number = NaN;
         var mega:uint = 0;
         var sizeLimit:uint = 0;
         var maxSize:uint = 0;
         var allowLogUpload:Boolean = param1;
         super();
         try
         {
            date = new Date();
            this._logFile = new File(CustomSharedObject.getCustomSharedObjectDirectory() + "/logs/log_" + date.fullYear + "-" + date.month + "-" + date.day + "_" + date.hours + "h" + date.minutes + "m" + date.seconds + "s" + date.milliseconds + ".d2l");
            this._logFile.parent.createDirectory();
            this._logStream = new FileStream();
            this._logStream.open(this._logFile,FileMode.WRITE);
            log_files = this._logFile.parent.getDirectoryListing();
            log_files.sortOn("creationDate",Array.DESCENDING);
            today = new Date();
            twoDay = 1000 * 60 * 60 * 24 * 2;
            mega = Math.pow(2,20) * 0 + 1024 * 250;
            sizeLimit = Math.pow(2,20) * 8 * 4;
            try
            {
               for each (deleteFile in log_files)
               {
                  if(today.getTime() - deleteFile.modificationDate.getTime() > twoDay && !(deleteFile.url.indexOf("log_") == -1) && deleteFile.extension == "d2l")
                  {
                     deleteFile.deleteFile();
                  }
                  else
                  {
                     if(deleteFile.size > mega && deleteFile.size > maxSize && deleteFile.size < sizeLimit && !LogUploadManager.getInstance().hasBeenAlreadySend(deleteFile.name))
                     {
                        maxFile = deleteFile;
                        maxSize = deleteFile.size;
                     }
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
         catch(e:Error)
         {
            trace("Error IO lors de la tentation de la création du fichier de log");
         }
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
         if((maxFile) && (allowLogUpload))
         {
            LogUploadManager.getInstance().askForUpload(maxFile);
         }
      }
      
      public static const UINT:int = -1;
      
      public static const INT:int = -2;
      
      public static const NUMBER:int = -3;
      
      public static const BOOLEAN:int = -4;
      
      public static const STRING:int = -5;
      
      public static const NULL_IDENTIFIER:int = -1431655766;
      
      private static const NO_LOG_STRING:String = "NoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLogNoLog";
      
      public static const REPLAY_LC_NAME:String = "_Dofus2ReplayInfo";
      
      public static function set sendReplayInfo(param1:Boolean) : void {
         getInstance();
         _self._sendReplayInfo = param1;
         _self._sendindLc = new LocalConnection();
      }
      
      private static var _self:LogFrame;
      
      private static var _logEnable:Boolean;
      
      public static function get enabled() : Boolean {
         return _logEnable;
      }
      
      public static function getInstance(param1:Boolean=false) : LogFrame {
         if(!_self)
         {
            _self = new LogFrame(param1);
         }
         return _self;
      }
      
      public static function log(param1:uint, param2:*) : void {
         if(!_self)
         {
            return;
         }
         _self._log(param1,param2);
      }
      
      public static function sendAck() : void {
         _self._sendindLc.send(REPLAY_LC_NAME,"process","ack");
      }
      
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
      
      public function pushed() : Boolean {
         _logEnable = true;
         return true;
      }
      
      public function get priority() : int {
         return Priority.LOG;
      }
      
      public function pulled() : Boolean {
         _logEnable = false;
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:DisplayObject = null;
         if(!_logEnable)
         {
            return false;
         }
         try
         {
            switch(true)
            {
               case param1 is INetworkMessage:
                  this._log(LogTypeEnum.NETWORK_IN,param1);
                  break;
               case param1 is ILogableMessage:
                  this._log(LogTypeEnum.MESSAGE,param1);
                  break;
               case param1 is MouseMessage:
                  if(MouseMessage(param1).target is ICustomUnicNameGetter)
                  {
                     this._log(LogTypeEnum.MOUSE,new MouseInteraction(ICustomUnicNameGetter(MouseMessage(param1).target).customUnicName,getQualifiedClassName(param1),MouseMessage(param1).mouseEvent.stageX,MouseMessage(param1).mouseEvent.stageY));
                  }
                  else
                  {
                     _loc2_ = MouseMessage(param1).target;
                     if(_loc2_ != null)
                     {
                        while((_loc2_.parent) && !(_loc2_ is ICustomUnicNameGetter))
                        {
                           _loc2_ = _loc2_.parent;
                        }
                        if(_loc2_ is ICustomUnicNameGetter)
                        {
                           this._log(LogTypeEnum.MOUSE,new MouseInteraction(ICustomUnicNameGetter(_loc2_).customUnicName,getQualifiedClassName(param1),MouseMessage(param1).mouseEvent.stageX,MouseMessage(param1).mouseEvent.stageY));
                        }
                     }
                  }
                  break;
            }
         }
         catch(e:Error)
         {
         }
         return false;
      }
      
      public function duplicateLogFile() : File {
         if(!enabled)
         {
            return null;
         }
         this._logStream.close();
         this._logStream.open(this._logFile,FileMode.READ);
         var _loc1_:File = new File(this._logFile.nativePath + ".copy");
         var _loc2_:FileStream = new FileStream();
         _loc2_.open(_loc1_,FileMode.WRITE);
         var _loc3_:ByteArray = new ByteArray();
         this._logStream.position = 0;
         this._logStream.readBytes(_loc3_);
         _loc2_.writeBytes(_loc3_);
         _loc2_.close();
         this._logStream.close();
         this._logStream.open(this._logFile,FileMode.APPEND);
         return _loc1_;
      }
      
      private function _log(param1:uint, param2:*) : void {
         var objectEncodingLen:uint = 0;
         var logType:uint = param1;
         var o:* = param2;
         if(!_logEnable || o is IDontLogThisMessage)
         {
            return;
         }
         try
         {
            this._arrayDef = new Dictionary(true);
            objectEncodingLen = this.writeObject(this._buffer,o);
            this._logStream.writeShort(0);
            this._logStream.writeDouble(getTimer());
            this._logStream.writeShort(logType);
            this._logStream.writeInt(objectEncodingLen);
            this._logStream.writeBytes(this._buffer);
            this._buffer.clear();
         }
         catch(e:Error)
         {
            _logEnable = false;
            _self = null;
            trace("Erreur lors de l\'encodage d\'un objet dans le fichier de log, arret des log.");
         }
         if(this._sendReplayInfo)
         {
            if(o is INetworkMessage || o is Action)
            {
               this._sendindLc.send(REPLAY_LC_NAME,"process","message",getQualifiedClassName(o));
               trace("Log " + getQualifiedClassName(o));
            }
         }
      }
      
      private function writeObject(param1:ByteArray, param2:*) : uint {
         var _loc4_:String = null;
         var _loc5_:LogClassField = null;
         if(param2 == null)
         {
            param1.writeInt(NULL_IDENTIFIER);
            return param1.length;
         }
         var _loc3_:Array = this.getClassField(param2);
         if(param2 is Array || param2 is Dictionary || param2 is Vector.<*> || param2 is Vector.<uint> || param2 is Vector.<Boolean> || param2 is Vector.<int> || param2 is Vector.<Number>)
         {
            param1.writeInt(this._arrayDef[param2]);
         }
         else
         {
            param1.writeInt(this.getClassIndex(getQualifiedClassName(param2)));
         }
         for each (_loc5_ in _loc3_)
         {
            _loc4_ = this._reverseStringRef[_loc5_.fieldNameId];
            switch(_loc5_.type)
            {
               case INT:
                  if(!_loc5_.transient)
                  {
                     param1.writeInt(param2[_loc4_]);
                  }
                  else
                  {
                     param1.writeInt(0);
                  }
                  continue;
               case UINT:
                  if(!_loc5_.transient)
                  {
                     param1.writeUnsignedInt(param2[_loc4_]);
                  }
                  else
                  {
                     param1.writeUnsignedInt(0);
                  }
                  continue;
               case NUMBER:
                  if(!_loc5_.transient)
                  {
                     param1.writeDouble(param2[_loc4_]);
                  }
                  else
                  {
                     param1.writeDouble(param2[_loc4_]);
                  }
                  continue;
               case BOOLEAN:
                  param1.writeBoolean(param2[_loc4_]);
                  continue;
               case STRING:
                  param1.writeBoolean(param2[_loc4_] == null);
                  if(param2[_loc4_] != null)
                  {
                     if(!_loc5_.transient)
                     {
                        param1.writeUnsignedInt(this.getStringIndex(param2[_loc4_]));
                     }
                     else
                     {
                        param1.writeUnsignedInt(this.getStringIndex(NO_LOG_STRING.substr(0,param2[_loc4_].length)));
                     }
                  }
                  continue;
               default:
                  this.writeObject(param1,param2[_loc4_]);
                  continue;
            }
         }
         return param1.length;
      }
      
      private function getClassField(param1:*) : Array {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc2_:String = getQualifiedClassName(param1);
         if(param1 is Array || param1 is Dictionary || param1 is Vector.<*> || param1 is Vector.<uint> || param1 is Vector.<Boolean> || param1 is Vector.<int> || param1 is Vector.<Number>)
         {
            _loc3_ = new Array();
            _loc4_ = 0;
            for (_loc5_ in param1)
            {
               _loc4_++;
               if(param1[_loc5_] != null)
               {
                  _loc3_[_loc3_.length] = new LogClassField(this.getStringIndex(_loc5_),this.getClassIndex(getQualifiedClassName(param1[_loc5_])),false);
               }
               else
               {
                  _loc3_[_loc3_.length] = new LogClassField(NULL_IDENTIFIER,this.getClassIndex(getQualifiedClassName(param1[_loc5_])),false);
               }
            }
            this.writeClassDefinition(++this._classCount,_loc2_,_loc4_,_loc3_);
            this._arrayDef[param1] = this._classCount;
            return _loc3_;
         }
         if(!this._classRef[_loc2_])
         {
            this.getClassIndex(_loc2_);
         }
         return this._classRef[_loc2_];
      }
      
      private function getClassIndex(param1:String) : int {
         var varCount:uint = 0;
         var variable:XML = null;
         var className:String = param1;
         if(this._classIndex[className])
         {
            return this._classIndex[className];
         }
         var fieldList:Array = new Array();
         var desc:XML = DescribeTypeCache.typeDescription(getDefinitionByName(className) as Class);
         for each (variable in desc..factory..variable)
         {
            fieldList[varCount] = new LogClassField(this.getStringIndex(variable.@name.toString()),this.getClassIndex(variable.@type.toString()),XMLList(variable..metadata.(@name == "Transient")).length());
            varCount++;
         }
         for each (variable in desc..accessor.(@access == "readwrite"))
         {
            fieldList[varCount] = new LogClassField(this.getStringIndex(variable.@name.toString()),this.getClassIndex(variable.@type.toString()),XMLList(variable..metadata.(@name == "Transient")).length());
            varCount++;
         }
         this._classRef[className] = fieldList;
         this._classIndex[className] = ++this._classCount;
         this.writeClassDefinition(this._classCount,className,varCount,fieldList);
         return this._classCount;
      }
      
      private function writeClassDefinition(param1:int, param2:String, param3:uint, param4:Array) : void {
         var _loc5_:LogClassField = null;
         var _loc6_:uint = this.getStringIndex(param2);
         this._logStream.writeShort(1);
         this._logStream.writeUnsignedInt(param1);
         this._logStream.writeUnsignedInt(_loc6_);
         this._logStream.writeShort(param3);
         for each (_loc5_ in param4)
         {
            this._logStream.writeUnsignedInt(_loc5_.fieldNameId);
            this._logStream.writeShort(_loc5_.type);
         }
      }
      
      private function getStringIndex(param1:String) : uint {
         if(this._stringRef[param1])
         {
            return this._stringRef[param1];
         }
         var _loc2_:uint = ++this._stringCount;
         this._stringRef[param1] = _loc2_;
         this._reverseStringRef[this._stringCount] = param1;
         this._logStream.writeShort(2);
         this._logStream.writeUnsignedInt(_loc2_);
         this._logStream.writeUTF(param1);
         return _loc2_;
      }
   }
}
