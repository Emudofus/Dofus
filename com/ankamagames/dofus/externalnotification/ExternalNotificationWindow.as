package com.ankamagames.dofus.externalnotification
{
   import flash.display.NativeWindow;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.berilia.Berilia;
   import flash.display.NativeWindowInitOptions;
   import flash.display.StageScaleMode;
   import flash.display.StageAlign;
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   
   public class ExternalNotificationWindow extends NativeWindow
   {
      
      public function ExternalNotificationWindow(pNotificationType:int, pClientId:String, pId:String, pContent:Object, pWinOpts:NativeWindowInitOptions, pHookName:String=null, pHookParams:Array=null) {
         this._notificationType = pNotificationType;
         this._id = pId;
         this._clientId = pClientId;
         this._hookName = pHookName;
         this._hookParams = pHookParams;
         super(pWinOpts);
         visible = false;
         alwaysInFront = true;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         this._contentWidth = pContent.contentWidth;
         this._contentHeight = pContent.contentHeight;
         HumanInputHandler.getInstance().registerListeners(stage);
         var notifCtr:Sprite = new Sprite();
         notifCtr.addChild(pContent as DisplayObject);
         stage.addChild(notifCtr);
      }
      
      private static const DEBUG:Boolean = false;
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalNotificationWindow));
      
      private static function log(pMsg:Object) : void {
         if(DEBUG)
         {
            _log.debug(pMsg);
         }
      }
      
      private var _notificationType:int;
      
      private var _id:String;
      
      private var _clientId:String;
      
      private var _contentWidth:Number;
      
      private var _contentHeight:Number;
      
      private var _hookName:String;
      
      private var _hookParams:Array;
      
      public var timeoutId:uint;
      
      public function get notificationType() : int {
         return this._notificationType;
      }
      
      public function get id() : String {
         return this._id;
      }
      
      public function get clientId() : String {
         return this._clientId;
      }
      
      public function get instanceId() : String {
         return this._clientId + "#" + this._id;
      }
      
      public function get contentWidth() : Number {
         return this._contentWidth;
      }
      
      public function get contentHeight() : Number {
         return this._contentHeight;
      }
      
      public function get hookName() : String {
         return this._hookName;
      }
      
      public function get hookParams() : Array {
         return this._hookParams;
      }
      
      public function show() : void {
         visible = true;
      }
      
      public function destroy() : void {
         HumanInputHandler.getInstance().unregisterListeners(stage);
         visible = false;
         Berilia.getInstance().unloadUi(this.instanceId);
         stage.removeChildAt(0);
         close();
      }
   }
}
