package com.ankamagames.dofus.internalDatacenter.taxi
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.world.Hint;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;


   public class TeleportDestinationWrapper extends Object implements IDataCenter
   {
         

      public function TeleportDestinationWrapper(teleporterType:uint, mapId:uint, subareaId:uint, cost:uint, spawn:Boolean=false, hint:Hint=null) {
         super();
         this.teleporterType=teleporterType;
         this.mapId=mapId;
         this.subArea=SubArea.getSubAreaById(subareaId);
         this.cost=cost;
         this.spawn=spawn;
         if(teleporterType==1)
         {
            if(hint)
            {
               this.category=hint.categoryId;
               this.name=hint.name;
            }
            else
            {
               this.category=-1;
            }
         }
         else
         {
            this.name=Area.getAreaById(this.subArea.areaId).name+" ("+this.subArea.name+")";
         }
         var p:Object = new WorldPointWrapper(mapId);
         this.coord=p.outdoorX+","+p.outdoorY;
      }

      private static var _hints:Dictionary;

      private static var _hintsRealMap:Dictionary;

      public static function getHintsFromMapId(mapId:uint) : Vector.<Hint> {
         var ret:Vector.<Hint> = null;
         generateHintsDictionary();
         if(_hintsRealMap.hasOwnProperty(mapId))
         {
            ret=_hintsRealMap[mapId];
         }
         else
         {
            ret=new Vector.<Hint>();
         }
         if(_hints.hasOwnProperty(mapId))
         {
            return ret.concat(_hints[mapId]);
         }
         return ret;
      }

      private static function generateHintsDictionary() : void {
         var hints:Array = null;
         var hint:Hint = null;
         if(!_hints)
         {
            hints=Hint.getHints();
            _hints=new Dictionary();
            _hintsRealMap=new Dictionary();
            for each (hint in hints)
            {
               if(_hints.hasOwnProperty(hint.mapId))
               {
                  _hints[hint.mapId].push(hint);
               }
               else
               {
                  _hints[hint.mapId]=new Vector.<Hint>();
                  _hints[hint.mapId].push(hint);
               }
               if(_hintsRealMap.hasOwnProperty(hint.realMapId))
               {
                  _hintsRealMap[hint.realMapId].push(hint);
               }
               else
               {
                  _hintsRealMap[hint.realMapId]=new Vector.<Hint>();
                  _hintsRealMap[hint.realMapId].push(hint);
               }
            }
         }
      }

      public var teleporterType:uint;

      public var mapId:uint;

      public var subArea:SubArea;

      public var cost:uint;

      public var spawn:Boolean;

      public var name:String;

      public var hintName:String;

      public var coord:String;

      public var hintMapId:uint;

      public var category:int;
   }

}