package com.ankamagames.dofus.misc.interClient
{
    import com.ankamagames.dofus.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.files.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class AppIdModifier extends Object
    {
        private var _currentAppId:uint;
        private static var _self:AppIdModifier;
        private static const APP_ID_TAG:String = "id";
        private static const APP_ID:String = "DofusAppId" + BuildInfos.BUILD_TYPE + "_";
        private static const APP_INFO:String = "D2Info" + BuildInfos.BUILD_TYPE;
        private static var COMMON_FOLDER:String;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AppIdModifier));

        public function AppIdModifier()
        {
            var idFile:File;
            var newAppId:String;
            var tmp2:Array;
            var ts:Number;
            _self = this;
            if (!COMMON_FOLDER)
            {
                tmp2 = File.applicationStorageDirectory.nativePath.split(File.separator);
                tmp2.pop();
                tmp2.pop();
                COMMON_FOLDER = tmp2.join(File.separator) + File.separator;
            }
            var applicationConfig:* = new File(File.applicationDirectory.nativePath + File.separator + "META-INF" + File.separator + "AIR" + File.separator + "application.xml");
            var fs:* = new FileStream();
            fs.open(applicationConfig, FileMode.READ);
            var content:* = fs.readUTFBytes(fs.bytesAvailable);
            fs.close();
            var startIdTagPos:* = content.indexOf("<" + APP_ID_TAG + ">");
            var endIdTagPos:* = content.indexOf("</" + APP_ID_TAG + ">");
            if (startIdTagPos == -1 || endIdTagPos == -1)
            {
                return;
            }
            startIdTagPos = startIdTagPos + 2 + APP_ID_TAG.length;
            var currentId:* = content.substr(startIdTagPos, endIdTagPos - startIdTagPos);
            var tmp:* = currentId.split("-");
            if (!tmp[1])
            {
                this._currentAppId = 1;
            }
            else
            {
                this._currentAppId = parseInt(tmp[1], 10);
            }
            this.updateTs();
            var nextId:uint;
            var idFileStream:* = new FileStream();
            var currentTimestamp:* = new Date().time;
            while (true)
            {
                
                idFile = new File(COMMON_FOLDER + APP_ID + nextId);
                if (!idFile.exists)
                {
                    break;
                }
                try
                {
                    idFileStream.open(idFile, FileMode.READ);
                    ts = idFileStream.readDouble();
                    idFileStream.close();
                    if (currentTimestamp - ts > 30000)
                    {
                        break;
                    }
                }
                catch (e:Error)
                {
                }
                nextId = (nextId + 1);
            }
            if (nextId == 1)
            {
                newAppId = tmp[0];
            }
            else
            {
                newAppId = tmp[0] + "-" + nextId;
            }
            content = content.substr(0, startIdTagPos) + newAppId + content.substr(endIdTagPos);
            fs.open(applicationConfig, FileMode.WRITE);
            fs.writeUTFBytes(content);
            fs.close();
            var soFolder:* = File.applicationStorageDirectory.resolvePath("#SharedObjects/" + FileUtils.getFileName(Dofus.getInstance().loaderInfo.loaderURL));
            var appInfoFile:* = new File(COMMON_FOLDER + APP_INFO);
            fs.open(new File(COMMON_FOLDER + APP_INFO), FileMode.WRITE);
            var pathSo:* = Base64.encode(soFolder.nativePath);
            fs.writeInt(pathSo.length);
            fs.writeUTFBytes(pathSo);
            fs.writeBoolean(true);
            fs.close();
            var t:* = new Timer(20000);
            t.addEventListener(TimerEvent.TIMER, this.updateTs);
            t.start();
            return;
        }// end function

        public function invalideCache() : void
        {
            var _loc_4:uint = 0;
            var _loc_1:* = new FileStream();
            var _loc_2:* = new File(COMMON_FOLDER + APP_INFO);
            var _loc_3:String = "";
            if (_loc_2.exists)
            {
                _loc_1.open(_loc_2, FileMode.READ);
                _loc_4 = _loc_1.readInt();
                _loc_3 = _loc_1.readUTFBytes(_loc_4);
                _loc_1.close();
            }
            _loc_1.open(_loc_2, FileMode.WRITE);
            _loc_1.writeInt(_loc_3.length);
            _loc_1.writeUTFBytes(_loc_3);
            _loc_1.writeBoolean(false);
            _loc_1.close();
            return;
        }// end function

        private function log(param1:String) : void
        {
            var _loc_2:* = new File(File.applicationDirectory.nativePath + File.separator + "logAppId.txt");
            var _loc_3:* = new FileStream();
            _loc_3.open(_loc_2, FileMode.APPEND);
            _loc_3.writeUTFBytes("[" + this._currentAppId + "] " + param1 + "\n");
            _loc_3.close();
            return;
        }// end function

        private function updateTs(param1 = null) : void
        {
            var _loc_2:* = new Date().time;
            var _loc_3:* = new File(COMMON_FOLDER + APP_ID + this._currentAppId);
            var _loc_4:* = new FileStream();
            new FileStream().open(_loc_3, FileMode.WRITE);
            _loc_4.writeDouble(_loc_2);
            _loc_4.close();
            return;
        }// end function

        public static function getInstance() : AppIdModifier
        {
            return _self;
        }// end function

    }
}
