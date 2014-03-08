package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.interfaces.ITransparency;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.managers.FontManager;
   import flash.text.TextFormatAlign;
   import com.ankamagames.atouin.AtouinConstants;
   import flash.geom.ColorTransform;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   
   public class ZoneTile extends Sprite implements IDisplayable, ITransparency
   {
      
      public function ZoneTile() {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      private static const _cell:Class = ZoneTile__cell;
      
      private var _displayBehavior:IDisplayBehavior;
      
      protected var _displayed:Boolean;
      
      private var _currentCell:Point;
      
      private var _cellId:uint;
      
      protected var _cellInstance:Sprite;
      
      private var _tf:TextField;
      
      private var _color:uint;
      
      public var text:String;
      
      public var format:TextFormat;
      
      public var strata:uint = 0;
      
      public function get displayBehaviors() : IDisplayBehavior {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void {
         this._displayBehavior = oValue;
      }
      
      public function get currentCellPosition() : Point {
         return this._currentCell;
      }
      
      public function set currentCellPosition(pValue:Point) : void {
         this._currentCell = pValue;
      }
      
      public function get displayed() : Boolean {
         return this._displayed;
      }
      
      public function get absoluteBounds() : IRectangle {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      public function set color(c:uint) : void {
         this._color = c;
      }
      
      public function get color() : uint {
         return this._color;
      }
      
      public function get cellId() : uint {
         return this._cellId;
      }
      
      public function set cellId(nValue:uint) : void {
         this._cellId = nValue;
      }
      
      public function display(wishedStrata:uint=0) : void {
         if(this.text)
         {
            if(!this.format)
            {
               this.format = new TextFormat(FontManager.getInstance().getRealFontName("Verdana"),20,16777215,true);
               this.format.align = TextFormatAlign.CENTER;
            }
            this._tf = new TextField();
            this._tf.selectable = false;
            this._tf.defaultTextFormat = this.format;
            this._tf.setTextFormat(this.format);
            this._tf.embedFonts = true;
            this._tf.text = this.text;
            this._tf.width = AtouinConstants.CELL_WIDTH;
            this._tf.height = AtouinConstants.CELL_HEIGHT;
            this._tf.x = -AtouinConstants.CELL_HALF_WIDTH;
            this._tf.y = -AtouinConstants.CELL_HALF_HEIGHT + 7;
            this._tf.alpha = 0.8;
         }
         else
         {
            this._tf = null;
         }
         this._cellInstance = new _cell();
         var ct:ColorTransform = new ColorTransform();
         ct.color = this._color;
         this._cellInstance.transform.colorTransform = ct;
         addChild(this._cellInstance);
         if(this._tf)
         {
            addChild(this._tf);
         }
         EntitiesDisplayManager.getInstance().displayEntity(this,MapPoint.fromCellId(this._cellId),this.strata);
         this._displayed = true;
      }
      
      public function remove() : void {
         this._displayed = false;
         if(this._tf)
         {
            removeChild(this._tf);
         }
         removeChild(this._cellInstance);
         EntitiesDisplayManager.getInstance().removeEntity(this);
      }
      
      public function getIsTransparencyAllowed() : Boolean {
         return false;
      }
   }
}
