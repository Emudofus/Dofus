package com.ankamagames.dofus.externalnotification
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ExternalNotificationWindow extends NativeWindow
    {
        private var _notificationType:int;
        private var _id:String;
        private var _clientId:String;
        public var timeoutId:uint;
        public var order:int;
        private static const DEBUG:Boolean = false;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalNotificationWindow));

        public function ExternalNotificationWindow(param1:int, param2:String, param3:String, param4:Object, param5:Number, param6:Number, param7:Point)
        {
            log("new ExternalNotificationWindow " + param4);
            this._notificationType = param1;
            this._id = param3;
            this._clientId = param2;
            var _loc_8:* = new NativeWindowInitOptions();
            new NativeWindowInitOptions().systemChrome = NativeWindowSystemChrome.NONE;
            _loc_8.type = NativeWindowType.LIGHTWEIGHT;
            _loc_8.resizable = false;
            _loc_8.transparent = true;
            super(_loc_8);
            visible = false;
            alwaysInFront = true;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            bounds = new Rectangle(param7.x, param7.y, param5, param6);
            HumanInputHandler.getInstance().registerListeners(stage);
            var _loc_9:* = new Sprite();
            new Sprite().addChild(param4 as DisplayObject);
            stage.addChild(_loc_9);
            return;
        }// end function

        public function get notificationType() : int
        {
            return this._notificationType;
        }// end function

        public function get id() : String
        {
            return this._id;
        }// end function

        public function get clientId() : String
        {
            return this._clientId;
        }// end function

        public function get instanceId() : String
        {
            return this._clientId + "#" + this._id;
        }// end function

        public function show() : void
        {
            log("window show");
            visible = true;
            return;
        }// end function

        public function destroy() : void
        {
            log("externalnotification window " + this.id + " destroy");
            HumanInputHandler.getInstance().unregisterListeners(stage);
            visible = false;
            Berilia.getInstance().unloadUi(this.instanceId);
            stage.removeChildAt(0);
            close();
            return;
        }// end function

        private static function log(param1:Object) : void
        {
            if (DEBUG)
            {
                _log.debug(param1);
            }
            return;
        }// end function

    }
}
