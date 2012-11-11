package com.ankamagames.dofus.misc.utils.errormanager
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import com.ankamagames.jerakine.utils.system.*;
    import com.hurlant.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import mx.graphics.codec.*;

    public class ErrorReport extends Object
    {
        private var _reportData:Object;
        private var _logBuffer:TemporaryBufferTarget;
        private var _htmlReport:String = "";
        private var _fightFrame:FightContextFrame;
        private static var _htmlTemplate:Class = ErrorReport__htmlTemplate;
        private static var ONLINE_REPORT_PLATEFORM:String = "http://utils.dofus.lan/bugs/";
        private static var ONLINE_REPORT_SERVICE:String = ONLINE_REPORT_PLATEFORM + "makeReport.php";

        public function ErrorReport(param1:Object, param2:TemporaryBufferTarget)
        {
            this._logBuffer = param2;
            this._reportData = param1;
            return;
        }// end function

        private function makeHtmlReport() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._htmlReport == "")
            {
                _loc_1 = new _htmlTemplate();
                if (this._reportData.screenshot && this._reportData.screenshot is BitmapData)
                {
                    _loc_3 = new JPEGEncoder(80);
                    this._reportData.screenshot = Base64.encodeByteArray(_loc_3.encode(this._reportData.screenshot));
                }
                for (_loc_2 in this._reportData)
                {
                    
                    _loc_1 = _loc_1.replace("{{" + _loc_2 + "}}", this._reportData[_loc_2]);
                }
                this._htmlReport = _loc_1;
            }
            return this._htmlReport;
        }// end function

        public function saveReport() : void
        {
            var _loc_1:* = File.desktopDirectory;
            var _loc_2:* = new Date();
            _loc_1.save(this.makeHtmlReport(), "dofus_bug_report_" + _loc_2.date + "-" + (_loc_2.month + 1) + "-" + _loc_2.fullYear + "_" + _loc_2.hours + "h" + _loc_2.minutes + "m" + _loc_2.seconds + "s.html");
            return;
        }// end function

        public function sendReport() : void
        {
            var _loc_1:* = new URLRequest(ONLINE_REPORT_SERVICE);
            _loc_1.method = URLRequestMethod.POST;
            _loc_1.data = new URLVariables();
            URLVariables(_loc_1.data).userName = File.documentsDirectory.nativePath.split(File.separator)[2];
            URLVariables(_loc_1.data).htmlContent = Base64.encode(this.makeHtmlReport());
            var _loc_2:* = new URLLoader(_loc_1);
            _loc_2.addEventListener(Event.COMPLETE, this.sendReportComplete);
            return;
        }// end function

        private function sendReportComplete(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget.data;
            if (_loc_2.charAt(0) == "0")
            {
                navigateToURL(new URLRequest(ONLINE_REPORT_PLATEFORM + _loc_2.substr(2)));
            }
            else
            {
                _loc_3 = new SystemPopupUI("exception" + Math.random());
                _loc_3.width = 300;
                _loc_3.centerContent = false;
                _loc_3.title = "Error";
                _loc_3.content = _loc_2.substr(2);
                _loc_3.buttons = [{label:"OK", callback:trace}];
                _loc_3.show();
                if (!AirScanner.hasAir())
                {
                    _loc_3.scaleX = 800 / 1280;
                    _loc_3.scaleY = 600 / 1024;
                }
            }
            (event.currentTarget as URLLoader).removeEventListener(Event.COMPLETE, this.sendReportComplete);
            return;
        }// end function

        private function getFightFrame() : FightContextFrame
        {
            if (this._fightFrame == null)
            {
                this._fightFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
            }
            return this._fightFrame;
        }// end function

    }
}
