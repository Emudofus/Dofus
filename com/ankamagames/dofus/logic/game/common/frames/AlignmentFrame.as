package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.alignment.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.pvp.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class AlignmentFrame extends Object implements Frame
    {
        private var _alignmentRank:int = -1;
        private var _angelsSubAreas:Vector.<int>;
        private var _evilsSubAreas:Vector.<int>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(PrismFrame));

        public function AlignmentFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get angelsSubAreas() : Vector.<int>
        {
            return this._angelsSubAreas.concat();
        }// end function

        public function get evilsSubAreas() : Vector.<int>
        {
            return this._evilsSubAreas.concat();
        }// end function

        public function get playerRank() : int
        {
            return this._alignmentRank;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:SetEnablePVPRequestAction = null;
            var _loc_3:SetEnablePVPRequestMessage = null;
            var _loc_4:AlignmentRankUpdateMessage = null;
            var _loc_5:AlignmentSubAreasListMessage = null;
            var _loc_6:AlignmentAreaUpdateMessage = null;
            var _loc_7:Area = null;
            var _loc_8:AlignmentSide = null;
            var _loc_9:String = null;
            var _loc_10:AlignmentSubAreaUpdateMessage = null;
            var _loc_11:SubArea = null;
            switch(true)
            {
                case param1 is SetEnablePVPRequestAction:
                {
                    _loc_2 = param1 as SetEnablePVPRequestAction;
                    _loc_3 = new SetEnablePVPRequestMessage();
                    _loc_3.enable = _loc_2.enable;
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is AlignmentRankUpdateMessage:
                {
                    _loc_4 = param1 as AlignmentRankUpdateMessage;
                    this._alignmentRank = _loc_4.alignmentRank;
                    if (_loc_4.verbose)
                    {
                        KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentRankUpdate, _loc_4.alignmentRank);
                    }
                    return true;
                }
                case param1 is AlignmentSubAreasListMessage:
                {
                    _loc_5 = param1 as AlignmentSubAreasListMessage;
                    this._angelsSubAreas = _loc_5.angelsSubAreas;
                    this._evilsSubAreas = _loc_5.evilsSubAreas;
                    KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentSubAreasList);
                    return true;
                }
                case param1 is AlignmentAreaUpdateMessage:
                {
                    _loc_6 = param1 as AlignmentAreaUpdateMessage;
                    _loc_7 = Area.getAreaById(_loc_6.areaId);
                    _loc_8 = AlignmentSide.getAlignmentSideById(_loc_6.side);
                    _loc_9 = I18n.getUiText("ui.alignment.areaIs", [_loc_7.name, _loc_8.name]);
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_9, ChatActivableChannelsEnum.CHANNEL_ALIGN, TimeManager.getInstance().getTimestamp());
                    KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentAreaUpdate, _loc_6.areaId, _loc_6.side);
                    return true;
                }
                case param1 is AlignmentSubAreaUpdateMessage:
                {
                    _loc_10 = param1 as AlignmentSubAreaUpdateMessage;
                    _loc_11 = SubArea.getSubAreaById(_loc_10.subAreaId);
                    _loc_8 = AlignmentSide.getAlignmentSideById(_loc_10.side);
                    if (!_loc_10.quiet)
                    {
                        _loc_9 = I18n.getUiText("ui.alignment.subareaIs", [_loc_11.name, _loc_8.name]);
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_9, ChatActivableChannelsEnum.CHANNEL_ALIGN, TimeManager.getInstance().getTimestamp());
                    }
                    KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentAreaUpdate, _loc_10.subAreaId, _loc_10.side);
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
