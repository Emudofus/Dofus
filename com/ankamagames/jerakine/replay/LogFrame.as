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
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.utils.getDefinitionByName;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.jerakine.utils.misc.LogUploadManager;
   
   public class LogFrame extends Object implements Frame
   {
      
      public function LogFrame(allowLogUpload:Boolean) {
         var maxFile:File = null;
         var date:Date = null;
         var log_files:Array = null;
         var deleteFile:File = null;
         var today:Date = null;
         var twoDay:Number = NaN;
         var mega:uint = 0;
         var sizeLimit:uint = 0;
         var maxSize:uint = 0;
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
                  if((today.getTime() - deleteFile.modificationDate.getTime() > twoDay) && (!(deleteFile.url.indexOf("log_") == -1)) && (deleteFile.extension == "d2l"))
                  {
                     deleteFile.deleteFile();
                  }
                  else
                  {
                     if((deleteFile.size > mega) && (deleteFile.size > maxSize) && (deleteFile.size < sizeLimit) && (!LogUploadManager.getInstance().hasBeenAlreadySend(deleteFile.name)))
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
      
      public static function set sendReplayInfo(v:Boolean) : void {
         getInstance();
         _self._sendReplayInfo = v;
         _self._sendindLc = new LocalConnection();
      }
      
      private static var _self:LogFrame;
      
      private static var _logEnable:Boolean;
      
      public static function get enabled() : Boolean {
         return _logEnable;
      }
      
      public static function getInstance(allowLogUpload:Boolean=false) : LogFrame {
         if(!_self)
         {
            _self = new LogFrame(allowLogUpload);
         }
         return _self;
      }
      
      public static function log(logType:uint, o:*) : void {
         if(!_self)
         {
            return;
         }
         _self._log(logType,o);
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
      
      public function process(msg:Message) : Boolean {
         var o:DisplayObject = null;
         if(!_logEnable)
         {
            return false;
         }
         try
         {
            switch(true)
            {
               case msg is INetworkMessage:
                  this._log(LogTypeEnum.NETWORK_IN,msg);
                  break;
               case msg is ILogableMessage:
                  this._log(LogTypeEnum.MESSAGE,msg);
                  break;
               case msg is MouseMessage:
                  if(MouseMessage(msg).target is ICustomUnicNameGetter)
                  {
                     this._log(LogTypeEnum.MOUSE,new MouseInteraction(ICustomUnicNameGetter(MouseMessage(msg).target).customUnicName,getQualifiedClassName(msg),MouseMessage(msg).mouseEvent.stageX,MouseMessage(msg).mouseEvent.stageY));
                  }
                  else
                  {
                     o = MouseMessage(msg).target;
                     if(o != null)
                     {
                        while((o.parent) && (!(o is ICustomUnicNameGetter)))
                        {
                           o = o.parent;
                        }
                        if(o is ICustomUnicNameGetter)
                        {
                           this._log(LogTypeEnum.MOUSE,new MouseInteraction(ICustomUnicNameGetter(o).customUnicName,getQualifiedClassName(msg),MouseMessage(msg).mouseEvent.stageX,MouseMessage(msg).mouseEvent.stageY));
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
         var copyLogFile:File = new File(this._logFile.nativePath + ".copy");
         var fs:FileStream = new FileStream();
         fs.open(copyLogFile,FileMode.WRITE);
         var ba:ByteArray = new ByteArray();
         this._logStream.position = 0;
         this._logStream.readBytes(ba);
         fs.writeBytes(ba);
         fs.close();
         this._logStream.close();
         this._logStream.open(this._logFile,FileMode.APPEND);
         return copyLogFile;
      }
      
      private function _log(logType:uint, o:*) : void {
         var objectEncodingLen:uint = 0;
         if((!_logEnable) || (o is IDontLogThisMessage))
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
            if((o is INetworkMessage) || (o is Action))
            {
               this._sendindLc.send(REPLAY_LC_NAME,"process","message",getQualifiedClassName(o));
               trace("Log " + getQualifiedClassName(o));
            }
         }
      }
      
      private function writeObject(output:ByteArray, o:*) : uint {
         var fieldName:String = null;
         var fieldData:LogClassField = null;
         if(o == null)
         {
            output.writeInt(NULL_IDENTIFIER);
            return output.length;
         }
         var field:Array = this.getClassField(o);
         if((o is Array) || (o is Dictionary) || (o is Vector.<*>) || (o is Vector.<uint>) || (o is Vector.<Boolean>) || (o is Vector.<int>) || (o is Vector.<Number>))
         {
            output.writeInt(this._arrayDef[o]);
         }
         else
         {
            output.writeInt(this.getClassIndex(getQualifiedClassName(o)));
         }
         for each (fieldData in field)
         {
            fieldName = this._reverseStringRef[fieldData.fieldNameId];
            switch(fieldData.type)
            {
               case INT:
                  if(!fieldData.transient)
                  {
                     output.writeInt(o[fieldName]);
                  }
                  else
                  {
                     output.writeInt(0);
                  }
                  continue;
               case UINT:
                  if(!fieldData.transient)
                  {
                     output.writeUnsignedInt(o[fieldName]);
                  }
                  else
                  {
                     output.writeUnsignedInt(0);
                  }
                  continue;
               case NUMBER:
                  if(!fieldData.transient)
                  {
                     output.writeDouble(o[fieldName]);
                  }
                  else
                  {
                     output.writeDouble(o[fieldName]);
                  }
                  continue;
               case BOOLEAN:
                  output.writeBoolean(o[fieldName]);
                  continue;
               case STRING:
                  output.writeBoolean(o[fieldName] == null);
                  if(o[fieldName] != null)
                  {
                     if(!fieldData.transient)
                     {
                        output.writeUnsignedInt(this.getStringIndex(o[fieldName]));
                     }
                     else
                     {
                        output.writeUnsignedInt(this.getStringIndex(NO_LOG_STRING.substr(0,o[fieldName].length)));
                     }
                  }
                  continue;
            }
         }
         return output.length;
      }
      
      private function getClassField(o:*) : Array {
         var fieldList:Array = null;
         var varCount:uint = 0;
         var fieldName:String = null;
         var className:String = getQualifiedClassName(o);
         if((o is Array) || (o is Dictionary) || (o is Vector.<*>) || (o is Vector.<uint>) || (o is Vector.<Boolean>) || (o is Vector.<int>) || (o is Vector.<Number>))
         {
            fieldList = new Array();
            varCount = 0;
            for (fieldName in o)
            {
               varCount++;
               if(o[fieldName] != null)
               {
                  fieldList[fieldList.length] = new LogClassField(this.getStringIndex(fieldName),this.getClassIndex(getQualifiedClassName(o[fieldName])),false);
               }
               else
               {
                  fieldList[fieldList.length] = new LogClassField(NULL_IDENTIFIER,this.getClassIndex(getQualifiedClassName(o[fieldName])),false);
               }
            }
            this.writeClassDefinition(++this._classCount,className,varCount,fieldList);
            this._arrayDef[o] = this._classCount;
            return fieldList;
         }
         if(!this._classRef[className])
         {
            this.getClassIndex(className);
         }
         return this._classRef[className];
      }
      
      private function getClassIndex(className:String) : int {
         var varCount:uint = 0;
         var variable:XML = null;
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
      
      private function writeClassDefinition(classId:int, className:String, varCount:uint, fieldList:Array) : void {
         var field:LogClassField = null;
         var classNameId:uint = this.getStringIndex(className);
         this._logStream.writeShort(1);
         this._logStream.writeUnsignedInt(classId);
         this._logStream.writeUnsignedInt(classNameId);
         this._logStream.writeShort(varCount);
         for each (field in fieldList)
         {
            this._logStream.writeUnsignedInt(field.fieldNameId);
            this._logStream.writeShort(field.type);
         }
      }
      
      private function getStringIndex(str:String) : uint {
         if(this._stringRef[str])
         {
            return this._stringRef[str];
         }
         var newIndex:uint = ++this._stringCount;
         this._stringRef[str] = newIndex;
         this._reverseStringRef[this._stringCount] = str;
         this._logStream.writeShort(2);
         this._logStream.writeUnsignedInt(newIndex);
         this._logStream.writeUTF(str);
         return newIndex;
      }
   }
}
