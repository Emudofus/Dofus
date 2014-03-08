package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.Square;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Line;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Cone;
   import com.ankamagames.jerakine.types.zones.HalfLozenge;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class SpellZoneManager extends Object implements IDestroyable
   {
      
      public function SpellZoneManager() {
         super();
         if(_self != null)
         {
            throw new SingletonError("SpellZoneManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            return;
         }
      }
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(SpellZoneManager));
      
      private static var _self:SpellZoneManager;
      
      private static const ZONE_COLOR:Color = new Color(10929860);
      
      private static const SELECTION_ZONE:String = "SpellCastZone";
      
      public static function getInstance() : SpellZoneManager {
         if(_self == null)
         {
            _self = new SpellZoneManager();
         }
         return _self;
      }
      
      private var _targetSelection:Selection;
      
      private var _spellWrapper:SpellWrapper;
      
      public function destroy() : void {
         _self = null;
      }
      
      public function displaySpellZone(param1:int, param2:int, param3:int, param4:uint, param5:uint) : void {
         this._spellWrapper = SpellWrapper.create(0,param4,param5,false,param1);
         if((this._spellWrapper) && (!(param2 == -1)) && !(param3 == -1))
         {
            this._targetSelection = new Selection();
            this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._targetSelection.color = ZONE_COLOR;
            this._targetSelection.zone = this.getSpellZone(this._spellWrapper);
            this._targetSelection.zone.direction = MapPoint.fromCellId(param3).advancedOrientationTo(MapPoint.fromCellId(param2),false);
            SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_ZONE);
            SelectionManager.getInstance().update(SELECTION_ZONE,param2);
         }
         else
         {
            this.removeTarget();
         }
      }
      
      public function removeSpellZone() : void {
         this.removeTarget();
      }
      
      private function removeTarget() : void {
         var _loc1_:Selection = SelectionManager.getInstance().getSelection(SELECTION_ZONE);
         if(_loc1_)
         {
            _loc1_.remove();
         }
      }
      
      public function getSpellZone(param1:*, param2:Boolean=false) : IZone {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:EffectInstance = null;
         var _loc7_:Cross = null;
         var _loc8_:Square = null;
         var _loc9_:Cross = null;
         var _loc10_:Cross = null;
         var _loc11_:Cross = null;
         var _loc12_:Cross = null;
         var _loc3_:uint = 88;
         _loc4_ = 0;
         _loc5_ = 0;
         if(!param1.hasOwnProperty("shape"))
         {
            for each (_loc6_ in param1.effects)
            {
               if(!(_loc6_.zoneShape == 0) && _loc6_.zoneSize < 63 && (_loc6_.zoneSize > _loc4_ || _loc6_.zoneSize == _loc4_ && _loc3_ == SpellShapeEnum.P))
               {
                  _loc3_ = _loc6_.zoneShape;
                  _loc4_ = _loc6_.zoneSize;
                  _loc5_ = _loc6_.zoneMinSize;
               }
            }
         }
         else
         {
            _loc3_ = param1.shape;
            _loc4_ = param1.ray;
         }
         switch(_loc3_)
         {
            case SpellShapeEnum.X:
               return new Cross(0,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.L:
               return new Line(_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.T:
               _loc7_ = new Cross(0,_loc4_,DataMapProvider.getInstance());
               _loc7_.onlyPerpendicular = true;
               return _loc7_;
            case SpellShapeEnum.D:
               return new Cross(0,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.C:
               return new Lozenge(_loc5_,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.O:
               return new Lozenge(_loc4_,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.Q:
               return new Cross(_loc5_?_loc5_:1,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.V:
               return new Cone(0,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.W:
               _loc8_ = new Square(0,_loc4_,DataMapProvider.getInstance());
               _loc8_.diagonalFree = true;
               return _loc8_;
            case SpellShapeEnum.plus:
               _loc9_ = new Cross(0,_loc4_,DataMapProvider.getInstance());
               _loc9_.diagonal = true;
               return _loc9_;
            case SpellShapeEnum.sharp:
               _loc10_ = new Cross(_loc5_,_loc4_,DataMapProvider.getInstance());
               _loc10_.diagonal = true;
               return _loc10_;
            case SpellShapeEnum.slash:
               return new Line(_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.star:
               _loc11_ = new Cross(0,_loc4_,DataMapProvider.getInstance());
               _loc11_.allDirections = true;
               return _loc11_;
            case SpellShapeEnum.minus:
               _loc12_ = new Cross(0,_loc4_,DataMapProvider.getInstance());
               _loc12_.onlyPerpendicular = true;
               _loc12_.diagonal = true;
               return _loc12_;
            case SpellShapeEnum.G:
               return new Square(0,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.I:
               return new Lozenge(_loc4_,63,DataMapProvider.getInstance());
            case SpellShapeEnum.U:
               return new HalfLozenge(0,_loc4_,DataMapProvider.getInstance());
            case SpellShapeEnum.A:
               if(!param2)
               {
                  return new Lozenge(0,63,DataMapProvider.getInstance());
               }
            case SpellShapeEnum.P:
            default:
               return new Cross(0,0,DataMapProvider.getInstance());
         }
      }
   }
}
