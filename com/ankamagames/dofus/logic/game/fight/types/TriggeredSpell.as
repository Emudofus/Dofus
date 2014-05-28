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
      
      public static function create(pTriggers:String, pSpellID:uint, pSpellLevel:int, pCriticalSpellLevel:int, pCasterId:int, pTargetId:int, pUseCache:Boolean = true) : TriggeredSpell {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
