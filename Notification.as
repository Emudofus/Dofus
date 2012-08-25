package 
{
    import com.ankamagames.jerakine.types.*;

    class Notification extends Object
    {
        public var title:String;
        public var contentText:String;
        public var type:uint;
        public var name:String = "";
        public var startTime:int;
        private var _duration:int;
        public var pauseOnOver:Boolean;
        public var callback:String;
        public var callbackType:String;
        public var callbackParams:Object;
        public var texture:Object;
        public var position:int;
        public var notifyUser:Boolean = false;
        public var tutorialId:int = -1;
        private var _buttonList:Array;
        private var _imageList:Array;

        function Notification() : void
        {
            this._buttonList = new Array();
            this._imageList = new Array();
            return;
        }// end function

        public function get duration() : int
        {
            return this._duration;
        }// end function

        public function get displayText() : String
        {
            return this.title + "\n\n" + this.contentText;
        }// end function

        public function get buttonList() : Array
        {
            return this._buttonList;
        }// end function

        public function get imageList() : Array
        {
            return this._imageList;
        }// end function

        public function addButton(param1:String, param2:String, param3:Object = null, param4:Boolean = false, param5:Number = 0, param6:Number = 0, param7:String = "action") : void
        {
            var _loc_8:* = new Object();
            new Object().label = param1;
            _loc_8.action = param2;
            _loc_8.actionType = param7;
            _loc_8.params = param3;
            _loc_8.width = param5 <= 0 ? (130) : (param5);
            _loc_8.height = param6 <= 0 ? (32) : (param6);
            _loc_8.forceClose = param4;
            _loc_8.name = "btn" + ((this._buttonList.length + 1)).toString();
            this._buttonList.push(_loc_8);
            return;
        }// end function

        public function addImage(param1:Uri, param2:String = "", param3:String = "", param4:Number = -1, param5:Number = -1, param6:Number = -1, param7:Number = -1) : void
        {
            var _loc_8:* = new Object();
            new Object().uri = param1;
            _loc_8.label = param2;
            _loc_8.tips = param3;
            _loc_8.x = param4;
            _loc_8.y = param5;
            _loc_8.width = param6;
            _loc_8.height = param7;
            _loc_8.verticalAlign = param5 == -1;
            _loc_8.horizontalAlign = false;
            this._imageList.push(_loc_8);
            return;
        }// end function

        public function setTimer(param1:uint, param2:Boolean = false) : void
        {
            this._duration = param1 * 1000;
            this.startTime = 0;
            this.pauseOnOver = param2;
            this.notifyUser = true;
            return;
        }// end function

    }
}
