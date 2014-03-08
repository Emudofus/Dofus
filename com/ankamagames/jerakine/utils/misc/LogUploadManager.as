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
      
      private static var mega:uint = Math.pow(2,20);
      
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
      
      public function askForUpload(param1:File) : void {
         var uui:SystemPopupUI = null;
         var targetFile:File = param1;
         if(!(this._so.data.disabled === true) && !this.hasBeenAlreadySend(targetFile.name))
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
      
      public function hasBeenAlreadySend(param1:String) : Boolean {
         return this._so.data.history[param1] === true;
      }
      
      private function onSendLog(param1:File) : void {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:FileStream = new FileStream();
         _loc3_.open(param1,FileMode.READ);
         _loc3_.readBytes(_loc2_);
         var _loc4_:ZipOutput = new ZipOutput();
         var _loc5_:ZipEntry = new ZipEntry("log.d2l");
         _loc4_.putNextEntry(_loc5_);
         _loc4_.write(_loc2_);
         _loc4_.closeEntry();
         _loc4_.finish();
         var _loc6_:SystemPopupUI = new SystemPopupUI("uploadLogFileProgress");
         _loc6_.modal = true;
         _loc6_.title = "Envoi du fichier de log";
         _loc6_.content = "Encodage & compression en cours ...";
         _loc6_.buttons = [{"label":"Masquer cette fenêtre"}];
         _loc6_.show();
      }
      
      private function onUploadError(param1:IOErrorEvent) : void {
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").destroy();
         }
         var _loc2_:SystemPopupUI = new SystemPopupUI("uploadLogFileError");
         _loc2_.title = "Erreur";
         _loc2_.content = "Une erreur est survenue lors de l\'envoi du fichier de log.";
         _loc2_.buttons = [{"label":"Ok"}];
         _loc2_.show();
      }
      
      private function onUploadEnd(param1:Event) : void {
         this._so.data.history[this._targetedFile.name] = true;
         this._so.flush();
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").content = "Envoi terminé.\nMerci pour votre participation.";
            SystemPopupUI.get("uploadLogFileProgress").buttons = [{"label":"Ok"}];
         }
      }
      
      private function onEncodeEnd(param1:Event) : void {
         var _loc2_:URLRequest = new URLRequest("http://www.ankama.com/stats/dofusconfiguration");
         _loc2_.data = new URLVariables();
         _loc2_.data.account = "test";
         _loc2_.method = URLRequestMethod.POST;
         this._loader = new URLLoader();
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onUploadError);
         this._loader.addEventListener(Event.COMPLETE,this.onUploadEnd);
         this._loader.load(_loc2_);
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").content = "Upload en cours ...";
         }
      }
      
      private function onEncodeProgress(param1:ProgressEvent) : void {
         if(SystemPopupUI.get("uploadLogFileProgress"))
         {
            SystemPopupUI.get("uploadLogFileProgress").content = "Encodage & compression en cours ... " + Math.floor(param1.bytesLoaded / param1.bytesTotal * 100) + "%";
         }
      }
   }
}
