package com.ankamagames.dofus.logic.game.fight.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import flash.utils.Dictionary;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.berilia.managers.TooltipManager;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
    import com.ankamagames.berilia.types.LocationEnum;
    import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
    import com.ankamagames.dofus.types.entities.RiderBehavior;
    import com.ankamagames.dofus.logic.game.fight.miscs.CarrierSubEntityBehaviour;
    import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
    import com.ankamagames.dofus.types.enums.AnimationEnum;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import com.ankamagames.atouin.managers.MapDisplayManager;
    import com.ankamagames.atouin.data.map.CellData;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.berilia.enums.StrataEnum;
    import __AS3__.vec.*;

    public class FightTeleportationPreview 
    {

        private static const _log:Logger = Log.getLogger(getQualifiedClassName(FightTeleportationPreview));

        private var _targetedEntities:Vector.<int>;
        private var _teleportationEffectId:uint;
        private var _impactPos:MapPoint;
        private var _casterPos:MapPoint;
        private var _previews:Vector.<AnimatedCharacter>;
        private var _teleFraggedEntities:Vector.<AnimatedCharacter>;
        private var _previewIdEntityIdAssoc:Dictionary;
        private var _multipleTeleportationEffects:Boolean;

        public function FightTeleportationPreview(pTargetedEntities:Vector.<int>, pTeleportationEffectId:uint, pImpactCell:uint, pCasterCell:uint, pMultipleTeleportationEffects:Boolean)
        {
            this._targetedEntities = pTargetedEntities;
            this._teleportationEffectId = pTeleportationEffectId;
            this._impactPos = MapPoint.fromCellId(pImpactCell);
            this._casterPos = MapPoint.fromCellId(pCasterCell);
            this._previewIdEntityIdAssoc = new Dictionary();
            this._multipleTeleportationEffects = pMultipleTeleportationEffects;
        }

        public function show():void
        {
            var entityId:int;
            var entity:AnimatedCharacter;
            var teleport:Function;
            var parentEntity:AnimatedCharacter;
            var parentEntityId:int;
            var i:int;
            switch (this._teleportationEffectId)
            {
                case 1100:
                    teleport = this.teleportationToPreviousPosition;
                    break;
                case 1104:
                    teleport = this.symetricTeleportation;
                    break;
                case 1105:
                    teleport = this.symetricTeleportationFromCaster;
                    break;
                case 1106:
                    teleport = this.symetricTeleportationFromImpactCell;
                    break;
            };
            this._targetedEntities.sort(this.compareDistanceFromCaster);
            var nbEntities:int = this._targetedEntities.length;
            i = 0;
            while (i < nbEntities)
            {
                entity = (DofusEntities.getEntity(this._targetedEntities[i]) as AnimatedCharacter);
                if (entity)
                {
                    parentEntity = (this.getParentEntity(entity) as AnimatedCharacter);
                    parentEntity.visible = false;
                    teleport.apply(this, [parentEntity.id]);
                };
                i++;
            };
        }

        public function remove():void
        {
            var entityId:int;
            var entity:AnimatedCharacter;
            var parentEntity:AnimatedCharacter;
            var parentEntityId:int;
            var ac:AnimatedCharacter;
            for each (entityId in this._targetedEntities)
            {
                entity = (DofusEntities.getEntity(entityId) as AnimatedCharacter);
                if (entity)
                {
                    parentEntity = (this.getParentEntity(entity) as AnimatedCharacter);
                    parentEntity.visible = true;
                };
            };
            if (this._previews)
            {
                for each (ac in this._previews)
                {
                    ac.destroy();
                };
            };
            if (this._teleFraggedEntities)
            {
                for each (ac in this._teleFraggedEntities)
                {
                    ac.visible = true;
                };
            };
        }

        private function symetricTeleportation(pTargetId:int):void
        {
            var preview:AnimatedCharacter;
            var entity:AnimatedCharacter = (DofusEntities.getEntity(pTargetId) as AnimatedCharacter);
            var teleportationCell:MapPoint = this._casterPos.pointSymetry(this._impactPos);
            if (((((teleportationCell) && (this.isValidCell(teleportationCell.cellId)))) && ((EntitiesManager.getInstance().getEntitiesOnCell(this._impactPos.cellId, AnimatedCharacter).length > 0))))
            {
                preview = this.createFighterPreview(pTargetId, teleportationCell, this._casterPos.advancedOrientationTo(this._impactPos));
                this.checkTeleFrag(preview, pTargetId, teleportationCell, this._casterPos);
            }
            else
            {
                entity.visible = true;
            };
        }

        private function symetricTeleportationFromCaster(pTargetId:int):void
        {
            var preview:AnimatedCharacter;
            var entity:AnimatedCharacter = (DofusEntities.getEntity(pTargetId) as AnimatedCharacter);
            var entityPos:MapPoint = entity.position;
            var teleportationCell:MapPoint = entityPos.pointSymetry(this._casterPos);
            if (((teleportationCell) && (this.isValidCell(teleportationCell.cellId))))
            {
                preview = this.createFighterPreview(pTargetId, teleportationCell, entity.getDirection());
                this.checkTeleFrag(preview, pTargetId, teleportationCell, entityPos);
            }
            else
            {
                entity.visible = true;
            };
        }

        private function symetricTeleportationFromImpactCell(pTargetId:int):void
        {
            var preview:AnimatedCharacter;
            var entity:AnimatedCharacter = (DofusEntities.getEntity(pTargetId) as AnimatedCharacter);
            var existingPreview:AnimatedCharacter = this.getPreview(pTargetId);
            var checkPositionsSwitch:Boolean = ((existingPreview) && (this._multipleTeleportationEffects));
            var entityPos:MapPoint = ((checkPositionsSwitch) ? existingPreview.position : entity.position);
            var teleportationCell:MapPoint = entityPos.pointSymetry(this._impactPos);
            if (((checkPositionsSwitch) && (this.willSwitchPosition(existingPreview, teleportationCell))))
            {
                entityPos = entity.position;
                teleportationCell = entityPos.pointSymetry(this._impactPos);
            };
            if (((teleportationCell) && (this.isValidCell(teleportationCell.cellId))))
            {
                preview = this.createFighterPreview(pTargetId, teleportationCell, entity.getDirection());
                this.checkTeleFrag(preview, pTargetId, teleportationCell, entityPos);
            }
            else
            {
                entity.visible = true;
            };
        }

        private function teleportationToPreviousPosition(pTargetId:int):void
        {
            var teleportationCell:MapPoint;
            var preview:AnimatedCharacter;
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entity:AnimatedCharacter = (DofusEntities.getEntity(pTargetId) as AnimatedCharacter);
            var teleportationCellId:int = fightContextFrame.getFighterPreviousPosition(pTargetId);
            if (teleportationCellId != -1)
            {
                teleportationCell = MapPoint.fromCellId(teleportationCellId);
                if (((teleportationCell) && (this.isValidCell(teleportationCell.cellId))))
                {
                    preview = this.createFighterPreview(pTargetId, teleportationCell, entity.getDirection());
                    this.checkTeleFrag(preview, pTargetId, teleportationCell, entity.position);
                }
                else
                {
                    entity.visible = true;
                };
            }
            else
            {
                entity.visible = true;
            };
        }

        private function checkTeleFrag(pTeleportPreview:AnimatedCharacter, pTargetId:int, pDestination:MapPoint, pFrom:MapPoint):void
        {
            var entity:AnimatedCharacter;
            var entityActualId:int;
            var _local_8:int;
            var _local_9:AnimatedCharacter;
            var teleportationCellEntities:Array = EntitiesManager.getInstance().getEntitiesOnCell(pDestination.cellId, AnimatedCharacter);
            if (teleportationCellEntities.length > 0)
            {
                for each (entity in teleportationCellEntities)
                {
                    if (((!((entity == pTeleportPreview))) && (!((entity.id == pTargetId)))))
                    {
                        entityActualId = ((this._previewIdEntityIdAssoc[entity.id]) ? this._previewIdEntityIdAssoc[entity.id] : entity.id);
                        if (this.canTeleport(entityActualId))
                        {
                            this.telefrag((this.getParentEntity(entity) as AnimatedCharacter), pTeleportPreview, pTargetId, pFrom);
                        }
                        else
                        {
                            _local_8 = this._previewIdEntityIdAssoc[pTeleportPreview.id];
                            _local_9 = (DofusEntities.getEntity(_local_8) as AnimatedCharacter);
                            if (_local_9)
                            {
                                _local_9 = (this.getParentEntity(_local_9) as AnimatedCharacter);
                                _local_9.visible = true;
                            };
                            pTeleportPreview.destroy();
                        };
                        break;
                    };
                };
            };
        }

        private function telefrag(pTeleFraggedEntity:AnimatedCharacter, pTeleFraggingPreviewEntity:AnimatedCharacter, pTeleFraggingActualEntityId:int, pDestination:MapPoint):void
        {
            var preview:AnimatedCharacter = this.createFighterPreview(pTeleFraggedEntity.id, pDestination, pTeleFraggedEntity.getDirection());
            if (!(this._previewIdEntityIdAssoc[pTeleFraggedEntity.id]))
            {
                pTeleFraggedEntity.visible = false;
            };
            if (!(this._teleFraggedEntities))
            {
                this._teleFraggedEntities = new Vector.<AnimatedCharacter>(0);
            };
            this._teleFraggedEntities.push(pTeleFraggedEntity);
            var telefraggedActualEntityId:int = ((this._previewIdEntityIdAssoc[pTeleFraggedEntity.id]) ? this._previewIdEntityIdAssoc[pTeleFraggedEntity.id] : pTeleFraggedEntity.id);
            this.showTelefragTooltip(telefraggedActualEntityId, preview);
            this.showTelefragTooltip(pTeleFraggingActualEntityId, pTeleFraggingPreviewEntity);
        }

        private function willSwitchPosition(pPreview:AnimatedCharacter, pTeleportationCell:MapPoint):Boolean
        {
            var teleportationCellEntities:Array;
            var entity:AnimatedCharacter;
            var actualEntityId:int;
            var fightContextFrame:FightContextFrame;
            var entityFightInfos:GameFightFighterInformations;
            var entityOnCellFightInfos:GameFightFighterInformations;
            var entityOnCellId:int;
            if (((pTeleportationCell) && (this.isValidCell(pTeleportationCell.cellId))))
            {
                teleportationCellEntities = EntitiesManager.getInstance().getEntitiesOnCell(pTeleportationCell.cellId, AnimatedCharacter);
                actualEntityId = this._previewIdEntityIdAssoc[pPreview.id];
                fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                entityFightInfos = (fightContextFrame.entitiesFrame.getEntityInfos(actualEntityId) as GameFightFighterInformations);
                for each (entity in teleportationCellEntities)
                {
                    if (((!((entity == pPreview))) && (!((entity.id == actualEntityId)))))
                    {
                        entityOnCellId = ((this._previewIdEntityIdAssoc[entity.id]) ? this._previewIdEntityIdAssoc[entity.id] : entity.id);
                        entityOnCellFightInfos = (fightContextFrame.entitiesFrame.getEntityInfos(entityOnCellId) as GameFightFighterInformations);
                        if (entityFightInfos.teamId == entityOnCellFightInfos.teamId)
                        {
                            return (true);
                        };
                        return (false);
                    };
                };
            };
            return (false);
        }

        private function getPreview(pEntityId:int):AnimatedCharacter
        {
            var previewEntityId:*;
            var previewEntity:AnimatedCharacter;
            if (this._previewIdEntityIdAssoc[pEntityId])
            {
                for each (previewEntity in this._previews)
                {
                    if (previewEntity.id == pEntityId)
                    {
                        return (previewEntity);
                    };
                };
            }
            else
            {
                for (previewEntityId in this._previewIdEntityIdAssoc)
                {
                    if (this._previewIdEntityIdAssoc[previewEntityId] == pEntityId)
                    {
                        for each (previewEntity in this._previews)
                        {
                            if (previewEntity.id == previewEntityId)
                            {
                                return (previewEntity);
                            };
                        };
                    };
                };
            };
            return (null);
        }

        private function canTeleport(pEntityId:int):Boolean
        {
            var monster:Monster;
            var fcf:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entityInfos:GameFightFighterInformations = (fcf.entitiesFrame.getEntityInfos(pEntityId) as GameFightFighterInformations);
            if ((entityInfos is GameFightMonsterInformations))
            {
                monster = Monster.getMonsterById((entityInfos as GameFightMonsterInformations).creatureGenericId);
                if (!(monster.canSwitchPos))
                {
                    return (false);
                };
            };
            var entityStates:Array = FightersStateManager.getInstance().getStates(pEntityId);
            return (((!(entityStates)) || ((((entityStates.indexOf(6) == -1)) && ((entityStates.indexOf(97) == -1))))));
        }

        private function createFighterPreview(pTargetId:int, pDestPos:MapPoint, pDirection:uint):AnimatedCharacter
        {
            var fightContextFrame:FightContextFrame;
            var entityInfos:GameFightFighterInformations;
            var ttCacheName:String;
            var ttName:String;
            var actualEntity:AnimatedCharacter = (DofusEntities.getEntity(pTargetId) as AnimatedCharacter);
            var parentEntity:TiphonSprite = this.getParentEntity(actualEntity);
            var previewEntity:AnimatedCharacter = this.getPreview(pTargetId);
            if (!(previewEntity))
            {
                previewEntity = new AnimatedCharacter(EntitiesManager.getInstance().getFreeEntityId(), parentEntity.look);
                this.addPreviewSubEntities(parentEntity, previewEntity);
                previewEntity.mouseEnabled = (previewEntity.mouseChildren = false);
                if (!(this._previews))
                {
                    this._previews = new Vector.<AnimatedCharacter>(0);
                };
                this._previews.push(previewEntity);
                this._previewIdEntityIdAssoc[previewEntity.id] = pTargetId;
            };
            previewEntity.position = pDestPos;
            previewEntity.setDirection(pDirection);
            previewEntity.display(PlacementStrataEnums.STRATA_PLAYER);
            if (TooltipManager.isVisible(("tooltipOverEntity_" + pTargetId)))
            {
                fightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
                entityInfos = (fightContextFrame.entitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations);
                ttCacheName = (((entityInfos is GameFightCharacterInformations)) ? ("PlayerShortInfos" + pTargetId) : ("EntityShortInfos" + pTargetId));
                ttName = ("tooltipOverEntity_" + pTargetId);
                TooltipManager.updatePosition(ttCacheName, ttName, previewEntity.absoluteBounds, LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, true, previewEntity.position.cellId);
            };
            return (previewEntity);
        }

        private function getParentEntity(pEntity:TiphonSprite):TiphonSprite
        {
            var parentEntity:TiphonSprite;
            var parent:TiphonSprite = pEntity.parentSprite;
            while (parent)
            {
                parentEntity = parent;
                parent = parent.parentSprite;
            };
            return (((!(parentEntity)) ? pEntity : parentEntity));
        }

        private function addPreviewSubEntities(pActualEntity:TiphonSprite, pPreviewEntity:TiphonSprite):void
        {
            var isRider:Boolean;
            var carriedPreviewEntity:TiphonSprite;
            if (((pActualEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER)) && (pActualEntity.look.getSubEntitiesFromCategory(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER).length)))
            {
                isRider = true;
                pPreviewEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, new RiderBehavior());
            };
            var carryingEntity:TiphonSprite = pActualEntity;
            if (((isRider) && (pActualEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0))))
            {
                carryingEntity = (pActualEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite);
            };
            var carryingPreviewEntity:TiphonSprite = pPreviewEntity;
            if (((isRider) && (pPreviewEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0))))
            {
                carryingPreviewEntity = (pPreviewEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER, 0) as TiphonSprite);
            };
            var carriedEntity:TiphonSprite = (carryingEntity.getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY, 0) as TiphonSprite);
            this.addTeamCircle(pActualEntity, pPreviewEntity);
            if (carriedEntity)
            {
                carriedPreviewEntity = new TiphonSprite(carriedEntity.look);
                carryingPreviewEntity.setSubEntityBehaviour(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY, new CarrierSubEntityBehaviour());
                carryingPreviewEntity.isCarrying = true;
                carryingPreviewEntity.addAnimationModifier(CarrierAnimationModifier.getInstance());
                carryingPreviewEntity.addSubEntity(carriedPreviewEntity, SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_LIFTED_ENTITY, 0);
                carriedPreviewEntity.setAnimation(AnimationEnum.ANIM_STATIQUE);
                carryingPreviewEntity.setAnimation(AnimationEnum.ANIM_STATIQUE_CARRYING);
                this.addPreviewSubEntities(carriedEntity, carriedPreviewEntity);
            };
        }

        private function addTeamCircle(pActualEntity:TiphonSprite, pEntity:TiphonSprite):void
        {
            var id:int;
            var entityId:int;
            var entitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            for each (entityId in entitiesFrame.getEntitiesIdsList())
            {
                if (DofusEntities.getEntity(entityId) == pActualEntity)
                {
                    id = entityId;
                };
            };
            if (id != 0)
            {
                entitiesFrame.addCircleToFighter(pEntity, ((((entitiesFrame.getEntityInfos(id) as GameFightFighterInformations).teamId == TeamEnum.TEAM_DEFENDER)) ? 0xFF : 0xFF0000));
            };
        }

        private function isValidCell(pCellId:int):Boolean
        {
            if (pCellId == -1)
            {
                return (false);
            };
            var cellData:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[pCellId];
            return (((cellData.mov) && (!(cellData.nonWalkableDuringFight))));
        }

        private function compareDistanceFromCaster(pEntityAId:uint, pEntityBId:uint):int
        {
            var entityA:IEntity = DofusEntities.getEntity(pEntityAId);
            var entityB:IEntity = DofusEntities.getEntity(pEntityBId);
            var distanceA:int = entityA.position.distanceToCell(this._casterPos);
            var distanceB:int = entityB.position.distanceToCell(this._casterPos);
            if (distanceA < distanceB)
            {
                return (-1);
            };
            if (distanceA > distanceB)
            {
                return (1);
            };
            return (0);
        }

        private function showTelefragTooltip(pActualEntityId:int, pPreviewEntity:AnimatedCharacter):void
        {
            var tooltipMaker:String;
            var cacheName:String;
            var fightContextFrame:FightContextFrame = (Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame);
            var entityInfos:GameFightFighterInformations = (fightContextFrame.entitiesFrame.getEntityInfos(pActualEntityId) as GameFightFighterInformations);
            TooltipManager.hide(("tooltipOverEntity_" + entityInfos.contextualId));
            if ((entityInfos is GameFightCharacterInformations))
            {
                tooltipMaker = null;
                cacheName = ("PlayerShortInfos" + entityInfos.contextualId);
            }
            else
            {
                if ((entityInfos is GameFightCompanionInformations))
                {
                    tooltipMaker = "companionFighter";
                    cacheName = ("EntityShortInfos" + entityInfos.contextualId);
                }
                else
                {
                    tooltipMaker = "monsterFighter";
                    cacheName = ("EntityShortInfos" + entityInfos.contextualId);
                };
            };
            TooltipManager.show(entityInfos, pPreviewEntity.absoluteBounds, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, ("tooltipOverEntity_" + entityInfos.contextualId), LocationEnum.POINT_BOTTOM, LocationEnum.POINT_TOP, 0, true, tooltipMaker, null, {
                "telefrag":true,
                "cellId":pPreviewEntity.position.cellId
            }, cacheName, false, StrataEnum.STRATA_WORLD);
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.types

