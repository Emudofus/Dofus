package com.ankamagames.dofus.logic.common.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.system.*;

    public class NotificationManager extends Object
    {
        private var _notificationList:Vector.<Notification>;
        private static var _self:NotificationManager;

        public function NotificationManager(param1:PrivateClass)
        {
            this._notificationList = new Vector.<>;
            return;
        }// end function

        public function showNotification(param1:String, param2:String, param3:uint = 0) : void
        {
            var _loc_4:* = new Notification();
            new Notification().title = param1;
            _loc_4.contentText = param2;
            _loc_4.type = param3;
            this.openNotification(_loc_4);
            return;
        }// end function

        public function prepareNotification(param1:String, param2:String, param3:uint = 0, param4:String = "", param5:Boolean = false) : uint
        {
            var _loc_6:* = new Notification();
            new Notification().title = param1;
            _loc_6.contentText = param2;
            _loc_6.type = param3;
            _loc_6.name = param4;
            return (this._notificationList.push(_loc_6) - 1);
        }// end function

        public function addButtonToNotification(param1:uint, param2:String, param3:String, param4:Object = null, param5:Boolean = false, param6:Number = 0, param7:Number = 0, param8:String = "action") : void
        {
            var _loc_9:* = this.getNotification(param1);
            this.getNotification(param1).addButton(param2, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        public function addCallbackToNotification(param1:uint, param2:String, param3:Object = null, param4:String = "action") : void
        {
            var _loc_5:* = this.getNotification(param1);
            this.getNotification(param1).callback = param2;
            _loc_5.callbackParams = param3;
            _loc_5.callbackType = param4;
            return;
        }// end function

        public function addImageToNotification(param1:uint, param2:Uri, param3:Number = 0, param4:Number = 0, param5:Number = -1, param6:Number = -1, param7:String = "", param8:String = "") : void
        {
            var _loc_9:* = this.getNotification(param1);
            this.getNotification(param1).addImage(param2, param7, param8, param3, param4, param5, param6);
            return;
        }// end function

        public function addTimerToNotification(param1:uint, param2:uint, param3:Boolean = false, param4:Boolean = false) : void
        {
            var _loc_5:* = this.getNotification(param1);
            this.getNotification(param1).setTimer(param2, param3, param4);
            return;
        }// end function

        public function sendNotification(param1:int = -1) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 == -1)
            {
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    this.sendNotification(_loc_2);
                    _loc_2 = _loc_2 + 1;
                }
            }
            else if (param1 >= 0 && param1 < this._notificationList.length && this._notificationList[param1] != null)
            {
                this.openNotification(this._notificationList[param1] as );
                this._notificationList.splice(param1, 1);
            }
            return;
        }// end function

        public function clearAllNotification() : void
        {
            this._notificationList = new Vector.<>;
            return;
        }// end function

        private function getNotification(param1:uint) : Notification
        {
            return this._notificationList[param1];
        }// end function

        private function openNotification(param1:Object) : void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.Notification, param1);
            if (param1.notifyUser)
            {
                SystemManager.getSingleton().notifyUser();
            }
            return;
        }// end function

        public function closeNotification(param1:String, param2:Boolean = false) : void
        {
            KernelEventsManager.getInstance().processCallback(HookList.CloseNotification, param1, param2);
            return;
        }// end function

        public function hideNotification(param1:String) : void
        {
            KernelEventsManager.getInstance().processCallback(HookList.HideNotification, param1);
            return;
        }// end function

        public static function getInstance() : NotificationManager
        {
            if (_self == null)
            {
                _self = new NotificationManager(new PrivateClass());
            }
            return _self;
        }// end function

    }
}

import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.system.*;

class PrivateClass extends Object
{

    function PrivateClass()
    {
        return;
    }// end function

}


import __AS3__.vec.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.misc.lists.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.system.*;

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
    public var blockCallbackOnTimerEnds:Boolean = false;
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

    public function setTimer(param1:uint, param2:Boolean = false, param3:Boolean = false) : void
    {
        this._duration = param1 * 1000;
        this.startTime = 0;
        this.pauseOnOver = param2;
        this.blockCallbackOnTimerEnds = param3;
        this.notifyUser = true;
        return;
    }// end function

}

