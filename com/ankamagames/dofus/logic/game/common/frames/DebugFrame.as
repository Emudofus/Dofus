package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.debug.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.zones.*;
    import flash.utils.*;

    public class DebugFrame extends Object implements Frame
    {
        private var _sName:String;
        private var _aZones:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DebugFrame));

        public function DebugFrame()
        {
            this._aZones = new Array();
            return;
        }// end function

        public function get priority() : int
        {
            return 0;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:DebugHighlightCellsMessage = null;
            var _loc_3:DebugClearHighlightCellsMessage = null;
            var _loc_4:DebugInClientMessage = null;
            var _loc_5:String = null;
            switch(true)
            {
                case param1 is DebugHighlightCellsMessage:
                {
                    _loc_2 = param1 as DebugHighlightCellsMessage;
                    this._sName = "debug_zone" + _loc_2.color + "_" + Math.round(Math.random() * 10000);
                    this.displayZone(this._sName, _loc_2.cells, _loc_2.color);
                    this._aZones.push(this._sName);
                    return true;
                }
                case param1 is DebugClearHighlightCellsMessage:
                {
                    _loc_3 = param1 as DebugClearHighlightCellsMessage;
                    for each (_loc_5 in this._aZones)
                    {
                        
                        SelectionManager.getInstance().getSelection(_loc_5).remove();
                    }
                    return true;
                }
                case param1 is DebugInClientMessage:
                {
                    _loc_4 = param1 as DebugInClientMessage;
                    switch(_loc_4.level)
                    {
                        case DebugLevelEnum.LEVEL_DEBUG:
                        {
                            _log.debug(_loc_4.message);
                            break;
                        }
                        case DebugLevelEnum.LEVEL_ERROR:
                        {
                            _log.error(_loc_4.message);
                            break;
                        }
                        case DebugLevelEnum.LEVEL_FATAL:
                        {
                            _log.fatal(_loc_4.message);
                            break;
                        }
                        case DebugLevelEnum.LEVEL_INFO:
                        {
                            _log.info(_loc_4.message);
                            break;
                        }
                        case DebugLevelEnum.LEVEL_TRACE:
                        {
                            _log.trace(_loc_4.message);
                            break;
                        }
                        case DebugLevelEnum.LEVEL_WARN:
                        {
                            _log.warn(_loc_4.message);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        private function displayZone(param1:String, param2:Vector.<uint>, param3:uint) : void
        {
            var _loc_4:* = new Selection();
            new Selection().renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_MOVEMENT);
            _loc_4.color = new Color(param3);
            _loc_4.zone = new Custom(param2);
            SelectionManager.getInstance().addSelection(_loc_4, param1);
            SelectionManager.getInstance().update(param1);
            return;
        }// end function

    }
}
