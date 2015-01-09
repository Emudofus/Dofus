package com.ankamagames.dofus.scripts.spells
{
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.scripts.api.FxApi;
    import com.ankamagames.dofus.scripts.api.SpellFxApi;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.scripts.SpellFxRunner;

    public class SpellScript1 extends SpellScriptBase 
    {

        public function SpellScript1(spellFxRunner:SpellFxRunner)
        {
            var entryPortalCell:MapPoint;
            var exitPortalCell:MapPoint;
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
            if (SpellFxApi.HasSpellParam(spell, "casterGfxId"))
            {
                addGfxEntityStep(casterCell, casterCell, tmpTargetCell, PREFIX_CASTER);
            };
            if (entryPortalCell)
            {
                addPortalAnimationSteps(SpellFxApi.GetPortalIds(runner));
            };
            if (SpellFxApi.HasSpellParam(spell, "targetGfxId"))
            {
                addGfxEntityStep(targetCell, tmpCasterCell, targetCell, PREFIX_TARGET);
            };
            if (SpellFxApi.HasSpellParam(spell, "targetGfxId2"))
            {
                addGfxEntityStep(targetCell, tmpCasterCell, targetCell, PREFIX_TARGET, "2");
            };
            addAnimHitSteps();
            destroy();
        }

    }
}//package com.ankamagames.dofus.scripts.spells

