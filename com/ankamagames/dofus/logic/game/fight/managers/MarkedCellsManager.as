package com.ankamagames.dofus.logic.game.fight.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
    import com.ankamagames.atouin.types.Selection;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.atouin.renderers.TrapZoneRenderer;
    import com.ankamagames.dofus.network.enums.GameActionMarkCellsTypeEnum;
    import com.ankamagames.jerakine.types.zones.Cross;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.jerakine.types.zones.Lozenge;
    import com.ankamagames.jerakine.types.zones.Custom;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.dofus.datacenter.spells.Spell;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.AtouinConstants;
    import __AS3__.vec.*;

    public class MarkedCellsManager implements IDestroyable 
    {

        private static const MARK_SELECTIONS_PREFIX:String = "FightMark";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(MarkedCellsManager));
        private static var _self:MarkedCellsManager;

        private var _marks:Dictionary;
        private var _glyphs:Dictionary;
        private var _markUid:uint;

        public function MarkedCellsManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("MarkedCellsManager is a singleton and should not be instanciated directly."));
            };
            this._marks = new Dictionary(true);
            this._glyphs = new Dictionary(true);
            this._markUid = 0;
        }

        public static function getInstance():MarkedCellsManager
        {
            if (_self == null)
            {
                _self = new (MarkedCellsManager)();
            };
            return (_self);
        }


        public function addMark(markId:int, markType:int, associatedSpell:Spell, associatedSpellLevel:SpellLevel, cells:Vector.<GameActionMarkedCell>, teamId:int=2, markActive:Boolean=true):void
        {
            var mi:MarkInstance;
            var markedCell:GameActionMarkedCell;
            var s:Selection;
            var selectionStrata:uint;
            var cellsId:Vector.<uint>;
            var gamcell:GameActionMarkedCell;
            var cell:uint;
            if (((!(this._marks[markId])) || ((this._marks[markId].cells.length == 0))))
            {
                mi = new MarkInstance();
                mi.markId = markId;
                mi.markType = markType;
                mi.associatedSpell = associatedSpell;
                mi.associatedSpellLevel = associatedSpellLevel;
                mi.selections = new Vector.<Selection>(0, false);
                mi.cells = new Vector.<uint>(0, false);
                mi.teamId = teamId;
                mi.active = markActive;
                if (cells.length > 0)
                {
                    markedCell = cells[0];
                    s = new Selection();
                    s.color = new Color(markedCell.cellColor);
                    selectionStrata = (((markType == GameActionMarkTypeEnum.PORTAL)) ? PlacementStrataEnums.STRATA_PORTAL : PlacementStrataEnums.STRATA_GLYPH);
                    s.renderer = new TrapZoneRenderer(selectionStrata);
                    cellsId = new Vector.<uint>();
                    for each (gamcell in cells)
                    {
                        cellsId.push(gamcell.cellId);
                    };
                    if (markedCell.cellsType == GameActionMarkCellsTypeEnum.CELLS_CROSS)
                    {
                        s.zone = new Cross(0, markedCell.zoneSize, DataMapProvider.getInstance());
                    }
                    else
                    {
                        if (markedCell.zoneSize > 0)
                        {
                            s.zone = new Lozenge(0, markedCell.zoneSize, DataMapProvider.getInstance());
                        }
                        else
                        {
                            s.zone = new Custom(cellsId);
                        };
                    };
                    SelectionManager.getInstance().addSelection(s, this.getSelectionUid(), markedCell.cellId);
                    for each (cell in s.cells)
                    {
                        mi.cells.push(cell);
                    };
                    mi.selections.push(s);
                };
                this._marks[markId] = mi;
                this.updateDataMapProvider();
            };
        }

        public function getMarks(pMarkType:int, pTeamId:int, pActiveOnly:Boolean=true):Vector.<MarkInstance>
        {
            var mi:MarkInstance;
            var marks:Vector.<MarkInstance> = new Vector.<MarkInstance>();
            for each (mi in this._marks)
            {
                if ((((((mi.markType == pMarkType)) && ((((pTeamId == TeamEnum.TEAM_SPECTATOR)) || ((mi.teamId == pTeamId)))))) && (((!(pActiveOnly)) || (mi.active)))))
                {
                    marks.push(mi);
                };
            };
            return (marks);
        }

        public function getMarkDatas(markId:int):MarkInstance
        {
            return (this._marks[markId]);
        }

        public function removeMark(markId:int):void
        {
            var s:Selection;
            var selections:Vector.<Selection> = (this._marks[markId] as MarkInstance).selections;
            for each (s in selections)
            {
                s.remove();
            };
            delete this._marks[markId];
            this.updateDataMapProvider();
        }

        public function addGlyph(glyph:Glyph, markId:int):void
        {
            this._glyphs[markId] = glyph;
        }

        public function getGlyph(markId:int):Glyph
        {
            return ((this._glyphs[markId] as Glyph));
        }

        public function removeGlyph(markId:int):void
        {
            if (this._glyphs[markId])
            {
                Glyph(this._glyphs[markId]).remove();
                delete this._glyphs[markId];
            };
        }

        public function getMarksMapPoint(markType:int, teamId:int=2, activeOnly:Boolean=true):Vector.<MapPoint>
        {
            var mi:MarkInstance;
            var mapPoints:Vector.<MapPoint> = new Vector.<MapPoint>();
            for each (mi in this._marks)
            {
                if ((((((mi.markType == markType)) && ((((teamId == TeamEnum.TEAM_SPECTATOR)) || ((mi.teamId == teamId)))))) && (((!(activeOnly)) || (mi.active)))))
                {
                    mapPoints.push(MapPoint.fromCellId(mi.cells[0]));
                };
            };
            return (mapPoints);
        }

        public function getMarkAtCellId(cellId:uint, markType:int=-1):MarkInstance
        {
            var mark:MarkInstance;
            for each (mark in this._marks)
            {
                if (((((mark.cells.length) && ((mark.cells[0] == cellId)))) && ((((markType == -1)) || ((markType == mark.markType))))))
                {
                    return (mark);
                };
            };
            return (null);
        }

        public function getCellIdsFromMarkIds(markIds:Vector.<int>):Vector.<int>
        {
            var markId:int;
            var cellIds:Vector.<int> = new Vector.<int>();
            for each (markId in markIds)
            {
                if (((((this._marks[markId]) && (this._marks[markId].cells))) && ((this._marks[markId].cells.length == 1))))
                {
                    cellIds.push(this._marks[markId].cells[0]);
                }
                else
                {
                    _log.warn((("Can't find cellId for markId " + markId) + " in getCellIdsFromMarkIds()"));
                };
            };
            cellIds.fixed = true;
            return (cellIds);
        }

        public function getMapPointsFromMarkIds(markIds:Vector.<int>):Vector.<MapPoint>
        {
            var markId:int;
            var mapPoints:Vector.<MapPoint> = new Vector.<MapPoint>();
            for each (markId in markIds)
            {
                if (((((this._marks[markId]) && (this._marks[markId].cells))) && ((this._marks[markId].cells.length == 1))))
                {
                    mapPoints.push(MapPoint.fromCellId(this._marks[markId].cells[0]));
                }
                else
                {
                    _log.warn((("Can't find cellId for markId " + markId) + " in getMapPointsFromMarkIds()"));
                };
            };
            mapPoints.fixed = true;
            return (mapPoints);
        }

        public function getActivePortalsCount(teamId:int=2):uint
        {
            var mi:MarkInstance;
            var count:uint;
            for each (mi in this._marks)
            {
                if ((((((mi.markType == GameActionMarkTypeEnum.PORTAL)) && ((((teamId == TeamEnum.TEAM_SPECTATOR)) || ((mi.teamId == teamId)))))) && (mi.active)))
                {
                    count++;
                };
            };
            return (count);
        }

        public function destroy():void
        {
            var mark:String;
            var i:int;
            var num:int;
            var glyph:String;
            var bufferId:Array = new Array();
            for (mark in this._marks)
            {
                bufferId.push(int(mark));
            };
            i = -1;
            num = bufferId.length;
            while (++i < num)
            {
                this.removeMark(bufferId[i]);
            };
            bufferId.length = 0;
            for (glyph in this._glyphs)
            {
                bufferId.push(int(glyph));
            };
            i = -1;
            num = bufferId.length;
            while (++i < num)
            {
                this.removeGlyph(bufferId[i]);
            };
            _self = null;
        }

        private function getSelectionUid():String
        {
            return ((MARK_SELECTIONS_PREFIX + this._markUid++));
        }

        private function updateDataMapProvider():void
        {
            var mi:MarkInstance;
            var dmp:DataMapProvider;
            var mp:MapPoint;
            var i:uint;
            var cell:uint;
            var markedCells:Array = [];
            for each (mi in this._marks)
            {
                for each (cell in mi.cells)
                {
                    markedCells[cell] = (markedCells[cell] | mi.markType);
                };
            };
            dmp = DataMapProvider.getInstance();
            i = 0;
            while (i < AtouinConstants.MAP_CELLS_COUNT)
            {
                mp = MapPoint.fromCellId(i);
                dmp.setSpecialEffects(i, ((dmp.pointSpecialEffects(mp.x, mp.y) | 3) ^ 3));
                if (markedCells[i])
                {
                    dmp.setSpecialEffects(i, (dmp.pointSpecialEffects(mp.x, mp.y) | markedCells[i]));
                };
                i++;
            };
            this.updateMarksNumber(GameActionMarkTypeEnum.PORTAL);
        }

        public function updateMarksNumber(marktype:uint):void
        {
            var mi:MarkInstance;
            var teamId:int;
            var num:int;
            var color:Color;
            var mitn:MarkInstance;
            var markInstanceToNumber:Array = new Array();
            var teamIds:Array = new Array();
            for each (mi in this._marks)
            {
                if (mi.markType == marktype)
                {
                    if (!(markInstanceToNumber[mi.teamId]))
                    {
                        markInstanceToNumber[mi.teamId] = new Array();
                        teamIds.push(mi.teamId);
                    };
                    markInstanceToNumber[mi.teamId].push(mi);
                };
            };
            for each (teamId in teamIds)
            {
                markInstanceToNumber[teamId].sortOn("markId", Array.NUMERIC);
                num = 1;
                for each (mitn in markInstanceToNumber[teamId])
                {
                    if (this._glyphs[mitn.markId])
                    {
                        color = mitn.selections[0].color;
                        Glyph(this._glyphs[mitn.markId]).addNumber(num, color);
                    };
                    num++;
                };
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.managers

