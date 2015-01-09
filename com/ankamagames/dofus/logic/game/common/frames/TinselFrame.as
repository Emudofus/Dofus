package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.tinsel.TitlesAndOrnamentsListRequestMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.TitlesAndOrnamentsListMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.TitleGainedMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.TitleLostMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentGainedMessage;
    import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitleSelectRequestAction;
    import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectRequestMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectedMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.TitleSelectErrorMessage;
    import com.ankamagames.dofus.logic.game.common.actions.tinsel.OrnamentSelectRequestAction;
    import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectRequestMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectedMessage;
    import com.ankamagames.dofus.network.messages.game.tinsel.OrnamentSelectErrorMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.common.actions.tinsel.TitlesAndOrnamentsListRequestAction;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.QuestHookList;
    import com.ankamagames.dofus.misc.utils.ParamsDecoder;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class TinselFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TinselFrame));

        private var _knownTitles:Vector.<uint>;
        private var _knownOrnaments:Vector.<uint>;
        private var _currentTitle:uint;
        private var _currentOrnament:uint;
        private var _titlesOrnamentsAskedBefore:Boolean;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get knownTitles():Vector.<uint>
        {
            return (this._knownTitles);
        }

        public function get knownOrnaments():Vector.<uint>
        {
            return (this._knownOrnaments);
        }

        public function get currentTitle():uint
        {
            return (this._currentTitle);
        }

        public function get currentOrnament():uint
        {
            return (this._currentOrnament);
        }

        public function get titlesOrnamentsAskedBefore():Boolean
        {
            return (this._titlesOrnamentsAskedBefore);
        }

        public function pushed():Boolean
        {
            this._knownTitles = new Vector.<uint>();
            this._knownOrnaments = new Vector.<uint>();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:TitlesAndOrnamentsListRequestMessage;
            var _local_3:TitlesAndOrnamentsListMessage;
            var _local_4:TitleGainedMessage;
            var _local_5:String;
            var _local_6:TitleLostMessage;
            var _local_7:int;
            var _local_8:OrnamentGainedMessage;
            var _local_9:String;
            var _local_10:TitleSelectRequestAction;
            var _local_11:TitleSelectRequestMessage;
            var _local_12:TitleSelectedMessage;
            var _local_13:TitleSelectErrorMessage;
            var _local_14:OrnamentSelectRequestAction;
            var _local_15:OrnamentSelectRequestMessage;
            var _local_16:OrnamentSelectedMessage;
            var _local_17:OrnamentSelectErrorMessage;
            var id:int;
            switch (true)
            {
                case (msg is TitlesAndOrnamentsListRequestAction):
                    _local_2 = new TitlesAndOrnamentsListRequestMessage();
                    _local_2.initTitlesAndOrnamentsListRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_2);
                    return (true);
                case (msg is TitlesAndOrnamentsListMessage):
                    _local_3 = (msg as TitlesAndOrnamentsListMessage);
                    this._titlesOrnamentsAskedBefore = true;
                    this._knownTitles = _local_3.titles;
                    this._knownOrnaments = _local_3.ornaments;
                    this._currentTitle = _local_3.activeTitle;
                    this._currentOrnament = _local_3.activeOrnament;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated, this._knownTitles);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated, this._knownOrnaments);
                    return (true);
                case (msg is TitleGainedMessage):
                    _local_4 = (msg as TitleGainedMessage);
                    this._knownTitles.push(_local_4.titleId);
                    _local_5 = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.titleUnlockWithLink"), [_local_4.titleId]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_5, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated, this._knownTitles);
                    return (true);
                case (msg is TitleLostMessage):
                    _local_6 = (msg as TitleLostMessage);
                    _local_7 = 0;
                    for each (id in this._knownTitles)
                    {
                        if (id == _local_6.titleId)
                        {
                            break;
                        };
                        _local_7++;
                    };
                    this._knownTitles.splice(_local_7, 1);
                    if (this._currentTitle == _local_6.titleId)
                    {
                        this._currentTitle = 0;
                    };
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated, this._knownTitles);
                    return (true);
                case (msg is OrnamentGainedMessage):
                    _local_8 = (msg as OrnamentGainedMessage);
                    this._knownOrnaments.push(_local_8.ornamentId);
                    _local_9 = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.ornamentUnlockWithLink"), [_local_8.ornamentId]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _local_9, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated, this._knownOrnaments);
                    return (true);
                case (msg is TitleSelectRequestAction):
                    _local_10 = (msg as TitleSelectRequestAction);
                    _local_11 = new TitleSelectRequestMessage();
                    _local_11.initTitleSelectRequestMessage(_local_10.titleId);
                    ConnectionsHandler.getConnection().send(_local_11);
                    return (true);
                case (msg is TitleSelectedMessage):
                    _local_12 = (msg as TitleSelectedMessage);
                    this._currentTitle = _local_12.titleId;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitleUpdated, this._currentTitle);
                    return (true);
                case (msg is TitleSelectErrorMessage):
                    _local_13 = (msg as TitleSelectErrorMessage);
                    _log.debug("erreur de selection de titre");
                    return (true);
                case (msg is OrnamentSelectRequestAction):
                    _local_14 = (msg as OrnamentSelectRequestAction);
                    _local_15 = new OrnamentSelectRequestMessage();
                    _local_15.initOrnamentSelectRequestMessage(_local_14.ornamentId);
                    ConnectionsHandler.getConnection().send(_local_15);
                    return (true);
                case (msg is OrnamentSelectedMessage):
                    _local_16 = (msg as OrnamentSelectedMessage);
                    this._currentOrnament = _local_16.ornamentId;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentUpdated, this._currentOrnament);
                    return (true);
                case (msg is OrnamentSelectErrorMessage):
                    _local_17 = (msg as OrnamentSelectErrorMessage);
                    _log.debug("erreur de selection d'ornement");
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

