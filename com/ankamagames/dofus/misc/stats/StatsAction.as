package com.ankamagames.dofus.misc.stats
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import flash.utils.getTimer;
    import com.ankamagames.dofus.network.messages.common.basic.BasicStatMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import __AS3__.vec.*;

    public class StatsAction 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(StatsAction));
        private static var _actions:Dictionary = new Dictionary();
        private static var _pendingActions:Vector.<StatsAction> = new Vector.<StatsAction>(0);

        private var _id:uint;
        private var _timestamp:Number;
        private var _persistent:Boolean;
        private var _startTime:uint;
        private var _started:Boolean;
        private var _params:Dictionary;

        public function StatsAction(pId:uint, pPersistent:Boolean)
        {
            this._id = pId;
            this._persistent = pPersistent;
            this._params = new Dictionary(true);
        }

        public static function get(pStatsActionId:uint, pPersistent:Boolean=false):StatsAction
        {
            if (!(_actions[pStatsActionId]))
            {
                _actions[pStatsActionId] = new (StatsAction)(pStatsActionId, pPersistent);
            };
            return (_actions[pStatsActionId]);
        }

        public static function exists(pStatsActionId:uint):Boolean
        {
            return (_actions[pStatsActionId]);
        }

        public static function deletePendingActions():void
        {
            _pendingActions.length = 0;
        }

        public static function sendPendingActions():void
        {
            var action:StatsAction;
            for each (action in _pendingActions)
            {
                action.send();
            };
            _pendingActions.length = 0;
        }


        public function start():void
        {
            var _local_1:Number;
            if (!(this._started))
            {
                if (!(this._persistent))
                {
                    this._timestamp = TimeManager.getInstance().getTimestamp();
                    this._startTime = getTimer();
                }
                else
                {
                    _local_1 = StatisticsManager.getInstance().getActionTimestamp(this._id);
                    if (isNaN(_local_1))
                    {
                        _local_1 = TimeManager.getInstance().getTimestamp();
                        StatisticsManager.getInstance().saveActionTimestamp(this._id, _local_1);
                    };
                    this._timestamp = _local_1;
                };
            };
            this._started = true;
        }

        public function restart():void
        {
            this._started = false;
            this.start();
        }

        public function cancel():void
        {
            delete _actions[this._id];
        }

        public function updateTimestamp():void
        {
            this._timestamp = TimeManager.getInstance().getTimestamp();
            if (this._persistent)
            {
                StatisticsManager.getInstance().saveActionTimestamp(this._id, this._timestamp);
            };
        }

        public function addParam(pKey:String, pValue:*):void
        {
            this._params[pKey] = pValue;
        }

        public function hasParam(pKey:String):Boolean
        {
            return (!((this._params[pKey] == undefined)));
        }

        public function send():void
        {
            var bsmg:BasicStatMessage;
            this._params["Time_Spent_On_Action"] = ((!(this._persistent)) ? (getTimer() - this._startTime) : (TimeManager.getInstance().getTimestamp() - this._timestamp));
            if (((StatisticsManager.getInstance().statsEnabled) && (StatisticsManager.getInstance().isConnected())))
            {
                bsmg = new BasicStatMessage();
                bsmg.initBasicStatMessage(this._id);
                ConnectionsHandler.getConnection().send(bsmg);
            }
            else
            {
                _pendingActions.push(this);
            };
            if (this._persistent)
            {
                StatisticsManager.getInstance().deleteTimeStamp(this._id);
            };
            delete _actions[this._id];
        }


    }
}//package com.ankamagames.dofus.misc.stats

