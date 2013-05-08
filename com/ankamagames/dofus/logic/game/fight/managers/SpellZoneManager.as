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
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Line;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Cone;
   import com.ankamagames.jerakine.types.zones.HalfLozenge;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;


   public class SpellZoneManager extends Object implements IDestroyable
   {
         

      public function SpellZoneManager() {
         super();
         if(_self!=null)
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
         if(_self==null)
         {
            _self=new SpellZoneManager();
         }
         return _self;
      }

      private var _targetSelection:Selection;

      private var _spellWrapper:Object;

      public function destroy() : void {
         _self=null;
      }

      public function displaySpellZone(casterId:int, targetCellId:int, sourceCellId:int, spellId:uint, spellLevelId:uint) : void {
         this._spellWrapper=SpellWrapper.create(0,spellId,spellLevelId,false,casterId);
         if((this._spellWrapper)&&(!(targetCellId==-1))&&(!(sourceCellId==-1)))
         {
            this._targetSelection=new Selection();
            this._targetSelection.renderer=new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
            this._targetSelection.color=ZONE_COLOR;
            this._targetSelection.zone=this.getSpellZone();
            this._targetSelection.zone.direction=MapPoint.fromCellId(sourceCellId).advancedOrientationTo(MapPoint.fromCellId(targetCellId),false);
            SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_ZONE);
            SelectionManager.getInstance().update(SELECTION_ZONE,targetCellId);
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
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_ZONE);
         if(s)
         {
            s.remove();
         }
      }

      private function getSpellZone() : IZone {
         var ray:uint = 0;
         var i:EffectInstance = null;
         var shapeT:Cross = null;
         var shapeW:Square = null;
         var shapePlus:Cross = null;
         var shapeSharp:Cross = null;
         var shapeStar:Cross = null;
         var shapeMinus:Cross = null;
         var shape:uint = 88;
         ray=666;
         for each (i in this._spellWrapper["effects"])
         {
            if((!(i.zoneShape==0))&&(i.zoneSize<0))
            {
               ray=Math.min(ray,i.zoneSize);
               shape=i.zoneShape;
            }
         }
         if(ray==666)
         {
            ray=0;
         }
         switch(shape)
         {
            case SpellShapeEnum.X:
               return new Cross(0,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.L:
               return new Line(ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.T:
               shapeT=new Cross(0,ray,DataMapProvider.getInstance());
               shapeT.onlyPerpendicular=true;
               return shapeT;
               break;
            case SpellShapeEnum.D:
               return new Cross(0,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.C:
               return new Lozenge(0,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.I:
               return new Lozenge(ray,63,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.O:
               return new Lozenge(ray,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.Q:
               return new Cross(1,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.G:
               return new Square(0,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.V:
               return new Cone(0,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.W:
               shapeW=new Square(0,ray,DataMapProvider.getInstance());
               shapeW.diagonalFree=true;
               return shapeW;
               break;
            case SpellShapeEnum.plus:
               shapePlus=new Cross(0,ray,DataMapProvider.getInstance());
               shapePlus.diagonal=true;
               return shapePlus;
               break;
            case SpellShapeEnum.sharp:
               shapeSharp=new Cross(1,ray,DataMapProvider.getInstance());
               shapeSharp.diagonal=true;
               return shapeSharp;
               break;
            case SpellShapeEnum.star:
               shapeStar=new Cross(0,ray,DataMapProvider.getInstance());
               shapeStar.allDirections=true;
               return shapeStar;
               break;
            case SpellShapeEnum.slash:
               return new Line(ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.minus:
               shapeMinus=new Cross(0,ray,DataMapProvider.getInstance());
               shapeMinus.onlyPerpendicular=true;
               shapeMinus.diagonal=true;
               return shapeMinus;
               break;
            case SpellShapeEnum.U:
               return new HalfLozenge(0,ray,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.A:
               return new Lozenge(0,63,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.P:
         }
         _log.debug("spell shape : "+shape);
         return new Cross(0,0,DataMapProvider.getInstance());
      }
   }

}