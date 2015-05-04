package com.ankamagames.dofus.misc.stats
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import flash.utils.getTimer;
   import com.ankamagames.dofus.network.messages.common.basic.BasicStatMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   
   public class StatsAction extends Object
   {
      
      public function StatsAction(param1:uint, param2:Boolean)
      {
         super();
         this._id = param1;
         this._persistent = param2;
         this._params = new Dictionary(true);
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(StatsAction));
      
      private static var _actions:Dictionary = new Dictionary();
      
      private static var _pendingActions:Vector.<StatsAction> = new Vector.<StatsAction>(0);
      
      public static function get(param1:uint, param2:Boolean = false) : StatsAction
      {
         if(!_actions[param1])
         {
            _actions[param1] = new StatsAction(param1,param2);
         }
         return _actions[param1];
      }
      
      public static function exists(param1:uint) : Boolean
      {
         return _actions[param1];
      }
      
      public static function deletePendingActions() : void
      {
         _pendingActions.length = 0;
      }
      
      public static function sendPendingActions() : void
      {
         var _loc1_:StatsAction = null;
         for each(_loc1_ in _pendingActions)
         {
            _loc1_.send();
         }
         _pendingActions.length = 0;
      }
      
      private var _id:uint;
      
      private var _timestamp:Number;
      
      private var _persistent:Boolean;
      
      private var _startTime:uint;
      
      private var _started:Boolean;
      
      private var _params:Dictionary;
      
      public function start() : void
      {
         var _loc1_:* = NaN;
         if(!this._started)
         {
            if(!this._persistent)
            {
               this._timestamp = TimeManager.getInstance().getTimestamp();
               this._startTime = getTimer();
            }
            else
            {
               _loc1_ = StatisticsManager.getInstance().getActionTimestamp(this._id);
               if(isNaN(_loc1_))
               {
                  _loc1_ = TimeManager.getInstance().getTimestamp();
                  StatisticsManager.getInstance().saveActionTimestamp(this._id,_loc1_);
               }
               this._timestamp = _loc1_;
            }
         }
         this._started = true;
      }
      
      public function restart() : void
      {
         this._started = false;
         this.start();
      }
      
      public function cancel() : void
      {
         delete _actions[this._id];
         true;
      }
      
      public function updateTimestamp() : void
      {
         this._timestamp = TimeManager.getInstance().getTimestamp();
         if(this._persistent)
         {
            StatisticsManager.getInstance().saveActionTimestamp(this._id,this._timestamp);
         }
      }
      
      public function addParam(param1:String, param2:*) : void
      {
         this._params[param1] = param2;
      }
      
      public function hasParam(param1:String) : Boolean
      {
         return !(this._params[param1] == undefined);
      }
      
      public function send() : void
      {
         var _loc1_:BasicStatMessage = null;
         this._params["Time_Spent_On_Action"] = !this._persistent?getTimer() - this._startTime:TimeManager.getInstance().getTimestamp() - this._timestamp;
         if((StatisticsManager.getInstance().statsEnabled) && (StatisticsManager.getInstance().isConnected()))
         {
            _loc1_ = new BasicStatMessage();
            _loc1_.initBasicStatMessage(this._id);
            ConnectionsHandler.getConnection().send(_loc1_);
         }
         else
         {
            _pendingActions.push(this);
         }
         if(this._persistent)
         {
            StatisticsManager.getInstance().deleteTimeStamp(this._id);
         }
         delete _actions[this._id];
         true;
      }
   }
}
