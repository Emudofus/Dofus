package com.ankamagames.dofus.misc.utils.errormanager
{
   import com.ankamagames.jerakine.logger.targets.TemporaryBufferTarget;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import flash.display.BitmapData;
   import by.blooddy.crypto.Base64;
   import by.blooddy.crypto.image.JPEGEncoder;
   import flash.filesystem.File;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.events.Event;
   import flash.filesystem.FileStream;
   import com.ankamagames.jerakine.utils.system.SystemPopupUI;
   import flash.filesystem.FileMode;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.ByteArray;
   import flash.net.URLVariables;
   import flash.net.URLLoader;
   import flash.net.navigateToURL;
   import com.ankamagames.dofus.kernel.Kernel;
   
   public class ErrorReport extends Object
   {
      
      public function ErrorReport(param1:Object, param2:TemporaryBufferTarget) {
         super();
         this._logBuffer = param2;
         this._reportData = param1;
      }
      
      private static var _htmlTemplate:Class = ErrorReport__htmlTemplate;
      
      private static var ONLINE_REPORT_PLATEFORM:String = "http://utils.dofus.lan/bugs/";
      
      private static var ONLINE_REPORT_SERVICE:String = ONLINE_REPORT_PLATEFORM + "makeReport.php";
      
      private var _reportData:Object;
      
      private var _logBuffer:TemporaryBufferTarget;
      
      private var _htmlReport:String = "";
      
      private var _fightFrame:FightContextFrame;
      
      private function makeHtmlReport() : String {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this._htmlReport == "")
         {
            _loc1_ = new _htmlTemplate();
            if((this._reportData.screenshot) && this._reportData.screenshot is BitmapData)
            {
               this._reportData.screenshot = Base64.encode(JPEGEncoder.encode(this._reportData.screenshot,80));
            }
            if((this._reportData.stacktrace) && this._reportData.stacktrace is String)
            {
               this._reportData.stacktrace = String(this._reportData.stacktrace).replace(new RegExp("<","g"),"&lt;").replace(new RegExp(">","g"),"&gt;");
            }
            for (_loc2_ in this._reportData)
            {
               _loc1_ = _loc1_.replace("{{" + _loc2_ + "}}",this._reportData[_loc2_]);
            }
            this._htmlReport = _loc1_;
         }
         return this._htmlReport;
      }
      
      public function saveReport() : void {
         var _loc1_:Date = new Date();
         var _loc2_:* = "dofus_bug_report_" + _loc1_.date + "-" + (_loc1_.month + 1) + "-" + _loc1_.fullYear + "_" + _loc1_.hours + "h" + _loc1_.minutes + "m" + _loc1_.seconds + "s.html";
         var _loc3_:File = File.desktopDirectory.resolvePath(_loc2_);
         if(!AirScanner.hasAir())
         {
            _loc3_.save(this.makeHtmlReport(),_loc2_);
         }
         else
         {
            _loc3_.addEventListener(Event.SELECT,this.onFileSelected);
            _loc3_.browseForSave("Save report");
         }
      }
      
      private function onFileSelected(param1:Event) : void {
         var fs:FileStream = null;
         var popup:SystemPopupUI = null;
         var e:Event = param1;
         try
         {
            fs = new FileStream();
            fs.open(e.target as File,FileMode.WRITE);
            fs.writeUTFBytes(this.makeHtmlReport());
            fs.close();
         }
         catch(err:Error)
         {
            popup = new SystemPopupUI("ReportSaveFail");
            popup.title = "Error";
            popup.content = "An error occurred during report saving :\n" + err.message;
            popup.show();
         }
      }
      
      public function sendReport() : void {
         var _loc1_:URLRequest = new URLRequest(ONLINE_REPORT_SERVICE);
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(this.makeHtmlReport());
         _loc1_.data = new URLVariables();
         URLVariables(_loc1_.data).userName = File.documentsDirectory.nativePath.split(File.separator)[2];
         URLVariables(_loc1_.data).htmlContent = Base64.encode(_loc2_);
         var _loc3_:URLLoader = new URLLoader(_loc1_);
         _loc3_.addEventListener(Event.COMPLETE,this.sendReportComplete);
      }
      
      private function sendReportComplete(param1:Event) : void {
         var _loc3_:SystemPopupUI = null;
         var _loc2_:String = param1.currentTarget.data;
         if(_loc2_.charAt(0) == "0")
         {
            navigateToURL(new URLRequest(ONLINE_REPORT_PLATEFORM + _loc2_.substr(2)));
         }
         else
         {
            _loc3_ = new SystemPopupUI("exception" + Math.random());
            _loc3_.width = 300;
            _loc3_.centerContent = false;
            _loc3_.title = "Error";
            _loc3_.content = _loc2_.substr(2);
            _loc3_.buttons = [
               {
                  "label":"OK",
                  "callback":trace
               }];
            _loc3_.show();
            if(!AirScanner.hasAir())
            {
               _loc3_.scaleX = 800 / 1280;
               _loc3_.scaleY = 600 / 1024;
            }
         }
         (param1.currentTarget as URLLoader).removeEventListener(Event.COMPLETE,this.sendReportComplete);
      }
      
      private function getFightFrame() : FightContextFrame {
         if(this._fightFrame == null)
         {
            this._fightFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         }
         return this._fightFrame;
      }
   }
}
