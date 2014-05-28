package com.ankamagames.jerakine.utils.misc
{
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import flash.net.URLLoader;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.utils.system.SystemPopupUI;
   import com.ankamagames.jerakine.types.Callback;
   import flash.utils.ByteArray;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   import nochump.util.zip.ZipOutput;
   import nochump.util.zip.ZipEntry;
   import flash.events.IOErrorEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.URLRequestMethod;
   import flash.events.ProgressEvent;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   
   public class LogUploadManager extends Object
   {
      
      public function LogUploadManager() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this._so = CustomSharedObject.getLocal("uploadLogOptions");
            if(!this._so.data.history)
            {
               this._so.data.history = new Dictionary();
               this._so.flush();
            }
            return;
         }
      }
      
      private static var _self:LogUploadManager;
      
      private static var mega:uint;
      
      public static function getInstance() : LogUploadManager {
         if(!_self)
         {
            _self = new LogUploadManager();
         }
         return _self;
      }
      
      private var _so:CustomSharedObject;
      
      private var _loader:URLLoader;
      
      private var _targetedFile:File;
      
      public function askForUpload(targetFile:File) : void {
         var uui:SystemPopupUI = null;
         if((!(this._so.data.disabled === true)) && (!this.hasBeenAlreadySend(targetFile.name)))
         {
            this._targetedFile = targetFile;
            uui = new SystemPopupUI("uploadLogFile");
            uui.modal = true;
            uui.title = "Analyse des performances";
            uui.content = "Nous avons détécté un fichier de log contenant une longue session de jeu (" + Math.floor(targetFile.size / mega * 10 / 4) / 10 + " Mo).\n" + "Voulez-vous transmettre ce fichier à l\'équipe Dofus 2.0 pour participter à l\'amélioration de Dofus 2.0 ?\n" + "\n" + "Note : Le fichier de log contiens des données nominatives mais les mots de passes ainsi que les conversations ne sont pas enregistrés";
            uui.buttons = [
               {
                  "label":"Envoyer",
                  "callback":new Callback(this.onSendLog,targetFile)
               },
               {
                  "label":"Ne plus demander",
                  "callback":function():void
                  {
                     _so.data.disabled = true;
                     _so.flush();
                  }
               },{"label":"Annuler"}];
            uui.show();
         }
      }
      
      public function hasBeenAlreadySend(fileName:String) : Boolean {
         return this._so.data.history[fileName] === true;
      }
      
      private function onSendLog(file:File) : void {
         var content:ByteArray = new ByteArray();
         var fs:FileStream = new FileStream();
         fs.open(file,FileMode.READ);
         fs.readBytes(content);
         var zipFile:ZipOutput = new ZipOutput();
         var entry:ZipEntry = new ZipEntry("log.d2l");
         zipFile.putNextEntry(entry);
         zipFile.write(content);
         zipFile.closeEntry();
         zipFile.finish();
         var uui:SystemPopupUI = new SystemPopupUI("uploadLogFileProgress");
         uui.modal = true;
         uui.title = "Envoi du fichier de log";
         uui.content = "Encodage & compression en cours ...";
         uui.buttons = [{"label":"Masquer cette fenêtre"}];
         uui.show();
      }
      
      private function onUploadError(e:IOErrorEvent) : void {
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").destroy();
         }
         var uui:SystemPopupUI = new SystemPopupUI("uploadLogFileError");
         uui.title = "Erreur";
         uui.content = "Une erreur est survenue lors de l\'envoi du fichier de log.";
         uui.buttons = [{"label":"Ok"}];
         uui.show();
      }
      
      private function onUploadEnd(e:Event) : void {
         this._so.data.history[this._targetedFile.name] = true;
         this._so.flush();
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").content = "Envoi terminé.\nMerci pour votre participation.";
            SystemPopupUI.get("uploadLogFileProgress").buttons = [{"label":"Ok"}];
         }
      }
      
      private function onEncodeEnd(e:Event) : void {
         var ur:URLRequest = new URLRequest("http://www.ankama.com/stats/dofusconfiguration");
         ur.data = new URLVariables();
         ur.data.account = "test";
         ur.method = URLRequestMethod.POST;
         this._loader = new URLLoader();
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onUploadError);
         this._loader.addEventListener(Event.COMPLETE,this.onUploadEnd);
         this._loader.load(ur);
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").content = "Upload en cours ...";
         }
      }
      
      private function onEncodeProgress(e:ProgressEvent) : void {
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").content = "Encodage & compression en cours ... " + Math.floor(e.bytesLoaded / e.bytesTotal * 100) + "%";
         }
      }
   }
}
