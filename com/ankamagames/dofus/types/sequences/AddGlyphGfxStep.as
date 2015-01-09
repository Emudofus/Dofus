package com.ankamagames.dofus.types.sequences
{
    import com.ankamagames.jerakine.sequencer.AbstractSequencable;
    import com.ankamagames.dofus.types.entities.Glyph;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.tiphon.types.look.TiphonEntityLook;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;

    public class AddGlyphGfxStep extends AbstractSequencable 
    {

        private var _gfxId:uint;
        private var _cellId:uint;
        private var _entity:Glyph;
        private var _markId:int;
        private var _markType:uint;
        private var _teamId:uint;
        private var _markActive:Boolean;

        public function AddGlyphGfxStep(gfxId:uint, cellId:uint, markId:int, markType:uint, teamId:uint=2, markActive:Boolean=true)
        {
            this._gfxId = gfxId;
            this._cellId = cellId;
            this._markId = markId;
            this._markType = markType;
            this._teamId = teamId;
            this._markActive = markActive;
        }

        override public function start():void
        {
            var id:int = EntitiesManager.getInstance().getFreeEntityId();
            this._entity = new Glyph(id, TiphonEntityLook.fromString((("{" + this._gfxId) + "}")), true, true, this._markType);
            this._entity.init();
            this._entity.position = MapPoint.fromCellId(this._cellId);
            this._entity.display(PlacementStrataEnums.STRATA_AREA);
            if ((((this._markType == GameActionMarkTypeEnum.PORTAL)) && (!(this._markActive))))
            {
                this._entity.setAnimation(PortalAnimationEnum.STATE_DISABLED);
            };
            MarkedCellsManager.getInstance().addGlyph(this._entity, this._markId);
            executeCallbacks();
        }


    }
}//package com.ankamagames.dofus.types.sequences

