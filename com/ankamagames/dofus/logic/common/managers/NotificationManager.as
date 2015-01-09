package com.ankamagames.dofus.logic.common.managers
{
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.Uri;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.jerakine.utils.system.SystemManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import __AS3__.vec.*;

    public class NotificationManager 
    {

        private static var _self:NotificationManager;

        private var _notificationList:Vector.<Notification>;

        public function NotificationManager(pvt:PrivateClass)
        {
            this._notificationList = new Vector.<Notification>();
        }

        public static function getInstance():NotificationManager
        {
            if (_self == null)
            {
                _self = new (NotificationManager)(new PrivateClass());
            };
            return (_self);
        }


        public function showNotification(pTitle:String, pContent:String, pType:uint=0):void
        {
            var notif:Notification = new Notification();
            notif.title = pTitle;
            notif.contentText = pContent;
            notif.type = pType;
            this.openNotification(notif);
        }

        public function prepareNotification(pTitle:String, pContent:String, pType:uint=0, pNotificationName:String="", pNotifyUser:Boolean=false):uint
        {
            var notif:Notification = new Notification();
            notif.title = pTitle;
            notif.contentText = pContent;
            notif.type = pType;
            notif.name = pNotificationName;
            return ((this._notificationList.push(notif) - 1));
        }

        public function addButtonToNotification(pId:uint, pTitle:String, pAction:String, pParams:Object=null, pForceClose:Boolean=false, pWidth:Number=0, pHeight:Number=0, pType:String="action"):void
        {
            var notif:Notification = this.getNotification(pId);
            notif.addButton(pTitle, pAction, pParams, pForceClose, pWidth, pHeight, pType);
        }

        public function addCallbackToNotification(pId:uint, pAction:String, pParams:Object=null, pType:String="action"):void
        {
            var notif:Notification = this.getNotification(pId);
            notif.callback = pAction;
            notif.callbackParams = pParams;
            notif.callbackType = pType;
        }

        public function addImageToNotification(pId:uint, pClip:Uri, pX:Number=0, pY:Number=0, pWidth:Number=-1, pHeight:Number=-1, pLabel:String="", pTips:String=""):void
        {
            var notif:Notification = this.getNotification(pId);
            notif.addImage(pClip, pLabel, pTips, pX, pY, pWidth, pHeight);
        }

        public function addTimerToNotification(pId:uint, pTime:uint, pPauseOnOver:Boolean=false, pBlockCallbackOnClose:Boolean=false, pNotify:Boolean=true):void
        {
            var notif:Notification = this.getNotification(pId);
            notif.setTimer(pTime, pPauseOnOver, pBlockCallbackOnClose, pNotify);
        }

        public function sendNotification(notificationId:int=-1):void
        {
            var n:Notification;
            if (notificationId == -1)
            {
                for each (n in this._notificationList)
                {
                    if (n)
                    {
                        this.openNotification(n);
                    };
                };
                this._notificationList = new Vector.<Notification>();
            }
            else
            {
                if ((((((notificationId >= 0)) && ((notificationId < this._notificationList.length)))) && (!((this._notificationList[notificationId] == null)))))
                {
                    this.openNotification((this._notificationList[notificationId] as Notification));
                    this._notificationList.splice(notificationId, 1);
                };
            };
        }

        public function clearAllNotification():void
        {
            this._notificationList = new Vector.<Notification>();
        }

        private function getNotification(pId:uint):Notification
        {
            return (this._notificationList[pId]);
        }

        private function openNotification(pNotif:Object):void
        {
            KernelEventsManager.getInstance().processCallback(ChatHookList.Notification, pNotif);
            if (pNotif.notifyUser)
            {
                SystemManager.getSingleton().notifyUser();
            };
        }

        public function closeNotification(pName:String, pBlockCallback:Boolean=false):void
        {
            KernelEventsManager.getInstance().processCallback(HookList.CloseNotification, pName, pBlockCallback);
        }

        public function hideNotification(pName:String):void
        {
            KernelEventsManager.getInstance().processCallback(HookList.HideNotification, pName);
        }


    }
}//package com.ankamagames.dofus.logic.common.managers

import com.ankamagames.jerakine.types.Uri;

class PrivateClass 
{


}
class Notification 
{

    public var title:String;
    public var contentText:String;
    public var type:uint;
    public var name:String = "";
    public var startTime:int;
    /*private*/ var _duration:int;
    public var pauseOnOver:Boolean;
    public var callback:String;
    public var callbackType:String;
    public var callbackParams:Object;
    public var texture:Object;
    public var position:int;
    public var notifyUser:Boolean = false;
    public var tutorialId:int = -1;
    public var blockCallbackOnTimerEnds:Boolean = false;
    /*private*/ var _buttonList:Array;
    /*private*/ var _imageList:Array;

    public function Notification():void
    {
        this._buttonList = new Array();
        this._imageList = new Array();
        super();
    }

    public function get duration():int
    {
        return (this._duration);
    }

    public function get displayText():String
    {
        return (((this.title + "\n\n") + this.contentText));
    }

    public function get buttonList():Array
    {
        return (this._buttonList);
    }

    public function get imageList():Array
    {
        return (this._imageList);
    }

    public function addButton(pTitle:String, pAction:String, pParams:Object=null, pForceClose:Boolean=false, pWidth:Number=0, pHeight:Number=0, pType:String="action"):void
    {
        var btn:Object = new Object();
        btn.label = pTitle;
        btn.action = pAction;
        btn.actionType = pType;
        btn.params = pParams;
        btn.width = (((pWidth)<=0) ? 130 : pWidth);
        btn.height = (((pHeight)<=0) ? 32 : pHeight);
        btn.forceClose = pForceClose;
        btn.name = ("btn" + (this._buttonList.length + 1).toString());
        this._buttonList.push(btn);
    }

    public function addImage(pClip:Uri, pLabel:String="", pTips:String="", pX:Number=-1, pY:Number=-1, pWidth:Number=-1, pHeight:Number=-1):void
    {
        var img:Object = new Object();
        img.uri = pClip;
        img.label = pLabel;
        img.tips = pTips;
        img.x = pX;
        img.y = pY;
        img.width = pWidth;
        img.height = pHeight;
        img.verticalAlign = (pY == -1);
        img.horizontalAlign = false;
        this._imageList.push(img);
    }

    public function setTimer(val:uint, pause:Boolean=false, pBlockCallbackOnClose:Boolean=false, pNotify:Boolean=true):void
    {
        this._duration = (val * 1000);
        this.startTime = 0;
        this.pauseOnOver = pause;
        this.blockCallbackOnTimerEnds = pBlockCallbackOnClose;
        this.notifyUser = pNotify;
    }


}

