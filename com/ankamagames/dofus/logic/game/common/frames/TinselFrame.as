package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.tinsel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.tinsel.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class TinselFrame extends Object implements Frame
    {
        private var _knownTitles:Vector.<uint>;
        private var _knownOrnaments:Vector.<uint>;
        private var _currentTitle:uint;
        private var _currentOrnament:uint;
        private var _titlesOrnamentsAskedBefore:Boolean;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TinselFrame));

        public function TinselFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get knownTitles() : Vector.<uint>
        {
            return this._knownTitles;
        }// end function

        public function get knownOrnaments() : Vector.<uint>
        {
            return this._knownOrnaments;
        }// end function

        public function get currentTitle() : uint
        {
            return this._currentTitle;
        }// end function

        public function get currentOrnament() : uint
        {
            return this._currentOrnament;
        }// end function

        public function get titlesOrnamentsAskedBefore() : Boolean
        {
            return this._titlesOrnamentsAskedBefore;
        }// end function

        public function pushed() : Boolean
        {
            this._knownTitles = new Vector.<uint>;
            this._knownOrnaments = new Vector.<uint>;
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            switch(true)
            {
                case param1 is TitlesAndOrnamentsListRequestAction:
                {
                    _loc_2 = new TitlesAndOrnamentsListRequestMessage();
                    _loc_2.initTitlesAndOrnamentsListRequestMessage();
                    ConnectionsHandler.getConnection().send(_loc_2);
                    return true;
                }
                case param1 is TitlesAndOrnamentsListMessage:
                {
                    _loc_3 = param1 as TitlesAndOrnamentsListMessage;
                    this._titlesOrnamentsAskedBefore = true;
                    this._knownTitles = _loc_3.titles;
                    this._knownOrnaments = _loc_3.ornaments;
                    this._currentTitle = _loc_3.activeTitle;
                    this._currentOrnament = _loc_3.activeOrnament;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated, this._knownTitles);
                    KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated, this._knownOrnaments);
                    return true;
                }
                case param1 is TitleGainedMessage:
                {
                    _loc_4 = param1 as TitleGainedMessage;
                    this._knownTitles.push(_loc_4.titleId);
                    _loc_5 = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.titleUnlockWithLink"), [_loc_4.titleId]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_5, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated, this._knownTitles);
                    return true;
                }
                case param1 is TitleLostMessage:
                {
                    _loc_6 = param1 as TitleLostMessage;
                    _loc_7 = 0;
                    for each (_loc_18 in this._knownTitles)
                    {
                        
                        if (_loc_18 == _loc_6.titleId)
                        {
                            break;
                        }
                        _loc_7++;
                    }
                    this._knownTitles.splice(_loc_7, 1);
                    if (this._currentTitle == _loc_6.titleId)
                    {
                        this._currentTitle = 0;
                    }
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitlesListUpdated, this._knownTitles);
                    return true;
                }
                case param1 is OrnamentGainedMessage:
                {
                    _loc_8 = param1 as OrnamentGainedMessage;
                    this._knownOrnaments.push(_loc_8.ornamentId);
                    _loc_9 = ParamsDecoder.applyParams(I18n.getUiText("ui.ornament.ornamentUnlockWithLink"), [_loc_8.ornamentId]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_9, ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentsListUpdated, this._knownOrnaments);
                    return true;
                }
                case param1 is TitleSelectRequestAction:
                {
                    _loc_10 = param1 as TitleSelectRequestAction;
                    _loc_11 = new TitleSelectRequestMessage();
                    _loc_11.initTitleSelectRequestMessage(_loc_10.titleId);
                    ConnectionsHandler.getConnection().send(_loc_11);
                    return true;
                }
                case param1 is TitleSelectedMessage:
                {
                    _loc_12 = param1 as TitleSelectedMessage;
                    this._currentTitle = _loc_12.titleId;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.TitleUpdated, this._currentTitle);
                    return true;
                }
                case param1 is TitleSelectErrorMessage:
                {
                    _loc_13 = param1 as TitleSelectErrorMessage;
                    _log.debug("erreur de selection de titre");
                    return true;
                }
                case param1 is OrnamentSelectRequestAction:
                {
                    _loc_14 = param1 as OrnamentSelectRequestAction;
                    _loc_15 = new OrnamentSelectRequestMessage();
                    _loc_15.initOrnamentSelectRequestMessage(_loc_14.ornamentId);
                    ConnectionsHandler.getConnection().send(_loc_15);
                    return true;
                }
                case param1 is OrnamentSelectedMessage:
                {
                    _loc_16 = param1 as OrnamentSelectedMessage;
                    this._currentOrnament = _loc_16.ornamentId;
                    KernelEventsManager.getInstance().processCallback(QuestHookList.OrnamentUpdated, this._currentOrnament);
                    return true;
                }
                case param1 is OrnamentSelectErrorMessage:
                {
                    _loc_17 = param1 as OrnamentSelectErrorMessage;
                    _log.debug("erreur de selection d\'ornement");
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

    }
}
