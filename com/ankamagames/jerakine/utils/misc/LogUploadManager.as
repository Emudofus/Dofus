package com.ankamagames.jerakine.utils.misc
{
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.utils.*;
    import nochump.util.zip.*;

    public class LogUploadManager extends Object
    {
        private var _so:CustomSharedObject;
        private var _loader:URLLoader;
        private var _base64Encoder:Base64Async;
        private var _targetedFile:File;
        private static var _self:LogUploadManager;
        private static var mega:uint = Math.pow(2, 20);

        public function LogUploadManager()
        {
            if (_self)
            {
                throw new SingletonError();
            }
            this._so = CustomSharedObject.getLocal("uploadLogOptions");
            if (!this._so.data.history)
            {
                this._so.data.history = new Dictionary();
                this._so.flush();
            }
            return;
        }// end function

        public function askForUpload(param1:File) : void
        {
            var uui:SystemPopupUI;
            var targetFile:* = param1;
            if (this._so.data.disabled !== true && !this.hasBeenAlreadySend(targetFile.name))
            {
                this._targetedFile = targetFile;
                uui = new SystemPopupUI("uploadLogFile");
                uui.modal = true;
                uui.title = "Analyse des performances";
                uui.content = "Nous avons détécté un fichier de log contenant une longue session de jeu (" + Math.floor(targetFile.size / mega * 10 / 4) / 10 + " Mo).\n" + "Voulez-vous transmettre ce fichier à l\'équipe Dofus 2.0 pour participter à l\'amélioration de Dofus 2.0 ?\n" + "\n" + "Note : Le fichier de log contiens des données nominatives mais les mots de passes ainsi que les conversations ne sont pas enregistrés";
                uui.buttons = [{label:"Envoyer", callback:new Callback(this.onSendLog, targetFile)}, {label:"Ne plus demander", callback:function () : void
            {
                _so.data.disabled = true;
                _so.flush();
                return;
            }// end function
            }, {label:"Annuler"}];
                uui.show();
            }
            return;
        }// end function

        public function hasBeenAlreadySend(param1:String) : Boolean
        {
            return this._so.data.history[param1] === true;
        }// end function

        private function onSendLog(param1:File) : void
        {
            var _loc_2:* = new ByteArray();
            var _loc_3:* = new FileStream();
            _loc_3.open(param1, FileMode.READ);
            _loc_3.readBytes(_loc_2);
            var _loc_4:* = new ZipOutput();
            var _loc_5:* = new ZipEntry("log.d2l");
            _loc_4.putNextEntry(_loc_5);
            _loc_4.write(_loc_2);
            _loc_4.closeEntry();
            _loc_4.finish();
            this._base64Encoder = new Base64Async();
            this._base64Encoder.addEventListener(Event.COMPLETE, this.onEncodeEnd);
            this._base64Encoder.addEventListener(ProgressEvent.PROGRESS, this.onEncodeProgress);
            this._base64Encoder.encodeByteArray(_loc_4.byteArray);
            var _loc_6:* = new SystemPopupUI("uploadLogFileProgress");
            new SystemPopupUI("uploadLogFileProgress").modal = true;
            _loc_6.title = "Envoi du fichier de log";
            _loc_6.content = "Encodage & compression en cours ...";
            _loc_6.buttons = [{label:"Masquer cette fenêtre"}];
            _loc_6.show();
            return;
        }// end function

        private function onUploadError(event:IOErrorEvent) : void
        {
            if (SystemPopupUI.get("uploadLogFileProgress"))
            {
                SystemPopupUI.get("uploadLogFileProgress").destroy();
            }
            var _loc_2:* = new SystemPopupUI("uploadLogFileError");
            _loc_2.title = "Erreur";
            _loc_2.content = "Une erreur est survenue lors de l\'envoi du fichier de log.";
            _loc_2.buttons = [{label:"Ok"}];
            _loc_2.show();
            return;
        }// end function

        private function onUploadEnd(event:Event) : void
        {
            this._so.data.history[this._targetedFile.name] = true;
            this._so.flush();
            if (SystemPopupUI.get("uploadLogFileProgress"))
            {
                SystemPopupUI.get("uploadLogFileProgress").content = "Envoi terminé.\nMerci pour votre participation.";
                SystemPopupUI.get("uploadLogFileProgress").buttons = [{label:"Ok"}];
            }
            return;
        }// end function

        private function onEncodeEnd(event:Event) : void
        {
            var _loc_2:* = new URLRequest("http://www.ankama.com/stats/dofusconfiguration");
            _loc_2.data = new URLVariables();
            _loc_2.data.account = "test";
            _loc_2.data.file = this._base64Encoder.encodedOutput;
            _loc_2.method = URLRequestMethod.POST;
            this._base64Encoder = null;
            this._loader = new URLLoader();
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.onUploadError);
            this._loader.addEventListener(Event.COMPLETE, this.onUploadEnd);
            this._loader.load(_loc_2);
            if (SystemPopupUI.get("uploadLogFileProgress"))
            {
                SystemPopupUI.get("uploadLogFileProgress").content = "Upload en cours ...";
            }
            return;
        }// end function

        private function onEncodeProgress(event:ProgressEvent) : void
        {
            if (SystemPopupUI.get("uploadLogFileProgress"))
            {
                SystemPopupUI.get("uploadLogFileProgress").content = "Encodage & compression en cours ... " + Math.floor(event.bytesLoaded / event.bytesTotal * 100) + "%";
            }
            return;
        }// end function

        public static function getInstance() : LogUploadManager
        {
            if (!_self)
            {
                _self = new LogUploadManager;
            }
            return _self;
        }// end function

    }
}
