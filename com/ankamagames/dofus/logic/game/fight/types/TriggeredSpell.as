package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
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
      
      public function TriggeredSpell(param1:int, param2:int, param3:SpellWrapper, param4:String, param5:Vector.<int>, param6:Boolean)
      {
         super();
         this._casterId = param1;
         this._targetId = param2;
         this._spell = param3;
         this._triggers = param4;
         this._targets = param5;
         this._hasCritical = param6;
      }
      
      public static function create(param1:String, param2:uint, param3:int, param4:int, param5:int, param6:int, param7:Boolean = true) : TriggeredSpell
      {
         var _loc13_:Vector.<int> = null;
         var _loc14_:uint = 0;
         var _loc15_:EffectInstance = null;
         var _loc16_:Array = null;
         var _loc17_:IEntity = null;
         var _loc18_:SpellWrapper = null;
         var _loc8_:SpellWrapper = SpellWrapper.create(0,param2,param3,param7,param5);
         var _loc9_:IZone = SpellZoneManager.getInstance().getSpellZone(_loc8_,false,false);
         var _loc10_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc11_:int = (_loc10_) && (_loc10_.getEntityInfos(param6))?_loc10_.getEntityInfos(param6).disposition.cellId:0;
         var _loc12_:Vector.<uint> = _loc9_.getCells(_loc11_);
         if(param4 > 0)
         {
            _loc18_ = SpellWrapper.create(0,param2,param4,false,param5);
            _loc8_.criticalEffect = _loc18_.effects;
         }
         for each(_loc14_ in _loc12_)
         {
            _loc16_ = EntitiesManager.getInstance().getEntitiesOnCell(_loc14_,AnimatedCharacter);
            for each(_loc17_ in _loc16_)
            {
               if(_loc10_.getEntityInfos(_loc17_.id))
               {
                  if(!_loc13_)
                  {
                     _loc13_ = new Vector.<int>(0);
                  }
                  for each(_loc15_ in _loc8_.effects)
                  {
                     if(DamageUtil.verifySpellEffectMask(param5,_loc17_.id,_loc15_,_loc11_))
                     {
                        _loc13_.push(_loc17_.id);
                        break;
                     }
                  }
               }
            }
         }
         return new TriggeredSpell(param5,param6,_loc8_,param1,_loc13_,param4 > 0);
      }
      
      private var _casterId:int;
      
      private var _targetId:int;
      
      private var _spell:SpellWrapper;
      
      private var _triggers:String;
      
      private var _targets:Vector.<int>;
      
      private var _hasCritical:Boolean;
      
      public function get casterId() : int
      {
         return this._casterId;
      }
      
      public function get targetId() : int
      {
         return this._targetId;
      }
      
      public function get spell() : SpellWrapper
      {
         return this._spell;
      }
      
      public function get triggers() : String
      {
         return this._triggers;
      }
      
      public function get targets() : Vector.<int>
      {
         return this._targets;
      }
      
      public function get hasCritical() : Boolean
      {
         return this._hasCritical;
      }
   }
}
