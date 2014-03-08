package com.ankamagames.dofus.logic.common.managers
{
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class NotificationManager extends Object
   {
      
      public function NotificationManager(param1:PrivateClass) {
         super();
         this._notificationList = new Vector.<NotificationManager>();
      }
      
      private static var _self:NotificationManager;
      
      public static function getInstance() : NotificationManager {
         if(_self == null)
         {
            _self = new NotificationManager(new PrivateClass());
         }
         return _self;
      }
      
      private var _notificationList:Vector.<Notification>;
      
      public function showNotification(param1:String, param2:String, param3:uint=0) : void {
         var _loc4_:Notification = new Notification();
         _loc4_.title = param1;
         _loc4_.contentText = param2;
         _loc4_.type = param3;
         this.openNotification(_loc4_);
      }
      
      public function prepareNotification(param1:String, param2:String, param3:uint=0, param4:String="", param5:Boolean=false) : uint {
         var _loc6_:Notification = new Notification();
         _loc6_.title = param1;
         _loc6_.contentText = param2;
         _loc6_.type = param3;
         _loc6_.name = param4;
         return this._notificationList.push(_loc6_)-1;
      }
      
      public function addButtonToNotification(param1:uint, param2:String, param3:String, param4:Object=null, param5:Boolean=false, param6:Number=0, param7:Number=0, param8:String="action") : void {
         var _loc9_:Notification = this.getNotification(param1);
         _loc9_.addButton(param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function addCallbackToNotification(param1:uint, param2:String, param3:Object=null, param4:String="action") : void {
         var _loc5_:Notification = this.getNotification(param1);
         _loc5_.callback = param2;
         _loc5_.callbackParams = param3;
         _loc5_.callbackType = param4;
      }
      
      public function addImageToNotification(param1:uint, param2:Uri, param3:Number=0, param4:Number=0, param5:Number=-1, param6:Number=-1, param7:String="", param8:String="") : void {
         var _loc9_:Notification = this.getNotification(param1);
         _loc9_.addImage(param2,param7,param8,param3,param4,param5,param6);
      }
      
      public function addTimerToNotification(param1:uint, param2:uint, param3:Boolean=false, param4:Boolean=false, param5:Boolean=true) : void {
         var _loc6_:Notification = this.getNotification(param1);
         _loc6_.setTimer(param2,param3,param4,param5);
      }
      
      public function sendNotification(param1:int=-1) : void {
         var _loc2_:Notification = null;
         if(param1 == -1)
         {
            for each (_loc2_ in this._notificationList)
            {
               if(_loc2_)
               {
                  this.openNotification(_loc2_);
               }
            }
            this._notificationList = new Vector.<NotificationManager>();
         }
         else
         {
            if(param1 >= 0 && param1 < this._notificationList.length && !(this._notificationList[param1] == null))
            {
               this.openNotification(this._notificationList[param1] as NotificationManager);
               this._notificationList.splice(param1,1);
            }
         }
      }
      
      public function clearAllNotification() : void {
         this._notificationList = new Vector.<NotificationManager>();
      }
      
      private function getNotification(param1:uint) : Notification {
         return this._notificationList[param1];
      }
      
      private function openNotification(param1:Object) : void {
         KernelEventsManager.getInstance().processCallback(ChatHookList.Notification,param1);
         if(param1.notifyUser)
         {
            SystemManager.getSingleton().notifyUser();
         }
      }
      
      public function closeNotification(param1:String, param2:Boolean=false) : void {
         KernelEventsManager.getInstance().processCallback(HookList.CloseNotification,param1,param2);
      }
      
      public function hideNotification(param1:String) : void {
         KernelEventsManager.getInstance().processCallback(HookList.HideNotification,param1);
      }
   }
}
class PrivateClass extends Object
{
   
   function PrivateClass() {
      super();
   }
}
import com.ankamagames.jerakine.types.Uri;

class Notification extends Object
{
   
   function Notification() {
      this._buttonList = new Array();
      this._imageList = new Array();
      super();
   }
   
   public var title:String;
   
   public var contentText:String;
   
   public var type:uint;
   
   public var name:String = "";
   
   public var startTime:int;
   
   private var _duration:int;
   
   public var pauseOnOver:Boolean;
   
   public function get duration() : int {
      return this._duration;
   }
   
   public var callback:String;
   
   public var callbackType:String;
   
   public var callbackParams:Object;
   
   public var texture:Object;
   
   public var position:int;
   
   public var notifyUser:Boolean = false;
   
   public var tutorialId:int = -1;
   
   public var blockCallbackOnTimerEnds:Boolean = false;
   
   public function get displayText() : String {
      return this.title + "\n\n" + this.contentText;
   }
   
   private var _buttonList:Array;
   
   public function get buttonList() : Array {
      return this._buttonList;
   }
   
   private var _imageList:Array;
   
   public function get imageList() : Array {
      return this._imageList;
   }
   
   public function addButton(param1:String, param2:String, param3:Object=null, param4:Boolean=false, param5:Number=0, param6:Number=0, param7:String="action") : void {
      var _loc8_:Object = new Object();
      _loc8_.label = param1;
      _loc8_.action = param2;
      _loc8_.actionType = param7;
      _loc8_.params = param3;
      _loc8_.width = param5 <= 0?130:param5;
      _loc8_.height = param6 <= 0?32:param6;
      _loc8_.forceClose = param4;
      _loc8_.name = "btn" + (this._buttonList.length + 1).toString();
      this._buttonList.push(_loc8_);
   }
   
   public function addImage(param1:Uri, param2:String="", param3:String="", param4:Number=-1, param5:Number=-1, param6:Number=-1, param7:Number=-1) : void {
      var _loc8_:Object = new Object();
      _loc8_.uri = param1;
      _loc8_.label = param2;
      _loc8_.tips = param3;
      _loc8_.x = param4;
      _loc8_.y = param5;
      _loc8_.width = param6;
      _loc8_.height = param7;
      _loc8_.verticalAlign = param5 == -1;
      _loc8_.horizontalAlign = false;
      this._imageList.push(_loc8_);
   }
   
   public function setTimer(param1:uint, param2:Boolean=false, param3:Boolean=false, param4:Boolean=true) : void {
      this._duration = param1 * 1000;
      this.startTime = 0;
      this.pauseOnOver = param2;
      this.blockCallbackOnTimerEnds = param3;
      this.notifyUser = param4;
   }
}
