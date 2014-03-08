package com.ankamagames.dofus.externalnotification
{
   import com.ankamagames.jerakine.json.JSON;
   
   public class ExternalNotificationRequest extends Object
   {
      
      public function ExternalNotificationRequest(param1:int, param2:String, param3:Array, param4:String, param5:int, param6:String, param7:Object, param8:String, param9:Boolean, param10:Boolean, param11:String=null, param12:Array=null) {
         super();
         this._notificationType = param1;
         this._clientId = param2;
         this._otherClientsIds = param3;
         this._id = param4;
         this._showMode = param5;
         this._uiName = param6;
         this._displayData = param7;
         this._soundId = param8;
         this._playSound = param9;
         this._notify = param10;
         this._hookName = param11;
         this._hookParams = param12;
      }
      
      public static function createFromJSONString(param1:String) : ExternalNotificationRequest {
         var _loc2_:Object = com.ankamagames.jerakine.json.JSON.decode(param1);
         var _loc3_:ExternalNotificationRequest = new ExternalNotificationRequest(_loc2_.notificationType,_loc2_.clientId,_loc2_.otherClientsIds,_loc2_.id,_loc2_.showMode,_loc2_.uiName,_loc2_.displayData,_loc2_.soundId,_loc2_.playSound,_loc2_.notify,_loc2_.hookName,_loc2_.hookParams);
         return _loc3_;
      }
      
      private var _notificationType:int;
      
      private var _clientId:String;
      
      private var _otherClientsIds:Array;
      
      private var _id:String;
      
      private var _showMode:int;
      
      private var _hookName:String;
      
      private var _hookParams:Array;
      
      private var _uiName:String;
      
      private var _displayData:Object;
      
      private var _soundId:String;
      
      private var _playSound:Boolean;
      
      private var _notify:Boolean;
      
      public function get notificationType() : int {
         return this._notificationType;
      }
      
      public function get instanceId() : String {
         return this._clientId + "#" + this._id;
      }
      
      public function get clientId() : String {
         return this._clientId;
      }
      
      public function get otherClientsIds() : Array {
         return this._otherClientsIds;
      }
      
      public function get id() : String {
         return this._id;
      }
      
      public function get showMode() : int {
         return this._showMode;
      }
      
      public function get uiName() : String {
         return this._uiName;
      }
      
      public function get displayData() : Object {
         return this._displayData;
      }
      
      public function get soundId() : String {
         return this._soundId;
      }
      
      public function get hookName() : String {
         return this._hookName;
      }
      
      public function get hookParams() : Array {
         return this._hookParams;
      }
      
      public function get playSound() : Boolean {
         return this._playSound;
      }
      
      public function get notify() : Boolean {
         return this._notify;
      }
   }
}
