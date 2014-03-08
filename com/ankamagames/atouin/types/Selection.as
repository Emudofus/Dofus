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
      
      public function set mapId(param1:uint) : void {
         this._mapId = param1;
      }
      
      public function get mapId() : uint {
         if(isNaN(this._mapId))
         {
            return MapDisplayManager.getInstance().currentMapPoint.mapId;
         }
         return this._mapId;
      }
      
      public function update(param1:Boolean=false) : void {
         if(this.renderer)
         {
            this.renderer.render(this.cells,this.color,MapDisplayManager.getInstance().getDataMapContainer(),this.alpha,param1);
         }
         this.visible = true;
      }
      
      public function remove(param1:Vector.<uint>=null) : void {
         if(this.renderer)
         {
            if(!param1)
            {
               this.renderer.remove(this.cells,MapDisplayManager.getInstance().getDataMapContainer());
            }
            else
            {
               this.renderer.remove(param1,MapDisplayManager.getInstance().getDataMapContainer());
            }
         }
         this.visible = false;
      }
      
      public function isInside(param1:uint) : Boolean {
         if(!this.cells)
         {
            return false;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.cells.length)
         {
            if(this.cells[_loc2_] == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}
