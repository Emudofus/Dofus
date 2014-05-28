package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Timer;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import flash.events.Event;
   import flash.events.TimerEvent;
   
   public class AFKFightManager extends Object
   {
      
      public function AFKFightManager() {
         this._afkSecurity = new Timer(5000);
         super();
         this._enabled = false;
         this._afkSecurity.addEventListener(TimerEvent.TIMER,this.onTimer);
      }
      
      private static var _self:AFKFightManager;
      
      protected static const _log:Logger;
      
      public static function getInstance() : AFKFightManager {
         if(!_self)
         {
            _self = new AFKFightManager();
         }
         return _self;
      }
      
      private var _enabled:Boolean;
      
      private var _confirm:Boolean;
      
      private var _afkSecurity:Timer;
      
      private var _securityTimerUp:Boolean;
      
      public var lastTurnSkip:int;
      
      public function initialize() : void {
         this._confirm = false;
         this.enabled = true;
      }
      
      public function set enabled(e:Boolean) : void {
         if(e == this._enabled)
         {
            return;
         }
         if(!e)
         {
            this.confirm = false;
         }
         this._enabled = e;
         if(this._enabled)
         {
            _log.info("looking for mouse or keybord activity");
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
            StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onActivity);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
            this._securityTimerUp = false;
            this._afkSecurity.start();
         }
         else
         {
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onActivity);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onActivity);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onActivity);
            this._afkSecurity.stop();
         }
      }
      
      public function set confirm(confirmed:Boolean) : void {
         this._afkSecurity.stop();
         if((this.enabled) || (!confirmed))
         {
            if(this._confirm != confirmed)
            {
               if((confirmed) && (!this._securityTimerUp))
               {
                  this.enabled = false;
                  return;
               }
               if(confirmed)
               {
                  _log.info("AFK mode enabled");
               }
               else
               {
                  _log.info("AFK mode disabled");
               }
               if(confirmed)
               {
               }
               KernelEventsManager.getInstance().processCallback(FightHookList.AfkModeChanged,confirmed);
            }
            this._confirm = confirmed;
         }
      }
      
      public function get isAfk() : Boolean {
         return (this._enabled) && (this._confirm);
      }
      
      public function get enabled() : Boolean {
         return this._enabled;
      }
      
      private function onActivity(event:Event) : void {
         _log.info("Activity detected. Player is not AFK");
         this.confirm = false;
         this.enabled = false;
      }
      
      private function onTimer(event:Event) : void {
         this._securityTimerUp = true;
      }
   }
}
