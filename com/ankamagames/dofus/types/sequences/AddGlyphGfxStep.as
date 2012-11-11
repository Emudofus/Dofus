package com.ankamagames.dofus.types.sequences
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.dofus.logic.game.fight.managers.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.types.look.*;

    public class AddGlyphGfxStep extends AbstractSequencable
    {
        private var _gfxId:uint;
        private var _cellId:uint;
        private var _entity:Glyph;
        private var _markId:int;
        private var _markType:uint;

        public function AddGlyphGfxStep(param1:uint, param2:uint, param3:int, param4:uint)
        {
            this._gfxId = param1;
            this._cellId = param2;
            this._markId = param3;
            this._markType = param4;
            return;
        }// end function

        override public function start() : void
        {
            var _loc_1:* = EntitiesManager.getInstance().getFreeEntityId();
            this._entity = new Glyph(_loc_1, TiphonEntityLook.fromString("{" + this._gfxId + "}"), true, true, this._markType);
            this._entity.init();
            this._entity.position = MapPoint.fromCellId(this._cellId);
            this._entity.display(PlacementStrataEnums.STRATA_AREA);
            MarkedCellsManager.getInstance().addGlyph(this._entity, this._markId);
            executeCallbacks();
            return;
        }// end function

    }
}
