package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.atouin.utils.IZoneRenderer;
   import com.ankamagames.jerakine.types.zones.IZone;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   
   public class Selection extends Object
   {
      
      public function Selection() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Selection));
      
      private var _mapId:uint;
      
      public var renderer:IZoneRenderer;
      
      public var zone:IZone;
      
      public var cells:Vector.<uint>;
      
      public var color:Color;
      
      public var alpha:Boolean = true;
      
      public var cellId:uint;
      
      public var visible:Boolean;
      
      public function set mapId(id:uint) : void {
         this._mapId = id;
      }
      
      public function get mapId() : uint {
         if(isNaN(this._mapId))
         {
            return MapDisplayManager.getInstance().currentMapPoint.mapId;
         }
         return this._mapId;
      }
      
      public function update(pUpdateStrata:Boolean=false) : void {
         if(this.renderer)
         {
            this.renderer.render(this.cells,this.color,MapDisplayManager.getInstance().getDataMapContainer(),this.alpha,pUpdateStrata);
         }
         this.visible = true;
      }
      
      public function remove(aCells:Vector.<uint>=null) : void {
         if(this.renderer)
         {
            if(!aCells)
            {
               this.renderer.remove(this.cells,MapDisplayManager.getInstance().getDataMapContainer());
            }
            else
            {
               this.renderer.remove(aCells,MapDisplayManager.getInstance().getDataMapContainer());
            }
         }
         this.visible = false;
      }
      
      public function isInside(cellId:uint) : Boolean {
         if(!this.cells)
         {
            return false;
         }
         var i:uint = 0;
         while(i < this.cells.length)
         {
            if(this.cells[i] == cellId)
            {
               return true;
            }
            i++;
         }
         return false;
      }
   }
}
