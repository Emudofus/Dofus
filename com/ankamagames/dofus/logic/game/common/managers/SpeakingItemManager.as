package com.ankamagames.dofus.logic.game.common.managers
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.livingObjects.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.inventory.items.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.events.*;
    import flash.utils.*;

    public class SpeakingItemManager extends Object implements IDestroyable
    {
        private var _nextMessageCount:int;
        private static const SPEAKING_ITEMS_MSG_COUNT:Number = 30;
        private static const SPEAKING_ITEMS_MSG_COUNT_DELTA:Number = 0.2;
        private static const SPEAKING_ITEMS_CHAT_PROBA:Number = 0.01;
        private static var _timer:Timer;
        public static const MINUTE_DELAY:int = 60000;
        public static const GREAT_DROP_LIMIT:int = 10;
        public static const SPEAK_TRIGGER_MINUTE:int = 1;
        public static const SPEAK_TRIGGER_AGRESS:int = 2;
        public static const SPEAK_TRIGGER_AGRESSED:int = 3;
        public static const SPEAK_TRIGGER_KILL_ENEMY:int = 4;
        public static const SPEAK_TRIGGER_KILLED_BY_ENEMY:int = 5;
        public static const SPEAK_TRIGGER_CC_OWNER:int = 6;
        public static const SPEAK_TRIGGER_EC_OWNER:int = 7;
        public static const SPEAK_TRIGGER_FIGHT_WON:int = 8;
        public static const SPEAK_TRIGGER_FIGHT_LOST:int = 9;
        public static const SPEAK_TRIGGER_NEW_ENEMY_WEAK:int = 10;
        public static const SPEAK_TRIGGER_NEW_ENEMY_STRONG:int = 11;
        public static const SPEAK_TRIGGER_CC_ALLIED:int = 12;
        public static const SPEAK_TRIGGER_EC_ALLIED:int = 13;
        public static const SPEAK_TRIGGER_CC_ENEMY:int = 14;
        public static const SPEAK_TRIGGER_EC_ENEMY:int = 15;
        public static const SPEAK_TRIGGER_ON_CONNECT:int = 16;
        public static const SPEAK_TRIGGER_KILL_ALLY:int = 17;
        public static const SPEAK_TRIGGER_KILLED_BY_ALLY:int = 18;
        public static const SPEAK_TRIGGER_GREAT_DROP:int = 19;
        public static const SPEAK_TRIGGER_KILLED_HIMSELF:int = 20;
        public static const SPEAK_TRIGGER_CRAFT_OK:int = 21;
        public static const SPEAK_TRIGGER_CRAFT_KO:int = 22;
        private static var _self:SpeakingItemManager;

        public function SpeakingItemManager()
        {
            if (_self != null)
            {
                throw new SingletonError("TimeManager is a singleton and should not be instanciated directly.");
            }
            this.init();
            return;
        }// end function

        public function get speakTimerMinuteDelay() : int
        {
            return _timer.delay;
        }// end function

        public function set speakTimerMinuteDelay(param1:int) : void
        {
            _timer.delay = param1;
            _timer.stop();
            _timer.start();
            return;
        }// end function

        public function triggerEvent(param1:int) : void
        {
            var _loc_4:ItemWrapper = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            var _loc_10:Number = NaN;
            var _loc_11:Boolean = false;
            var _loc_12:Number = NaN;
            var _loc_13:SpeakingItemText = null;
            var _loc_14:Array = null;
            var _loc_15:LivingObjectMessageRequestMessage = null;
            if (!Kernel.getWorker().getFrame(ChatFrame))
            {
                return;
            }
            var _loc_2:* = OptionManager.getOptionManager("chat").letLivingObjectTalk;
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = new Array();
            for each (_loc_4 in InventoryManager.getInstance().inventory.getView("equipment").content)
            {
                
                if (_loc_4 && _loc_4.isSpeakingObject)
                {
                    _loc_3.push(_loc_4);
                }
            }
            if (_loc_3.length == 0)
            {
                return;
            }
            var _loc_16:String = this;
            var _loc_17:* = this._nextMessageCount - 1;
            _loc_16._nextMessageCount = _loc_17;
            this._nextMessageCount = this._nextMessageCount - (_loc_3.length - 1) / 4;
            if (this._nextMessageCount > 0)
            {
                return;
            }
            var _loc_5:* = SpeakingItemsTrigger.getSpeakingItemsTriggerById(param1);
            var _loc_6:* = _loc_3[Math.floor(Math.random() * _loc_3.length)];
            var _loc_7:* = new Array();
            if (_loc_5)
            {
                _loc_8 = _loc_6.objectGID.toString();
                _loc_9 = 0;
                while (_loc_9 < _loc_5.textIds.length)
                {
                    
                    if (_loc_6.isLivingObject && _loc_5.states[_loc_9] != _loc_6.livingObjectMood)
                    {
                    }
                    else
                    {
                        _loc_13 = SpeakingItemText.getSpeakingItemTextById(_loc_5.textIds[_loc_9]);
                        if (!_loc_13)
                        {
                        }
                        else if (_loc_13.textLevel > _loc_6.livingObjectLevel && _loc_6.isLivingObject)
                        {
                        }
                        else
                        {
                            _loc_14 = _loc_13.textRestriction.split(",");
                            if (_loc_13.textRestriction != "" && _loc_14.indexOf(_loc_8) == -1)
                            {
                            }
                            else
                            {
                                _loc_7.push(_loc_5.textIds[_loc_9]);
                            }
                        }
                    }
                    _loc_9++;
                }
                if (_loc_7.length == 0)
                {
                    return;
                }
                _loc_11 = false;
                _loc_9 = 0;
                while (_loc_9 < 10)
                {
                    
                    _loc_10 = _loc_7[Math.floor(Math.random() * _loc_7.length)];
                    _loc_13 = SpeakingItemText.getSpeakingItemTextById(_loc_10);
                    if (Math.random() < _loc_13.textProba)
                    {
                        _loc_11 = true;
                    }
                    _loc_9++;
                }
                if (!_loc_11)
                {
                    return;
                }
                if (_loc_13.textSound != -1)
                {
                    _loc_12 = Math.floor(Math.random() * 3);
                }
                else
                {
                    _loc_12 = 1;
                }
                if (Math.random() < SPEAKING_ITEMS_CHAT_PROBA)
                {
                    _loc_15 = new LivingObjectMessageRequestMessage();
                    _loc_15.msgId = _loc_13.textId;
                    _loc_15.livingObject = _loc_6.objectUID;
                    ConnectionsHandler.getConnection().send(_loc_15);
                }
                else
                {
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ChatSpeakingItem, ChatActivableChannelsEnum.PSEUDO_CHANNEL_PRIVATE, _loc_6, _loc_13.textString, TimeManager.getInstance().getTimestamp());
                }
            }
            this.generateNextMsgCount(false);
            return;
        }// end function

        public function destroy() : void
        {
            _self = null;
            _timer.removeEventListener("timer", this.onTimer);
            return;
        }// end function

        private function init() : void
        {
            _timer = new Timer(MINUTE_DELAY);
            _timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            _timer.start();
            this.generateNextMsgCount(true);
            return;
        }// end function

        private function generateNextMsgCount(param1:Boolean) : void
        {
            var _loc_2:* = SPEAKING_ITEMS_MSG_COUNT;
            var _loc_3:* = SPEAKING_ITEMS_MSG_COUNT_DELTA;
            if (param1)
            {
                this._nextMessageCount = Math.floor(_loc_2 * Math.random());
            }
            else
            {
                this._nextMessageCount = _loc_2 + Math.floor(2 * _loc_3 * Math.random());
            }
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            this.triggerEvent(SPEAK_TRIGGER_MINUTE);
            return;
        }// end function

        public static function getInstance() : SpeakingItemManager
        {
            if (_self == null)
            {
                _self = new SpeakingItemManager;
            }
            return _self;
        }// end function

    }
}
