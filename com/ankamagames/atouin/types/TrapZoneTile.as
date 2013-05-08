package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import flash.geom.Point;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.interfaces.IRectangle;


   public class TrapZoneTile extends Sprite implements IDisplayable
   {
         

      public function TrapZoneTile() {
         super();
      }



      private var _displayBehaviors:IDisplayBehavior;

      private var _displayed:Boolean;

      private var _currentCell:Point;

      private var _cellId:uint;

      public var strata:uint = 10;

      public function display(strata:uint=0) : void {
         EntitiesDisplayManager.getInstance().displayEntity(this,MapPoint.fromCellId(this._cellId),strata);
         this._displayed=true;
      }

      public function drawStroke(t:Boolean, r:Boolean, b:Boolean, l:Boolean) : void {
         graphics.lineStyle(3,0);
         if(!t)
         {
            graphics.moveTo(-AtouinConstants.CELL_HALF_WIDTH,0);
            graphics.lineTo(0,AtouinConstants.CELL_HALF_HEIGHT);
         }
         if(!b)
         {
            graphics.moveTo(0,-AtouinConstants.CELL_HALF_HEIGHT);
            graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH,0);
         }
         if(!r)
         {
            graphics.moveTo(-AtouinConstants.CELL_HALF_WIDTH,0);
            graphics.lineTo(0,-AtouinConstants.CELL_HALF_HEIGHT);
         }
         if(!l)
         {
            graphics.moveTo(AtouinConstants.CELL_HALF_WIDTH,0);
            graphics.lineTo(0,AtouinConstants.CELL_HALF_HEIGHT);
         }
      }

      public function remove() : void {
         this._displayed=false;
         EntitiesDisplayManager.getInstance().removeEntity(this);
      }

      public function get displayBehaviors() : IDisplayBehavior {
         return this._displayBehaviors;
      }

      public function set displayBehaviors(value:IDisplayBehavior) : void {
         this._displayBehaviors=value;
      }

      public function get currentCell() : Point {
         return this._currentCell;
      }

      public function set currentCell(value:Point) : void {
         this._currentCell=value;
      }

      public function get displayed() : Boolean {
         return this._displayed;
      }

      public function get absoluteBounds() : IRectangle {
         return this._displayBehaviors.getAbsoluteBounds(this);
      }

      public function get cellId() : uint {
         return this._cellId;
      }

      public function set cellId(value:uint) : void {
         this._cellId=value;
      }
   }

}