package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.modificator.AreaFightModificatorUpdateMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.QuestHookList;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.spells.SpellPair;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.jerakine.messages.Message;

    public class WorldFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldFrame));

        private var _settings:Array = null;
        private var _currentFightModificator:int = -1;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get settings():Array
        {
            return (this._settings);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:AreaFightModificatorUpdateMessage;
            var updateModificatorText:String;
            switch (true)
            {
                case (msg is AreaFightModificatorUpdateMessage):
                    _local_2 = (msg as AreaFightModificatorUpdateMessage);
                    if (this._currentFightModificator != _local_2.spellPairId)
                    {
                        KernelEventsManager.getInstance().processCallback(QuestHookList.AreaFightModificatorUpdate, _local_2.spellPairId);
                        if (_local_2.spellPairId > -1)
                        {
                            if (this._currentFightModificator > -1)
                            {
                                updateModificatorText = I18n.getUiText("ui.spell.newFightModficator", [SpellPair.getSpellPairById(_local_2.spellPairId).name]);
                            }
                            else
                            {
                                updateModificatorText = I18n.getUiText("ui.spell.currentFightModficator", [SpellPair.getSpellPairById(_local_2.spellPairId).name]);
                            };
                            KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, updateModificatorText, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                        };
                        this._currentFightModificator = _local_2.spellPairId;
                    };
                    return (true);
            };
            return (false);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

