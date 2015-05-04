package com.ankamagames.dofus.misc.interClient
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.filesystem.FileStream;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import flash.events.TimerEvent;
   
   public class AppIdModifier extends Object
   {
      
      public function AppIdModifier()
      {
         var applicationConfig:File = null;
         var idFile:File = null;
         var newAppId:String = null;
         var tmp2:Array = null;
         var ts:Number = NaN;
         var pathSo:String = null;
         super();
         _self = this;
         if(!COMMON_FOLDER)
         {
            tmp2 = File.applicationStorageDirectory.nativePath.split(File.separator);
            tmp2.pop();
            tmp2.pop();
            COMMON_FOLDER = tmp2.join(File.separator) + File.separator;
         }
         applicationConfig = new File(File.applicationDirectory.nativePath + File.separator + "META-INF" + File.separator + "AIR" + File.separator + "application.xml");
         var fs:FileStream = new FileStream();
         fs.open(applicationConfig,FileMode.READ);
         var content:String = fs.readUTFBytes(fs.bytesAvailable);
         fs.close();
         var startIdTagPos:int = content.indexOf("<" + APP_ID_TAG + ">");
         var endIdTagPos:int = content.indexOf("</" + APP_ID_TAG + ">");
         if(startIdTagPos == -1 || endIdTagPos == -1)
         {
            return;
         }
         startIdTagPos = startIdTagPos + 2 + APP_ID_TAG.length;
         var currentId:String = content.substr(startIdTagPos,endIdTagPos - startIdTagPos);
         var tmp:Array = currentId.split("-");
         if(!tmp[1])
         {
            this._currentAppId = 1;
         }
         else
         {
            this._currentAppId = parseInt(tmp[1],10);
         }
         this.updateTs();
         var nextId:uint = 1;
         var idFileStream:FileStream = new FileStream();
         var currentTimestamp:Number = new Date().time;
         while(true)
         {
            idFile = new File(COMMON_FOLDER + APP_ID + nextId);
            if(!idFile.exists)
            {
               break;
            }
            try
            {
               idFileStream.open(idFile,FileMode.READ);
               ts = idFileStream.readDouble();
               idFileStream.close();
               if(currentTimestamp - ts > 30000)
               {
                  break;
               }
            }
            catch(e:Error)
            {
            }
            nextId++;
         }
         if(nextId == 1)
         {
            newAppId = tmp[0];
         }
         else
         {
            newAppId = tmp[0] + "-" + nextId;
         }
         try
         {
            content = content.substr(0,startIdTagPos) + newAppId + content.substr(endIdTagPos);
            fs.open(applicationConfig,FileMode.WRITE);
            fs.writeUTFBytes(content);
            fs.close();
         }
         catch(e:Error)
         {
            _log.error("Impossible d\'écrir le fichier " + applicationConfig.nativePath);
         }
         var soFolder:File = File.applicationStorageDirectory.resolvePath("#SharedObjects/" + FileUtils.getFileName(Dofus.getInstance().loaderInfo.loaderURL));
         var appInfoFile:File = new File(COMMON_FOLDER + APP_INFO);
         try
         {
            fs.open(new File(COMMON_FOLDER + APP_INFO),FileMode.WRITE);
            pathSo = Base64.encode(soFolder.nativePath);
            fs.writeInt(pathSo.length);
            fs.writeUTFBytes(pathSo);
            fs.writeBoolean(true);
            fs.close();
         }
         catch(e:Error)
         {
            _log.error("Impossible d\'écrir le fichier " + applicationConfig.nativePath);
         }
         var t:Timer = new Timer(20000);
         t.addEventListener(TimerEvent.TIMER,this.updateTs);
         t.start();
      }
      
      private static var _self:AppIdModifier;
      
      private static const APP_ID_TAG:String = "id";
      
      private static const APP_ID:String = "DofusAppId" + BuildInfos.BUILD_TYPE + "_";
      
      private static const APP_INFO:String = "D2Info" + BuildInfos.BUILD_TYPE;
      
      private static var COMMON_FOLDER:String;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AppIdModifier));
      
      public static function getInstance() : AppIdModifier
      {
         return _self;
      }
      
      private var _currentAppId:uint;
      
      public function invalideCache() : void
      {
         var _loc4_:uint = 0;
         var _loc1_:FileStream = new FileStream();
         var _loc2_:File = new File(COMMON_FOLDER + APP_INFO);
         var _loc3_:* = "";
         if(_loc2_.exists)
         {
            _loc1_.open(_loc2_,FileMode.READ);
            _loc4_ = _loc1_.readInt();
            _loc3_ = _loc1_.readUTFBytes(_loc4_);
            _loc1_.close();
         }
         _loc1_.open(_loc2_,FileMode.WRITE);
         _loc1_.writeInt(_loc3_.length);
         _loc1_.writeUTFBytes(_loc3_);
         _loc1_.writeBoolean(false);
         _loc1_.close();
      }
      
      private function log(param1:String) : void
      {
         var applicationConfig:File = null;
         var fs:FileStream = null;
         var txt:String = param1;
         try
         {
            applicationConfig = new File(File.applicationDirectory.nativePath + File.separator + "logAppId.txt");
            fs = new FileStream();
            fs.open(applicationConfig,FileMode.APPEND);
            fs.writeUTFBytes("[" + this._currentAppId + "] " + txt + "\n");
            fs.close();
         }
         catch(e:Error)
         {
            _log.info("Impossible d\'écrir dans le fichier " + File.applicationDirectory.nativePath + File.separator + "logAppId.txt");
         }
      }
      
      private function updateTs(param1:* = null) : void
      {
         var currentTimestamp:Number = NaN;
         var idFile:File = null;
         var idFileStream:FileStream = null;
         var e:* = param1;
         try
         {
            currentTimestamp = new Date().time;
            idFile = new File(COMMON_FOLDER + APP_ID + this._currentAppId);
            idFileStream = new FileStream();
            idFileStream.open(idFile,FileMode.WRITE);
            idFileStream.writeDouble(currentTimestamp);
            idFileStream.close();
         }
         catch(e:Error)
         {
            _log.error("Impossible de mettre à jour le fichier " + (COMMON_FOLDER + APP_ID + _currentAppId));
         }
      }
   }
}
