package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   
   public class TriggeredSpell extends Object
   {
      
      public function TriggeredSpell(pCasterId:int, pTargetId:int, pSpell:SpellWrapper, pTriggers:String, pTargets:Vector.<int>, pHasCritical:Boolean) {
         super();
         this._casterId = pCasterId;
         this._targetId = pTargetId;
         this._spell = pSpell;
         this._triggers = pTriggers;
         this._targets = pTargets;
         this._hasCritical = pHasCritical;
      }
      
      public static function create(pTriggers:String, pSpellID:uint, pSpellLevel:int, pCriticalSpellLevel:int, pCasterId:int, pTargetId:int, pUseCache:Boolean=true) : TriggeredSpell {
         var targets:Vector.<int> = null;
         var cellId:uint = 0;
         var entity:IEntity = null;
         var effect:EffectInstance = null;
         var criticalSw:SpellWrapper = null;
         var sw:SpellWrapper = SpellWrapper.create(0,pSpellID,pSpellLevel,pUseCache,pCasterId);
         var spellZone:IZone = SpellZoneManager.getInstance().getSpellZone(sw);
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var spellImpactCell:int = (fef) && (fef.getEntityInfos(pTargetId))?fef.getEntityInfos(pTargetId).disposition.cellId:0;
         var spellZoneCells:Vector.<uint> = spellZone.getCells(spellImpactCell);
         if(pCriticalSpellLevel > 0)
         {
            criticalSw = SpellWrapper.create(0,pSpellID,pCriticalSpellLevel,false,pCasterId);
            sw.criticalEffect = criticalSw.effects;
         }
         for each (cellId in spellZoneCells)
         {
            entity = EntitiesManager.getInstance().getEntityOnCell(cellId,AnimatedCharacter);
            if(entity)
            {
               if(!targets)
               {
                  targets = new Vector.<int>(0);
               }
               for each (effect in sw.effects)
               {
                  if(DamageUtil.verifySpellEffectMask(pCasterId,entity.id,effect))
                  {
                     targets.push(entity.id);
                     break;
                  }
               }
            }
         }
         return new TriggeredSpell(pCasterId,pTargetId,sw,pTriggers,targets,pCriticalSpellLevel > 0);
      }
      
      private var _casterId:int;
      
      private var _targetId:int;
      
      private var _spell:SpellWrapper;
      
      private var _triggers:String;
      
      private var _targets:Vector.<int>;
      
      private var _hasCritical:Boolean;
      
      public function get casterId() : int {
         return this._casterId;
      }
      
      public function get targetId() : int {
         return this._targetId;
      }
      
      public function get spell() : SpellWrapper {
         return this._spell;
      }
      
      public function get triggers() : String {
         return this._triggers;
      }
      
      public function get targets() : Vector.<int> {
         return this._targets;
      }
      
      public function get hasCritical() : Boolean {
         return this._hasCritical;
      }
   }
}
