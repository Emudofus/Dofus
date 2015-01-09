package com.ankamagames.dofus.scripts.spells
{
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.jerakine.sequencer.ISequencable;
    import com.ankamagames.dofus.scripts.api.FxApi;
    import com.ankamagames.dofus.scripts.api.SpellFxApi;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.scripts.api.SequenceApi;
    import com.ankamagames.dofus.scripts.SpellFxRunner;

    public class SpellScript5 extends SpellScriptBase 
    {

        public function SpellScript5(spellFxRunner:SpellFxRunner)
        {
            var entryPortalCell:MapPoint;
            var exitPortalCell:MapPoint;
            var glyphGfxStep:ISequencable;
            super(spellFxRunner);
            var targetCell:MapPoint = FxApi.GetCurrentTargetedCell(runner);
            var casterCell:MapPoint = FxApi.GetEntityCell(caster);
            var portalsCells:Vector.<MapPoint> = SpellFxApi.GetPortalCells(runner);
            if (((portalsCells) && ((portalsCells.length > 1))))
            {
                entryPortalCell = portalsCells[0];
                exitPortalCell = portalsCells[(portalsCells.length - 1)];
            };
            var tmpTargetCell:MapPoint = ((entryPortalCell) ? entryPortalCell : targetCell);
            var tmpCasterCell:MapPoint = ((exitPortalCell) ? exitPortalCell : casterCell);
            addCasterSetDirectionStep(tmpTargetCell);
            addCasterAnimationStep();
            if (entryPortalCell)
            {
                addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
            };
            if (((SpellFxApi.HasSpellParam(spell, "glyphGfxId")) && ((spell.silentCast == false))))
            {
                glyphGfxStep = SequenceApi.CreateAddGlyphGfxStep(runner, SpellFxApi.GetSpellParam(spell, "glyphGfxId"), targetCell, spell.markId);
                if (!(latestStep))
                {
                    SpellFxApi.AddFrontStep(runner, glyphGfxStep);
                }
                else
                {
                    SpellFxApi.AddStepAfter(runner, latestStep, glyphGfxStep);
                };
                latestStep = glyphGfxStep;
            };
            if (SpellFxApi.HasSpellParam(spell, "casterGfxId"))
            {
                addGfxEntityStep(casterCell, tmpCasterCell, targetCell, PREFIX_CASTER);
            };
            if (SpellFxApi.HasSpellParam(spell, "targetGfxId"))
            {
                addGfxEntityStep(targetCell, tmpCasterCell, targetCell, PREFIX_TARGET);
            };
            addAnimHitSteps();
            destroy();
        }

    }
}//package com.ankamagames.dofus.scripts.spells

