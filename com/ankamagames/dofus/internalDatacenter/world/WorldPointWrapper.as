package com.ankamagames.dofus.internalDatacenter.world
{
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.world.MapPosition;


   public class WorldPointWrapper extends WorldPoint implements IDataCenter
   {
         

      public function WorldPointWrapper(mapid:uint, fixedOutdoor:Boolean=false, outx:int=0, outy:int=0) {
         var mapInfo:Object = null;
         super();
         mapId=mapid;
         setFromMapId();
         if(fixedOutdoor)
         {
            this._outdoorX=outx;
            this._outdoorY=outy;
         }
         else
         {
            mapInfo=MapPosition.getMapPositionById(mapid);
            if(!mapInfo)
            {
               this._outdoorX=x;
               this._outdoorY=y;
            }
            else
            {
               this._outdoorX=mapInfo.posX;
               this._outdoorY=mapInfo.posY;
            }
         }
      }



      public var outdoorMapId:uint;

      private var _outdoorX:int;

      private var _outdoorY:int;

      public function get outdoorX() : int {
         return this._outdoorX;
      }

      public function get outdoorY() : int {
         return this._outdoorY;
      }

      public function setOutdoorCoords(x:int, y:int) : void {
         this._outdoorX=x;
         this._outdoorY=y;
      }
   }

}