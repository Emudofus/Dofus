package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.messages.debug.DebugHighlightCellsMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.messages.debug.DebugInClientMessage;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.dofus.network.messages.debug.DebugClearHighlightCellsMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
    import com.ankamagames.dofus.network.enums.DebugLevelEnum;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.atouin.types.Selection;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.jerakine.types.zones.Custom;
    import __AS3__.vec.*;

    public class DebugFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DebugFrame));

        private var _sName:String;
        private var _aZones:Array;

        public function DebugFrame()
        {
            this._aZones = new Array();
            super();
        }

        public function get priority():int
        {
            return (0);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:DebugHighlightCellsMessage;
            var _local_3:uint;
            var _local_4:Vector.<uint>;
            var _local_5:Vector.<uint>;
            var _local_6:DebugInClientMessage;
            switch (true)
            {
                case (msg is DebugHighlightCellsMessage):
                    _local_2 = (msg as DebugHighlightCellsMessage);
                    this._sName = ((("debug_zone" + _local_2.color) + "_") + Math.round((Math.random() * 10000)));
                    _local_4 = new Vector.<uint>(0);
                    _local_5 = new Vector.<uint>(0);
                    for each (_local_3 in _local_2.cells)
                    {
                        if (MapDisplayManager.getInstance().renderer.isCellUnderFixture(_local_3))
                        {
                            _local_4.push(_local_3);
                        }
                        else
                        {
                            _local_5.push(_local_3);
                        };
                    };
                    if (_local_4.length > 0)
                    {
                        this.displayZone((this._sName + "_foreground"), _local_4, _local_2.color, PlacementStrataEnums.STRATA_FOREGROUND);
                        this._aZones.push((this._sName + "_foreground"));
                    };
                    if (_local_5.length > 0)
                    {
                        this.displayZone(this._sName, _local_5, _local_2.color, PlacementStrataEnums.STRATA_MOVEMENT);
                        this._aZones.push(this._sName);
                    };
                    return (true);
                case (msg is DebugClearHighlightCellsMessage):
                case (msg is CurrentMapMessage):
                case (msg is GameFightJoinMessage):
                    this.clear();
                    return (false);
                case (msg is DebugInClientMessage):
                    _local_6 = (msg as DebugInClientMessage);
                    switch (_local_6.level)
                    {
                        case DebugLevelEnum.LEVEL_DEBUG:
                            _log.debug(_local_6.message);
                            break;
                        case DebugLevelEnum.LEVEL_ERROR:
                            _log.error(_local_6.message);
                            break;
                        case DebugLevelEnum.LEVEL_FATAL:
                            _log.fatal(_local_6.message);
                            break;
                        case DebugLevelEnum.LEVEL_INFO:
                            _log.info(_local_6.message);
                            break;
                        case DebugLevelEnum.LEVEL_TRACE:
                            _log.trace(_local_6.message);
                            break;
                        case DebugLevelEnum.LEVEL_WARN:
                            _log.warn(_local_6.message);
                            break;
                    };
                    return (true);
            };
            return (false);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        private function clear():void
        {
            var sName:String;
            for each (sName in this._aZones)
            {
                SelectionManager.getInstance().getSelection(sName).remove();
            };
        }

        private function displayZone(name:String, cells:Vector.<uint>, color:uint, pStrata:uint):void
        {
            var s:Selection = new Selection();
            s.renderer = new ZoneDARenderer(pStrata);
            s.color = new Color(color);
            s.zone = new Custom(cells);
            SelectionManager.getInstance().addSelection(s, name);
            SelectionManager.getInstance().update(name);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

